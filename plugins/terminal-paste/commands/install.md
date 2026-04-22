---
description: Install AutoHotkey (fallback chain) and launch the paste script
allowed-tools: Bash(powershell.exe:*)
---

Install terminal-paste. Steps:
1. Install AutoHotkey v2 if missing, using fallback chain: winget → direct download from autohotkey.com → Chocolatey.
2. Launch the AHK script immediately so Shift+Insert / Ctrl+V paste is active right away.

Auto-run on every subsequent Claude Code session is handled by the plugin's `SessionStart` hook — no Windows Startup registration is needed.

Run the following:

```bash
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "${CLAUDE_PLUGIN_ROOT}/scripts/install.ps1"
```

A UAC prompt may appear when winget installs AutoHotkey — warn the user in advance.
