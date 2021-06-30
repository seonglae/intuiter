; meta - mouse move function

mouse_up(accel, max, cos, sin, axis){
    v = 0
    while (GetKeyState("i", "P")){
        if (GetKeyState("l", "P") and GetKeyState("i", "P")){
            while(GetKeyState("l", "P") and GetKeyState("i", "P")){
                MouseRelativeMove(cos * v, -sin * v)
                if(v < max)
                    v := v + accel
            }
            return
        }
        else if (GetKeyState("j", "P") and GetKeyState("i", "P")){
            while(GetKeyState("j", "P") and GetKeyState("i", "P")){
                MouseRelativeMove(-cos * v, -sin * v)
                if(v < max)
                    v := v + accel
            }
            return
        }
        else if (GetKeyState("i", "P") and !GetKeyState("j", "P") and !GetKeyState("l", "P")){
            while (GetKeyState("i", "P") and !GetKeyState("j", "P") and !GetKeyState("l", "P")){
                MouseRelativeMove(0, -axis * v)
                if(v < max)
                    v := v + accel
            }
            return
        }
    }
}

mouse_down(accel, max, cos, sin, axis){
    v = 0
    while (GetKeyState("k", "P")){
        if (GetKeyState("j", "P")  and GetKeyState("k", "P")){
            while(GetKeyState("j", "P") and GetKeyState("k", "P")){
                MouseRelativeMove(-cos * v, sin * v)
                if(v < max)
                    v := v + accel
            }
            return
        }

        else if (GetKeyState("l", "P")  and GetKeyState("k", "P")){
            while(GetKeyState("l", "P")  and GetKeyState("k", "P")){
                MouseRelativeMove(cos * v, sin * v)
                if(v < max)
                    v := v + accel
            }
            return
        }
        else if (GetKeyState("k","P") and !GetKeyState("j","P")  and !GetKeyState("l","P")){
            while (GetKeyState("k","P") and !GetKeyState("j","P")  and !GetKeyState("l","P")){
                MouseRelativeMove(0, axis * v)
                if(v < max)
                    v := v + accel
            }
            return
        }
    }
}

mouse_left(accel, max, cos, sin, axis){
    v = 0
    while (GetKeyState("j", "P")){
        if (GetKeyState("i", "P") and GetKeyState("j", "P")){
            while(GetKeyState("i", "P")and GetKeyState("j", "P")){
                MouseRelativeMove(-cos * v, -sin * v)
                if(v < max)
                    v := v + accel
            }
            return
        }
        else if (GetKeyState("k", "P") and GetKeyState("j", "P")){
            while(GetKeyState("k", "P") and GetKeyState("j", "P")){
                MouseRelativeMove(-cos * v, sin * v)
                if(v < max)
                    v := v + accel
            }
            return
        }
        else if (GetKeyState("j", "P") and !GetKeyState("i", "P") and !GetKeyState("k", "P")){
            while (GetKeyState("j", "P") and !GetKeyState("i", "P") and !GetKeyState("k", "P")){
                MouseRelativeMove( -axis * v, 0)
                if(v < max)
                    v := v + accel
            }
            return
        }
    }
}

mouse_right(accel, max, cos, sin, axis){
    v = 0
    while (GetKeyState("l", "P")){
        if (GetKeyState("k", "P") and GetKeyState("l", "P")){
            while(GetKeyState("k", "P") and GetKeyState("l", "P")){
                MouseRelativeMove(cos * v, sin * v)
                if(v < max)
                    v := v + accel
            }
            return
        }
        else if (GetKeyState("i", "P") and GetKeyState("l", "P")){
            while(GetKeyState("i", "P")and GetKeyState("l", "P")){
                MouseRelativeMove(cos * v, -sin * v)
                if(v < max)
                    v := v + accel
            }
            return
        }
        else if (GetKeyState("l", "P") and !GetKeyState("k", "P") and !GetKeyState("i", "P")){
            while (GetKeyState("l", "P") and !GetKeyState("k", "P") and !GetKeyState("i", "P")){
            MouseRelativeMove(axis * v, 0)
            if(v < max)
                v := v + accel
            }
        }
        return
    }
}

MouseRelativeMove(x, y){
    DllCall("mouse_event", "UInt",0x0001, "Int",x, "Int", y)
    sleep 1
    return
}

; meta - scroll function

scroll_down(key){
    a_divider = 3
    while (GetKeyState(key, "P")){
        Click WheelDown
        sleep 500 / a_divider + 1
        a_divider := a_divider + 1
    }
}

scroll_up(key){
    a_divider = 3
    while (GetKeyState(key, "P")){
        Click Wheelup
        sleep 500 / a_divider
        a_divider := a_divider + 1
    }
}

scroll_left(key){
    a_divider = 3
    while (GetKeyState(key, "P")){
        Click WheelLeft
        sleep 500 / a_divider
        a_divider := a_divider + 1
    }
}

scroll_right(key){
    a_divider = 3
    while (GetKeyState(key, "P")){
        Click WheelRight
        sleep 500 / a_divider
        a_divider := a_divider + 1
    }
}


; meta - mouse click
click_left(key){
    DllCall("mouse_event", "UInt", 0x02)
    KeyWait, %key%
    DllCall("mouse_event", "UInt", 0x04)
}

click_right(key){
    DllCall("mouse_event", "UInt", 0x08)
    KeyWait, %key%
    DllCall("mouse_event", "UInt", 0x10)
}

click_mid(key){
    DllCall("mouse_event", "UInt", 0x20) ; middle button down
    KeyWait, %key%
    DllCall("mouse_event", "UInt", 0x40) ; middle button up
}
