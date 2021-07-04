; meta - tray icon
Menu, Tray, Icon, %A_ScriptDir%\img\logo.ico

; meta - Administrator
#SingleInstance Force
SetWorkingDir %A_ScriptDir%
if not A_IsAdmin
    Run *RunAs "%A_ScriptFullPath%",,hide

; meta - Load Directory
RegRead, OneDirec, HKCU, Software\Microsoft\OneDrive\Accounts\Business1, UserFolder

; meta - Modes
SetTitleMatchMode, 2
DetectHiddenWindows On
CoordMode, Mouse, Screen

; meta - Throttlestop
if FileExist("C:\Home\Usage\Prog\System\ThrottleStop\ThrottleStop.exe"){
    run C:\Home\Usage\Prog\System\ThrottleStop\ThrottleStop.exe
    WinWaitActive, ahk_exe ThrottleStop.exe
    Send, !{f4}
}

; meta - Regedit remove lock function for mouse
RegWrite, REG_DWORD, HKCU, SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System, DisableLockWorkstation, 000001
if (ErrorLevel = 1){
    MsgBox, regedit fail
}

; meta - Get monitor infor
Loop, %MONITOR_COUNT%
{
    SysGet, MonitorName, MonitorName, %A_Index%
    SysGet, Monitor%A_Index%, Monitor, %A_Index%
    SysGet, MonitorWorkArea, MonitorWorkArea, %A_Index%
}

; meta - Include lib
#Include %A_scriptDir%\lib\const.ahk
#Include %A_scriptDir%\lib\korean.ahk
#Include %A_scriptDir%\lib\template.ahk
#Include %A_scriptDir%\lib\text_func.ahk
#Include %A_scriptDir%\lib\mouse_func.ahk

; meta - Must lwin before lalt
; meta - Include right win
#Include %A_scriptDir%\src\right\mouse.ahk

; meta - Include win folder
#Include %A_scriptDir%\src\win\convention.ahk
#Include %A_scriptDir%\src\win\display_rotate.ahk
#Include %A_scriptDir%\src\win\app_shortcut.ahk
#Include %A_scriptDir%\src\win\global_win.ahk
