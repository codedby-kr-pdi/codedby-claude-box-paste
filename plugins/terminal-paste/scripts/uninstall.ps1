# terminal-paste: uninstall
# Stop running AHK + remove .ahk from Startup folder (AutoHotkey itself is kept)

[Console]::OutputEncoding = [Text.Encoding]::UTF8

& (Join-Path $PSScriptRoot 'stop.ps1') | Out-Null

$StartupDir = [Environment]::GetFolderPath('Startup')
$removed = $false
foreach ($name in 'codedby-text-paste.ahk','shift-insert-paste.ahk') {
    $path = Join-Path $StartupDir $name
    if (Test-Path $path) {
        Remove-Item $path -Force
        Write-Host "[terminal-paste] Auto-run removed: $path" -ForegroundColor Green
        $removed = $true
    }
}
if (-not $removed) {
    Write-Host '[terminal-paste] No file registered in Startup' -ForegroundColor DarkGray
}

Write-Host '[terminal-paste] Uninstalled. To remove AutoHotkey itself: winget uninstall AutoHotkey.AutoHotkey' -ForegroundColor Yellow
