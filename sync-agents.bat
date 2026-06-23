@echo off
REM Sync agent definitions from this source folder to the global Claude agents folder.
REM Run this after editing any agent .md here.

set "SRC=%~dp0"
set "DST=%USERPROFILE%\.claude\agents"

if not exist "%DST%" mkdir "%DST%"

for %%A in (api-doc-writer code-reviewer db-optimizer security-reviewer test-runner ui-ux-reviewer design-system-architect data-modeler system-architect) do (
  copy /Y "%SRC%%%A.md" "%DST%\%%A.md" >nul
  echo synced: %%A
)

echo.
echo Done. 9 agents synced to %DST%
pause
