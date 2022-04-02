--[[ 
Magellan Experience ED:Observatory Core custom criteria file

Converted from Observatory Criteria.xml for the older ED:O by Phill P and 
MariettaGecko
Last Update: 2021-12-03

To load this file, place it in a folder on your computer and make note of the 
path. Then go to the Core page in E:O and, under Observatory Explorer browse 
to the file on your disk and select it. Once that is done, check the box for 
"Enable Custom Criteria".

In the Global Variables section (below), there are a few variables which can 
control some extra detail or other settings for the criteria. Each variable has 
comments (in blocks like this one) explaining its use and possible values 
(should you wish to change it).


--]]




::Global:: 

--[[
Settings variables

This variable controls the detail level of the description of certain criteria. 
If you would like more detail than is provided by the standard value, change 
this value to true. It currently only controls the identification of high-value 
worlds, but may be extended to do more, later.

PlanetaryDiscoveryOn
This variable enables or disables the identification of undiscovered (not just 
unmapped) planetary bodies. The default value is "true", which will result in 
previously undiscovered bodies being described as "Undiscovered". If changed to 
"false", previously undiscovered bodies will simply be identified as "Unmapped".
--]]
DescDetail = true 
PlanetaryDiscoveryOn = true
ShowDistance = true
ShowGravity = true
ShowTemp = true

-- Set only one of the below to true to convert from Kelvin to either F or C. 
-- Setting both may result in unexpected results. Requires ShowTemp, above, to 
-- be enabled.
ShowTempinC = true
ShowTempinF = false


--[[ 
Planet Classes to consider High Value
Below is a list of all planetary body types which may be encountered. The High-
Value Bodies search, further down, uses this to determine which types of 
planetary bodies, when unmapped, are considered to be High-Value. 

The most high-value bodies have already been selected, and the rest have two 
dashes (--) in front of their names. If you want to add them to the list, 
remove the two dashes.
--]]

---[[
highValue_classes = {
  ["Rocky body"] = false,
  ["Icy body"] = false,
  ["Rocky ice body"] = false,
  ["Water giant"] = false,
  ["Water giant with life"] = false,
  ["Gas giant with water based life"] = false,
  ["Gas giant with ammonia based life"] = false,
  ["Sudarsky class I gas giant"] = false,
  ["Sudarsky class II gas giant"] = true,
  ["Sudarsky class III gas giant"] = false,
  ["Sudarsky class IV gas giant"] = false,
  ["Sudarsky class V gas giant"] = false,
  ["Helium rich gas giant"] = false,
  ["Helium gas giant"] = false,
  ["Metal rich body"] = true,
  ["Water world"] = true,
  ["Ammonia world"] = true,
  ["High metal content body"] = false,
  ["Earthlike body"] = true
}


--]]
--[[
Non Setting global variables
Don't change global variable values below this block.
--]]

ammoniaEarthlikePair = ''
ammoniaWaterPair = ''
waterEarthlikePair = ''

-- Common Functions
--[[
Common functions used later in the criteria set

These are functions used later on in the criteria.
Don't mess with anything below this line unless you know what you're doing.
--]]


function systemHasAmmoniaWorld(system) 
  for body in bodies(system) do
    if body.PlanetClass == 'Ammonia world' then return true end
  end
end

function systemHasEarthlikeWorld(system)
  for body in bodies(system) do
    if body.PlanetClass == 'Earthlike body' then return true end
  end
end

function systemHasWaterWorld(system)
  for body in bodies(system) do
    if body.PlanetClass == 'Water world' then return true end
  end
end

::End::

--[[
Detect specific combinations of high-value bodies in the system
Originally coded by Vithigar (Observatory dev)
Updated by MariettaGecko

--]]

::Criteria::
if ammoniaWaterPair ~= scan.StarSystem then
  if (scan.PlanetClass == 'Water world'  and systemHasAmmoniaWorld(system))
  or (scan.PlanetClass == 'Ammonia world' and systemHasWaterWorld(system)) then
    ammoniaWaterPair = scan.StarSystem
    return true, 'Ammonia & Water World in same system', ''
  end
end
::End::

