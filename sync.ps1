# Sync agent definitions + slash commands + launchers (source of truth) -> Claude Code global runtime dirs.
# Usage:  powershell -ExecutionPolicy Bypass -File sync.ps1   (or right-click > Run with PowerShell)
$src = $PSScriptRoot
$dst = Join-Path $env:USERPROFILE '.claude\agents'
New-Item -ItemType Directory -Force -Path $dst | Out-Null

# Count of failed copy/remove operations; non-zero -> exit code 1 at the end.
$errorCount = 0

# Manifest of agent files THIS repo deployed on the last run. Delete-sync uses it
# so we only ever remove agents we previously placed here (renamed/deleted in the
# repo) and never touch a user's own personal agents that this repo has never seen.
# Ignored by Claude Code (only *.md are loaded as agents).
$manifestPath = Join-Path $dst '.auto_agent_manifest.txt'
$prevManifest = @()
if (Test-Path $manifestPath) {
    $prevManifest = @(Get-Content -Path $manifestPath -ErrorAction SilentlyContinue |
        ForEach-Object { $_.Trim() } | Where-Object { $_ })
}

# ALLOWLIST check: a top-level *.md is deployed as an agent only if it is an
# actual agent definition, i.e. it starts with a YAML frontmatter block ("---")
# that contains a top-level `name:` field. Docs (README.md, AGENTS.md,
# CHANGELOG.md, CLAUDE.md, design-agents.md, and any future doc) have no such
# frontmatter and are skipped automatically.
function Test-AgentDefinition {
    param([string]$Path)
    try {
        $lines = @(Get-Content -Path $Path -TotalCount 40 -ErrorAction Stop)
    } catch {
        return $false
    }
    if ($lines.Count -lt 2 -or $lines[0].Trim() -ne '---') { return $false }
    for ($i = 1; $i -lt $lines.Count; $i++) {
        if ($lines[$i].Trim() -eq '---') { break }          # end of frontmatter
        if ($lines[$i] -match '^name:\s*\S') { return $true }
    }
    return $false
}

# Agent definitions -> global agents dir (allowlist: frontmatter `name:` required).
$syncedAgents = @()
Get-ChildItem -Path $src -Filter *.md |
    Where-Object { Test-AgentDefinition $_.FullName } |
    ForEach-Object {
        try {
            Copy-Item $_.FullName -Destination $dst -Force -ErrorAction Stop
            $syncedAgents += $_.Name
            Write-Host "synced agent: $($_.Name)"
        } catch {
            Write-Host "ERROR syncing agent $($_.Name): $($_.Exception.Message)"
            $script:errorCount++
        }
    }

# Delete-sync (agents dir ONLY, manifest-scoped): remove destination *.md files
# that THIS repo deployed on a previous run but no longer syncs (agent renamed or
# deleted in the repo), so they don't leave ghost copies. A destination file is
# removed only when ALL hold:
#   1. it was in the previous manifest (i.e. this repo placed it before),
#   2. it is not synced this run,
#   3. no file with the same name exists in the source dir at all.
# Because deletion is gated on the manifest, a user's own personal agents (which
# this repo never deployed and never recorded) are NEVER touched.
$staleAgents = @($prevManifest | Where-Object {
    ($syncedAgents -notcontains $_) -and (-not (Test-Path (Join-Path $src $_)))
})
foreach ($stale in $staleAgents) {
    $stalePath = Join-Path $dst $stale
    if (Test-Path $stalePath) {
        try {
            Remove-Item $stalePath -Force -Confirm:$false -ErrorAction Stop
            Write-Host "removed stale agent: $stale"
        } catch {
            Write-Host "ERROR removing stale agent ${stale}: $($_.Exception.Message)"
            $script:errorCount++
        }
    }
}

# Persist the manifest of what we deployed this run (for next run's delete-sync).
try {
    Set-Content -Path $manifestPath -Value $syncedAgents -Encoding utf8 -ErrorAction Stop
} catch {
    Write-Host "WARN: could not write manifest ${manifestPath}: $($_.Exception.Message)"
}

# Slash commands -> global commands dir.
$cmdSrc = Join-Path $src 'commands'
$cmdDst = Join-Path $env:USERPROFILE '.claude\commands'
if (Test-Path $cmdSrc) {
    New-Item -ItemType Directory -Force -Path $cmdDst | Out-Null
    Get-ChildItem -Path $cmdSrc -Filter *.md |
        ForEach-Object {
            try {
                Copy-Item $_.FullName -Destination $cmdDst -Force -ErrorAction Stop
                Write-Host "synced command: $($_.Name)"
            } catch {
                Write-Host "ERROR syncing command $($_.Name): $($_.Exception.Message)"
                $script:errorCount++
            }
        }
}

