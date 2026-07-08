$desktop = [Environment]::GetFolderPath("Desktop")
$shortcutPath = Join-Path $desktop "논문 분석기.lnk"

if (-not (Test-Path $shortcutPath)) {
    $ws = New-Object -ComObject WScript.Shell
    $shortcut = $ws.CreateShortcut($shortcutPath)
    $shortcut.TargetPath = Join-Path $PSScriptRoot "run.bat"
    $shortcut.WorkingDirectory = $PSScriptRoot
    $shortcut.IconLocation = Join-Path $PSScriptRoot "assets\app.ico"
    $shortcut.Description = "논문 분석기"
    $shortcut.Save()
    Write-Host "바탕화면에 바로가기를 만들었습니다."
}
