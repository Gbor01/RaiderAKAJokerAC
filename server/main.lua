
local banlist = {}
local banstatus = false 
local banreload = 1000 * 10 * 5

Citizen.CreateThread(function()
  while true do 
    Wait(1000)
    if banlist ~= {} then 
      LoadBan()
      banstatus = true
    else
      banstatus = {}
    end
  end
end)

Citizen.CreateThread(function()
  while true do
    Wait(banreload)
    LoadBan()
  end
end)

function LoadBan()
  MySQL.Async.fetchAll(
    'SELECT * FROM Raider',
    {},
    function (identifiers)
      if identifiers == nil then 
        print("^1J.O.K.E.R.   Error code #1^7")
        Wait(2000)
        os.exit()
      else 
      banlist = {}
      for i = 1, #identifiers, 1 do 
        table.insert(banlist, {
      identifier           = identifiers[i].identifier,
			license              = identifiers[i].license,
			ip                   = identifiers[i].ip,
			discord              = identifiers[i].discord,
			name               = identifiers[i].name,
        })
        end
      end
    end)
end

MySQL.ready(function()
  LoadBan()
end)

AddEventHandler('playerConnecting', function(playerName,setKickReason,set)
  local name = GetPlayerName(source)

  local license,steamID,liveid,xblid,discord,playerip  = "n/a","n/a","n/a","n/a","n/a","n/a"

for k,v in pairs(GetPlayerIdentifiers(source))do
      
    if string.sub(v, 1, string.len("steam:")) == "steam:" then
      steamid = v
    elseif string.sub(v, 1, string.len("license:")) == "license:" then
      license = v
    elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
      xbl  = v
    elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
      ip = v
    elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
      discord = v
    elseif string.sub(v, 1, string.len("live:")) == "live:" then
      liveid = v
    end

end
if (banlist == {}) then
  Citizen.Wait(1000)
end
  for i = 1, #banlist, 1 do
    if (tostring(banlist[i].identifier)) == tostring(identifier)
    or (tostring(banlist[i].license)) == tostring(license)
    or (tostring(banlist[i].ip)) == tostring(playerip)
    or (tostring(banlist[i].discord)) == tostring(playerdiscord) then 
            setKickReason('\nYou have been PWNED by: J.O.K.E.R. AC')
            print('^1[Raider-AC] This player tried to connect: ' .. GetPlayerName(source))
                  CancelEvent()
                  break
          end
      end
end)


for i, event in ipairs(RaiderEvents.eventek) do -- **/Raiders/events-Raider.l*a --
  RegisterNetEvent(event)
    AddEventHandler(event, function()
      _source = source
      player = _source
      local name = GetPlayerName(player)
     CancelEvent()
   TriggerEvent('101511518:71520381', "Fake event triggered: "..event.." ",player)
  end)  
end

function whitelist(entity)
  local model = GetEntityModel(entity)
  if (model ~= nil) then
      if (GetEntityType(entity) == 1 and GetEntityPopulationType(entity) == 7) then
          return true
      end
      for i=1, #RaiderList.whitelisted do -- **/Raiders/vehicles-Raider.lua --
          local hashkey = tonumber(RaiderList.whitelisted[i]) ~= nil and tonumber(RaiderList.whitelisted[i]) or GetHashKey(RaiderList.whitelisted[i])
          if (hashkey == model) then
              return false
          end
      end
  end
  return true
end


