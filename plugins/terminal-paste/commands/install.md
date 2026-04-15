---
description: Install AutoHotkey (fallback chain) + register in Startup + launch immediately
allowed-tools: Bash(powershell.exe:*)
---

Install terminal-paste. Steps:
1. Install AutoHotkey v2 if missing, using fallback chain: winget → direct download from autohotkey.com → Chocolatey.
2. Copy `codedby-text-paste.ahk` into the user's Startup folder (auto-run on boot).
3. Launch immediately so Shift+Insert / Ctrl+V paste is active right away.

Run the following:

```bash
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "${CLAUDE_PLUGIN_ROOT}/scripts/install.ps1"
```

A UAC prompt may appear when winget installs AutoHotkey — warn the user in advance.
