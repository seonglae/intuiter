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

Lwin & h::
    if (!GetKeyState("shift")){
        if FileExist("C:\Users\Seonglae\AppData\Local\hyper\Hyper.exe")
            run *Runas C:\Users\Seonglae\AppData\Local\hyper\Hyper.exe
        else
            send #h
    }
    else if (GetKeyState("shift")){
        send #h
    }
return