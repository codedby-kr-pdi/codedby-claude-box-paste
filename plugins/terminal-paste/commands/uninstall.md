---
description: Remove from Startup + stop process (AutoHotkey itself is kept)
allowed-tools: Bash(powershell.exe:*)
---

Unregister terminal-paste from auto-run. AutoHotkey itself is left in place so other scripts can keep using it.

```bash
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "${CLAUDE_PLUGIN_ROOT}/scripts/uninstall.ps1"
```

To fully remove AutoHotkey, advise the user to run: `winget uninstall AutoHotkey.AutoHotkey`
