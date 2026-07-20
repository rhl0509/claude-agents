<#
.SYNOPSIS
  auto_agent 서브에이전트 정의(.md)를 저장소 규범에 맞춰 검사한다.

.DESCRIPTION
  msitarzewski/agency-agents 의 scripts/lint-agents.sh 를 이 저장소 규범으로 이식하고,
  원본에 없던 세 가지 검사를 추가했다 — 경계 위임절 존재, 끊어진 위임 링크,
  라우팅 고아(아무도 가리키지 않는 에이전트).

  ERROR 는 머지 전에 고쳐야 하는 것, WARN 은 판단이 필요한 것이다.
  ERROR 가 하나라도 있으면 종료 코드 1.

.PARAMETER Path
  검사할 .md 파일 경로들. 생략하면 저장소 루트의 모든 에이전트 정의를 검사한다.

.PARAMETER WarnAsError
  WARN 도 실패로 취급한다(CI·사전 훅용).

.PARAMETER Quiet
  통과한 파일은 출력하지 않고 문제만 보고한다.

.EXAMPLE
  .\lint-agents.ps1
  .\lint-agents.ps1 -Path .\code-reviewer.md
  .\lint-agents.ps1 -Quiet
#>
[CmdletBinding()]
param(
    [string[]]$Path,
    [switch]$WarnAsError,
    [switch]$Quiet
)

$ErrorActionPreference = 'Stop'
$root = $PSScriptRoot
if (-not $root) { $root = (Get-Location).Path }

# ---------------------------------------------------------------- 규범 상수 --
$RequiredFields = @('name', 'description', 'tools', 'model', 'color', 'memory', 'version', 'updated')
$ValidModels    = @('opus', 'sonnet', 'haiku', 'fable', 'inherit')
$ValidEfforts   = @('low', 'medium', 'high', 'xhigh', 'max')
$ValidColors    = @('red', 'blue', 'green', 'yellow', 'purple', 'orange', 'pink', 'cyan')
$MutatingTools  = @('Write', 'Edit', 'NotebookEdit', 'MultiEdit')
$GuardToken     = 'agent-guard.ps1'
$ConventionSkill= 'agent-conventions'

# 본문 규범 — 저장소의 모든 에이전트가 지키기로 한 것
$BodyNorms = @(
    @{ Name = '신뢰 경계(프롬프트 인젝션 방어)'; Patterns = @('신뢰 경계', '인젝션 방어') }
    @{ Name = '출력 형식';                       Patterns = @('출력 형식', '보고 형식', '출력 규칙', '산출 형식') }
)

$script:Errors   = 0
$script:Warnings = 0
$script:Findings = @{}

function Add-Finding {
    param([string]$File, [ValidateSet('ERROR','WARN')][string]$Level, [string]$Message)
    if (-not $script:Findings.ContainsKey($File)) { $script:Findings[$File] = New-Object System.Collections.ArrayList }
    [void]$script:Findings[$File].Add([pscustomobject]@{ Level = $Level; Message = $Message })
    if ($Level -eq 'ERROR') { $script:Errors++ } else { $script:Warnings++ }
}

function Read-Text {
    param([string]$File)
    # UTF-8(BOM 유무 무관)로 읽는다. 기본 인코딩으로 읽으면 한글이 깨진다.
    return [System.IO.File]::ReadAllText($File, [System.Text.Encoding]::UTF8)
}

function Get-Frontmatter {
    <# 프론트매터를 원문 문자열과 최상위 키 해시로 돌려준다(중첩은 원문으로 검사). #>
    param([string]$Text)
    $lines = $Text -split "`r?`n"
    if ($lines.Count -lt 2 -or $lines[0].Trim() -ne '---') { return $null }
    $end = -1
    for ($i = 1; $i -lt $lines.Count; $i++) {
        if ($lines[$i].Trim() -eq '---') { $end = $i; break }
    }
    if ($end -lt 0) { return $null }

    $fmLines = $lines[1..($end - 1)]
    $map = @{}
    foreach ($l in $fmLines) {
        if ($l -match '^([A-Za-z_][A-Za-z0-9_]*):\s*(.*)$') {
            $map[$Matches[1]] = $Matches[2].Trim()
        }
    }
    return [pscustomobject]@{
        Raw  = ($fmLines -join "`n")
        Map  = $map
        Body = ($lines[($end + 1)..($lines.Count - 1)] -join "`n")
    }
}

