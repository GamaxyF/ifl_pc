@echo off
rem Runs inFAMOUS First Light (CUSA00575, base 1.00 + update 1.04) from a source build on Windows.
rem Game folder: ISS_GAME_DIR, or the one remembered in port\user\firstlight_game_dir.txt, or asked once.
rem Python: PYTHON, or the first "py -3" / "python" that has iced-x86 (pip install iced-x86).
rem Texture cache: thresholds from the card's own memory (ISS_GC_BUDGET_MB=card) instead of the launcher's
rem fixed 3500 MB, made for 6 GB cards: on 8 GB the city kept evicting textures, and buildings flickered.
rem VSync: ISS_VSYNC=0 presents with Mailbox (no tearing, no drop to 30 FPS past 16.7 ms).
rem Flicker: ISS_STALE_READBACK=0 gives the game this frame's GPU results (one frame late, the
rem buildings it culls with them flicker while the camera moves); ISS_BP07=1 compiles full-screen
rem passes at once instead of skipping them (a black flash while a new shader builds).
rem ISS_OCCLUSION_MODE=2 answers occlusion queries "visible" (the default 3 says zero pixels:
rem what the game hides with them blinks while moving). 3 = the old answer.
rem Game language: the launcher setting (automatic: the system language), or ISS_LANGUAGE (PS4
rem system language id; 2 = French, 1 = English).
setlocal
set "PORT=%~dp0port"
rem Same settings file as launcher_firstlight.bat (folder, language, texture budget...).
set "ISS_GAME=firstlight"
if not defined MSYS2_ROOT set "MSYS2_ROOT=C:\msys64"
set "SAVED=%PORT%\user\firstlight_game_dir.txt"
if not defined ISS_GC_BUDGET_MB set "ISS_GC_BUDGET_MB=card"
if not defined ISS_VSYNC set "ISS_VSYNC=0"
if not defined ISS_STALE_READBACK set "ISS_STALE_READBACK=0"
if not defined ISS_BP07 set "ISS_BP07=1"
if not defined ISS_OCCLUSION_MODE set "ISS_OCCLUSION_MODE=2"

if not exist "%PORT%\out\tlg-probe.exe" (
    echo Port not built: run "bash port/build.sh" from an MSYS2 CLANG64 shell first.
    pause & exit /b 1
)

if not defined PYTHON (
    for %%P in ("py -3" "python") do if not defined PYTHON (
        %%~P -c "import iced_x86" >nul 2>&1 && set "PYTHON=%%~P"
    )
)
if not defined PYTHON (
    echo No Python with iced-x86 found. Install Python 3.8+ then: pip install iced-x86
    pause & exit /b 1
)
rem The full path, before MSYS2 goes first on PATH: its own python has no iced-x86.
for /f "delims=" %%E in ('%PYTHON% -c "import sys; print(sys.executable)"') do set "PYTHON_EXE=%%E"
set "PATH=%MSYS2_ROOT%\clang64\bin;%PATH%"

if not defined ISS_GAME_DIR if exist "%SAVED%" set /p ISS_GAME_DIR=<"%SAVED%"
if not defined ISS_GAME_DIR (
    echo Folder of inFAMOUS First Light CUSA00575 ^(base 1.00 with update 1.04 copied over it^):
    set /p "ISS_GAME_DIR=> "
)
set "ISS_GAME_DIR=%ISS_GAME_DIR:"=%"
if not exist "%ISS_GAME_DIR%\eboot.bin" (
    echo No eboot.bin in "%ISS_GAME_DIR%".
    if exist "%SAVED%" del "%SAVED%"
    pause & exit /b 1
)
if not exist "%PORT%\user" mkdir "%PORT%\user"
>"%SAVED%" echo %ISS_GAME_DIR%

echo inFAMOUS First Light: preparing (about 30 s), then the game window opens.
echo F10 = FPS counter, Insert = port menu. Log: port\out\last_run.log
"%PYTHON_EXE%" -u "%PORT%\launcher\infamous_run.py"
set "CODE=%ERRORLEVEL%"
if not "%CODE%"=="0" (
    echo.
    echo The game stopped with code %CODE%. The log is in port\out\logs\.
    pause
)
exit /b %CODE%
