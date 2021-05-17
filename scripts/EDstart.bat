:: Launch Elite Dangerous processes asynchronously
:: notes: https://www.reddit.com/r/EliteDangerous/comments/5occmo/external_tools_i_use_with_elite_dangerous/ 
:: source: https://gist.github.com/beelzebubbles/f03c064df816f5a1db906b3e4e1c1430

:: start AutoHotKey master script
start "" "ABSOLUTE\PATH\TO\master_run_all_other_scripts.ahk"
:: start EDengineer
start "" "ABSOLUTE\PATH\TO\EDEngineer.appref-ms"
:: start Captain's Log
start "" "ABSOLUTE\PATH\TO\CaptainsLog.exe"
:: start Always on Top
start "" "ABSOLUTE\PATH\TO\always-on-top.exe"
:: start ED Market Connector
start "" "ABSOLUTE\PATH\TO\EDMarketConnector.exe"
:: start Voice Attack
start "" "ABSOLUTE\PATH\TO\VoiceAttack.exe"
:: start game
start "" "steam://rungameid/359320"

:: Finish up
