; =============================================================================
; Name ..........: Elite Dangerous Lanucher
; Description ...: Open Elite Dangerous Game and companion apps all in one go
; Platform ......: Windows 10
; Language ......: English (en-US)
; Author ........: Dylan Kinnett <dylan@nocategories.net>
; =============================================================================

; tray icon
; =============================================================================

I_Icon = elite.ico
IfExist, %I_Icon%
Menu, Tray, Icon, %I_Icon%
;return


;Blank Template written by GroggyOtter
#UseHook
;========================= Start Auto-Execution Section ========================
; Always run as admin
if not A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"  ; Requires v1.0.92.01+
   ExitApp
}

; Keeps script permanently running
#Persistent

; Determines how fast a script will run (affects CPU utilization).
; The value -1 means the script will run at it's max speed possible.
SetBatchLines, -1

; Avoids checking empty variables to see if they are environment variables.
; Recommended for performance and compatibility with future AutoHotkey releases.
; Disabled here because we're relying on environment variables. They're useful.
; #NoEnv

; Ensures that there is only a single instance of this script running.
#SingleInstance, Force
Process, Priority, ,High

; Makes a script unconditionally use its own folder as its working directory.
; Ensures a consistent starting directory.
SetWorkingDir %A_ScriptDir%

; sets title matching to search for "containing" instead of "exact"
SetTitleMatchMode, 2

; Recommended for new scripts due to its superior speed and reliability.
SendMode Input

DetectHiddenWindows, On
#WinActivateForce

GroupAdd, saveReload, %A_ScriptName%


; Main Script 
; =============================================================================

; hide all the things
Send {LWinDown}{d}{LWinUp}}

; Launchers -------------------------------------------------------------------
; Run programS. Note that most programs will require a FULL file path:

; Elite Observatory
; important to run from its own directory.
Run, %USERPROFILE%\AppData\Local\Elite Observatory\Observatory.exe, %USERPROFILE%\AppData\Local\Elite Observatory\

; the big ones, take a moment to load...
Run, C:\Program Files\EDDiscovery\EDDiscovery.exe
Run, C:\Program Files (x86)\Steam\steamapps\common\VoiceAttack\VoiceAttack.exe
Run, C:\Program Files (x86)\EDMarketConnector\EDMarketConnector.exe
; some others...
Run, C:\Program Files (x86)\Sidsoft\FirstContact\FirstContact.exe
Run, %USERPROFILE%\AppData\Local\Programs\EliteG19s\EliteG19s.Windows.exe
Run, %USERPROFILE%\AppData\Local\Elite Observatory\Observatory.exe
Run, %USERPROFILE%\AppData\Local\Programs\EliteG19s\EliteG19s.Windows.exe
Run, M:\Games\Elite Dangerous\Elite Dangerous Scout\EDScout.exe

; Unused Launchers ------------------------------------------------------------
; Run, M:\Games\Elite Dangerous\elite-toolbox-edtb\toolbox.exe
; EDDI can also run inside of voice attack, so it's disabled here
; "C:\Program Files (x86)\VoiceAttack\Apps\EDDI\EDDI.exe"

; hide all the things
Send {LWinDown}{d}{LWinUp}}

; Ironically Launch the Launcher now (steam requires this)
; Run, C:\Program Files (x86)\Steam\steamapps\common\Elite Dangerous\EDLaunch.exe
run, steam://rungameid/359320


; once the game is running, no more need for its launcher
Loop
{
    WinWait, ahk_exe EliteDangerous64.exe
    ;WinWaitClose, ahk_exe EliteDangerous64.exe
    WinClose, ahk_exe EDlaunch.exe
}



;; only after the game is actually running 
;; then open and then start Cougar Display
;; I think you even have to be logged into Open or wherever
;; better check the manual
;; Run, M:\Games\Elite Dangerous\Cougar Display\MFDCougar.exe







return

;======================== Save Reload / Quick Stop ========================
#IfWinActive, ahk_group saveReload

; Use Control+S to save your script and reload it at the same time.
~^s::
	TrayTip, Reloading updated script, %A_ScriptName%
	SetTimer, RemoveTrayTip, 1500
	Sleep, 1750
	Reload
return

; Removes any popped up tray tips.
RemoveTrayTip:
	SetTimer, RemoveTrayTip, Off 
	TrayTip 
return 

; Hard exit that just closes the script
^Esc::
ExitApp

#UseHook 
#IfWinActive


;======================== Experimental ========================







; Global hotstrings
; etc...

;============================== Program 1 ==============================
; Evertything between here and the next #IfWinActive will ONLY work in someProgram.exe
; This is called being "context sensitive"
; #IfWinActive, ahk_exe someProgram.exe



; #IfWinActive
;============================== ini Section ==============================
; Do not remove /* or */ from this section. Only modify if you're
; storing values to this file that need to be permanantly saved.
/*
[SavedVariables]
Key=Value
*/

;============================== End Script ==============================
