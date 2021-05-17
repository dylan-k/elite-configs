; closes Elite Dangerous Launcher, once the game has launched
; because what good is a launcher once the launch is done?
; author: https://forums.frontier.co.uk/threads/auto-close-launcher-when-game-starts.119468/
;
; How it works:
;  - sleep until Elite Dangerous is running
;  - sleep until Elite Dangerous closes
;  - close the launcher

#Persistent
#SingleInstance, force

Loop
{
    WinWait, ahk_exe EliteDangerous64.exe
    WinWaitClose, ahk_exe EliteDangerous64.exe
    WinClose, ahk_exe EDlaunch.exe
}
