# terminal-paste: uninstall
# 실행 중인 AHK 종료 + Startup 폴더에서 .ahk 제거 (AutoHotkey 자체는 남김)

[Console]::OutputEncoding = [Text.Encoding]::UTF8

& (Join-Path $PSScriptRoot 'stop.ps1') | Out-Null

$StartupAhk = Join-Path ([Environment]::GetFolderPath('Startup')) 'shift-insert-paste.ahk'
if (Test-Path $StartupAhk) {
    Remove-Item $StartupAhk -Force
    Write-Host "[terminal-paste] 자동 실행 해제: $StartupAhk" -ForegroundColor Green
} else {
    Write-Host '[terminal-paste] Startup에 등록된 파일 없음' -ForegroundColor DarkGray
}

Write-Host '[terminal-paste] 언인스톨 완료. AutoHotkey 본체는 winget uninstall AutoHotkey.AutoHotkey 로 제거.' -ForegroundColor Yellow
