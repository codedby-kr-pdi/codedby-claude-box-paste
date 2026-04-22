---
description: 실행 중인 프로세스 종료 (AutoHotkey 본체는 유지)
allowed-tools: Bash(powershell.exe:*)
---

실행 중인 AHK 스크립트를 종료한다. AutoHotkey 본체는 남겨둔다 (다른 스크립트에서 쓸 수 있으므로). 자동 실행(SessionStart 훅)은 플러그인 디렉토리에 포함돼 있으므로 플러그인 제거와 동시에 비활성화된다.

```bash
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "${CLAUDE_PLUGIN_ROOT}/scripts/uninstall.ps1"
```

AutoHotkey까지 완전 제거하려면 사용자에게 `winget uninstall AutoHotkey.AutoHotkey` 안내.
