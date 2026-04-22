---
description: Stop the running process (AutoHotkey itself is kept)
allowed-tools: Bash(powershell.exe:*)
---

Stop the running AHK script. AutoHotkey itself is left in place so other scripts can keep using it. Auto-run stops as soon as the plugin is uninstalled, because the `SessionStart` hook lives inside the plugin directory.

```bash
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "${CLAUDE_PLUGIN_ROOT}/scripts/uninstall.ps1"
```

To fully remove AutoHotkey, advise the user to run: `winget uninstall AutoHotkey.AutoHotkey`
