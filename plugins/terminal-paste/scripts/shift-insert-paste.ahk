#Requires AutoHotkey v2.0
#SingleInstance Force

; 콘솔 (cmd, conhost, pwsh) — 클립보드 텍스트를 직접 전송
#HotIf WinActive("ahk_class ConsoleWindowClass")
+Insert::SendText(A_Clipboard)
^v::SendText(A_Clipboard)

; Windows Terminal
#HotIf WinActive("ahk_class CASCADIA_HOSTING_WINDOW_CLASS")
+Insert::SendText(A_Clipboard)
^v::SendText(A_Clipboard)

; 그 외 모든 앱 — 표준 붙여넣기(Ctrl+V)로 대체
#HotIf
+Insert::SendInput("^v")
