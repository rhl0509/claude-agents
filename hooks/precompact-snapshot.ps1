# PreCompact hook: before Claude Code compacts the conversation, snapshot the
# current transcript to E:\claude_memory\_precompact\ as a safety net, so nothing
# in the pre-compaction conversation is irrecoverably lost (aligns with the
# "never lose data" memory rule). Self-rotating (keeps newest 10). Fail-safe.
#
# Rules:
#   - Writes ONLY under E:\claude_memory\_precompact\ (new isolated dir). Never touches memory files.
#   - Copies the transcript read-only; never modifies it.
#   - FAIL-SAFE: E: unmounted / missing transcript / any error -> exit 0 silently.
#   - ASCII-only source (PS 5.1 BOM-less non-ASCII issue).

try {
    $stdin = [Console]::OpenStandardInput()
    $ms = New-Object System.IO.MemoryStream
    $stdin.CopyTo($ms)
    $raw = [System.Text.Encoding]::UTF8.GetString($ms.ToArray())
    if (-not $raw) { exit 0 }
    if ($raw.Length -gt 0 -and $raw[0] -eq [char]0xFEFF) { $raw = $raw.Substring(1) }

    $j = $raw | ConvertFrom-Json -ErrorAction Stop
    $tp = [string]$j.transcript_path
    if (-not $tp -or -not (Test-Path -LiteralPath $tp)) { exit 0 }

    $root = 'E:\claude_memory'
    if (-not (Test-Path -LiteralPath $root)) { exit 0 }
    $dir = Join-Path $root '_precompact'
    if (-not (Test-Path -LiteralPath $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }

    $stamp = (Get-Date).ToString('yyyyMMdd_HHmmss')
    $trigger = [string]$j.trigger
    if (-not $trigger) { $trigger = 'unknown' }
    $dest = Join-Path $dir ("precompact_" + $stamp + "_" + $trigger + ".jsonl")
    Copy-Item -LiteralPath $tp -Destination $dest -Force

    # self-rotate: keep the newest 10 snapshots
    $all = @(Get-ChildItem -LiteralPath $dir -Filter 'precompact_*.jsonl' -File | Sort-Object LastWriteTime -Descending)
    if ($all.Count -gt 10) {
        $all[10..($all.Count - 1)] | ForEach-Object { Remove-Item -LiteralPath $_.FullName -Force }
    }
    exit 0
}
catch {
    exit 0   # never block compaction
}
