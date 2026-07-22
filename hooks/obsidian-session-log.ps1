# SessionEnd hook: append THIS session's final assistant summary to a daily note
# in the Obsidian vault (ClaudeCode/Daily/YYYY-MM-DD.md).
#
# DIRECT FILE WRITE - works even when Obsidian is closed.
#
# Why not the Local REST API (port 27124) anymore (2026-07-17): it required the
# Obsidian app to be running. A closed app silently diverted every summary into a
# fallback file that nothing ever flushed - a failure nobody would notice until
# the daily notes were found missing. The sibling hook obsidian-memory-mirror.ps1
# already proved a plain filesystem write is enough here; Obsidian reloads files
# changed underneath it. No API key, no port, no app dependency.
#
# ASCII-ONLY source on purpose: Windows PowerShell 5.1 misreads a BOM-less .ps1
# that contains non-ASCII literals (CP949), so the Korean vault folder name is
# discovered by enumerating D:\Obsidian at runtime - never hardcoded.
#
# Rules:
#   - Reads the hook JSON on stdin -> transcript_path / cwd / reason.
#   - Appends the LAST assistant text message (the wrap-up summary).
#   - Never rewrites or deletes existing notes; append-only.
#   - FAIL-OPEN: any error exits 0 with no output; session end is never blocked.
#   - If the vault is unreachable (D: unmounted / vault renamed), the summary goes
#     to ~/.claude/hooks/obsidian-log-fallback.md and is flushed into the daily
#     note by the next run that can see the vault, so nothing is lost.

try {
    [Console]::OutputEncoding = New-Object System.Text.UTF8Encoding $false
    $utf8 = New-Object System.Text.UTF8Encoding $false
    $fallback = Join-Path $env:USERPROFILE '.claude\hooks\obsidian-log-fallback.md'

    # --- 1. Read hook payload from stdin (raw UTF-8) ---
    $stdin = [Console]::OpenStandardInput()
    $ms = New-Object System.IO.MemoryStream
    $stdin.CopyTo($ms)
    $raw = [System.Text.Encoding]::UTF8.GetString($ms.ToArray())
    if (-not $raw) { exit 0 }
    # Defensive: strip a leading UTF-8 BOM if present, else ConvertFrom-Json throws.
    if ($raw.Length -gt 0 -and $raw[0] -eq [char]0xFEFF) { $raw = $raw.Substring(1) }
    $j = $raw | ConvertFrom-Json -ErrorAction Stop
    $transcript = [string]$j.transcript_path
    $cwd        = [string]$j.cwd
    $reason     = [string]$j.reason
    if (-not $transcript -or -not (Test-Path -LiteralPath $transcript)) { exit 0 }

    # --- 2. Extract the last assistant text message from the transcript ---
    $lastText = $null
    foreach ($line in (Get-Content -LiteralPath $transcript -Encoding UTF8 -ErrorAction Stop)) {
        if (-not $line -or -not $line.Trim()) { continue }
        try { $o = $line | ConvertFrom-Json -ErrorAction Stop } catch { continue }
        if ($o.type -ne 'assistant') { continue }
        $content = $o.message.content
        if (-not $content) { continue }
        if ($content -is [string]) {
            if ($content.Trim()) { $lastText = $content }
            continue
        }
        $texts = @()
        foreach ($c in $content) {
            if ($c.type -eq 'text' -and $c.text) { $texts += [string]$c.text }
        }
        if ($texts.Count -gt 0) { $lastText = ($texts -join "`n") }
    }
    if (-not $lastText -or -not $lastText.Trim()) { exit 0 }

    # --- 3. Build the markdown entry ---
    $stamp = Get-Date -Format 'yyyy-MM-dd HH:mm'
    $day   = Get-Date -Format 'yyyy-MM-dd'
    if (-not $reason) { $reason = 'other' }
    $dot = [char]0x00B7   # middle dot (`u{} escape is PS7-only, unavailable in 5.1)
    $entry = "`n## $stamp $dot $cwd`n`n> _(session end: $reason)_`n`n$lastText`n`n---`n"

    # --- 4. Locate the vault without a Korean literal (same rule as the mirror hook):
    #        prefer the vault that already holds our folders; else the sole vault.
    $vaultDir = $null
    $base = 'D:\Obsidian'
    if (Test-Path -LiteralPath $base) {
        $dirs = @(Get-ChildItem -LiteralPath $base -Directory -ErrorAction SilentlyContinue)
        if ($dirs.Count -gt 0) {
            $vaultDir = $dirs | Where-Object {
                (Test-Path -LiteralPath (Join-Path $_.FullName 'ClaudeCode')) -or
                (Test-Path -LiteralPath (Join-Path $_.FullName 'claude_memory'))
            } | Select-Object -First 1
            if (-not $vaultDir -and $dirs.Count -eq 1) { $vaultDir = $dirs[0] }
        }
    }

    # --- 5. Append to the daily note; fall back locally if the vault is gone ---
    if ($vaultDir) {
        $dir = Join-Path $vaultDir.FullName 'ClaudeCode\Daily'
        if (-not (Test-Path -LiteralPath $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
        $target = Join-Path $dir "$day.md"

        # Carry over anything stranded by an earlier unreachable-vault run.
        $pending = ''
        if (Test-Path -LiteralPath $fallback) {
            try {
                $pending = [System.IO.File]::ReadAllText($fallback, $utf8)
                $pending = $pending -replace '<!-- NOT synced[^>]*-->', ''
                if (-not $pending.Trim()) { $pending = '' }
            } catch { $pending = '' }
        }

        # Write first, delete the fallback only after it is safely on disk.
        [System.IO.File]::AppendAllText($target, ($pending + $entry), $utf8)
        if ($pending -ne '') { Remove-Item -LiteralPath $fallback -Force -ErrorAction SilentlyContinue }
    }
    else {
        $note = "`n<!-- NOT synced to Obsidian (vault unreachable at session end). Auto-flushed on the next run that finds it. -->$entry"
        [System.IO.File]::AppendAllText($fallback, $note, $utf8)
    }

    exit 0
}
catch {
    exit 0   # never break session end
}
