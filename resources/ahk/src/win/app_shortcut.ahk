; meta - application shortcuts

Lwin & c::
    
    if (!GetKeyState("shift")){
        Run *Runas cmd.exe /c Code,,hide
    }
    else if (GetKeyState("shift")){
        send #c
    }
return

; meta - windows terminal
Lwin & t::
    if (!GetKeyState("shift")){
        Run *Runas cmd.exe /c explorer.exe shell:appsFolder\Microsoft.WindowsTerminal_8wekyb3d8bbwe!App,,hide
    }
    else if (GetKeyState("shift")){
        send #t
    }
return
