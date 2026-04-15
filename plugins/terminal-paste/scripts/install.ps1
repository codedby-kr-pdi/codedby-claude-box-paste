# terminal-paste: install
# 1) Install AutoHotkey v2 (skipped if already present)
#    Fallback chain: winget -> direct download (autohotkey.com) -> Chocolatey
# 2) Copy .ahk to Startup folder (auto-run on boot)
# 3) Launch immediately

[Console]::OutputEncoding = [Text.Encoding]::UTF8

$ErrorActionPreference = 'Stop'

$PluginRoot = if ($env:CLAUDE_PLUGIN_ROOT) { $env:CLAUDE_PLUGIN_ROOT } else { Split-Path -Parent $PSScriptRoot }
$AhkSource  = Join-Path $PluginRoot 'scripts\codedby-text-paste.ahk'
$StartupDir = [Environment]::GetFolderPath('Startup')
$AhkDest    = Join-Path $StartupDir 'codedby-text-paste.ahk'

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

function Try-Winget {
    if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
        Write-Host '[terminal-paste] winget: not available, skip' -ForegroundColor DarkGray
        return $false
    }
    Write-Host '[terminal-paste] winget: installing AutoHotkey...' -ForegroundColor Yellow
    try {
        winget install --id AutoHotkey.AutoHotkey -e --accept-source-agreements --accept-package-agreements | Out-Host
        return [bool](Find-AutoHotkey)
    } catch {
        Write-Host "[terminal-paste] winget: failed ($_)" -ForegroundColor DarkYellow
        return $false
    }
}

function Try-DirectDownload {
    $url = 'https://www.autohotkey.com/download/ahk-v2.exe'
    $tmp = Join-Path $env:TEMP 'ahk-v2-installer.exe'
    Write-Host "[terminal-paste] direct: downloading $url" -ForegroundColor Yellow
    try {
        Invoke-WebRequest -Uri $url -OutFile $tmp -UseBasicParsing
    } catch {
        Write-Host "[terminal-paste] direct: download failed ($_)" -ForegroundColor DarkYellow
        return $false
    }
    Write-Host '[terminal-paste] direct: running silent installer (/S)...' -ForegroundColor Yellow
    try {
        $p = Start-Process -FilePath $tmp -ArgumentList '/S' -Wait -PassThru
        Remove-Item $tmp -Force -ErrorAction SilentlyContinue
        if ($p.ExitCode -ne 0) {
            Write-Host "[terminal-paste] direct: installer exit code $($p.ExitCode)" -ForegroundColor DarkYellow
            return $false
        }
        return [bool](Find-AutoHotkey)
    } catch {
        Write-Host "[terminal-paste] direct: installer failed ($_)" -ForegroundColor DarkYellow
        return $false
    }
}

function Try-Chocolatey {
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host '[terminal-paste] choco: not available, skip' -ForegroundColor DarkGray
        return $false
    }
    Write-Host '[terminal-paste] choco: installing AutoHotkey...' -ForegroundColor Yellow
    try {
        choco install autohotkey -y --no-progress | Out-Host
        return [bool](Find-AutoHotkey)
    } catch {
        Write-Host "[terminal-paste] choco: failed ($_)" -ForegroundColor DarkYellow
        return $false
    }
}

# 1) Install AutoHotkey (with fallback chain)
$ahk = Find-AutoHotkey
if (-not $ahk) {
    $methods = @(
        @{ Name = 'winget';            Run = { Try-Winget } },
        @{ Name = 'direct download';   Run = { Try-DirectDownload } },
        @{ Name = 'chocolatey';        Run = { Try-Chocolatey } }
    )
    foreach ($m in $methods) {
        if (& $m.Run) { $ahk = Find-AutoHotkey; break }
        Write-Host "[terminal-paste] $($m.Name): did not yield AHK, trying next..." -ForegroundColor DarkYellow
    }
    if (-not $ahk) {
        Write-Host ''
        Write-Host '=============================================================' -ForegroundColor Red
        Write-Host ' AutoHotkey v2 installation failed via all methods:' -ForegroundColor Red
        Write-Host '   1. winget install AutoHotkey.AutoHotkey' -ForegroundColor Red
        Write-Host '   2. direct download from https://www.autohotkey.com/' -ForegroundColor Red
        Write-Host '   3. choco install autohotkey' -ForegroundColor Red
        Write-Host '' -ForegroundColor Red
        Write-Host ' Manual install: https://www.autohotkey.com/download/' -ForegroundColor Red
        Write-Host ' Afterwards, run /terminal-paste:install again.' -ForegroundColor Red
        Write-Host '=============================================================' -ForegroundColor Red
        throw 'AutoHotkey install failed (see message above).'
    }
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
