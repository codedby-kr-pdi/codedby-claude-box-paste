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
/plugin marketplace add codedby-kr-pdi/codedby-claude-box-paste
/plugin install terminal-paste@codedby-claude-box-paste
/terminal-paste:install
```

`install` 실행 시 AutoHotkey 미설치면 `winget`으로 설치되며 UAC 프롬프트가 뜰 수 있습니다.

## 요구사항

- **Windows 10 (1809 이상) 또는 Windows 11** — `[Environment]::GetFolderPath('Startup')` 및 `winget` 의존
- **PowerShell 5.1 이상** (Windows 기본 포함) 또는 PowerShell 7
- **`winget` (Windows App Installer)** — 구버전 Windows 10 / LTSC / Server에는 기본 미포함. Microsoft Store에서 "앱 설치 관리자"로 설치
- **인터넷 연결** — winget이 AutoHotkey를 다운로드
- **사용자 본인의 UAC 허용 권한** — AHK 최초 설치 시 winget이 관리자 권한을 요구하므로 UAC 프롬프트가 뜸
- **AutoHotkey v2 64-bit 호환 환경** — 64-bit Windows 필요 (32-bit Windows는 비지원)

## 트러블슈팅

### `winget: command not found` 류 오류
Windows App Installer 미설치 환경입니다. Microsoft Store에서 "앱 설치 관리자" 설치 후 재시도.

### UAC 프롬프트가 안 보임
Claude Code 창 뒤에 가려진 경우가 많습니다. 작업 표시줄에 깜빡이는 "사용자 계정 컨트롤" 아이콘을 확인하세요.

### ExecutionPolicy 거부 (기업 PC)
MDM/GPO로 PowerShell 실행 정책이 잠긴 환경에서는 `-ExecutionPolicy Bypass`가 무력화될 수 있습니다. IT 관리자에게 문의하거나 관리자 권한의 PowerShell에서 수동 실행 필요.

### 이미 AHK가 설치된 PC
`Find-AutoHotkey`가 기존 설치를 탐지해 winget 단계를 건너뜁니다. UAC도 뜨지 않고 Startup 등록 + 프로세스 실행만 진행됩니다.

## 라이선스

MIT
