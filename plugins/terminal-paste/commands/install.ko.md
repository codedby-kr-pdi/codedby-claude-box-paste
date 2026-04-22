---
description: AutoHotkey 설치(폴백 체인) + 붙여넣기 스크립트 즉시 실행
allowed-tools: Bash(powershell.exe:*)
---

terminal-paste를 설치한다. 절차:
1. AutoHotkey v2 미설치면 폴백 체인으로 설치 시도: winget → autohotkey.com 직접 다운로드 → Chocolatey
2. AHK 스크립트를 즉시 실행하여 Shift+Insert / Ctrl+V 붙여넣기 활성화

이후 Claude Code를 띄울 때마다 자동 실행되는 것은 플러그인의 `SessionStart` 훅이 처리한다 — Windows Startup 등록 불필요.

아래 명령을 실행한다:

```bash
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "${CLAUDE_PLUGIN_ROOT}/scripts/install.ps1"
```

winget/choco가 AutoHotkey를 설치할 때 UAC 프롬프트가 뜰 수 있다 — 사용자에게 미리 안내한다. 세 방법 모두 실패 시 스크립트가 수동 설치 안내 메시지를 출력한다.
