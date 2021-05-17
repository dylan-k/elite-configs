

ELITE DANGEROUS VOICE CONFIGS
============================

contains:
  - my configs for Voice Attack
  - windows voices
  - more voices


Install More Voices for Windows from Microsoft
----------------------------------------------------------------------------

https://www.reddit.com/r/Windows10/comments/96dx8z/

install the voices
https://support.microsoft.com/en-us/topic/download-voices-for-immersive-reader-4e1bb019-3069-4bef-b1ad-92da2a1f2922

save this as a file eg voices.ps1 and run it as admin
```.ps

$sourcePath = 'HKLM:\software\Microsoft\Speech_OneCore\Voices\Tokens' #Where the OneCore voices live
$destinationPath = 'HKLM:\SOFTWARE\Microsoft\Speech\Voices\Tokens' #For 64-bit apps
$destinationPath2 = 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\SPEECH\Voices\Tokens' #For 32-bit apps
cd $destinationPath
$listVoices = Get-ChildItem $sourcePath
foreach($voice in $listVoices)
{
$source = $voice.PSPath #Get the path of this voices key
copy -Path $source -Destination $destinationPath -Recurse
copy -Path $source -Destination $destinationPath2 -Recurse
}

```


Additional Voices
--------------------------------------------------------------------------------

### Espeak Voices
http://espeak.sourceforge.net/download.html

at install, enter these 5 lines to get the most voices. 

```
en+m1 en+m2 en+m3 en+m4 en+m5 en+m6 en+m7 en+f1 en+f2 en+f3 en+f4 en+f5

en-gb+m1 en-gb+m2 en-gb+m3 en-gb+m4 en-gb+m5 en-gb+m6 en-gb+m7 en-gb+f1 en-gb+f2 en-gb+f3 en-gb+f4 en-gb+f5

en-sc+m1 en-sc+m2 en-sc+m3 en-sc+m4 en-sc+m5 en-sc+m6 en-sc+m7 en-sc+f1 en-sc+f2 en-sc+f3 en-sc+f4 en-sc+f5

en-rp+m1 en-rp+m2 en-rp+m3 en-rp+m4 en-rp+m5 en-rp+m6 en-rp+m7 en-rp+f1 en-rp+f2 en-rp+f3 en-rp+f4 en-rp+f5

en-wi+m1 en-wi+m2 en-wi+m3 en-wi+m4 en-wi+m5 en-wi+m6 en-wi+m7 en-wi+f1 en-wi+f2 en-wi+f3 en-wi+f4 en-wi+f5
```


- http://www.zero2000.com/free-text-to-speech-natural-voices.html
- https://www.neuber.com/free/voicesinstaller/
- https://support.freedomscientific.com/Downloads/synthesizers

setup for voices to work in most apps, not just the built-in ones



