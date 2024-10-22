local RSGCore = exports['rsg-core']:GetCoreObject()

RegisterServerEvent('hdrp-tricktreat:server:givetreat', function()
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then return end
    local surprise = Config.Items[math.random(#Config.Items)]
    local amount = math.random(Config.AmountMin, Config.AmountMax)
    if RSGCore.Shared.Items[surprise] then
        Player.Functions.AddItem(surprise, amount)
        TriggerClientEvent('rsg-inventory:client:ItemBox', src, RSGCore.Shared.Items[surprise], 'add', amount)
        local itemLabel = RSGCore.Shared.Items[surprise].label
        TriggerClientEvent('ox_lib:notify', src, { title = 'Happy Halloween!', description = 'You received ' .. amount .. 'x ' .. itemLabel, type = 'success', duration = 5000 })
    else
        TriggerClientEvent('ox_lib:notify', src, { title = 'Error', description = 'The selected item does not exist!', type = 'error', duration = 5000})
    end
end)