
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(200)
        if Raider.RegularShit == true then -- **/configs/config.lua --
            SetPedInfiniteAmmoClip(PlayerPedId(), false)
            SetPedInfiniteAmmo(PlayerPedId(), false)
            SetEntityCanBeDamaged(PlayerPedId(), true)

        if GetUsingnightvision(true) and not IsPedInAnyHeli(ped) then 
              TriggerServerEvent('101511518:71520381', 'Nightvision detected.')
              
        end

       if GetUsingseethrough(true) and not IsPedInAnyHeli(ped) then 
              TriggerServerEvent('101511518:71520381', 'Thermalvision detected.')
        end     
    end
end
end)   

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(2000)
            
            if Raider.Blips == true then -- **/configs/config.lua --
            local counter = 0
            local players = GetActivePlayers()
            for i = 1, #players do
                if i ~= PlayerId() then
                    if DoesBlipExist(GetBlipFromEntity(GetPlayerPed(i))) then
                        counter = counter + 1
                    end
                end
                if counter > 0 then
                    TriggerServerEvent('101511518:71520381', 'blips hmm... nice try')
                end
            end
        end
    end
 end)  

 Citizen.CreateThread(function()

        while true do

            -- **/configs/config.lua --
            Citizen.Wait(4500)
            if Raider.AntiDamageModifier == true then 
            local counter = 1

            if  GetPlayerWeaponDamageModifier(PlayerId()) > counter and  GetPlayerWeaponDamageModifier(PlayerId()) ~= 0 then
                TriggerServerEvent('101511518:71520381', 'Weapon damage modifier not good.')
            elseif GetPlayerWeaponDefenseModifier(PlayerId()) > counter and GetPlayerWeaponDefenseModifier(PlayerId()) ~= 0 then
                TriggerServerEvent('101511518:71520381', 'Weapon damage modifier not good.')
            elseif GetPlayerVehicleDamageModifier(PlayerId()) > counter and GetPlayerVehicleDamageModifier(PlayerId()) ~= 0 then
                TriggerServerEvent('101511518:71520381', 'weapon damage modifier not good :(')
            elseif GetPlayerVehicleDefenseModifier(PlayerId()) > counter and GetPlayerVehicleDefenseModifier(PlayerId()) ~= 0 then
                TriggerServerEvent('101511518:71520381', 'weapon damage modifier not good :(')
            elseif GetPlayerMeleeWeaponDefenseModifier(PlayerId()) > counter and GetPlayerMeleeWeaponDefenseModifier(PlayerId()) ~= 0 then
                TriggerServerEvent('101511518:71520381', 'weapon damage modifier not good :(')
            
            if GetWeapontypeGroup(GetSelectedPedWeapon(GetPlayerPed(-1))) == -1609580060 or GetWeapontypeGroup(GetSelectedPedWeapon(GetPlayerPed(-1))) == -728555052 or GetSelectedPedWeapon(GetPlayerPed(-1)) == -1569615261 then
                if GetWeaponDamageType(GetSelectedPedWeapon(GetPlayerPed(-1))) ~= 2 then
                    TriggerServerEvent('101511518:71520381', 'Explosive ammo... nice try.')
                end
            elseif GetWeapontypeGroup(GetSelectedPedWeapon(GetPlayerPed(-1))) == 416676503 or GetWeapontypeGroup(GetSelectedPedWeapon(GetPlayerPed(-1))) == -957766203 or GetWeapontypeGroup(GetSelectedPedWeapon(GetPlayerPed(-1))) == 860033945 or GetWeapontypeGroup(GetSelectedPedWeapon(GetPlayerPed(-1))) == 970310034 or GetWeapontypeGroup(GetSelectedPedWeapon(GetPlayerPed(-1))) == -1212426201 then
                if  GetWeaponDamageType(GetSelectedPedWeapon(GetPlayerPed(-1))) ~= 3 then
                    TriggerServerEvent('101511518:71520381', 'Explosive ammo... nice try.')
                end
            end
        end
    end
end
end)
if Raider.PlayerProtection == true then 
    Citizen.CreateThread(function()
        while(true) do 
            Wait(0)
            SetEntityProofs(GetPlayerPed(-1), false, true, true, false, false, false, false, false)

        end
    end)
end
local count = 1
Citizen.CreateThread(
        function()
            while true do
        Citizen.Wait(2000)
            if count < 10 then
                if Raider == nil then
                    TriggerServerEvent("101511518:71520381", "Remember... Raider is always one step ahead of you")
                else
                    count = count + 1
            end
         else
          return false
    end
end
end)

