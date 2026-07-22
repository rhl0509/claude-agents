# UserPromptSubmit hook: when the user's prompt asks to "read the index"
# (matches 인덱스 ... 읽), deterministically steer the main model to delegate
# the read to the cheap `memory-recaller` (Haiku) subagent instead of reading
# the index itself in the expensive main context.
#
# The hook only INJECTS an instruction — it does not read the index. The actual
# read stays with the Haiku agent, consistent with the token-saving design.
#
# FAIL-OPEN: any parse error / no match exits 0 with no output, so normal
# prompts are never blocked or altered.

try {
    [Console]::OutputEncoding = New-Object System.Text.UTF8Encoding $false

    # Read stdin as raw UTF-8 bytes (robust against console codepage issues).
    $stdin = [Console]::OpenStandardInput()
    $ms = New-Object System.IO.MemoryStream
    $stdin.CopyTo($ms)
    $raw = [System.Text.Encoding]::UTF8.GetString($ms.ToArray())
    if (-not $raw) { exit 0 }

    $j = $raw | ConvertFrom-Json -ErrorAction Stop
    $prompt = [string]$j.prompt
    if (-not $prompt) { exit 0 }

    # Trigger: "인덱스" followed (loosely) by a "읽" verb — covers
    # "인덱스 파일 읽어", "인덱스 읽어줘", "최신 인덱스 읽어봐" 등.
    if ($prompt -notmatch '인덱스.*읽') { exit 0 }

    $instruction = "[자동 트리거] 사용자가 인덱스 파일 읽기를 요청했다. " +
        "메인이 직접 인덱스를 읽지 말고, memory-recaller(Haiku) 서브에이전트를 호출해 " +
        "E:\claude_memory 의 최신 날짜 인덱스(YYYYMMDD_MEMORY.md)와 관련 토픽 파일을 읽고 " +
        "핵심만 요약·보고하게 하라. 사용자가 특정 주제를 함께 말했으면 그 주제로 좁혀 회상시켜라."

    $payload = @{
        hookSpecificOutput = @{
            hookEventName     = 'UserPromptSubmit'
            additionalContext = $instruction
        }
    } | ConvertTo-Json -Depth 5 -Compress

    [Console]::Out.Write($payload)
    exit 0
}
catch {
    exit 0   # never block a normal prompt
}
