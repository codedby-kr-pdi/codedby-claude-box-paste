# terminal-paste

Windows 콘솔(conhost / pwsh / Windows Terminal)에서 Claude Code CLI 실행 시 **Shift+Insert** 및 **Ctrl+V** 붙여넣기를 활성화하는 플러그인.

AutoHotkey v2 스크립트로 클립보드 텍스트를 `SendText`로 직접 전송하여, Claude Code 프롬프트에 안정적으로 붙여넣기가 된다.

## 동작 방식

- `ConsoleWindowClass` (legacy conhost, pwsh) → Shift+Insert / Ctrl+V → 클립보드 텍스트 직접 전송
- `CASCADIA_HOSTING_WINDOW_CLASS` (Windows Terminal) → 동일
- 그 외 앱 → Shift+Insert를 표준 Ctrl+V로 매핑

## 슬래시 커맨드

| 커맨드 | 설명 |
|---|---|
| `/terminal-paste:install` | AutoHotkey 설치(winget) + Startup 등록 + 즉시 실행 |
| `/terminal-paste:start` | 수동 실행 (재부팅 없이 적용) |
| `/terminal-paste:stop` | 실행 중인 프로세스 종료 |
| `/terminal-paste:uninstall` | Startup 해제 + 종료 (AHK 본체는 유지) |

## 설치

```
/plugin marketplace add codedby-kr/codedby-claude-box-paste
/plugin install terminal-paste@codedby-claude-box-paste
/terminal-paste:install
```

`install` 실행 시 AutoHotkey 미설치면 `winget`으로 설치되며 UAC 프롬프트가 뜰 수 있습니다.

## 요구사항

- Windows 10 이상
- PowerShell 5.1 또는 7
- `winget` (Windows App Installer)

## 라이선스

MIT
