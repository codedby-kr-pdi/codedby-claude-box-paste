#Requires AutoHotkey v2.0
#SingleInstance Force

; Console (cmd, conhost, pwsh) -- send clipboard text directly
#HotIf WinActive("ahk_class ConsoleWindowClass")
+Insert::SendText(A_Clipboard)
^v::SendText(A_Clipboard)

; Windows Terminal
#HotIf WinActive("ahk_class CASCADIA_HOSTING_WINDOW_CLASS")
+Insert::SendText(A_Clipboard)
^v::SendText(A_Clipboard)

; All other apps -- fall back to standard paste (Ctrl+V)
#HotIf
+Insert::SendInput("^v")
