---
description: terminal-paste AHK 스크립트를 수동으로 실행 (재부팅 없이)
allowed-tools: Bash(powershell.exe:*)
---

AHK 스크립트를 지금 실행한다. 이미 실행 중이면 재시작.

```bash
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "${CLAUDE_PLUGIN_ROOT}/scripts/start.ps1"
```