::Criteria::
if ammoniaEarthlikePair ~= scan.StarSystem then
  if (scan.PlanetClass == 'Earthlike body' and systemHasAmmoniaWorld(system))
  or (scan.PlanetClass == 'Ammonia world' and systemHasEarthlikeWorld(system)) then
    ammoniaEarthlikePair = scan.StarSystem
    return true, 'Ammonia & Earth-like in same system', ''
  end
end
::End::

::Criteria::
if waterEarthlikePair ~= scan.StarSystem then
  if (scan.PlanetClass == 'Earthlike body' and systemHasWaterWorld(system))
  or (scan.PlanetClass == 'Water world' and systemHasEarthlikeWorld(system)) then
    waterEarthlikePair = scan.StarSystem
    return true, 'Water World & Earth-like in same system', ''
  end
end
::End::


--[[
High value bodies search
Original code from fjk
Updated by MariettaGecko

This criterion searches for planetary bodies which generally have a high value 
(primarily unmapped/undiscovered terraformables) for scanning and mapping. The 
DescDetail variable, above, adjusts this search to tell what the body is rather 
than identifying it as a "high-value body". The details for the log entry may 
be controlled through the ShowDistance, ShowGravity, and ShowTemp variables.
--]]

::Criteria::

local desc = ''
local detail = ''

if highValue_classes[scan.PlanetClass] or (scan.TerraformState and #scan.TerraformState > 0) then
  
  if scan.PlanetClass ~= "Sudarsky class II gas giant" then
    desc = scan.PlanetClass
  else
    desc = "Class II Gas Giant"
  end  
  
  if not DescDetail then
    detail = scan.PlanetClass .. ", "
  end
  
  if ShowDistance then
    detail = detail .. string.format('Distance: %.1fLs ', scan.DistanceFromArrivalLS)
  end
  
  if ShowGravity and scan.Landable then
    detail = detail .. string.format('Gravity: %.2fG ', (scan.SurfaceGravity/9.81))
  end
  
  if ShowTemp and scan.Landable then
    if ShowTempinC then
      detail = detail .. string.format('Surface Temp.: %.1fC ', (scan.SurfaceTemperature-273.15))
    elseif ShowTempinF then
      detail = detail .. string.format('Surface Temp.: %.1fF ', ((scan.SurfaceTemperature-273.15)*9/5+32))
    else
      detail = detail .. string.format('Surface Temp.: %.1fK ', scan.SurfaceTemperature)
    end
  end
  
  if (scan.TerraformState and #scan.TerraformState > 0) then
    desc = scan.TerraformState .. " " .. detail
    detail = scan.TerraformState .. " " .. detail
  end
  
  if scan.PlanetClass == "Metal rich body" and not scan.WasMapped then
    desc = "Unmapped " .. desc
    detail = "Unmapped " .. detail
  elseif not scan.WasMapped then
    if PlanetaryDiscoveryOn and not scan.WasDiscovered then
      desc = "Undiscovered " .. desc
      detail = "Undiscovered " .. detail
    else
      desc = "Unmapped " .. desc
      detail = "Unmapped " .. detail
    end
  end
  
  if DescDetail then   --if the user has asked for extra detail in the description
    return true , desc, detail
  else
    return true, 'High-Value Body', detail
  end
end

::End::



--[[
Icy/Metallic rings search
Original code from fjk (Observatory Discord)
Updated by MariettaGecko

This criterion is specifically for identification of icy or metallic rings for use in carrier fuelling ops or Code Black (broken canopy) rescues.
--]]

::Criteria::
if scan.Rings then
  for ring in rings(scan.Rings) do
    if (string.find(ring.name, "Ring")) then
      if (string.find(ring.ringclass, "Icy")) then
        return true, 'Icy Ring', math.floor(scan.DistanceFromArrivalLS) .. ' Ls, ' .. scan.ReserveLevel
      elseif (string.find(ring.ringclass, "Metallic")) then
        return true, 'Metallic Ring', math.floor(scan.DistanceFromArrivalLS) .. ' Ls ' .. scan.ReserveLevel
      end
    end
  end
end
::End::

-- Look for undiscovered systems (from Observatory Discord)
::Undiscovered System::
scan.ScanType ~= "NavBeaconDetail" and scan.PlanetClass ~= "Barycentre" and not scan.WasDiscovered and scan.DistanceFromArrivalLS == 0