AddEventHandler("entityCreating",  function(entity,player)
 local entity = entity
  local model = GetEntityModel(entity)
  local eType = GetEntityPopulationType(entity)

if DoesEntityExist(entity) then

local source = NetworkGetEntityOwner(entity)
local entID = NetworkGetNetworkIdFromEntity(entity)
if GetEntityType(entity) == 2 then 
    if eType == 6 or eType == 7 then
      if model ~= 0 then
    veh[source] = (veh[source] or 0) + 1
    if veh[source] > Raider.MaxCars then 
      TriggerEvent('101511518:71520381', "Mass car spawn detected ",source)
     
      CancelEvent()
    end
  end
end
end
  if GetEntityType(entity) == 1 then 
    if eType == 6 or eType == 7 or eType == 0 then
      ped[source] = (ped[source] or 0) + 1
      if ped[source] > Raider.MaxPeds then 
      
        TriggerEvent('101511518:71520381', "Mass ped spawn detected ",source)
        CancelEvent()
          end
        end
      end
    end
end) 
AddEventHandler("entityCreating",  function(entity,player)
  local entity = entity
  local model = GetEntityModel(entity)
  local eType = GetEntityPopulationType(entity)

if DoesEntityExist(entity) then

local source = NetworkGetEntityOwner(entity)
local entID = NetworkGetNetworkIdFromEntity(entity)

  if (whitelist(entity)) then
    CancelEvent()
  end
  end
end) 


Citizen.CreateThread(function()
    exp = {}
    veh = {}
    ped = {}
    while true do
        Citizen.Wait(2500)
        exp = {}
        veh = {}
        ped = {}
    end
end)



function inTable(tbl, item)
    for key, value in pairs(tbl) do
        if value == item then return key end
    end
    return false
end

AddEventHandler(
        "explosionEvent",
        function(sender, ev)
            if ev.damageScale ~= 0.0 then
                local arrayblack = {}

                for kkk, vvv in pairs(RaiderExplosion.ExplosionsList) do
                    table.insert(arrayblack, vvv)
                end

                if inTable(arrayblack, ev.explosionType) ~= false then
                    CancelEvent()
                    TriggerEvent('101511518:71520381', "Explosion detected | "..ev.explosionType.." ",sender)
                end

                if ev.explosionType ~= 9 then
                    exp[sender] = (exp[sender] or 0) + 1
                    if exp[sender] > Raider.MaxExplosions then
                     TriggerEvent('101511518:71520381', "Mass explosion detected | "..ev.explosionType.."  ",sender)
                        CancelEvent()

                    end
                end

                if ev.isAudible == false then
                 TriggerEvent('101511518:71520381', "Tried to spawn silent explosion | "..ev.explosionType.." ",sender)
                end

                if ev.isInvisible == true then
                 TriggerEvent('101511518:71520381', "Tried to spawn invisible explosion | "..ev.explosionType.." ",sender)
                end

                if ev.damageScale > 1.0 then
                 TriggerEvent('101511518:71520381', "Tried to spawn manipulated explosion | "..ev.explosionType.." ",sender)
                end
                CancelEvent()
        end
  end)
  
function remove(entity)
  Citizen.InvokeNative(0xAE3CBE5BF394C9C9, Citizen.PointerValueIntInitialized(entity))
end

