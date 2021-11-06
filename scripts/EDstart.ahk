; =============================================================================
; Name ..........: Elite Dangerous Lanucher
; Description ...: Open Elite Dangerous Game and companion apps all in one go
; Platform ......: Windows 10
; Language ......: English (en-US)
; Author ........: Dylan Kinnett <dylan@nocategories.net>
; Credits        : From a starter AHK template written by GroggyOtter
; =============================================================================

; tray icon
; =============================================================================

I_Icon = elite.ico
IfExist, %I_Icon%
Menu, Tray, Icon, %I_Icon%
;return


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

; Steam
Process, Exist, steam.exe,
If Not ErrorLevel {
Run, C:\Program Files (x86)\Steam\steam.exe 
}

Process, Wait, steam.exe ; make sure steam is online before proceeding

; hide all the things
Send {LWinDown}{d}{LWinUp}}

Sleep 20000 ; give steam some time to get online

; Launchers -------------------------------------------------------------------
; Run programS. Note that most programs will require a FULL file path.
; Apps with the longest startup are listed first.

; EDD Elite Discovery
Process, Exist, EDDiscovery.exe
If Not ErrorLevel {
Run, C:\Program Files\EDDiscovery\EDDiscovery.exe, C:\Program Files\EDDiscovery\
}

; VoiceAttack
Process, Exist, VoiceAttack.exe
If Not ErrorLevel {
Run, C:\Program Files (x86)\Steam\steamapps\common\VoiceAttack\VoiceAttack.exe, C:\Program Files (x86)\Steam\steamapps\common\VoiceAttack\
}

; EDMC EDMarketConnector
Process, Exist, EDMarketConnector.exe
If Not ErrorLevel {
Run, C:\Program Files (x86)\EDMarketConnector\EDMarketConnector.exe, C:\Program Files (x86)\EDMarketConnector\
}

; Elite Dangerous Engineer
; this app is weird and must be run from its funny kind of shortcut
; Process, Exist, EDEngineer.exe
; If Not ErrorLevel {
; Run, "C:\Users\Dylan\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Games\Elite Dangerous Engineer.appref-ms"
; }

; EDO Elite Observatory
Process, Exist, Observatory.exe,
If Not ErrorLevel {
Run, %USERPROFILE%\AppData\Local\Elite Observatory\Observatory.exe, %USERPROFILE%\AppData\Local\Elite Observatory\
}

; EDO Elite Observatory v2
; Process, Exist, ObservatoryCore.exe,
; If Not ErrorLevel {
; Run, M:\Games\Elite Dangerous\Elite Observatory\ObservatoryCore.exe, M:\Games\Elite Dangerous\Elite Observatory\
; }

; Elite Dangerous Journal Processor
Process, Exist, EliteDangerousJournalProcessor.exe,
If Not ErrorLevel {
Run, M:\Games\Elite Dangerous\EDJP\EliteDangerousJournalProcessor.exe, M:\Games\Elite Dangerous\EDJP\
}

; EliteG19s
Process, Exist, EliteG19s.Windows.exe,
If Not ErrorLevel {
Run, %USERPROFILE%\AppData\Local\Programs\EliteG19s\EliteG19s.Windows.exe, %USERPROFILE%\AppData\Local\Programs\EliteG19s\
}

; Discord
Process, Exist, Discord.exe,
If Not ErrorLevel {
Run, C:\Users\Dylan\AppData\Local\Discord\Update.exe --processStart Discord.exe
}

; StatusDisplay
; Run, M:\Games\Elite Dangerous\Status Display\StatusDisplay.exe, M:\Games\Elite Dangerous\Status Display\

; FirstContact
; Run, C:\Program Files (x86)\Sidsoft\FirstContact\FirstContact.exe, C:\Program Files (x86)\Sidsoft\FirstContact

; Elite Dangerous Scout
; Run, M:\Games\Elite Dangerous\Elite Dangerous Scout\EDScout.exe, M:\Games\Elite Dangerous\Elite Dangerous Scout\

; Game Glass host
; Run, C:\Program Files\GameGlass\launcher.exe

; Elite Toolbox
; Run, M:\Games\Elite Dangerous\elite-toolbox-edtb\toolbox.exe

; EDDI: normally runs inside of voiceattack, so it's disabled here
; "C:\Program Files (x86)\VoiceAttack\Apps\EDDI\EDDI.exe"

