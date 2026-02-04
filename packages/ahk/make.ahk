; Administrator and Set Options
#NoTrayIcon
#SingleInstance Force

SetWorkingDir %A_ScriptDir%

if not A_IsAdmin
    Run *RunAs "%A_ScriptFullPath%"

; meta - kill process
Run, %comspec% /c taskkill /im Intuit.exe, , Hide
Process, WaitClose, Intuit.exe

; meta - check previous file and remove
if FileExist("Intuit.exe"){
    FileDelete, Intuit.exe
    while (FileExist("Intuit.exe"))
        sleep 1
}

; meta - Make EXE
Run *Runas cmd.exe /c ""exe\ahk\Ahk2Exe.exe" /in "runner.ahk" /icon "img\logo.ico" /out Intuit.exe",,hide

; meta - if made then run
while(true)
if FileExist("Intuit.exe"){
    run "Intuit.exe"
    break
}

Exitapp
