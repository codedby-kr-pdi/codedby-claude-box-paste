---
description: AutoHotkey 설치 + Startup 자동 실행 등록 + 즉시 실행
allowed-tools: Bash(powershell.exe:*)
---

terminal-paste를 설치한다. 절차:
1. AutoHotkey v2 설치 여부 확인 → 없으면 winget으로 설치
2. `shift-insert-paste.ahk`를 사용자 Startup 폴더에 복사 (부팅 시 자동 실행)
3. 지금 바로 실행하여 Shift+Insert / Ctrl+V 붙여넣기 활성화

아래 명령을 실행한다:

```bash
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "${CLAUDE_PLUGIN_ROOT}/scripts/install.ps1"
```

winget이 AutoHotkey를 설치할 때 UAC 프롬프트가 뜰 수 있다 — 사용자에게 미리 안내한다.
