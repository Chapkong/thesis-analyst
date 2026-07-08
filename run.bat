@echo off
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