# Workflow scripts (*.js) -> global workflows dir (invoked by the Workflow tool by name).
$wfSrc = Join-Path $src 'workflows'
$wfDst = Join-Path $env:USERPROFILE '.claude\workflows'
if (Test-Path $wfSrc) {
    New-Item -ItemType Directory -Force -Path $wfDst | Out-Null
    Get-ChildItem -Path $wfSrc -Filter *.js |
        ForEach-Object {
            try {
                Copy-Item $_.FullName -Destination $wfDst -Force -ErrorAction Stop
                Write-Host "synced workflow: $($_.Name)"
            } catch {
                Write-Host "ERROR syncing workflow $($_.Name): $($_.Exception.Message)"
                $script:errorCount++
            }
        }
}

# Desktop launcher(s) -> global launchers dir.
$lchSrc = Join-Path $src 'launchers'
$lchDst = Join-Path $env:USERPROFILE '.claude\launchers'
if (Test-Path $lchSrc) {
    New-Item -ItemType Directory -Force -Path $lchDst | Out-Null
    Get-ChildItem -Path $lchSrc -Filter *.bat |
        ForEach-Object {
            try {
                Copy-Item $_.FullName -Destination $lchDst -Force -ErrorAction Stop
                Write-Host "synced launcher: $($_.Name)"
            } catch {
                Write-Host "ERROR syncing launcher $($_.Name): $($_.Exception.Message)"
                $script:errorCount++
            }
        }
}

# PreToolUse guard hook script(s) -> global hooks dir (referenced by agent frontmatter).
$hkSrc = Join-Path $src 'hooks'
$hkDst = Join-Path $env:USERPROFILE '.claude\hooks'
if (Test-Path $hkSrc) {
    New-Item -ItemType Directory -Force -Path $hkDst | Out-Null
    Get-ChildItem -Path $hkSrc -Filter *.ps1 |
        ForEach-Object {
            try {
                Copy-Item $_.FullName -Destination $hkDst -Force -ErrorAction Stop
                Write-Host "synced hook: $($_.Name)"
            } catch {
                Write-Host "ERROR syncing hook $($_.Name): $($_.Exception.Message)"
                $script:errorCount++
            }
        }
}

# Preloaded skills (each a <name>/SKILL.md dir) -> global skills dir.
$skSrc = Join-Path $src 'skills'
$skDst = Join-Path $env:USERPROFILE '.claude\skills'
if (Test-Path $skSrc) {
    New-Item -ItemType Directory -Force -Path $skDst | Out-Null
    Get-ChildItem -Path $skSrc -Directory |
        ForEach-Object {
            try {
                Copy-Item $_.FullName -Destination $skDst -Recurse -Force -ErrorAction Stop
                Write-Host "synced skill: $($_.Name)"
            } catch {
                Write-Host "ERROR syncing skill $($_.Name): $($_.Exception.Message)"
                $script:errorCount++
            }
        }
}

# Coding-standard rules -> global rules dir. Claude Code natively auto-loads
# ~/.claude/rules/*.md; a `paths:` frontmatter scopes a rule to matching files
# (conditional load), no frontmatter = unconditional. README.md is docs, not a
# rule, so it is skipped.
$rlSrc = Join-Path $src 'rules'
$rlDst = Join-Path $env:USERPROFILE '.claude\rules'
if (Test-Path $rlSrc) {
    New-Item -ItemType Directory -Force -Path $rlDst | Out-Null
    Get-ChildItem -Path $rlSrc -Filter *.md |
        Where-Object { $_.Name -ne 'README.md' } |
        ForEach-Object {
            try {
                Copy-Item $_.FullName -Destination $rlDst -Force -ErrorAction Stop
                Write-Host "synced rule: $($_.Name)"
            } catch {
                Write-Host "ERROR syncing rule $($_.Name): $($_.Exception.Message)"
                $script:errorCount++
            }
        }
}

if ($errorCount -gt 0) {
    Write-Host "FAILED: $errorCount error(s). Targets: $dst , $cmdDst , $wfDst , $lchDst , $hkDst , $skDst , $rlDst"
    exit 1
}
Write-Host "Done -> $dst , $cmdDst , $wfDst , $lchDst , $hkDst , $skDst , $rlDst"
exit 0
