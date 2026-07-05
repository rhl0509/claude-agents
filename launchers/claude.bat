@echo off
title Claude Code
echo.
echo  ==========================================================
echo    Claude Code Launcher
echo    Select your project folder (a dialog will open)
echo  ==========================================================
echo.

for /f "delims=" %%I in ('powershell -NoProfile -Command "Add-Type -AssemblyName System.Windows.Forms; $f=New-Object System.Windows.Forms.FolderBrowserDialog; $f.Description='Select project folder for Claude'; $f.SelectedPath='D:\'; if($f.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK){Write-Output $f.SelectedPath}"') do set "PROJ=%%I"

if not defined PROJ (
  echo No folder selected. Exiting.
  timeout /t 2 >nul
  exit /b
)

cd /d "%PROJ%" || (
  echo Failed to enter "%PROJ%". Exiting.
  timeout /t 3 >nul
  exit /b 1
)
cls
echo.
echo  Project: %PROJ%
echo  ----------------------------------------------------------
echo   /review   code review      /sec     security check
echo   /db       db performance   /apidoc  api docs
echo   /test     run tests        or just type your question
echo  ----------------------------------------------------------
echo.

claude
