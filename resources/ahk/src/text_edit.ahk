Lalt & h::
    if (!GetKeyState("shift") && !GetKeyState("ctrl") && !GetKeyState("lwin"))
        send, {home}
    else if (GetKeyState("shift") && !GetKeyState("ctrl"))
        send, +{home}
    else if (!GetKeyState("shift") && GetKeyState("ctrl"))
        send, ^{home}
    else if (GetKeyState("shift") && GetKeyState("ctrl"))
        send, ^+{home}
return

Lalt & `;::
if (!GetKeyState("shift") && !GetKeyState("ctrl") && !GetKeyState("lwin"))
    send, {end}
else if (GetKeyState("shift") && !GetKeyState("ctrl"))
    send, +{end}
else if (!GetKeyState("shift") && GetKeyState("ctrl"))
    send, ^{end}
else if (GetKeyState("shift") && GetKeyState("ctrl"))
    send, ^+{end}
return

Lalt & Enter::
    if (!GetKeyState("shift") && !GetKeyState("ctrl") && !GetKeyState("lwin")){
        send, {end}
        send, {enter}
    }
return

Lalt & '::
    if (!GetKeyState("shift") && !GetKeyState("ctrl") && !GetKeyState("lwin")){
        send, {home}
        send, {enter}
        send, {up}
    }
return

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
return

Lalt & n::
    if (!GetKeyState("shift") && !GetKeyState("ctrl") && !GetKeyState("lwin"))
        send, ^{Delete}
    else if (GetKeyState("shift") && !GetKeyState("ctrl"))
        send, {Delete}
    else if (!GetKeyState("shift") && GetKeyState("ctrl"))
        send, +{End}{BackSpace}
    else if (GetKeyState("shift") && GetKeyState("ctrl"))
        send, +^{End}{BackSpace}
return

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
return