---
description: Launch the terminal-paste AHK script manually (no reboot required)
allowed-tools: Bash(powershell.exe:*)
---

Launch the AHK script now. If an instance is already running, it is restarted.

```bash
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "${CLAUDE_PLUGIN_ROOT}/scripts/start.ps1"
```
