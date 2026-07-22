# UserPromptSubmit hook: capture the user's prompt as a RAW observation for the
# self-improvement loop. Append-only into E:\claude_memory\_observations\YYYYMMDD.jsonl.
#
# This is raw signal for later distillation (via /회고 or the self-reflector agent);
# it is NOT distilled memory and NEVER touches any existing memory file.
#
# Rules (mirrors obsidian-memory-mirror.ps1 discipline):
#   - Writes ONLY under E:\claude_memory\_observations\ (a new, isolated dir). Append-only.
#   - Never reads, modifies, or deletes any existing memory file.
#   - Emits NO stdout -> does not alter the prompt or inject context (pure capture).
#   - FAIL-SAFE: E: unmounted / any error -> exit 0 silently, never blocks a prompt.
#   - ASCII-only source (PS 5.1 misreads a BOM-less .ps1 with non-ASCII literals).

try {
    # Read stdin as UTF-8 bytes (robust against console codepage issues).
    $stdin = [Console]::OpenStandardInput()
    $ms = New-Object System.IO.MemoryStream
    $stdin.CopyTo($ms)
    $raw = [System.Text.Encoding]::UTF8.GetString($ms.ToArray())
    if (-not $raw) { exit 0 }
    # Strip a leading UTF-8 BOM if present (some stdin producers prepend one).
    if ($raw.Length -gt 0 -and $raw[0] -eq [char]0xFEFF) { $raw = $raw.Substring(1) }

    $j = $raw | ConvertFrom-Json -ErrorAction Stop
    $prompt = [string]$j.prompt
    if (-not $prompt) { exit 0 }

    # Capture only when the canonical memory root is present.
    $root = 'E:\claude_memory'
    if (-not (Test-Path -LiteralPath $root)) { exit 0 }

    $obsDir = Join-Path $root '_observations'
    if (-not (Test-Path -LiteralPath $obsDir)) {
        New-Item -ItemType Directory -Path $obsDir -Force | Out-Null
    }

    # Bound the stored prompt so logs stay small.
    if ($prompt.Length -gt 4000) { $prompt = $prompt.Substring(0, 4000) }

    $rec = [ordered]@{
        ts      = (Get-Date).ToString('o')
        cwd     = [string]$j.cwd
        session = [string]$j.session_id
        prompt  = $prompt
    }
    $line = ($rec | ConvertTo-Json -Depth 5 -Compress)

    $day  = (Get-Date).ToString('yyyyMMdd')
    $file = Join-Path $obsDir ($day + '.jsonl')
    [System.IO.File]::AppendAllText($file, $line + "`n", (New-Object System.Text.UTF8Encoding $false))

    exit 0
}
catch {
    exit 0   # never block a prompt
}
