# terminal-paste: uninstall
# Stop the running AHK script (AutoHotkey itself is kept so other scripts can use it).
# Auto-run on Claude Code sessions is disabled automatically once the plugin is removed
# (the SessionStart hook lives inside the plugin directory).

[Console]::OutputEncoding = [Text.Encoding]::UTF8

& (Join-Path $PSScriptRoot 'stop.ps1') | Out-Null

# Clean up any stale Startup folder copy left over from v1.2.x installs.
$StaleStartupAhk = Join-Path ([Environment]::GetFolderPath('Startup')) 'codedby-text-paste.ahk'
if (Test-Path $StaleStartupAhk) {
    Remove-Item $StaleStartupAhk -Force -ErrorAction SilentlyContinue
    Write-Host "[terminal-paste] Removed legacy Startup entry: $StaleStartupAhk" -ForegroundColor Green
}

Write-Host '[terminal-paste] Uninstalled. To remove AutoHotkey itself: winget uninstall AutoHotkey.AutoHotkey' -ForegroundColor Yellow
