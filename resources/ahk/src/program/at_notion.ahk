; todo - add gui where to shortcut work per program extension - plus notion.exe
; meta - notion - whale, chrome, edge
#If WinActive("ahk_exe whale.exe") or WinActive("ahk_exe chrome.exe") or WinActive("Edge") or WinActive("ahk_exe msedge.exe")

; meta - enter notion
Lalt & `::
    Send, ^t
    SendEng("notion.so")
    Send,{Enter}
return

; meta - notion block shortcut
Lalt & 1::
    if (!GetKeyState("shift") && !GetKeyState("ctrl") && !GetKeyState("lwin")){
        Send, ^+1
        send, {Enter}---{Enter 5}
    }
    else if (GetKeyState("shift") && !GetKeyState("ctrl"))
        send, ^+1
    else if (!GetKeyState("shift") && GetKeyState("ctrl"))
        send, ^!1
    else if (GetKeyState("shift") && GetKeyState("ctrl")){
    }
    else if (GetKeyState("Lwin")){
    }
return

Lalt & 3::
    if (!GetKeyState("shift") && !GetKeyState("ctrl") && !GetKeyState("lwin"))
        Send, ^+3
    else if (GetKeyState("shift") && !GetKeyState("ctrl"))
        send, ^+3
    else if (!GetKeyState("shift") && GetKeyState("ctrl"))
        send, ^!3
    else if (GetKeyState("shift") && GetKeyState("ctrl")){
    }
    else if (GetKeyState("Lwin")){
    }
return

Lalt & 5::
    if (!GetKeyState("shift") && !GetKeyState("ctrl") && !GetKeyState("lwin"))
        Send, ^+5
    else if (GetKeyState("shift") && !GetKeyState("ctrl"))
        send, ^+5
    else if (!GetKeyState("shift") && GetKeyState("ctrl"))
        send, ^!5
    else if (GetKeyState("shift") && GetKeyState("ctrl")){
    }
    else if (GetKeyState("Lwin")){
    }
return

Lalt & 9::
    if (!GetKeyState("shift") && !GetKeyState("ctrl") && !GetKeyState("lwin"))
        Send, ^+9
    else if (GetKeyState("shift") && !GetKeyState("ctrl"))
        send, +^9
    else if (!GetKeyState("shift") && GetKeyState("ctrl"))
        send, ^!9
    else if (GetKeyState("shift") && GetKeyState("ctrl")){
    }
    else if (GetKeyState("Lwin")){
    }
return

