; meta - mouse move
Lwin & i::
    if (!GetKeyState("shift"))
        mouse_up(V_ACCEL, MAX_V, X_V, Y_V, AXIS_V)
    else if (GetKeyState("shift") && !GetKeyState("ctrl"))
        send, #i
return

Lwin & k::
    if (!GetKeyState("shift"))
        mouse_down(V_ACCEL, MAX_V, X_V, Y_V, AXIS_V)
    else if (GetKeyState("shift") && !GetKeyState("ctrl"))
        send, #k
return

Lwin & j::
    if (!GetKeyState("shift"))
        mouse_left(V_ACCEL, MAX_V, X_V, Y_V, AXIS_V)
    else if (GetKeyState("shift") && !GetKeyState("ctrl"))
        send, #j
return

Lwin & l::
    if (!GetKeyState("shift"))
        mouse_right(V_ACCEL, MAX_V, X_V, Y_V, AXIS_V)
    else if (GetKeyState("shift"))
        run %windir%\System32\tsdiscon.exe
return

; meta - click
Lwin & u::
    click_left("u")
return

Lwin & o::
    if (!GetKeyState("shift"))
        click_right("o")
    else if (GetKeyState("shift"))
        send, #o
return

; meta - mouse click
Lwin & p::
    if (!GetKeyState("shift"))
        scroll_down("p")
    else if (GetKeyState("shift") and !GetKeyState("ctrl"))
        send, #p
return

Lwin & w::
    if (!GetKeyState("shift"))
        click_left("w")
    else if (GetKeyState("shift") and !GetKeyState("ctrl"))
        send, #w
return

Lwin & y::
    if (!GetKeyState("shift")){
    }
    else if (GetKeyState("shift"))
        send, #y
return

Lwin & `;::
if (!GetKeyState("shift"))
    scroll_down(":")
return

Lwin & m::
    if (!GetKeyState("shift"))
        click_mid("m")
    else if (GetKeyState("shift"))
        click_mid("m")
return

; meta - mouse scroll global variable
Lwin & h::
    if (!GetKeyState("shift"))
        scroll_up("h")
    else if (GetKeyState("shift"))
        send #h
return

Lalt & u::
    if (!GetKeyState("shift") && !GetKeyState("ctrl") && !GetKeyState("lwin"))
        scroll_up("u")
    else if (GetKeyState("shift") && !GetKeyState("ctrl"))
        scroll_left("u")
    else if (!GetKeyState("shift") && GetKeyState("ctrl"))
        scroll_up("u")
    else if (GetKeyState("shift") && GetKeyState("ctrl"))
        send, {home}
return

Lalt & o::
    if (!GetKeyState("shift") && !GetKeyState("ctrl") && !GetKeyState("lwin"))
        scroll_down("o")
    else if (GetKeyState("shift") && !GetKeyState("ctrl"))
        scroll_right("o")
    else if (!GetKeyState("shift") && GetKeyState("ctrl"))
        scroll_down("o")
    else if (GetKeyState("shift") && GetKeyState("ctrl"))
        send, {end}
return