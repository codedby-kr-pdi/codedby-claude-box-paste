---
description: Startup 자동 실행 해제 + 프로세스 종료 (AutoHotkey 본체는 유지)
allowed-tools: Bash(powershell.exe:*)
---

terminal-paste 자동 실행을 해제한다. AutoHotkey 본체는 남겨둔다 (다른 스크립트에서 쓸 수 있으므로).

```bash
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "${CLAUDE_PLUGIN_ROOT}/scripts/uninstall.ps1"
```

AutoHotkey까지 완전 제거하려면 사용자에게 `winget uninstall AutoHotkey.AutoHotkey` 안내.
