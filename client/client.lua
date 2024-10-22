local RSGCore = exports['rsg-core']:GetCoreObject()
local spawnedPeds = {}
local spawnedProps = {}
local isInteracting = false

--------------------------------------
-- Message Trick Random
--------------------------------------
local function notifyHalloween()
    local randomIndex = math.random(#Config.msg)
    local randomMsgSelected = Config.msg[randomIndex]
    lib.notify({ title = randomMsgSelected, type = 'error', duration = 10000 })
end

---------------------
-- requeriment animation
---------------------
local function AnimationNpc(entity, dict, name, flag)
	local waiting = 0
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		waiting = waiting + 100
		Wait(100)
		if waiting > 5000 then
            lib.notify({ title = 'Error', description = 'Rompiste la animacion, Reubicar', type = 'error', duration = 3000 })
            break
        end
	end

    TaskPlayAnim(entity, dict, name, 1.0, 1.0, -1, flag or 0, 0, false, false, false)
end

local function npcAnimation(entity, dict, dictname, flag)
	local coords = GetEntityCoords(entity)
	ClearPedTasks(entity)
	ClearPedSecondaryTask(entity)
	AnimationNpc(entity, dict, dictname, flag)
    FreezeEntityPosition(entity, true)
end

local function StopAnimation(entity, animdict, animdictname)
    TaskPlayAnim(entity, animdict, animdictname, 1.0, 1.0, -1, 0, 1.0, false, false, false)
	FreezeEntityPosition(entity, false)
end

---------------------
-- spawn
--------------------- 
local function NearProp(npc)
    -- animation spawn
	npcAnimation(npc,'mini_games@blackjack_mg@dealer@self@cleanup', 'cleanup_discard', 31)
    Wait(1500)
    StopAnimation(npc,'mini_games@blackjack_mg@dealer@self@cleanup', 'cleanup_discard')
    ClearPedTasks(npc)

    -- spawn
    local coords = GetEntityCoords(npc)
    local randomtrickIndex = math.random(#Config.trick)
    local randomtrickModel = joaat(Config.trick[randomtrickIndex])

    while not HasModelLoaded(randomtrickModel) do
        Wait(10)
        RequestModel(randomtrickModel)
    end
    RequestModel(randomtrickModel)
    local boneTrick = GetEntityBoneIndexByName(npc, 'SKEL_R_Finger00')
    local trick = CreateObject(randomtrickModel, coords.x, coords.y, coords.z, true, true, true)
    -- spawn B
    local randomtreatIndex = math.random(#Config.treat)
    local randomtreatModel = joaat(Config.treat[randomtreatIndex])

    while not HasModelLoaded(randomtreatModel) do
        Wait(10)
        RequestModel(randomtreatModel)
    end
    RequestModel(randomtreatModel)
    local boneTreat = GetEntityBoneIndexByName(npc, 'SKEL_L_Finger00')
    local treat = CreateObject(randomtreatModel, coords.x, coords.y, coords.z, true, true, true)

    SetCurrentPedWeapon(npc, "WEAPON_UNARMED", true)
    FreezeEntityPosition(npc, true)
    ClearPedTasksImmediately(npc)

    AttachEntityToEntity(trick, npc, boneTrick, 0.00, -0.05, -0.04, 0.0, 120.0, 0.0, false, false, false, false, 0, true)
    AttachEntityToEntity(treat, npc, boneTreat, 0.00, -0.05, 0.03, 0.0, 150.0, -45.0, false, false, false, false, 0, true)

    -- animation hands
    npcAnimation(npc,'script_proc@robberies@homestead@lonnies_shack@deception', 'hands_up_loop', 31)
    table.insert(spawnedProps, {trick = trick, treat = treat})

    return trick, treat
end

local function NearNPC(model_entry, coords, heading)
    -- spawn
    local model = joaat(model_entry)
    while not HasModelLoaded(model) do
        Wait(10)
        RequestModel(model)
    end
    RequestModel(model)

    local distanceBehind = -0.50  -- Dist spawn  (0.5 unidades)
    local radians = math.rad(heading)
    local offsetX = -distanceBehind * math.sin(radians)
    local offsetY = distanceBehind * math.cos(radians)

    local X = coords.x - offsetX
    local Y = coords.y - offsetY
    local Z = coords.z - 1.0

    Wait(500)

    local spawnedPed = CreatePed(model, X, Y, Z, heading or 0.0, false, false, 0, 0)
    SetEntityAlpha(spawnedPed, 0, false)
    SetRandomOutfitVariation(spawnedPed, true)
    SetEntityCanBeDamaged(spawnedPed, false)
    SetEntityInvincible(spawnedPed, true)
    FreezeEntityPosition(spawnedPed, true)
    SetBlockingOfNonTemporaryEvents(spawnedPed, true)

    table.insert(spawnedPeds, {ped = spawnedPed})

    SetPedRelationshipGroupHash(spawnedPed, GetPedRelationshipGroupHash(spawnedPed)) -- SetPedRelationshipGroupHash
    SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(spawnedPed), `PLAYER`) -- SetRelationshipBetweenGroups
    if Config.FadeIn then
        for i = 0, 255, 51 do
            Wait(50)
            SetEntityAlpha(spawnedPed, i, false)
        end
    end
    return spawnedPed
end

---------------------
-- Function to play the knock animation
---------------------
local function playKnockAnimation()
    npcAnimation(cache.ped, 'amb_misc@world_human_door_knock@male_a@idle_c', 'idle_h', 16)
    TriggerServerEvent('InteractSound_SV:PlayOnSource', 'boxopen', 0.8)
    Wait(2000)
    StopAnimation(cache.ped, 'amb_misc@world_human_door_knock@male_a@idle_c', 'idle_h')
end

local function npcanimationobject(entity)
	local coords = GetEntityCoords(cache.ped)
    npcAnimation(cache.ped, 'cnv_camp@handover@stage_03', 'handover_ped', 16)
    Wait(2000)
    if entity ~= nil then
        local boneIndex = GetPedBoneIndex(cache.ped, 7966)
        Wait(1800)
        SetEntityVisible(entity, false, false)
        AttachEntityToEntity(entity, cache.ped, boneIndex, 0.00, 0.00, 0.0, 0.0, 180.0, 0.0, false, false, false, false, 0, true)
        SetEntityVisible(entity, true, true)
        SetEntityAsMissionEntity(entity, true, true)
        Wait(1000)
        AttachEntityToEntity(entity, cache.ped, boneIndex, 0.05, 0.02, -0.06, 0.0, 30.0, 15.0, false, false, false, false, 0, true)
        Wait(300)
        SetEntityVisible(entity, false)
        if DoesEntityExist(entity)  then
            DeleteObject(entity)
        end
    end
    Wait(1000)
    StopAnimation(cache.ped, 'cnv_camp@handover@stage_03', 'handover_ped')
end

local function npcGiveObject(npc, object, objectB, key)
    if DoesEntityExist(object) then
        npcanimationobject(object)
    end
    Wait(1000)

    SetEntityVisible(objectB, false)
    if DoesEntityExist(objectB) then
        DeleteObject(objectB)
    end

    npcAnimation(npc,'mini_games@blackjack_mg@dealer@self@cleanup', 'cleanup_discard', 31)
    Wait(2000)
    StopAnimation(npc,'mini_games@blackjack_mg@dealer@self@cleanup', 'cleanup_discard')
    ClearPedTasks(npc)
end
local hasInteracted = false
--------------------------
-- selected action
--------------------------
local function addCardTarget(ped, trick, treat)
    hasInteracted = false
    lib.notify({ title = 'Trick or Treat!', description = 'selected option!', type = 'error', duration = 7000 })
    local chance = math.random(1, 100)
    CreateThread(function()
        if DoesEntityExist(ped) then
                exports['rsg-target']:AddTargetEntity(ped, {
                    options = {
                        {
                            icon = 'fa-solid fa-eye',
                            label = 'Trick',
                            action = function()
                                if hasInteracted then
                                    lib.notify({ title = 'You have already interacted!', description = 'You cannot select again.', type = 'error', duration = 5000 })
                                    return
                                else
                                    hasInteracted = true
                                    if chance >= (100 - Config.Trollprevent) then
                                        lib.notify({ title = 'I\'m not in the mood, this is what you got..', type = 'error', duration = 5000 })
                                        npcGiveObject(ped, treat, trick, 'Treat')
                                        StopAnimation(ped,'script_proc@robberies@homestead@lonnies_shack@deception', 'hands_up_loop')
                                        TriggerServerEvent('hdrp-tricktreat:server:givetreat')
                                    else
                                        npcGiveObject(ped, trick, treat, 'Trick')
                                        StopAnimation(ped,'script_proc@robberies@homestead@lonnies_shack@deception', 'hands_up_loop')
                                        TriggerEvent('hdrp-tricktreat:client:eventsHalloween')
                                    end
                                    ClearPedSecondaryTask(ped)
                                    SetEntityAsNoLongerNeeded(ped)
                                    Wait(10000)
                                    if DoesEntityExist(ped) then
                                        if Config.FadeIn then
                                            for i = 255, 0, -51 do
                                                Wait(50)
                                                SetEntityAlpha(ped, i, false)
                                            end
                                        end
                                        DeleteEntity(ped)
                                        ped = nil
                                        hasInteracted = false
                                    end
                                end
                            end
                        },
                        {
                            icon = 'fa-solid fa-eye',
                            label = 'Treat',
                            action = function()
                                if hasInteracted then
                                    lib.notify({ title = 'You have already interacted!', description = 'You cannot select again.', type = 'error', duration = 5000 })
                                    return
                                else
                                    hasInteracted = true
                                    if chance >= (100 - Config.Trollprevent) then
                                        lib.notify({ title = 'Halloween is the one night where the impossible becomes possible, and magic dances in the air', type = 'error', duration = 10000 })
                                        npcGiveObject(ped, trick, treat, 'Trick')
                                        StopAnimation(ped,'script_proc@robberies@homestead@lonnies_shack@deception', 'hands_up_loop')
                                        TriggerEvent('hdrp-tricktreat:client:eventsHalloween')
                                    else
                                        npcGiveObject(ped, treat, trick, 'Treat')
                                        StopAnimation(ped,'script_proc@robberies@homestead@lonnies_shack@deception', 'hands_up_loop')
                                        TriggerServerEvent('hdrp-tricktreat:server:givetreat')
                                    end
                                    ClearPedSecondaryTask(ped)

                                    SetEntityAsNoLongerNeeded(ped)
                                    Wait(10000)
                                    if DoesEntityExist(ped) then
                                        if Config.FadeIn then
                                            for i = 255, 0, -51 do
                                                Wait(50)
                                                SetEntityAlpha(ped, i, false)
                                            end
                                        end
                                        DeleteEntity(ped)
                                        ped = nil
                                        hasInteracted = false
                                    end
                                end
                            end
                        }
                    },
                    distance = 2.5 -- Distancia en la que el jugador puede interactuar con la carta
                })
        end
    end)
end

---------------------
-- start interactions
---------------------
local function HandleDoorKnock(door)
    if isInteracting then return end
    isInteracting = true
    door.looted = true

    playKnockAnimation()    -- knock start event
    ClearPedTasks(cache.ped)

    local playerPos = GetEntityCoords(cache.ped)
    local playerHeading = GetEntityHeading(cache.ped)
    local doorcoords = door.coords
    -- spawn ped
    local randomIndex = math.random(#Config.Peds)
    local randomPedModel = joaat(Config.Peds[randomIndex])
    local heading = playerHeading - 180.0
    Wait(100)
    local spawnedPed = NearNPC(randomPedModel, doorcoords, heading)
    if spawnedPed then
        Citizen.InvokeNative(0x524B54361229154F, spawnedPed, joaat('WORLD_HUMAN_STAND_IMPATIENT'), -1, true, false, 0, false)

        Wait(1000)
        if spawnedPed and DoesEntityExist(spawnedPed) then
            local trick, treat = NearProp(spawnedPed)
            Wait(100)
            addCardTarget(spawnedPed, trick, treat)
        end
    end

    isInteracting = false
end

---------------------
-- Event handler for knocking on the door
---------------------
RegisterNetEvent('hdrp-tricktreat:client:knockOnDoor')
AddEventHandler('hdrp-tricktreat:client:knockOnDoor', function()
    
    local playerPos = GetEntityCoords(cache.ped)
    local doorFound = false
    for k, v in pairs(Config.Doors) do
        local dst = #(playerPos - v.coords)
        if dst < 3.0 then
            doorFound = true
            if not v.looted then
                local chance = math.random(100)
                if chance >= 80 then
                    lib.notify({ title = 'If you knock on the right door this Halloween, you might just meet a friendly ghost... or not so friendly!', type = 'error', duration = 7000 })
                end
                HandleDoorKnock(v)
                break
            else
				lib.notify({ title = 'Already Visited!', description = 'this door has already been visited!', type = 'error', duration = 7000 })
                break
            end
        end
    end
    if not doorFound then
        lib.notify({ title = 'Something went wrong!', type = 'error', duration = 7000 })
    end
end)

local zone = 0
CreateThread(function()
    for k, v in pairs(Config.Doors) do
        zone = zone + 1
        if not isInteracting then
            exports['rsg-target']:AddBoxZone(tostring(zone), v.coords, 2.0, 2.0, {
                name = tostring(zone),
                heading = 0,
                debugPoly = false,
                minZ = v.coords.z - 1.0,
                maxZ = v.coords.z + 1.0
            }, {
                options = {
                    {
                        event = 'hdrp-tricktreat:client:knockOnDoor',
                        icon = 'fas fa-door',
                        label = 'Knock',
                    },
                },
                distance = 2.0
            })
        else
        end
    end
end)

--------------------------------------
-- command
--------------------------------------
RegisterCommand('tricktreat', function(source, args)
    TriggerEvent('hdrp-tricktreat:client:knockOnDoor')
end, false)

--------------------------
-- selected trick
--------------------------
RegisterNetEvent('hdrp-tricktreat:client:eventsHalloween')
AddEventHandler('hdrp-tricktreat:client:eventsHalloween', function(npc)
    local location = GetEntityCoords(cache.ped)
    local radius = Config.RadiusEvent
    notifyHalloween()
    Wait(3000)
    TriggerServerEvent('hdrp-clowsfight:server:StartFight', GetPlayerServerId(PlayerId()), location, radius)
end)

--------------------------------------
-- cleanup
--------------------------------------
AddEventHandler("onResourceStop", function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    for k, v in pairs(spawnedPeds) do
        if v.ped and DoesEntityExist(v.ped) then
            DeleteEntity(v.ped)
        end
        spawnedPeds[k] = nil
    end
    for k, v in pairs(spawnedProps) do
        if v.treat and DoesEntityExist(v.treat) then
            DeleteEntity(v.treat)
        end
        if v.trick and DoesEntityExist(v.trick) then
            DeleteEntity(v.trick)
        end
        spawnedProps[k] = nil
    end
end)