; ok now open some web apps
run, C:\Users\Dylan\AppData\Local\BraveSoftware\Brave-Browser\Application\brave.exe https://www.spansh.co.uk/exact-plotter https://eddb.io/trade/loops https://inara.cz/search-nearest/ https://s.orbis.zone/gpj5 https://www.reddit.com/r/EliteDangerous/comments/ggffqq/ https://www.reddit.com/r/EliteDangerous/comments/merpky


; Minimize Everything ---------------------------------------------------------
Send {LWinDown}{d}{LWinUp}}

; Start the game from Steam ---------------------------------------------------
; note: in steam my shortcut is set to use a tool to skip the launcher
; Steam launches the default way if min-ed-launcher is not installed
; see also https://github.com/Rfvgyhn/min-ed-launcher
; Elite Dangerous Scout


Run, C:\Program Files (x86)\Steam\steam.exe -bigpicture, C:\Program Files (x86)\Steam
WinWait, ahk_exe steam.exe
run, steam://rungameid/359320

;; only after the game is actually running 
;; then open and then start Cougar Display
;; I think you even have to be logged into Open or wherever
;; better check the manual
; Run, M:\Games\Elite Dangerous\Cougar Display\MFDCougar.exe




; Cleanup ----------------------------------------------------------------------


; Close launcher after launch
; note: min-ed-launcher also checks to close launcher when game exits
Process, Wait, EliteDangerous64.exe
Process, Close, cmd.exe
;Process, Close, launcher.exe

; Close companions after exit
Process, WaitClose, EliteDangerous64.exe
Process, Close, Discord.exe
Process, Close, EDDI.exe
Process, Close, EDDiscovery.exe
Process, Close, EDMarketConnector.exe
Process, Close, EDScout.exe
Process, Close, EliteG19s.Windows.exe
Process, Close, FirstContact.exe
Process, Close, MFDCougar.exe
Process, Close, Observatory.exe 
Process, Close, toolbox.exe
Process, Close, VoiceAttack.exe
Process, Close, EliteDangerousJournalProcessor.exe
Process, Close, steam.exe
Process, Close, EDEngineer.exe
Process, Close, ObservatoryCore.exe
; Minimize Everything 
Send {LWinDown}{d}{LWinUp}}
Tray_Refresh()
ExitApp






return
; END OF MAIN SCRIPT 
; ==============================================================================




; FUNCTIONS
; ==============================================================================


; Always on Top 
; ------------------------------------------------------------------------------
; stick” any window to  foreground of desktop with a simple keyboard shortcut.
; source: https://www.labnol.org/software/tutorials/keep-window-always-on-top/5213/
; to use it, while this script is running, click a window, then do control+space
; control+space again will un-stick the window.
 ^SPACE::  Winset, Alwaysontop, , A


; TRAY REFRESH
; ------------------------------------------------------------------------------
Tray_Refresh() {
/*    Remove any dead icon from the tray menu
 *    Should work both for W7 & W10
 */
  WM_MOUSEMOVE := 0x200
  detectHiddenWin := A_DetectHiddenWindows
  DetectHiddenWindows, On

  allTitles := ["ahk_class Shell_TrayWnd"
      , "ahk_class NotifyIconOverflowWindow"]
  allControls := ["ToolbarWindow321"
        ,"ToolbarWindow322"
        ,"ToolbarWindow323"
        ,"ToolbarWindow324"]
  allIconSizes := [24,32]

  for id, title in allTitles {
    for id, controlName in allControls
    {
      for id, iconSize in allIconSizes
      {
        ControlGetPos, xTray,yTray,wdTray,htTray,% controlName,% title
        y := htTray - 10
        While (y > 0)
        {
          x := wdTray - iconSize/2
          While (x > 0)
          {
            point := (y << 16) + x
            PostMessage,% WM_MOUSEMOVE, 0,% point,% controlName,% title
            x -= iconSize/2
          }
          y -= iconSize/2
        }
      }
    }
  }

  DetectHiddenWindows, %detectHiddenWin%
}


; Save Reload / Quick Stop
; =============================================================================

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


; ==============================================================================
; =============================== Experimental =================================
; ==============================================================================


; Global hotstrings ------------------------------------------------------------
; etc...

; Program 1 ==============================
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

; ============================== End Script ==============================
