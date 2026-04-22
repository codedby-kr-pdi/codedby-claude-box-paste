# terminal-paste: SessionStart hook
# Launch the AHK script in the background if it is not already running.
# Silent on success and on most failures — never block Claude Code startup.

[Console]::OutputEncoding = [Text.Encoding]::UTF8
$ErrorActionPreference = 'SilentlyContinue'

# Skip if an instance is already loaded
$running = Get-CimInstance Win32_Process -Filter "Name='AutoHotkey64.exe' OR Name='AutoHotkey32.exe' OR Name='AutoHotkey.exe'" |
    Where-Object { $_.CommandLine -like '*codedby-text-paste.ahk*' }
if ($running) { exit 0 }

$PluginRoot = if ($env:CLAUDE_PLUGIN_ROOT) { $env:CLAUDE_PLUGIN_ROOT } else { Split-Path -Parent $PSScriptRoot }
$AhkScript = Join-Path $PluginRoot 'scripts\codedby-text-paste.ahk'
if (-not (Test-Path $AhkScript)) { exit 0 }

$candidates = @(
    "$env:ProgramFiles\AutoHotkey\v2\AutoHotkey64.exe",
    "$env:ProgramFiles\AutoHotkey\AutoHotkey64.exe",
    "${env:ProgramFiles(x86)}\AutoHotkey\v2\AutoHotkey64.exe"
)
$ahk = $null
foreach ($p in $candidates) { if (Test-Path $p) { $ahk = $p; break } }
if (-not $ahk) {
    $cmd = Get-Command AutoHotkey64.exe -ErrorAction SilentlyContinue
    if ($cmd) { $ahk = $cmd.Source }
}
if (-not $ahk) { exit 0 }

Start-Process -FilePath $ahk -ArgumentList "`"$AhkScript`""
exit 0
