; meta - mouse move function

mouse_up(accel, max, cos, sin, axis){
    v = 0
    while (GetKeyState("i", "P")){
        if (GetKeyState("l", "P"))
            while(GetKeyState("l", "P")){
                MouseRelativeMove(cos * v, -sin * v)
                if(v < max)
                    v := v + accel
            }
        else if (GetKeyState("j", "P"))
            while(GetKeyState("j", "P")){
                MouseRelativeMove(-cos * v, -sin * v)
                if(v < max)
                    v := v + accel
            }
        else if (GetKeyState("i", "P")){
            MouseRelativeMove(0, -axis * v)
            if(v < max)
                v := v + accel
        }
    }
}

mouse_down(accel, max, cos, sin, axis){
    v = 0
    while (GetKeyState("k", "P")){
        if (GetKeyState("l", "P"))
            while(GetKeyState("l", "P")){
                MouseRelativeMove(cos * v, sin * v)
                if(v < max)
                    v := v + accel
            }
        else if (GetKeyState("j", "P"))
            while(GetKeyState("j", "P")){
                MouseRelativeMove(-cos * v, sin * v)
                if(v < max)
                    v := v + accel
            }
        else if (GetKeyState("k","P")){
            MouseRelativeMove(0, axis * v)
            if(v < max)
                v := v + accel
        }
    }
}

mouse_left(accel, max, cos, sin, axis){
    v = 0
    while (GetKeyState("j", "P")){
        if (GetKeyState("k", "P"))
            while(GetKeyState("k", "P")){
                MouseRelativeMove(-cos * v, sin * v)
                if(v < max)
                    v := v + accel
            }
        else if (GetKeyState("i", "P"))
            while(GetKeyState("i", "P")){
                MouseRelativeMove(-cos * v, -sin * v)
                if(v < max)
                    v := v + accel
            }
        else if (GetKeyState("j", "P")){
            MouseRelativeMove( -axis * v, 0)
            if(v < max)
                v := v + accel
        }
    }
}

mouse_right(accel, max, cos, sin, axis){
    v = 0
    while (GetKeyState("l", "P")){
        if (GetKeyState("k", "P"))
            while(GetKeyState("k", "P")){
                MouseRelativeMove(cos * v, sin * v)
                if(v < max)
                    v := v + accel
            }
        else if (GetKeyState("i", "P"))
            while(GetKeyState("i", "P")){
                MouseRelativeMove(cos * v, -sin * v)
                if(v < max)
                    v := v + accel
            }
        else if (GetKeyState("l", "P")){
            MouseRelativeMove(axis * v, 0)
            if(v < max)
                v := v + accel
        }
    }
}

MouseRelativeMove(x, y){
    DllCall("mouse_event", "UInt",0x0001, "Int",x, "Int", y)
    sleep 1
    return
}

; meta - scroll function

scroll_down(){
    a_divider = 3
    while (GetKeyState("o", "P")){
        Click WheelDown
        sleep 500 / a_divider + 1
        a_divider := a_divider + 1
    }
}

scroll_up(){
    a_divider = 3
    while (GetKeyState("u", "P")){
        Click Wheelup
        sleep 500 / a_divider
        a_divider := a_divider + 1
    }
}

scroll_left(){
    a_divider = 3
    while (GetKeyState("u", "P")){
        Click WheelLeft
        sleep 500 / a_divider
        a_divider := a_divider + 1
    }
}

scroll_right(){
    a_divider = 3
    while (GetKeyState("o", "P")){
        Click WheelRight
        sleep 500 / a_divider
        a_divider := a_divider + 1
    }
}

; meta - toggle function
toggle_left(ByRef left_down){
    if (left_down = true){
        DllCall("mouse_event", "UInt", 0x04) ; left button up
        left_down := false
    }
    else{
        DllCall("mouse_event", "UInt", 0x02) ; left button down
        left_down := true
    }
}

toggle_mid(ByRef mid_down){
    if (mid_down = true){
        DllCall("mouse_event", "UInt", 0x40) ; middle button up
        mid_down := false
    }
    else{
        DllCall("mouse_event", "UInt", 0x20) ; middle button down
        mid_down := true
    }
}

; meta - mouse click
click_left(key){
    DllCall("mouse_event", "UInt", 0x02) ; left button up
    KeyWait, %key%
    DllCall("mouse_event", "UInt", 0x04) ; left button down
}

click_right(key){
    DllCall("mouse_event", "UInt", 0x08) ; left button up
    KeyWait, %key%
    DllCall("mouse_event", "UInt", 0x10) ; left button down
}
