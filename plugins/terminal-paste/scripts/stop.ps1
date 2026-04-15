# terminal-paste: stop
# Terminate only AutoHotkey processes that loaded codedby-text-paste.ahk
# (Also matches legacy shift-insert-paste.ahk for backward compatibility.)

[Console]::OutputEncoding = [Text.Encoding]::UTF8

$targets = Get-CimInstance Win32_Process -Filter "Name='AutoHotkey64.exe' OR Name='AutoHotkey32.exe' OR Name='AutoHotkey.exe'" -ErrorAction SilentlyContinue |
    Where-Object { $_.CommandLine -like '*codedby-text-paste.ahk*' -or $_.CommandLine -like '*shift-insert-paste.ahk*' }

if (-not $targets) {
    Write-Host '[terminal-paste] No running process' -ForegroundColor DarkGray
    return
}

foreach ($p in $targets) {
    try {
        Stop-Process -Id $p.ProcessId -Force -ErrorAction Stop
        Write-Host "[terminal-paste] Stopped PID $($p.ProcessId)" -ForegroundColor Green
    } catch {
        Write-Host "[terminal-paste] Failed to stop PID $($p.ProcessId): $_" -ForegroundColor Red
    }
}
