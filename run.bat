@echo off
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0create_shortcut.ps1"

cd /d "%~dp0webapp"

echo 필요한 패키지를 확인합니다 (최초 실행 시 몇 분 걸릴 수 있습니다)...
pip install -r requirements.txt -q

python setup_check.py
if errorlevel 1 (
    pause
    exit /b 1
)

echo.
echo 논문 분석기를 시작합니다. 브라우저가 자동으로 열립니다.
echo 종료하려면 이 창을 닫으세요.
echo.
python app.py
pause
