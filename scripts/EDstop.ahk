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




; Minimize Everything ---------------------------------------------------------
Send {LWinDown}{d}{LWinUp}}


Process, Close, cmd.exe


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
