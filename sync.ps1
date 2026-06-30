# Sync agent definitions + slash commands (source of truth) -> Claude Code global runtime dirs.
# Usage:  powershell -ExecutionPolicy Bypass -File sync.ps1   (or right-click > Run with PowerShell)
$src = $PSScriptRoot
$dst = Join-Path $env:USERPROFILE '.claude\agents'
New-Item -ItemType Directory -Force -Path $dst | Out-Null

# Docs that are NOT agent definitions and must not be synced.
$skip = @('AGENTS.md', 'README.md', 'CHANGELOG.md', 'CLAUDE.md', 'design-agents.md')

Get-ChildItem -Path $src -Filter *.md |
    Where-Object { $skip -notcontains $_.Name } |
    ForEach-Object {
        Copy-Item $_.FullName -Destination $dst -Force
        Write-Host "synced agent: $($_.Name)"
    }

# Slash commands -> global commands dir.
$cmdSrc = Join-Path $src 'commands'
$cmdDst = Join-Path $env:USERPROFILE '.claude\commands'
if (Test-Path $cmdSrc) {
    New-Item -ItemType Directory -Force -Path $cmdDst | Out-Null
    Get-ChildItem -Path $cmdSrc -Filter *.md |
        ForEach-Object {
            Copy-Item $_.FullName -Destination $cmdDst -Force
            Write-Host "synced command: $($_.Name)"
        }
}

Write-Host "Done -> $dst , $cmdDst"
