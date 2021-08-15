; meta - h enter, t right alt

Lalt & h::
    if (!GetKeyState("shift") && !GetKeyState("ctrl") && !GetKeyState("lwin"))
        send, {Enter}
    else if (GetKeyState("shift") && !GetKeyState("ctrl"))
        send, +{Enter}
    else if (!GetKeyState("shift") && GetKeyState("ctrl"))
        send, ^{Enter}
    else if (GetKeyState("shift") && GetKeyState("ctrl"))
        send, ^+{Enter}
    else if (GetKeyState("Lwin")){
    }
Return

; meta - large delete
Lalt & b::
    if (!GetKeyState("shift") && !GetKeyState("ctrl") && !GetKeyState("lwin"))
        send, ^{BackSpace}
    else if (GetKeyState("shift") && !GetKeyState("ctrl"))
        send, {BackSpace}
    else if (!GetKeyState("shift") && GetKeyState("ctrl"))
        send, +{home}{BackSpace}
    else if (GetKeyState("shift") && GetKeyState("ctrl"))
        send, +^{home}{BackSpace}
    else if (GetKeyState("Lwin")){
    }
Return

Lalt & n::
    if (!GetKeyState("shift") && !GetKeyState("ctrl") && !GetKeyState("lwin"))
        send, ^{Delete}
    else if (GetKeyState("shift") && !GetKeyState("ctrl"))
        send, {Delete}
    else if (!GetKeyState("shift") && GetKeyState("ctrl"))
        send, +{End}{BackSpace}
    else if (GetKeyState("shift") && GetKeyState("ctrl"))
        send, +^{End}{BackSpace}
    else if (GetKeyState("Lwin1")){
    }
Return

; meta - large delete

Lalt & x::
    if (!GetKeyState("shift") && !GetKeyState("ctrl") && !GetKeyState("lwin"))
        send {home}+{end}{delete}
    else if (GetKeyState("shift") && !GetKeyState("ctrl"))
        send {up}{end}+{down}+{end}{delete}
    else if (!GetKeyState("shift") && GetKeyState("ctrl"))
        send ^{left}+^{right}{BackSpace}
    else if (GetKeyState("shift") && GetKeyState("ctrl"))
        send ^{home}+^{end}{BackSpace}
    else if (GetKeyState("Lwin")){
    }
Return