# codedby-claude-box-paste

A Claude Code marketplace — plugins that improve paste UX in Windows consoles.

## Plugins

| Name | Description |
|---|---|
| [`terminal-paste`](./plugins/terminal-paste) | AutoHotkey-based Shift+Insert / Ctrl+V paste |

## Install

From the Claude Code CLI:

```
/plugin marketplace add codedby-kr-pdi/codedby-claude-box-paste
/plugin install terminal-paste@codedby-claude-box-paste
```

Then initialize the plugin:

```
/terminal-paste:install
```

## Requirements

- Windows 10 or later
- PowerShell 5.1 or 7
- `winget` (Windows App Installer) — optional, fallbacks available

## License

MIT © codedby-kr-pdi

---

한국어 문서: [README.ko.md](./README.ko.md)
