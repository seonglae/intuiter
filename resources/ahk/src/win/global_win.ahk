; meta - run, %comspec% /c COMMAND,,hide
; meta - %comspec% points to cmd.exe
; meta - Run, Target, WorkingDir, Options, OutputVarPID
; meta - RunWait, Target, WorkingDir, Options, OutputVarPID
; meta - runas - administartor, hide - hide cmd

; meta - sleep with no asking
Lwin & s::
    if (!GetKeyState("lalt") and GetKeyState("shift"))
        send, +#s
    else if (!GetKeyState("lalt") and !GetKeyState("shift") and !GetKeyState("ctrl")){
        Msgbox, 4, AHK, Sleep Windows?, 5
        ifMsgbox, Yes
        {
            Send, #x
            sleep 100
            SendInput, ui
        }
    }
return

Lwin & q::
    if (GetKeyState("shift")){
        Msgbox, 4, AHK, Shutdown Windows?, 5
        ifMsgbox, Yes
        {
            Run *Runas cmd.exe /c shutdown -s -t 0,,hide
        }
    }
    else if (!GetKeyState("shift"))
        send #q
return

Lwin & r::
    if (GetKeyState("shift") and !GetKeyState("lalt")){
        Msgbox, 4, AHK, Restart Windows?, 5
        ifMsgbox, Yes
        {
            Run *Runas cmd.exe /c shutdown /r -t 0,,,hide
        }
    }
    else if (!GetKeyState("shift") and !GetKeyState("lalt")){
        send #r
    }
return

; meta - autohotkey meta
Lalt & r::
    if (!GetKeyState("shift") && !GetKeyState("ctrl") && !GetKeyState("lwin")){
        MsgBox ,,AHK, Reload Start
        Reload
    }
    else if (GetKeyState("shift") && !GetKeyState("ctrl"))
        send, +!r
    else if (!GetKeyState("shift") && GetKeyState("ctrl"))
        send !^r
    else if (GetKeyState("shift") && GetKeyState("ctrl"))
        send, !+^r
return

Lalt & q::
    if (!GetKeyState("shift") && !GetKeyState("ctrl") && !GetKeyState("lwin"))
        send, {esc}
    else if (GetKeyState("shift") && !GetKeyState("ctrl")){
        Msgbox, 4, AHK, AHK Exit and Restore Lock Feature?, 5
        ifMsgbox, Yes
        {
            RegWrite, REG_DWORD, HKCU, SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System, DisableLockWorkstation, 000000
            if (ErrorLevel = 1)
                MsgBox, regedit fail
            Exitapp
        }
    }
    else if (!GetKeyState("shift") && GetKeyState("ctrl"))
        send, !^q
    else if (GetKeyState("shift") && GetKeyState("ctrl"))
        send, !+^q
    else if (GetKeyState("Lwin")){
        if FileExist("exe\screen_save.lnk")
            Run exe\screen_save
        else
            run C:\Windows\System32\scrnsave.scr
        return 
    }
return

; meta - alt included
Lalt & t::
    if (!GetKeyState("shift") && !GetKeyState("ctrl") && !GetKeyState("lwin")){
    }
    else if (GetKeyState("shift") && !GetKeyState("ctrl")){
    }
    else if (!GetKeyState("shift") && GetKeyState("ctrl"))
        Run *Runas cmd.exe
    else if (GetKeyState("shift") && GetKeyState("ctrl")){
    }
    else if (GetKeyState("Lwin")){
    }
return

Lalt & m::
    if (!GetKeyState("shift") && !GetKeyState("ctrl") && !GetKeyState("lwin")){
        Run cmd.exe /c explorer.exe shell:Downloads,,hide
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