; meta - move - asdw - for accurate move

Lalt & s::
    if (!GetKeyState("shift") && !GetKeyState("ctrl") && !GetKeyState("lwin"))
        send, {left}
    else if (GetKeyState("shift") && !GetKeyState("ctrl"))
        send, +{left}
    else if (!GetKeyState("shift") && GetKeyState("ctrl"))
        send, +!s
    else if (GetKeyState("shift") && GetKeyState("ctrl"))
        send, +!^s
    else if (GetKeyState("Lwin"))
        send, #{left}
return

Lalt & f::
    if (!GetKeyState("shift") && !GetKeyState("ctrl") && !GetKeyState("lwin"))
        send, {Right}
    else if (GetKeyState("shift") && !GetKeyState("ctrl"))
        send, +{Right}
    else if (!GetKeyState("shift") && GetKeyState("ctrl"))
        send, +!f
    else if (GetKeyState("shift") && GetKeyState("ctrl"))
        send, +!^f
    else if (GetKeyState("Lwin"))
        send, #{right}
return

Lalt & e::
    if (!GetKeyState("shift") && !GetKeyState("ctrl") && !GetKeyState("lwin"))
        send, {up}
    else if (GetKeyState("shift") && !GetKeyState("ctrl"))
        send, +{up}
    else if (!GetKeyState("shift") && GetKeyState("ctrl"))
        send, +!e
    else if (GetKeyState("shift") && GetKeyState("ctrl"))
        send, +!^e
    else if (GetKeyState("Lwin"))
        send #{up} 
return

Lalt & d::
    if (!GetKeyState("shift") && !GetKeyState("ctrl") && !GetKeyState("lwin"))
        send, {down}
    else if (GetKeyState("shift") && !GetKeyState("ctrl"))
        send, +{down}
    else if (!GetKeyState("shift") && GetKeyState("ctrl"))
        send, +!d
    else if (GetKeyState("shift") && GetKeyState("ctrl"))
        send +!^d
    else if (GetKeyState("Lwin"))
        send, #{down}
return
