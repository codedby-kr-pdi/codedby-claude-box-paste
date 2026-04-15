# terminal-paste: install
# 1) AutoHotkey v2 설치 (이미 있으면 건너뜀)
# 2) .ahk 스크립트를 Startup 폴더에 복사 → 부팅 시 자동 실행
# 3) 지금 바로 실행

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

# 1) AutoHotkey 설치
$ahk = Find-AutoHotkey
if (-not $ahk) {
    Write-Host '[terminal-paste] AutoHotkey v2 미설치 → winget으로 설치' -ForegroundColor Yellow
    winget install --id AutoHotkey.AutoHotkey -e --accept-source-agreements --accept-package-agreements
    $ahk = Find-AutoHotkey
    if (-not $ahk) { throw 'AutoHotkey 설치 실패. winget 수동 실행 필요.' }
}
Write-Host "[terminal-paste] AutoHotkey: $ahk" -ForegroundColor Green

# 2) Startup에 복사
if (-not (Test-Path $AhkSource)) { throw "소스 파일 없음: $AhkSource" }
Copy-Item -Path $AhkSource -Destination $AhkDest -Force
Write-Host "[terminal-paste] 자동 실행 등록: $AhkDest" -ForegroundColor Green

# 3) 지금 실행 (이미 실행 중이면 재시작)
& (Join-Path $PSScriptRoot 'stop.ps1') | Out-Null
Start-Process -FilePath $ahk -ArgumentList "`"$AhkDest`""
Write-Host '[terminal-paste] 실행 완료. Shift+Insert / Ctrl+V 사용 가능.' -ForegroundColor Green
