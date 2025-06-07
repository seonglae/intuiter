; meta - application shortcuts

Lwin & c::
    if (!GetKeyState("shift") && !GetKeyState("ctrl"))
        Run cmd.exe /c "code-insiders || code",,hide
    else if (!GetKeyState("shift") && GetKeyState("ctrl"))
        Run *Runas cmd.exe /c "code-insiders || code",,hide
    else if (GetKeyState("shift") && !GetKeyState("ctrl"))
        send #c
return

; meta - windows terminal
Lwin & t::
    if (!GetKeyState("shift") && !GetKeyState("ctrl"))
        Run cmd.exe /c "explorer.exe shell:appsFolder\Microsoft.WindowsTerminal_8wekyb3d8bbwe!App",,hide
    else if (!GetKeyState("shift") && GetKeyState("ctrl"))
        Run *Runas cmd.exe /c "explorer.exe shell:appsFolder\Microsoft.WindowsTerminal_8wekyb3d8bbwe!App",,hide
    else if (GetKeyState("shift") && !GetKeyState("ctrl"))
        send #t
return

; meta - custom application hotkeys for Win+1..0
Loop, 10
{
    num := A_Index
    if (num = 10)
        num := 0
    Hotkey, % "Lwin & " num "::", Func("HandleHotkey").Bind(num)
}

HandleHotkey(num) {
    if (!GetKeyState("shift") && !GetKeyState("ctrl"))
        Run % CUSTOM_APP_PATH_%num%,,hide
    else if (!GetKeyState("shift") && GetKeyState("ctrl"))
        Run *Runas % CUSTOM_APP_PATH_%num%,,hide
    else if (GetKeyState("shift") && !GetKeyState("ctrl"))
        send #%num%
}
Lwin & 6::
    if (!GetKeyState("shift") && !GetKeyState("ctrl"))
        Run %CUSTOM_APP_PATH_6%,,hide
    else if (!GetKeyState("shift") && GetKeyState("ctrl"))
        Run *Runas %CUSTOM_APP_PATH_6%,,hide
    else if (GetKeyState("shift") && !GetKeyState("ctrl"))
        send #6
return

Lwin & 7::
    if (!GetKeyState("shift") && !GetKeyState("ctrl"))
        Run %CUSTOM_APP_PATH_7%,,hide
    else if (!GetKeyState("shift") && GetKeyState("ctrl"))
        Run *Runas %CUSTOM_APP_PATH_7%,,hide
    else if (GetKeyState("shift") && !GetKeyState("ctrl"))
        send #7
return

Lwin & 8::
    if (!GetKeyState("shift") && !GetKeyState("ctrl"))
        Run %CUSTOM_APP_PATH_8%,,hide
    else if (!GetKeyState("shift") && GetKeyState("ctrl"))
        Run *Runas %CUSTOM_APP_PATH_8%,,hide
    else if (GetKeyState("shift") && !GetKeyState("ctrl"))
        send #8
return

Lwin & 9::
    if (!GetKeyState("shift") && !GetKeyState("ctrl"))
        Run %CUSTOM_APP_PATH_9%,,hide
    else if (!GetKeyState("shift") && GetKeyState("ctrl"))
        Run *Runas %CUSTOM_APP_PATH_9%,,hide
    else if (GetKeyState("shift") && !GetKeyState("ctrl"))
        send #9
return

Lwin & 0::
    if (!GetKeyState("shift") && !GetKeyState("ctrl"))
        Run %CUSTOM_APP_PATH_0%,,hide
    else if (!GetKeyState("shift") && GetKeyState("ctrl"))
        Run *Runas %CUSTOM_APP_PATH_0%,,hide
    else if (GetKeyState("shift") && !GetKeyState("ctrl"))
        send #0
return
