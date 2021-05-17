:: Stop Elite Dangerous processes asynchronously
:: notes: https://www.reddit.com/r/EliteDangerous/comments/5occmo/external_tools_i_use_with_elite_dangerous/ 
:: source: https://gist.github.com/beelzebubbles/f03c064df816f5a1db906b3e4e1c1430

taskkill /f /im always-on-top.exe
taskkill /f /im EDEngineer.exe
taskkill /f /im AutoHotkey.exe
taskkill /f /im CaptainsLog.exe
taskkill /f /im EDLaunch.exe
taskkill /f /im EDMarketConnector.exe
taskkill /f /im VoiceAttack.exe

:: END
