local RSGCore = exports['rsg-core']:GetCoreObject()
local spawnedPedFights = {}

---------------------------------------------------------
-- spawn when in distance
---------------------------------------------------------
local function SetPedClothing(entity)
    local chance = math.random(100)
    local buffaloHornOutfitHash = 0x96B481A2  -- Hash for 'player_zero_tal_buffalo_horn_000'

    if DoesEntityExist(entity) then

        Citizen.InvokeNative(0x283978A15512B2FE, entity, true)
        -- RemoveAllPedWeapons(entity, true)

        if Config.outfithChange == true then
            if chance >= Config.clownsuit and Config.clownsuithalloween == true then
                Citizen.InvokeNative(0x1902C4CFCC5BE57C, entity, buffaloHornOutfitHash)    -- Apply the 'buffalo horn' talisman outfit piece
                Citizen.InvokeNative(0xCC8CA3E88256E58F, entity, false, true, true, true, false)    -- Update the ped's variation to show the change
            end
        end

    end
end

local function SetPedweaponfith(entity)
    local chance = math.random(100)
    if entity and DoesEntityExist(entity) then
        -- RemoveAllPedWeapons(entity, false)
        if Config.weaponfithChange == true then
            -- if chance >= Config.weaponhalloween then
                local index = math.random(#Config.weaponModels)
                local modelweaponName = Config.weaponModels[index]
                local weaponHash = joaat(modelweaponName)
                GiveWeaponToPed(entity, weaponHash, 1, false, true)
                SetCurrentPedWeapon(entity, weaponHash, true)
            -- end
        else
            local weaponHash = joaat('weapon_melee_lantern_halloween')
            GiveWeaponToPed(entity, weaponHash, 1, false, true)
            SetCurrentPedWeapon(entity, weaponHash, true)
        end
    end
end

local function Spawnattaker(model, spawnpoint, heading)
    RequestModel(model)
    DecorRegister('trick', 2)
    while not HasModelLoaded(model) do
        Wait(50)
    end
    local spawnedPed = CreatePed(model, spawnpoint.x, spawnpoint.y, spawnpoint.z - 1.0, heading, true, false, 0, 0)
    table.insert(spawnedPedFights, {ped = spawnedPed})
    DecorSetBool(spawnedPed, 'trick', true)
    SetPedClothing(spawnedPed)
    -- SetPedOutfitPreset(spawnedPed, outfit)

    -- trick settings
    SetPedSeeingRange(spawnedPed, Config.AngryClows.SeeingRange)
    SetPedHearingRange(spawnedPed, Config.AngryClows.HearingRange)
    SetPedCombatAttributes(spawnedPed, 46, true)
    StopPedSpeaking(spawnedPed, true)
    SetPedRelationshipGroupHash(spawnedPed, joaat('trick'))
    SetPedPromptName(spawnedPed, 'Trick')
    SetPedFleeAttributes(spawnedPed, 0, 0)
    TaskSetBlockingOfNonTemporaryEvents(spawnedPed, true)

    -- set relationship
    AddRelationshipGroup('trick')
    SetRelationshipBetweenGroups(5, joaat('trick'), joaat('PLAYER'))
    SetRelationshipBetweenGroups(5, joaat('PLAYER'), joaat('trick'))

    -- give trick halloween lantern
    SetPedweaponfith(spawnedPed)

    SetPedRelationshipGroupHash(spawnedPed, GetHashKey('REL_HATE_PLAYER'))
    TaskCombatPed(spawnedPed, cache.ped, 0, 16)

    -- set trick walk
    walk = Config.AngryClows.Walks[math.random(1, #Config.AngryClows.Walks)]
    Citizen.InvokeNative(0x923583741DC87BCE, spawnedPed, walk[1])
    Citizen.InvokeNative(0x89F5E7ADECCCB49C, spawnedPed, walk[2])

    -- show trick blips (config for on/off)
    if Config.AngryClows.ShowtrickBlips then
        Citizen.InvokeNative(0x23f74c2fda6e7c61, Config.AngryClows.trickBlipSprite, spawnedPed)
    end

    TaskWanderStandard(spawnedPed, 10.0, 10)

    return spawnedPed

end

RegisterNetEvent('hdrp-clowsfight:client:spawnAngryPeds')
AddEventHandler('hdrp-clowsfight:client:spawnAngryPeds', function(pedPositions, pedModels, despawnTime)
    CreateThread(function()
        for i, position in ipairs(pedPositions) do
            local modelName = pedModels[math.random(#pedModels)]
            local modelHash = GetHashKey(modelName)

            local heading = math.random(1, 359)
            local ped = Spawnattaker(modelHash, position, heading)
            if DoesEntityExist(ped) then

                SetPedRelationshipGroupHash(ped, GetHashKey('REL_HATE_PLAYER'))
                TaskCombatPed(ped, cache.ped, 0, 16)

                -- Despawn after the specified time
                SetTimeout(despawnTime, function()
                    SetModelAsNoLongerNeeded(modelHash)
                    if DoesEntityExist(ped) then
                        DeleteEntity(ped)
                    end
                end)
            end
        end
    end)
end)

---------------------------------------------------------
-- Restrictions
---------------------------------------------------------
local function MakeNearbyPedsFlee()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local radius = 20.0 -- Adjust this to change the area where peds will flee

    -- Get all peds in the area
    local peds = GetGamePool('CPed')
    for _, ped in ipairs(peds) do
        if ped ~= playerPed and not IsPedAPlayer(ped) then
            local pedCoords = GetEntityCoords(ped)
            local distance = #(playerCoords - pedCoords)

            if distance <= radius then
                -- Make the ped flee
                TaskSmartFleePed(ped, playerPed, 100.0, -1, true, true)
                SetPedKeepTask(ped, true)
            end
        end
    end
end

RegisterNetEvent('hdrp-clowsfight:client:applyFightRestrictions')
AddEventHandler('hdrp-clowsfight:client:applyFightRestrictions', function()
    local RESTRICTION_END_TIME = GetGameTimer() + Config.AngryClows.RestrictionDuration
    local playerCoords = GetEntityCoords(PlayerPedId())

    -- Notify the player about the fight restrictions
    lib.notify({ title =  "FIREARMS DISABLED", description = "FIGHT", type = 'inform', duration = 5000 })
    Wait(5000)
    lib.notify({ title = "FISTS ONLY BRAWL BEGUN", description = "FIGHT", type = 'inform', duration = 5000 })
    -- Alert lawmen about the bar fight
    TriggerServerEvent('rsg-lawman:server:lawmanAlert', "Night fight in progress!", playerCoords)

    CreateThread(function()
        while GetGameTimer() <= RESTRICTION_END_TIME do
            Wait(0)
            local ped = PlayerPedId()

            -- Disable firing for all weapons
            SetPedConfigFlag(ped, 58, true)
            SetPedConfigFlag(ped, 60, true)

            -- Disable weapon wheel and weapon-related controls
            DisableControlAction(0, 0xD8F73058, true) -- Weapon Wheel
            DisableControlAction(0, 0x4CC0E2FE, true) -- Weapon Wheel Up/Down
            DisableControlAction(0, 0x07CE1E61, true) -- LMB (Fire)
            DisableControlAction(0, 0xF84FA74F, true) -- RMB (Aim)
            DisableControlAction(0, 0x0AF99998, true) -- R key (Reload)
            DisableControlAction(0, 0x8B7ECFB7, true) -- Equip/Unequip Weapon

            -- Allow melee controls
            EnableControlAction(0, 0x2EAB0795, true) -- Melee Attack Light
            EnableControlAction(0, 0x0283C582, true) -- Melee Attack Heavy
            EnableControlAction(0, 0xB2F377E8, true) -- Melee Block
        end

        -- Re-enable weapon functionality for the player
        local ped = PlayerPedId()
        SetPedConfigFlag(ped, 58, false)
        SetPedConfigFlag(ped, 60, false)

        MakeNearbyPedsFlee()

        -- lib.notify({ title = "FIGHT OVER - NPCs FLEEING!", description = "BAR FIGHT", type = 'inform', duration = 5000 })
        Wait(5000)
        -- lib.notify({ title = "BAR FIGHT CONCLUDED", description = "AREA CLEAR", type = 'inform', duration = 5000 })
        TriggerServerEvent('rsg-lawman:server:lawmanAlert', "Monsters fight has ended.", playerCoords)
    end)
end)

local resource = GetCurrentResourceName()
AddEventHandler('onResourceStop', function(r)
    if r == resource then
        for _, v in ipairs(spawnedPedFights) do
            if DoesEntityExist(v.ped) then
                DeleteEntity(v.ped)
                v.ped = nil
            end
        end
        -- Clear the list after deletion
        spawnedPedFights = {}
    end
end)