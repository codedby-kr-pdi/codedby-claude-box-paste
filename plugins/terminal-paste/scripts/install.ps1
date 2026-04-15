# terminal-paste: install
# 1) Install AutoHotkey v2 (skipped if already present)
# 2) Copy .ahk to Startup folder (auto-run on boot)
# 3) Launch immediately

[Console]::OutputEncoding = [Text.Encoding]::UTF8

$ErrorActionPreference = 'Stop'

$PluginRoot = if ($env:CLAUDE_PLUGIN_ROOT) { $env:CLAUDE_PLUGIN_ROOT } else { Split-Path -Parent $PSScriptRoot }
$AhkSource  = Join-Path $PluginRoot 'scripts\shift-insert-paste.ahk'
$StartupDir = [Environment]::GetFolderPath('Startup')
$AhkDest    = Join-Path $StartupDir 'shift-insert-paste.ahk'

function Find-AutoHotkey {
    $candidates = @(
        "$env:ProgramFiles\AutoHotkey\v2\AutoHotkey64.exe",
        "$env:ProgramFiles\AutoHotkey\AutoHotkey64.exe",
        "${env:ProgramFiles(x86)}\AutoHotkey\v2\AutoHotkey64.exe"
    )
    foreach ($p in $candidates) { if (Test-Path $p) { return $p } }
    $cmd = Get-Command AutoHotkey64.exe -ErrorAction SilentlyContinue
    if ($cmd) { return $cmd.Source }
    return $null
}

# 1) Install AutoHotkey
$ahk = Find-AutoHotkey
if (-not $ahk) {
    Write-Host '[terminal-paste] AutoHotkey v2 not found. Installing via winget...' -ForegroundColor Yellow
    winget install --id AutoHotkey.AutoHotkey -e --accept-source-agreements --accept-package-agreements
    $ahk = Find-AutoHotkey
    if (-not $ahk) { throw 'AutoHotkey install failed. Run winget manually.' }
}
Write-Host "[terminal-paste] AutoHotkey: $ahk" -ForegroundColor Green

# 2) Copy to Startup
if (-not (Test-Path $AhkSource)) { throw "Source not found: $AhkSource" }
Copy-Item -Path $AhkSource -Destination $AhkDest -Force
Write-Host "[terminal-paste] Auto-run registered: $AhkDest" -ForegroundColor Green

# 3) Launch (restart if already running)
& (Join-Path $PSScriptRoot 'stop.ps1') | Out-Null
Start-Process -FilePath $ahk -ArgumentList "`"$AhkDest`""
Write-Host '[terminal-paste] Running. Shift+Insert / Ctrl+V paste is active.' -ForegroundColor Green
