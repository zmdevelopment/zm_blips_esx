ESX = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(30)-- Saniye Bekletme
  end
end)

local display = false

function show_message(entry)
	return Locale[config.locale][entry]
end

local clothing_label   =  Locale[config.locale]['clothing_label']
local tower_label   =  Locale[config.locale]['tower_label']
local jobs_label   =  Locale[config.locale]['jobs_label']
local gasoline_label   =  Locale[config.locale]['gasoline_label']
local legaljob_label   =  Locale[config.locale]['legaljob_label']
local market_label   =  Locale[config.locale]['market_label']
local mechanic_label   =  Locale[config.locale]['mechanic_label']
local bank_label   =  Locale[config.locale]['bank_label']
local garage_label   =  Locale[config.locale]['garage_label']



RegisterCommand("blips", function(source)
    SetDisplay(not display,clothing_label,tower_label,jobs_label,gasoline_label,legaljob_label,market_label,mechanic_label,bank_label,garage_label)
end)

RegisterNUICallback("exit", function(data)
    SetDisplay(display)
end)


function SetDisplay(bool,clothing_label,tower_label,jobs_label,gasoline_label,legaljob_label,market_label,mechanic_label,bank_label,garage_label)
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        clothing_label = clothing_label,
        tower_label = tower_label,
        jobs_label = jobs_label,
        gasoline_label = gasoline_label,
        legaljob_label = legaljob_label,
        market_label = market_label,
        mechanic_label = mechanic_label,
        bank_label = bank_label,
        garage_label = garage_label,
        status = bool,
    })
end



Citizen.CreateThread(function()
    while display do
        Citizen.Wait(0)
        DisableControlAction(0, 1, display) -- LookLeftRight
        DisableControlAction(0, 2, display) -- LookUpDown
        DisableControlAction(0, 142, display) -- MeleeAttackAlternate
        DisableControlAction(0, 18, display) -- Enter
        DisableControlAction(0, 322, display) -- ESC
        DisableControlAction(0, 106, display) -- VehicleMouseControlOverride
    end
end)




----------------------- BLİPS ------------------------------

local old_blips = {}
local entire_blips = {


  ----- You can add a new coordinat and you can find another blips or color from here : https://docs.fivem.net/docs/game-references/blips/
    
    -- Clothing
  
    {title="Kıyafetçi",   colour = 0,  id = 73,  x = 1693.4566, y = 4823.17,  z = 42.1631294,  scale= 0.4,  kind ="clothing"},   ----EXAMPLE
  
    -- tower 

    {title="Polis Merkezi",    colour = 29, id = 60,  x = 434.3231,  y =  -981.9143,z = 30.71062,  scale= 0.7,  kind ="tower"},  ----EXAMPLE

    -- jobs 

    {title="Kuaför",           colour = 2,  id = 71,  x = -817.078, y = -185.478, z = 37.568,    scale= 0.7,  kind ="jobs"}, ----EXAMPLE


    -- gasoline 
      
    {title="Benzinlik",       colour = 41,  id = 361, x = 49.4187,   y = 2778.793,  z = 58.043,    scale= 0.4,  kind = "gasoline"}, ----EXAMPLE


    -- legal jobs 

    {title="Silahçı",          colour = 37, id = 110, x = 17.41546,  y = -1115.932, z = 29.79117,  scale= 0.7,  kind ="legal_jobs"}, ----EXAMPLE


    -- market --
  
    {title="Market",           colour = 2,  id = 52,  x = 373.875,   y = 325.896,   z = 102.566,   scale= 0.7,  kind ="market"}, ----EXAMPLE
    

    --mechanic 

    {title="Mekanik",         colour = 47,  id = 566, x = 942.24,    y = -971.04,   z = 39.48,     scale= 0.7,  kind = "mechanic"},   ----EXAMPLE

    -- bank --
  
    {title="Pacific Bank",     colour = 1,  id = 272, x = 243.35,    y = 224.706,   z = 106.28,    scale= 0.7,  kind ="bank"}, ----EXAMPLE
    
    --garages

    {title="Hells Angels MC",  colour = 64, id = 675, x = 1085.971,  y = -783.059,  z = 58.733,    scale= 0.7,  kind ="garage"}, ----EXAMPLE

  }


Citizen.CreateThread(function()	for _, info in pairs(entire_blips) do
  Citizen.Wait(10)
  create_blip(info.x,info.y,info.title,info.colour,info.id,info.scale,info.kind)
end
end)

function create_blip(x, y,text,colour,sprite,scale,kind)
    local blip = AddBlipForCoord(x, y)
    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, colour)
    SetBlipAsShortRange(blip, true)
    SetBlipScale(blip, scale)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
    table.insert(old_blips, {id = blip, kind = kind})
end


RegisterNUICallback("blip_open_close", function(data)
  if data.status == true then
    for k,v in ipairs(entire_blips) do
      if v.kind == data.name then
        create_blip(v.x,v.y,v.title,v.colour,v.id,v.scale,v.kind)
      end
    end
  else
    for k,v in ipairs(old_blips) do
      if v.kind == data.name then
        RemoveBlip(v.id)
      end
    end
  end
end)