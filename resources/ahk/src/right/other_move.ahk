; meta - yp is next previous browser
Lalt & y::
    if (!GetKeyState("shift") && !GetKeyState("ctrl") && !GetKeyState("lwin"))
        send, ^+{tab}
    else if (GetKeyState("shift") && !GetKeyState("ctrl")){
    }
    else if (!GetKeyState("shift") && GetKeyState("ctrl"))
        send, ^1
    else if (GetKeyState("shift") && GetKeyState("ctrl")){
    }
    else if (GetKeyState("Lwin")){
    }
return

Lalt & p::
    if (!GetKeyState("shift") && !GetKeyState("ctrl") && !GetKeyState("lwin")) 
        send, ^{tab}
    else if (GetKeyState("shift") && !GetKeyState("ctrl")){
    }
    else if (!GetKeyState("shift") && GetKeyState("ctrl"))
        send, ^9
    else if (GetKeyState("shift") && GetKeyState("ctrl")){
    }
    else if (GetKeyState("Lwin")){
    }
return

