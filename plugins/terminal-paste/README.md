# terminal-paste

Enables **Shift+Insert** and **Ctrl+V** paste inside Claude Code CLI running in Windows consoles (conhost / pwsh / Windows Terminal).

An AutoHotkey v2 script sends the clipboard directly via `SendText`, so paste works reliably at the Claude Code prompt.

## How it works

- `ConsoleWindowClass` (legacy conhost, pwsh) → Shift+Insert / Ctrl+V → direct clipboard text send
- `CASCADIA_HOSTING_WINDOW_CLASS` (Windows Terminal) → same
- Other apps → Shift+Insert mapped to standard Ctrl+V

## Slash commands

| Command | Description |
|---|---|
| `/terminal-paste:install` | Install AutoHotkey (winget/direct/choco fallback chain) + launch |
| `/terminal-paste:start` | Launch manually |
| `/terminal-paste:stop` | Stop the running process |
| `/terminal-paste:uninstall` | Stop the running process (AutoHotkey itself is kept) |

Korean variants (`:install.ko`, `:start.ko`, etc.) are also available.

## Install

```
/plugin marketplace add codedby-kr-pdi/codedby-claude-box-paste
/plugin install terminal-paste@codedby-claude-box-paste
/terminal-paste:install
```

On first install, AutoHotkey is installed via a fallback chain: `winget` → direct download from autohotkey.com → `choco`. If all three fail, a guidance message is shown.

### Auto-launch

Once installed, the AHK script is launched automatically at the start of every Claude Code session by the plugin's `SessionStart` hook (`hooks/hooks.json`). If an instance is already running, the hook is a no-op. The script runs as a detached process, so it survives after you exit Claude Code until the next reboot or `/terminal-paste:stop`.

## Requirements

- **Windows 10 (1809+) or Windows 11** — required for `winget`
- **PowerShell 5.1+** (Windows default) or PowerShell 7
- **At least one of**: `winget`, internet access (for direct download), or `choco`
- **User privilege to approve UAC** — the first AHK install requires admin elevation
- **64-bit Windows** — AutoHotkey v2 64-bit is required

## Troubleshooting

### All three install methods failed
The script shows a banner with the failing methods. Download AHK v2 manually from https://www.autohotkey.com/download/ and rerun `/terminal-paste:install` — the installed AHK will be detected and installation step skipped.

### UAC prompt not visible
It may be hidden behind the Claude Code window. Check the taskbar for a blinking "User Account Control" icon.

### ExecutionPolicy blocked (corporate machines)
If PowerShell ExecutionPolicy is locked by MDM/GPO, `-ExecutionPolicy Bypass` may be ignored. Contact your IT admin or run installation manually from an admin PowerShell.

### AHK already installed
`Find-AutoHotkey` detects the existing installation and skips the install step — no UAC prompt, only the immediate launch happens.

## License

MIT

---

한국어 문서: [README.ko.md](./README.ko.md)