# ------------------------------------------------------- 대상 파일 수집 ------
if ($Path) {
    $files = @($Path | ForEach-Object { (Resolve-Path $_).Path })
} else {
    $files = @(Get-ChildItem -Path $root -Filter *.md -File |
               Where-Object { (Read-Text $_.FullName) -match '(?m)^name:\s*\S' } |
               Select-Object -ExpandProperty FullName | Sort-Object)
}

if ($files.Count -eq 0) { Write-Host 'No agent definitions found.'; exit 1 }

# 에이전트 이름 집합 · 커맨드 집합(교차 검사용)
$agentNames = @{}
foreach ($f in $files) {
    $n = [System.IO.Path]::GetFileNameWithoutExtension($f)
    $agentNames[$n] = $true
}
$commandDir = Join-Path $root 'commands'
$commandNames = @{}
if (Test-Path $commandDir) {
    Get-ChildItem -Path $commandDir -Filter *.md -File | ForEach-Object {
        $commandNames[$_.BaseName] = $true
    }
}

# 실존 에이전트 이름의 마지막 마디를 모아 "에이전트처럼 생긴 토큰"의 판별 근거로 쓴다.
# (하드코딩 목록 대신 데이터에서 유도해야 새 접미사가 생겨도 따라온다)
$roleSuffixes = @{}
foreach ($n in $agentNames.Keys) {
    $parts = $n -split '-'
    $roleSuffixes[$parts[-1]] = $true
}

# 라우팅 진입점 — 의도적으로 "아무도 이쪽으로 위임하지 않는" 에이전트.
# project-manager 는 모든 에이전트 위에 앉는 조율 층이라 다른 정의가 그쪽으로 넘길 일이 없다
# (사용자가 직접 호출하거나 /pm-run 워크플로가 부른다). 고아 검사에서 제외한다.
$RoutingEntryPoints = @('project-manager')

# 라우팅 그래프: 누가 누구를 가리키는가
$referencedBy = @{}
foreach ($n in $agentNames.Keys) { $referencedBy[$n] = New-Object System.Collections.ArrayList }

$parsed = @{}

