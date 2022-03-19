ESX = nil 

TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
print('^5GMW_Trucker-Script v2')
print('^1Version: 2.0.7')
print('^2github.com/devkoma')

local filename = function()
    local str = debug.getinfo(2, "S").source:sub(2)
    return str:match("^.*/(.*).lua$") or str
end
local file = filename()
ESX.RegisterServerCallback('GMW_Scripts:FileStartetd', function(source, cb)
    cb(file)
end)

-- ════════════════════════════════════════════════════════════════════════════════════ --
--                                 ServerEvents                                         --
-- ════════════════════════════════════════════════════════════════════════════════════ --

RegisterServerEvent("GMW_Scripts:GiveTruckerMoney")
AddEventHandler("GMW_Scripts:GiveTruckerMoney", function(info, EndReward)
    local xPlayer = ESX.GetPlayerFromId(source)
    print(EndReward)
    xPlayer.addMoney(EndReward)
    TriggerClientEvent('esx:showNotification', source, "Du hast ~g~"..EndReward.."$~w~ von ~g~"..info.Reward.."$~w~ für deinen Auftrag bekommen")
end)

RegisterServerEvent("GMW_Scripts:PayFee")
AddEventHandler("GMW_Scripts:PayFee", function(info)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeMoney(info.Reward)
    TriggerClientEvent('esx:showNotification', source, "~y~Ein Mitarbeiter~w~ hat die Ware abgeholt und sie zurück ins ~b~Depot~w~ gebracht!")
    TriggerClientEvent('esx:showNotification', source, "~r~Du musstest die Kosten für die Ware Übernehmen!~w~\r\nKosten: ~g~"..info.Reward.."$")
end)
