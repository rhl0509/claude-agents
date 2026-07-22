# SessionStart hook: inject a THIN "memory map" so every session cheaply knows
# WHAT memories exist — each bullet's title + topic-file pointer, NOT full prose.
#
# Two sources (2026-07-12 wiring):
#   1. project_active.md  -> the single source of ACTIVE / next-up work (📌).
#   2. latest daily index -> that day's NEW items only.
# Heavy filtered recall of actual content is delegated on-demand to the cheap
# `memory-recaller` (Haiku) subagent. Archived memories live under `_archive\`
# and are intentionally NOT surfaced here (out of default recall scope).
#
# FAIL-OPEN by design: any missing drive / no files / parse error exits 0 with
# no output, so session start is never broken by this hook.

try {
    [Console]::OutputEncoding = New-Object System.Text.UTF8Encoding $false

    $dir = 'E:\claude_memory'
    if (-not (Test-Path $dir)) { exit 0 }

    $pinChar = [char]::ConvertFromUtf32(0x1F4CC)   # 📌

    # Parse '- [title](file.md)' bullet-pointer lines into "- [pin]title -> file".
    # Skips pointers to project_active.md itself (it is expanded as its own section).
    function Get-Pointers([string[]]$lns) {
        $out = New-Object System.Collections.Generic.List[string]
        if (-not $lns) { return $out }
        foreach ($line in $lns) {
            if ($line -notmatch '^\s*-\s') { continue }
            $m = [regex]::Match($line, '\[([^\]]+)\]\(([^)]+\.md)\)')
            if (-not $m.Success) { continue }
            $title = $m.Groups[1].Value.Trim()
            $file  = $m.Groups[2].Value.Trim()
            if ($file -eq 'project_active.md') { continue }
            $pin = if ($line.Contains($script:pinChar)) { "$($script:pinChar) " } else { '' }
            $out.Add("- $pin$title -> $file")
        }
        return $out
    }

    # 1) Active work (single source).
    $activeItems = New-Object System.Collections.Generic.List[string]
    $activePath = Join-Path $dir 'project_active.md'
    if (Test-Path $activePath) {
        $alines = Get-Content -LiteralPath $activePath -Encoding UTF8 -ErrorAction SilentlyContinue
        $activeItems = Get-Pointers $alines
    }

    # 2) Latest daily index (root only; _archive is not scanned).
    $indexItems = New-Object System.Collections.Generic.List[string]
    $latest = Get-ChildItem -Path $dir -Filter '*_MEMORY.md' -ErrorAction SilentlyContinue |
        Sort-Object Name | Select-Object -Last 1
    if ($latest) {
        $lines = Get-Content -LiteralPath $latest.FullName -Encoding UTF8 -ErrorAction SilentlyContinue
        $indexItems = Get-Pointers $lines
    }

    if ($activeItems.Count -eq 0 -and $indexItems.Count -eq 0) { exit 0 }

    $latestName = if ($latest) { $latest.BaseName } else { '(없음)' }
    $header = "📚 메모리 지도 (활성: project_active.md, 최신 인덱스: $latestName, 위치: E:\claude_memory\). " +
              "아래는 '무엇이 있는지'만 보여주는 얇은 목차다. 실제 내용 회상이 필요하면 " +
              "memory-recaller(Haiku) 서브에이전트에게 해당 파일/주제를 물어라 — 메인이 직접 인덱스를 통째로 읽지 말 것. " +
              "📌 = 다음 착수 예정 항목. 아카이브(_archive\)는 기본 회상 범위 밖(명시 요청 시만)."

    $parts = New-Object System.Collections.Generic.List[string]
    $parts.Add($header)
    if ($activeItems.Count -gt 0) {
        $parts.Add("🎯 활성 작업 (project_active.md):")
        $parts.Add(($activeItems -join "`n"))
    }
    if ($indexItems.Count -gt 0) {
        $parts.Add("🗓 최신 인덱스 신규 ($latestName):")
        $parts.Add(($indexItems -join "`n"))
    }
    $context = $parts -join "`n"

    $payload = @{
        hookSpecificOutput = @{
            hookEventName     = 'SessionStart'
            additionalContext = $context
        }
    } | ConvertTo-Json -Depth 5 -Compress

    [Console]::Out.Write($payload)
    exit 0
}
catch {
    exit 0   # never break session start
}
