# SessionEnd hook: mirror canonical memory (E:\claude_memory) into the Obsidian
# vault (D:\Obsidian\<vault>\claude_memory). PURE FILESYSTEM COPY - works even
# when Obsidian is closed (no REST API / port 27124 dependency).
#
# ASCII-ONLY source on purpose: Windows PowerShell 5.1 misreads a BOM-less .ps1
# that contains non-ASCII literals (CP949), so the Korean vault folder name is
# discovered by enumerating D:\Obsidian at runtime - never hardcoded.
#
# Rules:
#   - Source E:\claude_memory is CANONICAL and READ-ONLY here; never modified.
#   - One-directional: copy files that are NEW or NEWER only.
#   - NEVER delete vault files (a memory archived out of E: stays as valid history).
#   - Root-level *.md only (skips _archive\ - out of normal recall scope).
#   - FAIL-OPEN: any error, or E:/vault missing, exits 0 without blocking session end.
#
# The sibling hook obsidian-session-log.ps1 separately posts this session's final
# summary to ClaudeCode/Daily/ via REST; this hook only mirrors the memory files.

try {
    $src = 'E:\claude_memory'
    if (-not (Test-Path -LiteralPath $src)) { exit 0 }   # E: unmounted -> skip

    # Locate the Obsidian vault under D:\Obsidian without a Korean literal:
    # prefer the vault that already contains a claude_memory folder; else the sole vault.
    $base = 'D:\Obsidian'
    if (-not (Test-Path -LiteralPath $base)) { exit 0 }
    $dirs = @(Get-ChildItem -LiteralPath $base -Directory -ErrorAction SilentlyContinue)
    if ($dirs.Count -eq 0) { exit 0 }
    $vaultDir = $dirs | Where-Object { Test-Path -LiteralPath (Join-Path $_.FullName 'claude_memory') } | Select-Object -First 1
    if (-not $vaultDir) {
        if ($dirs.Count -eq 1) { $vaultDir = $dirs[0] } else { exit 0 }
    }
    $dst = Join-Path $vaultDir.FullName 'claude_memory'
    if (-not (Test-Path -LiteralPath $dst)) { New-Item -ItemType Directory -Path $dst -Force | Out-Null }

    $copied = 0
    foreach ($f in (Get-ChildItem -LiteralPath $src -Filter *.md -File)) {
        $target = Join-Path $dst $f.Name
        $need = $true
        if (Test-Path -LiteralPath $target) {
            if ((Get-Item -LiteralPath $target).LastWriteTimeUtc -ge $f.LastWriteTimeUtc) { $need = $false }
        }
        if ($need) {
            Copy-Item -LiteralPath $f.FullName -Destination $target -Force
            $copied++
        }
    }

    # light self-rotating debug log
    $log = Join-Path $env:USERPROFILE '.claude\hooks\obsidian-memory-mirror.log'
    try {
        if ((Test-Path -LiteralPath $log) -and ((Get-Item -LiteralPath $log).Length -gt 524288)) {
            Remove-Item -LiteralPath $log -Force
        }
        $stamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
        [System.IO.File]::AppendAllText($log, "[$stamp] mirror: $copied file(s) copied`n",
            (New-Object System.Text.UTF8Encoding $false))
    } catch {}

    exit 0
}
catch {
    exit 0   # never break session end
}
