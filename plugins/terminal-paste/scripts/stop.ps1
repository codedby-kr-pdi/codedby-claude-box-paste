# terminal-paste: stop
# shift-insert-paste.ahk 를 로드한 AutoHotkey 프로세스만 종료

[Console]::OutputEncoding = [Text.Encoding]::UTF8

$targets = Get-CimInstance Win32_Process -Filter "Name='AutoHotkey64.exe' OR Name='AutoHotkey32.exe' OR Name='AutoHotkey.exe'" -ErrorAction SilentlyContinue |
    Where-Object { $_.CommandLine -like '*shift-insert-paste.ahk*' }

if (-not $targets) {
    Write-Host '[terminal-paste] 실행 중인 프로세스 없음' -ForegroundColor DarkGray
    return
}

foreach ($p in $targets) {
    try {
        Stop-Process -Id $p.ProcessId -Force -ErrorAction Stop
        Write-Host "[terminal-paste] 종료: PID $($p.ProcessId)" -ForegroundColor Green
    } catch {
        Write-Host "[terminal-paste] 종료 실패 PID $($p.ProcessId): $_" -ForegroundColor Red
    }
}
