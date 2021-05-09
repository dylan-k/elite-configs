

ELITE DANGEROUS CONFIGS
=======================================================================

My Elite Dangerous Settings,  
controller mappings, voice profiles, app preferences  
for storing, sharing, learning, and versioning.  

I've done my best to credit the authors. I'm open to suggestions.



Config File Locations
------------------------------------------------------------------------------

Often the controller config will rely on two files. Steam's controller settings are .vdf files. Elite Dangerous in-game mappings are stored as .binds files. Some settings only use the Steam config with a default in-game mapping. Others require both files. Either way, a config will have two parts.


### Elite Dangerous Config Files Location

`.binds` files are stored in a special folder and their names will be someting like `filename.4.0.binds`. You'll find some defaults in there along with at least one "Custom" file that the game makes when you save any bindings. These files are XML files and you can open and edit them with any text editor, carefully, and make backups.

```
%LocalAppData%\Frontier Developments\Elite Dangerous\Options\Bindings
```
For example: `C:\Users\<Username>\AppData\Local\Frontier Developments\Elite Dangerous\Options\Bindings\`


### Steam Config Files Location

If you use Steam's controller settings (to configure a steam controller, xbox controller, dualshock etc.), they'll be stored in a `.vdf` file. These files can also be opened in a text editor, and their syntax is something like JSON. They're stored in a special folder, for example:  

```
C:\Program Files (x86)\Steam\userdata\<youraccountid>\241100\remote\controller_config\359320
```  

Lookup `<youraccountid>` at https://steamidfinder.com/



References
-------------------------------------------------------------------------------

How to use Steam Controller Config (.vdf) Files  
  https://www.steamcontrollerdb.com/home/about/

Editing .vdf steam controller files  
  https://steamcommunity.com/sharedfiles/filedetails/?id=932405100

How to make the most of the Steam Controller: a comprehensive guide  
  https://www.pcgamer.com/steam-controller-setup-guide/

