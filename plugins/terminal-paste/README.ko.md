# terminal-paste

Windows 콘솔(conhost / pwsh / Windows Terminal)에서 Claude Code CLI 실행 시 **Shift+Insert** 및 **Ctrl+V** 붙여넣기를 활성화하는 플러그인.

AutoHotkey v2 스크립트로 클립보드 텍스트를 `SendText`로 직접 전송하여, Claude Code 프롬프트에 안정적으로 붙여넣기가 됩니다.

## 동작 방식

- `ConsoleWindowClass` (legacy conhost, pwsh) → Shift+Insert / Ctrl+V → 클립보드 텍스트 직접 전송
- `CASCADIA_HOSTING_WINDOW_CLASS` (Windows Terminal) → 동일
- 그 외 앱 → Shift+Insert를 표준 Ctrl+V로 매핑

## 슬래시 커맨드

| 커맨드 | 설명 |
|---|---|
| `/terminal-paste:install` | AutoHotkey 설치(winget/직접/choco 폴백 체인) + 즉시 실행 |
| `/terminal-paste:start` | 수동 실행 |
| `/terminal-paste:stop` | 실행 중인 프로세스 종료 |
| `/terminal-paste:uninstall` | 프로세스 종료 (AHK 본체는 유지) |

한국어 변형(`:install.ko`, `:start.ko` 등)도 함께 제공됩니다.

## 설치

```
/plugin marketplace add codedby-kr-pdi/codedby-claude-box-paste
/plugin install terminal-paste@codedby-claude-box-paste
/terminal-paste:install
```

최초 설치 시 AutoHotkey는 폴백 체인으로 설치됩니다: `winget` → autohotkey.com 직접 다운로드 → `choco`. 세 방법 모두 실패하면 안내 메시지가 출력됩니다.

### 자동 실행

설치가 끝나면 Claude Code 세션이 시작될 때마다 플러그인의 `SessionStart` 훅(`hooks/hooks.json`)이 AHK 스크립트를 자동 실행합니다. 이미 실행 중이면 아무 것도 하지 않습니다. 스크립트는 분리된 프로세스로 돌기 때문에 Claude Code를 꺼도 살아있고, 재부팅하거나 `/terminal-paste:stop`을 실행해야 종료됩니다.

## 요구사항

- **Windows 10 (1809 이상) 또는 Windows 11** — winget 의존
- **PowerShell 5.1 이상** (Windows 기본 포함) 또는 PowerShell 7
- **다음 중 하나 이상**: `winget`, 인터넷 연결(직접 다운로드), `choco`
- **UAC 허용 권한** — AHK 최초 설치 시 관리자 권한이 필요해 UAC 프롬프트가 뜸
- **64-bit Windows** — AutoHotkey v2 64-bit 필수

## 트러블슈팅

### 세 가지 설치 방법 모두 실패
스크립트가 실패 이력을 빨간 박스로 출력합니다. https://www.autohotkey.com/download/ 에서 AHK v2를 수동 설치한 뒤 `/terminal-paste:install`를 다시 실행하면 설치된 AHK를 자동 감지해 설치 단계를 건너뜁니다.

### UAC 프롬프트가 안 보임
Claude Code 창 뒤에 가려진 경우가 많습니다. 작업 표시줄에 깜빡이는 "사용자 계정 컨트롤" 아이콘을 확인하세요.

### ExecutionPolicy 거부 (기업 PC)
MDM/GPO로 PowerShell 실행 정책이 잠긴 환경에서는 `-ExecutionPolicy Bypass`가 무력화될 수 있습니다. IT 관리자에게 문의하거나 관리자 권한 PowerShell에서 수동 실행 필요.

### 이미 AHK가 설치된 PC
`Find-AutoHotkey`가 기존 설치를 탐지해 설치 단계를 건너뜁니다. UAC도 뜨지 않고 즉시 실행만 진행됩니다.

## 라이선스

MIT

---

English: [README.md](./README.md)
