; meta - move - default - for fast move

Lalt & i::
    if (!GetKeyState("shift") && !GetKeyState("ctrl") && !GetKeyState("lwin"))
        send, {up}
    else if (GetKeyState("shift") && !GetKeyState("ctrl"))
        send, +{up}
    else if (!GetKeyState("shift") && GetKeyState("ctrl")){
        while (GetKeyState("i", "P")){
            send, {up}
            sleep 1
        }
    }
    else if (GetKeyState("shift") && GetKeyState("ctrl")){
        while (GetKeyState("i", "P")){
            send, +{up}
            sleep 1
        }
    }
    else if (GetKeyState("Lwin"))
        send !{up}
return

Lalt & k::
    if (!GetKeyState("shift") && !GetKeyState("ctrl") && !GetKeyState("lwin"))
        send, {down}
    else if (GetKeyState("shift") && !GetKeyState("ctrl"))
        send, +{down}
    else if (!GetKeyState("shift") && GetKeyState("ctrl")){
        while (GetKeyState("k", "P")){
            send, {down}
            sleep 1
        }
    }
    else if (GetKeyState("shift") && GetKeyState("ctrl")){
        while (GetKeyState("k", "P")){
            send, +{down}
            sleep 1
        }
    }
    else if (GetKeyState("Lwin"))
        send !{down}
return

Lalt & j::
    if (!GetKeyState("shift") && !GetKeyState("ctrl") && !GetKeyState("lwin"))
        send, ^{Left}
    else if (GetKeyState("shift") && !GetKeyState("ctrl"))
        send, +^{Left}
    else if (!GetKeyState("shift") && GetKeyState("ctrl")){
        while (GetKeyState("j", "P")){
            send, {left}
            sleep 1
        }
    }
    else if (GetKeyState("shift") && GetKeyState("ctrl"))
        send, +{home}
    else if (GetKeyState("Lwin"))
        send !{left}
return

Lalt & l::
    if (!GetKeyState("shift") && !GetKeyState("ctrl") && !GetKeyState("lwin"))
        send, ^{Right}
    else if (GetKeyState("shift") && !GetKeyState("ctrl"))
        send, +^{Right}
    else if (!GetKeyState("shift") && GetKeyState("ctrl")){
        while (GetKeyState("l", "P")){
            send, {right}
            sleep 1
        }
    }
    else if (GetKeyState("shift") && GetKeyState("ctrl"))
        send, +{end}
    else if (GetKeyState("Lwin"))
        send !{right}
return