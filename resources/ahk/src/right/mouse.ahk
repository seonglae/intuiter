; meta - mouse move

Lwin & i::
    if (!GetKeyState("shift") && !GetKeyState("ctrl")){
        mouse_up(V_ACCEL, MAX_V, X_V, Y_V, AXIS_V)
    }
    else if (GetKeyState("shift") && !GetKeyState("ctrl")){
        send, #i
    }
    else if (!GetKeyState("shift") && GetKeyState("ctrl")){
    }
return

Lwin & k::
    if (!GetKeyState("shift") && !GetKeyState("ctrl")){
        mouse_down(V_ACCEL, MAX_V, X_V, Y_V, AXIS_V)
    }
    else if (GetKeyState("shift") && !GetKeyState("ctrl")){
        send, #k
    }
    else if (!GetKeyState("shift") && GetKeyState("ctrl")){
    }
return

Lwin & j::
    if (!GetKeyState("shift") && !GetKeyState("ctrl")){
        mouse_left(V_ACCEL, MAX_V, X_V, Y_V, AXIS_V)
    }
    else if (GetKeyState("shift") && !GetKeyState("ctrl")){
        send, #j
    }
    else if (!GetKeyState("shift") && GetKeyState("ctrl")){
    }
return

Lwin & l::
    if (!GetKeyState("shift")){
        mouse_right(V_ACCEL, MAX_V, X_V, Y_V, AXIS_V)
    }
    else if (GetKeyState("shift")){
        run %windir%\System32\tsdiscon.exe
    }
return


; meta - scroll at win
Lwin & u::
    if (!GetKeyState("shift")){
         click_left("u")
    }
    else if (GetKeyState("shift")){
        Run *Runas cmd.exe /c explorer.exe shell:appsFolder\CanonicalGroupLimited.Ubuntu18.04onWindows_79rhkp1fndgsc!ubuntu1804,,hide
    }
return

Lwin & o::
    if (!GetKeyState("shift")){
        click_right("o")
        
    }
    else if (GetKeyState("shift")){
        send, #o
    }
return


; meta - mouse click
Lwin & p::
    if (!GetKeyState("shift")){
        scroll_down("p")
    }
    else if (GetKeyState("shift") and !GetKeyState("ctrl")){
        send, #p
    }
return

Lwin & w::
    if (!GetKeyState("shift")){
        click_left("w")
    }
    else if (GetKeyState("shift") and !GetKeyState("ctrl")){
        send, #w
    }
return

Lwin & y::
    if (!GetKeyState("shift")){
        scroll_up("y")
       
    }
    else if (GetKeyState("shift")){
        send, #y
    }
return

Lwin & m::
    if (!GetKeyState("shift")){
        click_mid("m")
    }
    else if (GetKeyState("shift")){
        send, #m
    }
return

; meta - mouse scroll global variable
Lalt & u::
    if (!GetKeyState("shift") && !GetKeyState("ctrl") && !GetKeyState("lwin")){
        scroll_up("u")
    }
    else if (GetKeyState("shift") && !GetKeyState("ctrl")){
        scroll_left("u")
    }
    else if (!GetKeyState("shift") && GetKeyState("ctrl")){
        
    }
    else if (GetKeyState("shift") && GetKeyState("ctrl")){
        send, {home}
    }
    else if (GetKeyState("Lwin")){
    }
Return

Lalt & o::
    if (!GetKeyState("shift") && !GetKeyState("ctrl") && !GetKeyState("lwin")){
        scroll_down("o")
    }
    else if (GetKeyState("shift") && !GetKeyState("ctrl")){
        scroll_right("o")
    }
    else if (!GetKeyState("shift") && GetKeyState("ctrl")){
        
    } 
    else if (GetKeyState("shift") && GetKeyState("ctrl")){
        send, {end}
    }
    else if (GetKeyState("Lwin")){
    }
Return