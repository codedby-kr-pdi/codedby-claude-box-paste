# terminal-paste: start
# AHK 스크립트를 수동으로 실행 (재부팅 없이 즉시 적용)

[Console]::OutputEncoding = [Text.Encoding]::UTF8
$ErrorActionPreference = 'Stop'

$PluginRoot = if ($env:CLAUDE_PLUGIN_ROOT) { $env:CLAUDE_PLUGIN_ROOT } else { Split-Path -Parent $PSScriptRoot }
$StartupDir = [Environment]::GetFolderPath('Startup')
$StartupAhk = Join-Path $StartupDir 'shift-insert-paste.ahk'
$LocalAhk   = Join-Path $PluginRoot 'scripts\shift-insert-paste.ahk'

# Startup에 설치된 버전 우선, 없으면 플러그인 내부 파일 사용
$AhkScript = if (Test-Path $StartupAhk) { $StartupAhk } else { $LocalAhk }
if (-not (Test-Path $AhkScript)) { throw "AHK 스크립트 없음: $AhkScript (먼저 /terminal-paste:install 실행)" }

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
if (-not $ahk) { throw 'AutoHotkey v2 미설치. /terminal-paste:install 먼저 실행.' }

# 이미 같은 스크립트가 돌고 있으면 재시작
& (Join-Path $PSScriptRoot 'stop.ps1') | Out-Null

Start-Process -FilePath $ahk -ArgumentList "`"$AhkScript`""
Write-Host "[terminal-paste] 실행됨: $AhkScript" -ForegroundColor Green
