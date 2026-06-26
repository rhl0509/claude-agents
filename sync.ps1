# Sync agent definitions (source of truth) -> Claude Code global runtime dir.
# Usage:  pwsh -File sync.ps1   (or right-click > Run with PowerShell)
$src = $PSScriptRoot
$dst = Join-Path $env:USERPROFILE '.claude\agents'
New-Item -ItemType Directory -Force -Path $dst | Out-Null

# Docs that are NOT agent definitions and must not be synced.
$skip = @('AGENTS.md', 'README.md', 'CHANGELOG.md', 'CLAUDE.md', 'design-agents.md')

Get-ChildItem -Path $src -Filter *.md |
    Where-Object { $skip -notcontains $_.Name } |
    ForEach-Object {
        Copy-Item $_.FullName -Destination $dst -Force
        Write-Host "synced: $($_.Name)"
    }

Write-Host "Done -> $dst"
