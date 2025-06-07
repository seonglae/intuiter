Lalt & w::
    if (!GetKeyState("shift") && !GetKeyState("ctrl") && !GetKeyState("lwin")){
        press_count = 1
        while (GetKeyState("lalt", "P")){
            KeyWait, w, D
            if (press_count = 1){
                send, {left}^{right}+^{left}
                press_count += 1
            }
            else if (press_count = 2){
                send, {end}+{home}
                return
            }
            sleep 50
            if (A_PriorKey != "w" and A_PriorKey != "")
                return
        }
    }
    else if (GetKeyState("shift") && !GetKeyState("ctrl"))
        send, {home}+{end}
    else if (!GetKeyState("shift") && GetKeyState("ctrl"))
        send, {up}{end}+{down}+{end}
    else if (GetKeyState("shift") && GetKeyState("ctrl")){
    }
    else if (GetKeyState("Lwin")){
    }
return

Lalt & a::
    if (!GetKeyState("shift") && !GetKeyState("ctrl") && !GetKeyState("lwin")){
        press_count = 1
        while (GetKeyState("lalt", "P")){
            KeyWait, a, D
            if (press_count == 1){
                send, {end}+{home}
                press_count += 1
            }
            else if (press_count == 2){
                send, {up}{end}+{down}+{end}
                press_count -= 1
            }
            sleep 50
            if (A_PriorKey != "a")
                return
        }
    }
    else if (GetKeyState("shift") && !GetKeyState("ctrl")){
    }
    else if (!GetKeyState("shift") && GetKeyState("ctrl")){
    }
    else if (GetKeyState("shift") && GetKeyState("ctrl")){
    }
    else if (GetKeyState("Lwin")){
    }
return