# terminal-paste: start
# Launch the AHK script manually (no reboot required)

[Console]::OutputEncoding = [Text.Encoding]::UTF8
$ErrorActionPreference = 'Stop'

$PluginRoot = if ($env:CLAUDE_PLUGIN_ROOT) { $env:CLAUDE_PLUGIN_ROOT } else { Split-Path -Parent $PSScriptRoot }
$StartupDir = [Environment]::GetFolderPath('Startup')
$StartupAhk = Join-Path $StartupDir 'codedby-text-paste.ahk'
$LocalAhk   = Join-Path $PluginRoot 'scripts\codedby-text-paste.ahk'

# Prefer the version in Startup; fall back to the plugin-internal copy
$AhkScript = if (Test-Path $StartupAhk) { $StartupAhk } else { $LocalAhk }
if (-not (Test-Path $AhkScript)) { throw "AHK script not found: $AhkScript (run /terminal-paste:install first)" }

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

$ahk = Find-AutoHotkey
if (-not $ahk) { throw 'AutoHotkey v2 not installed. Run /terminal-paste:install first.' }

# Restart if already running
& (Join-Path $PSScriptRoot 'stop.ps1') | Out-Null

Start-Process -FilePath $ahk -ArgumentList "`"$AhkScript`""
Write-Host "[terminal-paste] Running: $AhkScript" -ForegroundColor Green