# ------------------------------------------------------------- 파일별 검사 --
foreach ($file in $files) {
    $rel  = [System.IO.Path]::GetFileName($file)
    $name = [System.IO.Path]::GetFileNameWithoutExtension($file)
    $text = Read-Text $file

    # 0) CRLF 거부 — 이 검사를 빼먹어서 실제로 사고가 났다.
    # Claude Code 의 프론트매터 파서는 CRLF 를 거부한다. project-manager.md 가 CRLF 가 되어
    # 에이전트 목록에서 통째로 사라졌고, 원인을 찾는 데 한참 걸렸다(python 텍스트 모드 읽기가
    # 줄바꿈을 정규화해 버려서 검증조차 눈이 멀었다). 이식한 원본 린터에 이 검사가 있었는데
    # 옮기면서 누락했다. 반드시 바이트 수준으로 본다 — 텍스트 모드로 읽으면 못 잡는다.
    if ($text.Contains("`r")) {
        Add-Finding $rel 'ERROR' 'CRLF 줄바꿈이 있다 — 프론트매터 파서가 거부해 에이전트가 통째로 로드되지 않는다. LF로 정규화할 것(.gitattributes 의 `*.md text eol=lf` 도 확인)'
        continue
    }

    $fm = Get-Frontmatter $text
    if (-not $fm) {
        Add-Finding $rel 'ERROR' '프론트매터가 없거나 --- 구분자가 닫히지 않았다'
        continue
    }
    $parsed[$name] = $fm

    # 1) 필수 필드
    foreach ($field in $RequiredFields) {
        if (-not $fm.Map.ContainsKey($field) -or [string]::IsNullOrWhiteSpace($fm.Map[$field])) {
            Add-Finding $rel 'ERROR' "필수 프론트매터 필드 누락: $field"
        }
    }

    # 2) name 과 파일명 일치
    if ($fm.Map.ContainsKey('name') -and $fm.Map['name'] -ne $name) {
        Add-Finding $rel 'ERROR' "name('$($fm.Map['name'])')이 파일명('$name')과 다르다"
    }

    # 3) model / effort / color 유효값
    if ($fm.Map.ContainsKey('model') -and $fm.Map['model'] -notin $ValidModels) {
        Add-Finding $rel 'ERROR' "model 값이 유효하지 않다: '$($fm.Map['model'])' (허용: $($ValidModels -join '/'))"
    }
    if ($fm.Map.ContainsKey('effort')) {
        if ($fm.Map['effort'] -notin $ValidEfforts) {
            Add-Finding $rel 'ERROR' "effort 값이 유효하지 않다: '$($fm.Map['effort'])'"
        }
    } elseif ($fm.Map['model'] -eq 'opus' -or $fm.Map['model'] -eq 'fable') {
        # 1.57 규범: opus·fable 은 effort 를 고정해 세션 설정에 흔들리지 않게 한다
        Add-Finding $rel 'WARN' "model=$($fm.Map['model'])인데 effort가 없다 — 세션 설정에 따라 추론 깊이가 떨어질 수 있다"
    }
    if ($fm.Map.ContainsKey('color') -and $fm.Map['color'] -notin $ValidColors) {
        Add-Finding $rel 'WARN' "color 값이 스펙 목록 밖이다: '$($fm.Map['color'])'"
    }

    # 4) 읽기 전용 계약 — tools 허용목록에 변경 도구가 있으면 안 된다
    if ($fm.Map.ContainsKey('tools')) {
        $toolList = $fm.Map['tools'] -split ',' | ForEach-Object { $_.Trim() }
        foreach ($t in $toolList) {
            if ($t -in $MutatingTools) {
                Add-Finding $rel 'ERROR' "tools에 변경 도구 '$t'가 있다 — 읽기 전용 계약 위반"
            }
        }
        if ($toolList -contains 'Bash') {
            # Bash 는 문서화된 좁은 목적이 있을 때만 (CLAUDE.md 최소권한 규범)
            if ($fm.Body -notmatch 'Bash') {
                Add-Finding $rel 'WARN' 'tools에 Bash가 있는데 본문에 사용 범위 설명이 없다 — 목적·한계를 본문에 명시할 것'
            }
        }
    }

    # 5) 공유 규범 배선 — 스킬 프리로드 · 가드 훅
    if ($fm.Raw -notmatch [regex]::Escape($ConventionSkill)) {
        Add-Finding $rel 'ERROR' "skills에 $ConventionSkill 프리로드가 없다"
    }
    if ($fm.Raw -notmatch [regex]::Escape($GuardToken)) {
        Add-Finding $rel 'ERROR' "PreToolUse 가드 훅($GuardToken)이 없다 — 읽기 전용 봉인이 tools 허용목록만 남는다"
    }
    if ($fm.Map['memory'] -and $fm.Map['memory'] -ne 'user') {
        Add-Finding $rel 'WARN' "memory 값이 'user'가 아니다: '$($fm.Map['memory'])'"
    }

    # 6) updated 형식
    if ($fm.Map.ContainsKey('updated') -and $fm.Map['updated'] -notmatch '^\d{4}-\d{2}-\d{2}$') {
        Add-Finding $rel 'WARN' "updated가 YYYY-MM-DD 형식이 아니다: '$($fm.Map['updated'])'"
    }
    if ($fm.Map.ContainsKey('version') -and $fm.Map['version'] -notmatch '^\d+\.\d+$') {
        Add-Finding $rel 'WARN' "version이 '메이저.마이너' 형식이 아니다: '$($fm.Map['version'])'"
    }

    # 7) description 은 라우팅 신호다
    $desc = ''
    if ($fm.Map.ContainsKey('description')) { $desc = $fm.Map['description'] }
    if ($desc) {
        if ($desc -notmatch '[가-힣]') {
            Add-Finding $rel 'ERROR' 'description이 한국어가 아니다 — 이 저장소는 한국어 정의를 쓴다'
        }
        if ($desc.Length -lt 120) {
            Add-Finding $rel 'WARN' "description이 짧다($($desc.Length)자) — 트리거 상황과 이웃 구분이 들어가야 라우터가 고른다"
        }
        # 경계 위임절: "~는 X를 쓴다" 형태가 최소 하나 있어야 라우팅이 새지 않는다
        if ($desc -notmatch '쓴다') {
            Add-Finding $rel 'ERROR' 'description에 경계 위임절이 없다 — 이웃 에이전트로 넘길 조건을 명시할 것'
        }
        # 사용 시점 신호
        if ($desc -notmatch '사용|적합|호출|점검할 때|쓸 때') {
            Add-Finding $rel 'WARN' 'description에 호출 시점(언제 쓰는지) 신호가 약하다'
        }

        # 8-a) 라우팅 그래프 — 실존 이름을 직접 찾는다.
        # 토큰 정규식으로만 잡으면 하이픈 없는 이름(brainstormer·debugger·storyteller)이 통째로 누락된다.
        foreach ($known in $agentNames.Keys) {
            if ($known -eq $name) { continue }
            if ($desc -match ('(?<![a-z0-9-])' + [regex]::Escape($known) + '(?![a-z0-9-])')) {
                [void]$referencedBy[$known].Add($name)
            }
        }

        # 8-b) 끊어진 위임 링크 — 에이전트처럼 생겼는데 실존하지 않는 이름
        $tokens = [regex]::Matches($desc, '[a-z][a-z0-9]*(?:-[a-z0-9]+)+')
        $seen = @{}
        foreach ($m in $tokens) {
            $tok = $m.Value
            if ($seen.ContainsKey($tok)) { continue }
            $seen[$tok] = $true
            if ($agentNames.ContainsKey($tok)) { continue }
            # 실존 에이전트 이름의 부분 문자열이면(예: 'game-design'), 오탐이므로 넘긴다
            $isPrefix = $false
            foreach ($known in $agentNames.Keys) { if ($known.StartsWith($tok) -or $known.Contains($tok)) { $isPrefix = $true; break } }
            if ($isPrefix) { continue }
            $lastPart = ($tok -split '-')[-1]
            if ($roleSuffixes.ContainsKey($lastPart)) {
                Add-Finding $rel 'ERROR' "존재하지 않는 에이전트를 위임 대상으로 지목한다: '$tok'"
            }
        }
    }

    # 9) 본문 규범
    foreach ($norm in $BodyNorms) {
        $hit = $false
        foreach ($pat in $norm.Patterns) { if ($fm.Body -match [regex]::Escape($pat)) { $hit = $true; break } }
        if (-not $hit) {
            Add-Finding $rel 'WARN' "본문에 '$($norm.Name)' 절이 없다"
        }
    }
    # 읽기 전용 선언은 본문이든 description 이든 한 곳에만 있으면 계약이 선다.
    # 설계 계열(아키텍트)은 description 에 "코드를 직접 작성하지 않고 설계만 한다"로 두는 게 관행이라
    # 본문만 보면 7종이 거짓 경고로 잡혔다 — 판정 위치를 둘 다로 넓힌다.
    $roDeclared = ($fm.Body -match '수정하지 않|변경하지 않|작성하지 않|만들지 않|고치지 않|쓰지 않는다|실행하지 않|읽기 전용') -or
                  ($desc -match '수정하지 않|변경하지 않|작성하지 않|만들지 않|고치지 않|쓰지 않는다|실행하지 않|읽기 전용')
    if (-not $roDeclared) {
        Add-Finding $rel 'WARN' '읽기 전용/비수정 선언이 본문·description 어디에도 없다'
    }

    # 10) 슬래시 커맨드 존재 여부
    if ($commandNames.Count -gt 0) {
        $hasCmd = $false
        foreach ($c in $commandNames.Keys) {
            $cText = Read-Text (Join-Path $commandDir "$c.md")
            if ($cText -match [regex]::Escape($name)) { $hasCmd = $true; break }
        }
        if (-not $hasCmd) {
            Add-Finding $rel 'WARN' "이 에이전트를 부르는 슬래시 커맨드가 commands/ 에 없다"
        }
    }
}

