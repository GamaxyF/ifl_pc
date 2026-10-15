@echo off
rem Lance inFAMOUS First Light (CUSA00575 1.04) avec le port natif.
setlocal
set "PORT=%~dp0port"
set "PYTHON=C:\Users\Oubey\AppData\Local\Programs\Python\Python38\python.exe"
set "ISS_GAME_DIR=E:\ALAN WAKE\Infamous\CUSA00575-merged"
rem DLL du build (SDL3, Vulkan, FFmpeg...) depuis MSYS2 CLANG64.
set "PATH=C:\msys64\clang64\bin;%PATH%"

if not exist "%PYTHON%" ( echo Python introuvable : %PYTHON% & pause & exit /b 1 )
if not exist "%ISS_GAME_DIR%\eboot.bin" ( echo Jeu introuvable : %ISS_GAME_DIR% & pause & exit /b 1 )
if not exist "%PORT%\out\tlg-probe.exe" ( echo Port non compile : %PORT%\out\tlg-probe.exe & pause & exit /b 1 )

echo inFAMOUS First Light - preparation (environ 30 s), puis le jeu s'ouvre...
echo F10 = FPS, Insert = menu du port. Journal : port\out\last_run.log
"%PYTHON%" -u "%PORT%\launcher\infamous_run.py"
set "CODE=%ERRORLEVEL%"
if not "%CODE%"=="0" (
    echo.
    echo Le jeu s'est arrete avec le code %CODE%. Envoie le dernier journal de port\out\logs\.
    pause
)
exit /b %CODE%
