; meta - virtual desktop switch

VDA_Load(){
    global hVDA, GoToDesktopNumberProc, MoveWindowToDesktopNumberProc
    if (!hVDA){
        hVDA := DllCall("LoadLibrary", "Str", A_ScriptDir "\exe\VirtualDesktopAccessor.dll", "Ptr")
        GoToDesktopNumberProc := DllCall("GetProcAddress", "Ptr", hVDA, "AStr", "GoToDesktopNumber", "Ptr")
        MoveWindowToDesktopNumberProc := DllCall("GetProcAddress", "Ptr", hVDA, "AStr", "MoveWindowToDesktopNumber", "Ptr")
    }
}

MoveOrGotoDesktopNumber(num){
    global GoToDesktopNumberProc, MoveWindowToDesktopNumberProc
    if (!hVDA)
        VDA_Load()
    if (GetKeyState("LButton")){
        WinGet, activeHwnd, ID, A
        DllCall(MoveWindowToDesktopNumberProc, "Ptr", activeHwnd, "Int", num)
    }
    DllCall(GoToDesktopNumberProc, "Int", num)
}

; switch desktops with Ctrl+Win+number
^#1::MoveOrGotoDesktopNumber(0)
^#2::MoveOrGotoDesktopNumber(1)
^#3::MoveOrGotoDesktopNumber(2)
^#4::MoveOrGotoDesktopNumber(3)
^#5::MoveOrGotoDesktopNumber(4)
^#6::MoveOrGotoDesktopNumber(5)
^#7::MoveOrGotoDesktopNumber(6)
^#8::MoveOrGotoDesktopNumber(7)
^#9::MoveOrGotoDesktopNumber(8)
return
