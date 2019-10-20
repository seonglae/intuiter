; meta - application shortcuts

Lwin & c::
    
    if (!GetKeyState("shift")){
        Run *Runas cmd.exe /c Code,,hide
    }
    else if (GetKeyState("shift")){
        send #c
    }
return

Lwin & n::
    if (!GetKeyState("shift")){
        Run cmd.exe /c explorer.exe shell:appsFolder\DBA41F73.ColorNoteNotepadNotes_3jn8vbmxrzmj2!App,,hide
    }
    else if (GetKeyState("shift")){
        send #n
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
            run C:\Users\Seonglae\AppData\Local\hyper\Hyper.exe
        else
            send #h
    }
    else if (GetKeyState("shift")){
        send #h
    }
return