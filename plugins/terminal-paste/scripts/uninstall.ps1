# terminal-paste: uninstall
# Stop running AHK + remove .ahk from Startup folder (AutoHotkey itself is kept)

[Console]::OutputEncoding = [Text.Encoding]::UTF8

& (Join-Path $PSScriptRoot 'stop.ps1') | Out-Null

$StartupAhk = Join-Path ([Environment]::GetFolderPath('Startup')) 'codedby-text-paste.ahk'
if (Test-Path $StartupAhk) {
    Remove-Item $StartupAhk -Force
    Write-Host "[terminal-paste] Auto-run removed: $StartupAhk" -ForegroundColor Green
} else {
    Write-Host '[terminal-paste] No file registered in Startup' -ForegroundColor DarkGray
}

Write-Host '[terminal-paste] Uninstalled. To remove AutoHotkey itself: winget uninstall AutoHotkey.AutoHotkey' -ForegroundColor Yellow
