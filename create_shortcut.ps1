$desktop = [Environment]::GetFolderPath("Desktop")
$shortcutPath = Join-Path $desktop "논문 분석기.lnk"

if (-not (Test-Path $shortcutPath)) {
    $pythonw = (Get-Command pythonw.exe -ErrorAction SilentlyContinue).Source
    if (-not $pythonw) { $pythonw = "pythonw.exe" }

    $webappDir = Join-Path $PSScriptRoot "webapp"

    $ws = New-Object -ComObject WScript.Shell
    $shortcut = $ws.CreateShortcut($shortcutPath)
    $shortcut.TargetPath = $pythonw
    $shortcut.Arguments = '"' + (Join-Path $webappDir "tray_app.py") + '"'
    $shortcut.WorkingDirectory = $webappDir
    $shortcut.IconLocation = Join-Path $PSScriptRoot "assets\app.ico"
    $shortcut.Description = "논문 분석기"
    $shortcut.Save()
    Write-Host "바탕화면에 바로가기를 만들었습니다."
}
