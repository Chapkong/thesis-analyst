@echo off

where python >nul 2>nul
if errorlevel 1 (
    echo ============================================================
    echo  Python was not found.
    echo  Please install Python 3.10+ from https://www.python.org/downloads/
    echo  and make sure to check "Add Python to PATH" during setup.
    echo  Then run this file again.
    echo ============================================================
    pause
    exit /b 1
)

where pythonw >nul 2>nul
if errorlevel 1 (
    echo ============================================================
    echo  pythonw.exe was not found alongside python.exe.
    echo  Please reinstall Python and make sure "Add Python to PATH" is checked.
    echo ============================================================
    pause
    exit /b 1
)

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0create_shortcut.ps1"

cd /d "%~dp0webapp"

echo Installing required packages (first run may take a few minutes)...
pip install -r requirements.txt -q

python setup_check.py
if errorlevel 1 (
    pause
    exit /b 1
)

start "" pythonw tray_app.py
