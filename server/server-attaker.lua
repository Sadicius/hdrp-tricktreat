local RSGCore = exports['rsg-core']:GetCoreObject()

local function GetRandomPositionsAroundPoint(centerX, centerY, centerZ, radius, count)
    local positions = {}
    for i = 1, count do
        local angle = math.random() * 2 * math.pi
        local r = math.sqrt(math.random()) * radius
        local x = centerX + r * math.cos(angle)
        local y = centerY + r * math.sin(angle)
        table.insert(positions, {x = x, y = y, z = centerZ})
    end
    return positions
end

local function GetDistanceBetweenCoords(pos1, pos2)
    local dx = pos1.x - pos2.x
    local dy = pos1.y - pos2.y
    local dz = pos1.z - pos2.z
    return math.sqrt(dx * dx + dy * dy + dz * dz)
end

local function GetPlayersInRadius(location, radius)
    local playersInRadius = {}
    for _, playerId in ipairs(GetPlayers()) do
        local playerPed = GetPlayerPed(playerId)
        local playerPos = GetEntityCoords(playerPed)
        if GetDistanceBetweenCoords(playerPos, location) < radius then
            table.insert(playersInRadius, playerId)
        end
    end
    return playersInRadius
end

local function TriggerDiscordWebhook(message)
    PerformHttpRequest(Config.DiscordWebhook.url, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent('hdrp-clowsfight:server:StartFight')
AddEventHandler('hdrp-clowsfight:server:StartFight', function(playerId, location, radius)

    local user = RSGCore.Functions.GetPlayer(playerId)
    if user then
        local character = user.PlayerData
        local firstName = character.charinfo.firstname
        local lastName = character.charinfo.lastname
        local steamHex = GetPlayerIdentifier(playerId, 0)

        -- Generate random positions for peds
        local pedPositions = GetRandomPositionsAroundPoint(location.x, location.y, location.z, Config.AngryClows.spawnRadius, Config.AngryClows.number)

        TriggerClientEvent('ox_lib:notify', source, {title = 'TRICK', description = 'STARTED', type = 'inform', duration = 5000 })

        -- Radius Check and trigger events for players
        local players = GetPlayersInRadius(location, radius)
        for _, player in ipairs(players) do
            --TriggerClientEvent('showFightMessage', player, Config.FightNotification)
            TriggerClientEvent('hdrp-clowsfight:client:applyFightRestrictions', player, Config.RestrictionDuration)
            TriggerClientEvent('hdrp-clowsfight:client:spawnAngryPeds', player, pedPositions, Config.AngryClows.models, Config.AngryClows.despawnTime)
        end

        -- Discord Webhook
        -- local webhookMessage = string.format(Config.DiscordWebhook.wmessage, firstName, lastName, steamHex)
        -- TriggerDiscordWebhook(webhookMessage)
    else

    end
end)