RegisterNetEvent('fika:xd')
AddEventHandler('fika:xd', function(message)
 
    _source = source
    player = _source  
 
  local name = GetPlayerName(player)
  local steamidentifer = GetPlayerIdentifier(player)
  local discord = false 
  local license = false
  for k,v in pairs(GetPlayerIdentifiers(player))do
    if string.sub(v, 1, string.len("discord:")) == "discord:" then
        discord = v
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
        license = v
    end
  end
   local embed = {
        {
            ["color"] = 9841982,
            ["description"] =        
        "\n**Name:** "..tostring(name)..
       "\n **Steam: **"..tostring(steamidentifer)..
       "**\n Discord UID: **" ..tostring(discord)..
       "**\n Fivem: **"..tostring(license)..
       "\n **Log: **"..message..
       " \n**Server Name: **" ..Raider.ServerName,
        }
    }

   PerformHttpRequest(Raider.LOGWebhook, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
   DropPlayer(source, "You have been kicked by: J.O.K.E.R. AC")
  
end)



 


RegisterNetEvent('101511518:71520381')
AddEventHandler('101511518:71520381',function(reason, player)
  if player == nil or player == "" then 
    _source = source
    player = _source  
  end
  local name = GetPlayerName(player)
  local steamidentifer = GetPlayerIdentifier(player)
  local identifiers, steamIdentifier = GetPlayerIdentifiers(player)
  local steamid  = false
  local license  = false
  local discord  = false
  local ips       = false
  local date = os.date("%Y/%m/%d %H:%M")

        if IsPlayerAceAllowed(player, "administrator") then

            else
 for k,v in pairs(GetPlayerIdentifiers(player))do
      if string.sub(v, 1, string.len("steam:")) == "steam:" then
        steamid = v
      elseif string.sub(v, 1, string.len("license:")) == "license:" then
        license = v
      elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
        xbl  = v
      elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
        ips = v
      elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
        discord = v
      elseif string.sub(v, 1, string.len("live:")) == "live:" then
        liveid = v
      end
    
  end

  DropPlayer(player, '\nYou have been PWNED by: J.O.K.E.R. AC')
 
  
 if name ~= nil then  
  PerformHttpRequest(Raider.Webhook, function(err, text, headers) end, 'POST', json.encode({ embeds = {
    {
         author = {
           name = "J.O.K.E.R. [BAN]",
           url = "",
           icon_url = "https://cdn.discordapp.com/attachments/708228335494234146/801153153289420800/Jok.png"
         },
         description = 
         "**\n Name: **"..tostring(name)..
         "**\n Steam: **"..tostring(steamidentifer)..
         "**\n Discord UID: **" ..tostring(discord)..
         "**\n Fivem: **"..tostring(license)..
         "**\n IP: **"..tostring(ips)..
         "**\n Reason: **"..tostring(reason),
         color = "9841982"
       }
     }
   }), { ['Content-Type'] = 'application/json' })
   
  
  end
  if name ~= nil then 
    MySQL.Async.execute(
    'INSERT INTO Raider (identifier,license,ip,discord,name,date) VALUES (@identifier,@license,@ip,@discord,@name,@date)', {
      ['@identifier'] = steamid,
      ['@license'] = license,
      ['@ip'] = ips,
      ['@discord'] = discord,
      ['@name'] = name,
      ['@date'] = date,
    },
    function()
    end)
  end
 end
end)


Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(100)
            if _G == nil or _G == {} or _G == "" then
               TriggerEvent('101511518:71520381', "J.O.K.E.R. bypass detected.")
                return
            else
                Wait(500)
            end
        end
    end)

AddEventHandler('chatMessage', function(source, n, message)
        local name = GetPlayerName(source)
        for k,n in pairs(Raider.Blwords) do
          if string.match(message:lower(),n:lower()) then
            TriggerEvent('101511518:71520381', "Blacklisted word!  Word: "..n.."", source)
                  CancelEvent()
          end
      end
end)

RegisterNetEvent('screen')
AddEventHandler('screen',function()
  exports['screenshot-basic']:requestClientScreenshot(GetPlayers()[1], {
    fileName = 'cache/screenshot.jpg'
})
end)

if Raider.ClearPedTasks == true then
    AddEventHandler("clearPedTasksEvent",
        function(sender, data)
            sender = tonumber(sender) --this line will fix it
            local entity = NetworkGetEntityFromNetworkId(data.pedId)
            if DoesEntityExist(entity) then
                local owner = NetworkGetEntityOwner(entity)
                if owner ~= sender then
                    
                    CancelEvent()
                    
                    TriggerEvent("101511518:71520381", "ClearPedTask detected", sender)
                end
            end
        end)
  end

  if Raider.GiveAndRemoveWeapons then
    AddEventHandler(
      "giveWeaponEvent",
      function(sender, data)
          if data.givenAsPickup == false then
            TriggerEvent("101511518:71520381", "GiveWeapon detected", sender)
              CancelEvent()
          end
      end)

  AddEventHandler(
      "RemoveWeaponEvent",
      function(sender, data)
          CancelEvent()
          TriggerEvent("101511518:71520381", "RemoveWeapon detected", sender)
      end)

  AddEventHandler(
      "RemoveAllWeaponsEvent",
      function(sender, data)
          CancelEvent()
          TriggerEvent("101511518:71520381", "RemoveAllWeapons detected", sender)
      end)
  end

RegisterCommand("wipeall", function(source, args, rawCommand) 
  if IsPlayerAceAllowed(source, "administrator") then
  TriggerClientEvent("vbcvb", -1)
  end
end,true)