# --------------------------- 교차 검사: 레지스트리 · 문서 표 · 라우팅 고아 ---

# 레지스트리 드리프트 — 생성기가 판정한다(명단이 한 벌이라는 전제를 지키는 검사)
$builder = Join-Path $root 'build-registry.ps1'
if ((Test-Path $builder) -and (-not $Path)) {
    & $builder -Check | Out-Null
    if ($LASTEXITCODE -ne 0) {
        Add-Finding 'registry.json' 'ERROR' 'registry.json 또는 project-manager.md 라우팅 블록이 실제 파일 집합과 어긋난다 — .\build-registry.ps1 실행 필요'
    }
}

# 문서 표 누락 — README·AGENTS 는 사람이 쓴 설명이 많아 생성하지 않고 "행이 있는가"만 본다
if (-not $Path) {
    foreach ($doc in @('README.md', 'AGENTS.md')) {
        $docPath = Join-Path $root $doc
        if (-not (Test-Path $docPath)) { continue }
        $docText = Read-Text $docPath
        foreach ($n in ($agentNames.Keys | Sort-Object)) {
            if ($docText -notmatch ('\|\s*`' + [regex]::Escape($n) + '`')) {
                Add-Finding $doc 'WARN' "표에 '$n' 행이 없다"
            }
        }
    }
}

