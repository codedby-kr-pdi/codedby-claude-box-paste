---
description: 실행 중인 terminal-paste AHK 프로세스 종료
allowed-tools: Bash(powershell.exe:*)
---

`codedby-text-paste.ahk`를 로드한 AutoHotkey 프로세스만 종료한다 (다른 AHK 스크립트는 건드리지 않음).

```bash
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "${CLAUDE_PLUGIN_ROOT}/scripts/stop.ps1"
```