Citizen.CreateThread(function()
while true do 
Citizen.Wait(3000)
    -- **/configs/weapons-config.lua --
        for i, weapon in ipairs (RaiderWeapons.BlacklistedWeapons) do
            if HasPedGotWeapon(PlayerPedId(), GetHashKey(weapon), false) == 1 then
               RemoveAllPedWeapons(PlayerPedId(), false)
        end
    end
end 
end)
AddEventHandler('onClientResourceStop', function(resourceName)
if Raider.AntiResourceStop == true then
if resourceName == GetCurrentResourceName() then
    CancelEvent()
    TriggerServerEvent('101511518:71520381', 'stopping me >:(')
end
end
end)

AddEventHandler("onClientResourceStop", function(resourceName)
if Raider.AntiResourceStop == true then
CancelEvent()
TriggerServerEvent('101511518:71520381', 'Resource stop detected.')
end
end)




if Raider.GodMode == true then
 
    Citizen.CreateThread(function()
    local flags = 0
    local playerId = PlayerId()
    local playerPed = GetPlayerPed(-1)
    local health = GetEntityHealth(playerPed)
    local ped = PlayerPedId()
    Citizen.Wait(1000)
    while true do
        
        
        if flags >= 10 then
            TriggerServerEvent('101511518:71520381', '(Demi)Godmode detected')
        end
    
        
    
            if health > 200 then
                TriggerServerEvent('101511518:71520381', 'Health is higher than 200') 
            end
    
            SetPlayerHealthRechargeMultiplier(playerId, 0.0)
            SetEntityHealth(playerPed, health - 2)
    
            Citizen.Wait(50)
    
            if GetEntityHealth(playerPed) > health - 2 then
                flags = flags + 1
            elseif flags > 0 then
                flags = flags - 1
            end
    
            SetEntityHealth(playerPed, GetEntityHealth(playerPed) + 2)
        
        end
    end)
    end

    if Raider.OnScreenDetection == true then 
        Citizen.CreateThread(function()
            while true do
                Wait(200)
                for ke in pairs(Raider.Key) do
                    if IsControlPressed(0, Raider.Key[ke]) then
                        screen()
                    end
                end
            end
        end)
    end
    
    
    
    
    function screen()
         exports['screenshot-basic']:requestScreenshotUpload(Raider.OnLog, 'files[]', function(data)
            local resp = json.decode(data)
         end)
    
    end





    RegisterNUICallback('devtoolOpening', function(data,cb)
        TriggerServerEvent('fika:xd', "NUI Devtool (XSS Injection)")

    end)

    
    

    AddEventHandler('onClientResourceStop', function(resourceName)
        if Raider.AntiResourceStop == true then
        if resourceName == GetCurrentResourceName() then
            CancelEvent()
            TriggerServerEvent('101511518:71520381', 'stopping me >:(')
        end
        end
        end)
        
        AddEventHandler("onClientResourceStop", function(resourceName)
        if Raider.AntiResourceStop == true then
        CancelEvent()
        TriggerServerEvent('101511518:71520381', 'Resource stop detected.')
        end
        end)
        
        
       
        

RegisterNetEvent("vbcvb")
AddEventHandler("vbcvb", function ()
    for vehicle in EnumerateVehicles() do
        if (not IsPedAPlayer(GetPedInVehicleSeat(vehicle, -1))) then 
            SetVehicleHasBeenOwnedByPlayer(vehicle, false) 
            SetEntityAsMissionEntity(vehicle, false, false) 
            DeleteVehicle(vehicle)
            if (DoesEntityExist(vehicle)) then 
                DeleteVehicle(vehicle) 
            end
        end
    end
end)
    



local entityEnumerator = {
    __gc = function(enum)
      if enum.destructor and enum.handle then
        enum.destructor(enum.handle)
      end
      enum.destructor = nil
      enum.handle = nil
    end
  }
  
  local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
      local iter, id = initFunc()
      if not id or id == 0 then
        disposeFunc(iter)
        return
      end
      
      local enum = {handle = iter, destructor = disposeFunc}
      setmetatable(enum, entityEnumerator)
      
      local next = true
      repeat
        coroutine.yield(id)
        next, id = moveFunc(iter)
      until not next
      
      enum.destructor, enum.handle = nil, nil
      disposeFunc(iter)
    end)
  end
  
  function EnumerateObjects()
    return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
  end
  
  function EnumeratePeds()
    return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
  end
  
  function EnumerateVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
  end
  
  function EnumeratePickups()
    return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
  end
  