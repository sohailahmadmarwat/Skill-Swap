@echo off
setlocal
cd /d "%~dp0"
title SkillSwap - Run on Mobile (Debug)

echo ==============================================
echo   SkillSwap - Run on connected phone (DEBUG)
echo ==============================================
echo.
echo Before you start:
echo  1. Enable Developer Options + USB Debugging on the phone
echo  2. Connect it by USB cable and tap "Allow" on the phone
echo.

echo [1/3] Getting packages...
call flutter pub get
if errorlevel 1 goto :fail

echo.
echo [2/3] Connected devices:
call flutter devices
echo.

echo [3/3] Launching in debug mode...
echo   r = hot reload   R = hot restart   q = quit   d = detach
echo.
call flutter run --debug
if errorlevel 1 goto :fail
goto :end

:fail
echo.
echo Something failed. Check that the phone is connected, USB debugging is on,
echo and that "flutter devices" lists your phone. Run "flutter doctor" for help.

:end
echo.
pause
endlocal
