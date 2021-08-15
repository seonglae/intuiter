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
