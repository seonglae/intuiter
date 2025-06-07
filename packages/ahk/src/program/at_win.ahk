; meta - windows system
#If WinActive("ahk_exe Explorer.EXE") or WinActive("Program Manager")
    
f1::
    Msgbox, 4, AHK, Empty Recycle bin?, 5
    ifMsgbox, Yes
    {   
        FileRecycleEmpty
    }
return

lalt & p::
    send ,!p
return