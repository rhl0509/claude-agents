# weekly-reflect.ps1 — 매주 월요일 09:00 Windows 작업 스케줄러가 실행
# /누적회고(self-reflector)를 헤드리스로 돌려 학습 후보 리포트만 남긴다.
# 리포트는 제안일 뿐 정식 메모리가 아니다 — 실제 기록은 메인 세션이 승인 후 수행(자동 기록 금지 규칙).
# 등록: schtasks /Create /TN "auto_agent-weekly-reflect" /SC WEEKLY /D MON /ST 09:00
#        /TR "powershell.exe -NoProfile -ExecutionPolicy Bypass -File D:\auto_agent\weekly-reflect.ps1" /F

if (-not (Test-Path 'E:\claude_memory')) { exit 1 }  # E: 미마운트 → 실패 코드로 남김(작업 스케줄러 Last Run Result)

$dir = 'E:\claude_memory\_reflections'
New-Item -ItemType Directory -Force $dir | Out-Null
$out = Join-Path $dir ("{0}_누적회고.md" -f (Get-Date -Format yyyyMMdd))

& claude -p "/누적회고" *>&1 | Out-File $out -Encoding utf8
exit $LASTEXITCODE
