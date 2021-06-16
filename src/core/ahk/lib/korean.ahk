; meta - for korean keyboard status check

IME_CHECK(WinTitle){
    WinGet,hWnd,ID,%WinTitle%
    Return Send_ImeControl(ImmGetDefaultIMEWnd(hWnd),0x005,"")
}

Send_ImeControl(DefaultIMEWnd, wParam, lParam){
    DetectSave := A_DetectHiddenWindows
    DetectHiddenWindows,ON
    SendMessage 0x283, wParam,lParam,,ahk_id %DefaultIMEWnd%
    if (DetectSave <> A_DetectHiddenWindows)
        DetectHiddenWindows,%DetectSave%
    return ErrorLevel
}

ImmGetDefaultIMEWnd(hWnd){
    return DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hWnd, Uint)
}

SendEng(tex){
    ret:=IME_CHECK("A") ; program in now
    if ret=1
        Send, {vk15sc1F2}
    SendInput %tex%
    if ret=1
        Send, {vk15sc1F2}
}
