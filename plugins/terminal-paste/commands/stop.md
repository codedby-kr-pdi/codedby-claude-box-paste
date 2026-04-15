---
description: Stop the running terminal-paste AHK process
allowed-tools: Bash(powershell.exe:*)
---

Terminate only AutoHotkey processes that loaded `codedby-text-paste.ahk` (other AHK scripts are left alone).

```bash
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "${CLAUDE_PLUGIN_ROOT}/scripts/stop.ps1"
```
