; meta - display rotate 

Lalt & up::
    if (!GetKeyState("shift") && !GetKeyState("ctrl") && !GetKeyState("lwin"))
        send, !{up}
    else if (!GetKeyState("shift") && GetKeyState("ctrl")){
        InputBox, display_num, Display Choose, What number of Display
        run, %comspec% /c "exe\display\display64.exe" /device %display_num% /rotate 0 ,,hide
        run, %comspec% /c "exe\display\display32.exe" /device %display_num% /rotate 0 ,,hide
    }
return

Lalt & left::
    if (!GetKeyState("shift") && !GetKeyState("ctrl") && !GetKeyState("lwin"))
        send, !{left}
    else if (!GetKeyState("shift") && GetKeyState("ctrl")){
        InputBox, display_num, Display Choose, What number of Display
        run, %comspec% /c "exe\display\display64.exe" /device %display_num% /rotate 90,,hide
        run, %comspec% /c "exe\display\display32.exe" /device %display_num% /rotate 90,,hide
    }
return

Lalt & right::
    if (!GetKeyState("shift") && !GetKeyState("ctrl") && !GetKeyState("lwin"))
        send, !{right}
    else if (!GetKeyState("shift") && GetKeyState("ctrl")){
        InputBox, display_num, Display Choose, What number of Display
        run, %comspec% /c "exe\display\display64.exe" /device %display_num% /rotate 270,,hide
        run, %comspec% /c "exe\display\display32.exe" /device %display_num% /rotate 270,,hide
    }
return

Lalt & down::
    if (!GetKeyState("shift") && !GetKeyState("ctrl") && !GetKeyState("lwin"))
        send, !{down}
    else if (!GetKeyState("shift") && GetKeyState("ctrl")){
        InputBox, display_num, Display Choose, What number of Display
        run, %comspec% /c "exe\display\display64.exe" /device %display_num% /rotate 180 ,,hide
        run, %comspec% /c "exe\display\display32.exe" /device %display_num% /rotate 180 ,,hide
    }
return