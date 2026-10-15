@echo off
rem Opens the inFAMOUS First Light launcher window (port\launcher\infamous_launcher.py with
rem ISS_GAME=firstlight): game folder, language, video, texture budget, experimental fixes, Play.
rem Its settings: %APPDATA%\infamous-firstlight-launcher\settings.json (Second Son keeps its own).
rem Python: PYTHON, or the first "py -3" / "python" that has iced-x86 (pip install iced-x86).
setlocal
set "PORT=%~dp0port"
set "ISS_GAME=firstlight"
if not defined MSYS2_ROOT set "MSYS2_ROOT=C:\msys64"

if not defined PYTHON (
    for %%P in ("py -3" "python") do if not defined PYTHON (
        %%~P -c "import iced_x86, tkinter" >nul 2>&1 && set "PYTHON=%%~P"
    )
)
if not defined PYTHON (
    echo No Python with iced-x86 and tkinter found. Install Python 3.8+ then: pip install iced-x86
    pause & exit /b 1
)
rem The full path, before MSYS2 goes first on PATH: its own python has no iced-x86.
for /f "delims=" %%E in ('%PYTHON% -c "import sys; print(sys.executable)"') do set "PYTHON_EXE=%%E"
set "PATH=%MSYS2_ROOT%\clang64\bin;%PATH%"

rem pythonw: no console window behind the launcher.
set "PYTHONW_EXE=%PYTHON_EXE:python.exe=pythonw.exe%"
if not exist "%PYTHONW_EXE%" set "PYTHONW_EXE=%PYTHON_EXE%"
start "" "%PYTHONW_EXE%" "%PORT%\launcher\infamous_launcher.py"
