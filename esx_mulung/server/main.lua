local ESX = nil

TriggerEvent("esx:getSharedObject", function(obj) 
    ESX = obj 
end)

RegisterServerEvent("wr-mulung:sellBottles")
AddEventHandler("wr-mulung:sellBottles", function()
    local player = ESX.GetPlayerFromId(source)

    local currentBottles = player.getInventoryItem("botol")["count"]
    
    if currentBottles > 0 then
        math.randomseed(os.time())
        local randomMoney = math.random((Config.BottleReward[1] or 1), (Config.BottleReward[2] or 4))

        player.removeInventoryItem("botol", currentBottles)
        player.addMoney(randomMoney * currentBottles)

        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Anda memberi toko %s botol dan dibayar Rp%s.', currentBottles, currentBottles * randomMoney})
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Anda tidak memiliki botol untuk diberikan ke toko.'})
    end
end)

RegisterServerEvent("wr-mulung:retrieveBottle")
AddEventHandler("wr-mulung:retrieveBottle", function()
    local player = ESX.GetPlayerFromId(source)

    math.randomseed(os.time())
    local luck = math.random(0, 69)
    local randomBottle = math.random((Config.BottleRecieve[1] or 1), (Config.BottleRecieve[2] or 6))

    if luck >= 0 and luck <= 29 then
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Tidak ada botol di tempat sampah itu.'})
    else
        player.addInventoryItem("botol", randomBottle)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Anda menemukan x%s botol', randomBottle})
    end
end)