# 라우팅 고아
foreach ($n in ($agentNames.Keys | Sort-Object)) {
    if ($n -in $RoutingEntryPoints) { continue }
    if ($referencedBy[$n].Count -eq 0) {
        Add-Finding "$n.md" 'WARN' '다른 어떤 에이전트도 이 에이전트를 위임 대상으로 지목하지 않는다 — 역방향 경계절 누락(라우팅 고아)'
    }
}

# ----------------------------------------------------------------- 출력 ----
Write-Host ""
Write-Host "auto_agent 정의 검사 — 대상 $($files.Count)개" -ForegroundColor Cyan
Write-Host ""

foreach ($f in ($script:Findings.Keys | Sort-Object)) {
    Write-Host $f -ForegroundColor White
    foreach ($item in $script:Findings[$f]) {
        if ($item.Level -eq 'ERROR') {
            Write-Host "  ERROR  $($item.Message)" -ForegroundColor Red
        } else {
            Write-Host "  WARN   $($item.Message)" -ForegroundColor Yellow
        }
    }
    Write-Host ""
}

if (-not $Quiet) {
    $clean = @($files | ForEach-Object { [System.IO.Path]::GetFileName($_) } |
               Where-Object { -not $script:Findings.ContainsKey($_) })
    if ($clean.Count -gt 0) {
        Write-Host "이상 없음 $($clean.Count)개" -ForegroundColor Green
    }
}

Write-Host "결과: ERROR $($script:Errors)건 / WARN $($script:Warnings)건 (파일 $($files.Count)개)" -ForegroundColor Cyan

if ($script:Errors -gt 0) {
    Write-Host "실패 — 위 ERROR를 고친 뒤 sync/commit 할 것." -ForegroundColor Red
    exit 1
}
if ($WarnAsError -and $script:Warnings -gt 0) {
    Write-Host "실패 — WarnAsError 모드에서 WARN은 실패로 취급한다." -ForegroundColor Red
    exit 1
}
Write-Host "통과" -ForegroundColor Green
exit 0
