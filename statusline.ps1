# Claude Code statusline (2줄)
#   1줄: 폴더 (git브랜치) [모델] 컨텍스트막대 %
#   2줄: 플랜 사용량 잔여(%) + CPU/RAM/GPU
[Console]::OutputEncoding = [Text.Encoding]::UTF8
# stdin은 UTF-8인데 [Console]::In은 콘솔 코드페이지(한국어 Windows = CP949)로 읽는다.
# 세션 이름이 한글이면 그 구간이 깨지면서 JSON 파싱이 통째로 실패해 statusline이 빈다 → 스트림을 UTF-8로 직접 읽는다.
$reader = New-Object IO.StreamReader ([Console]::OpenStandardInput()), (New-Object Text.UTF8Encoding $false)
$in = $reader.ReadToEnd() | ConvertFrom-Json

# --- 1줄 ---
$dir = $in.workspace.current_dir
$name = Split-Path $dir -Leaf
if (-not $name) { $name = $dir }

# git 브랜치: stdin JSON에 없어서 git을 직접 부른다 (~50ms, 레포가 아니면 생략)
$branch = ''
try {
    $b = git -C $dir rev-parse --abbrev-ref HEAD 2>$null
    if ($LASTEXITCODE -eq 0 -and $b) { $branch = " ($b)" }
} catch {}

# 컨텍스트: used_percentage가 계산된 채로 stdin에 온다 (추가 비용 0)
$pct = [math]::Round(([double]$in.context_window.used_percentage))
$fill = [math]::Max(0, [math]::Min(10, [math]::Round($pct / 10)))
# ■/□를 소스에 직접 넣으면 PS 5.1이 BOM 없는 UTF-8을 ANSI로 읽어 깨진다 → 코드포인트로 생성
$bar = ([string][char]0x25A0) * $fill + ([string][char]0x25A1) * (10 - $fill)

"$name$branch [$($in.model.display_name)] $bar $pct%"

# --- 2줄 ---
$parts = @()
foreach ($w in @(@{k = 'five_hour'; n = '5h' }, @{k = 'seven_day'; n = '7d' })) {
    $v = $in.rate_limits.($w.k).used_percentage
    if ($null -ne $v) { $parts += "$($w.n) left $([math]::Round(100 - $v))%" }
}

# CPU: Win32_Processor.LoadPercentage는 1.1초 걸려 statusline을 통째로 날린다.
# 대신 전체 프로세스 CPU 시간 델타 / (구간 × 코어수) 로 계산 — 오버헤드 ~100ms.
$sampleMs = 500
$cpu = try {
    $t1 = ((Get-Process -ErrorAction SilentlyContinue).TotalProcessorTime.TotalMilliseconds | Measure-Object -Sum).Sum
    Start-Sleep -Milliseconds $sampleMs
    $t2 = ((Get-Process -ErrorAction SilentlyContinue).TotalProcessorTime.TotalMilliseconds | Measure-Object -Sum).Sum
    [math]::Min(100, [math]::Round(($t2 - $t1) / ($sampleMs * [Environment]::ProcessorCount) * 100))
} catch { '?' }
$parts += "CPU $cpu%"
try {
    $os = Get-CimInstance Win32_OperatingSystem -ErrorAction Stop
    $usedMB = ($os.TotalVisibleMemorySize - $os.FreePhysicalMemory) / 1024
    $totMB = $os.TotalVisibleMemorySize / 1024
    $parts += "RAM $([math]::Round(100*$usedMB/$totMB))%"
} catch {}
if (Get-Command nvidia-smi -ErrorAction SilentlyContinue) {
    try {
        $g = (nvidia-smi --query-gpu=utilization.gpu,memory.used,memory.total --format=csv,noheader,nounits) -split ','
        $parts += "GPU $($g[0].Trim())% $([math]::Round([int]$g[1].Trim()/1024,1))/$([math]::Round([int]$g[2].Trim()/1024,1))G"
    } catch {}
}

$parts -join ' | '
