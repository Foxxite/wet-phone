/*
 *   Copyright (c) Foxxite | Articca
 *   All rights reserved.
 */

QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('wet-phone:server:MakePhonesWet', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	for k, v in pairs(Config.PhoneItems) do
		if Player.Functions.GetItemByName(v) then
			Player.Functions.RemoveItem(v, 1)
			Player.Functions.AddItem(Config.WetPhoneItem, 1, nil, { ["prev-phone"] = v })
		end
	end
end)

RegisterNetEvent('wet-phone:server:RepairPhone', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.GetItemByName(Config.WetPhoneItem) then
		if Player.Functions.RemoveMoney("bank", Config.RepairCost, "wet-phone-repair") then
			local prevPhone = Player.Functions.GetItemByName(Config.WetPhoneItem).info["prev-phone"]
			Player.Functions.RemoveItem(Config.WetPhoneItem, 1)
			Player.Functions.AddItem(prevPhone, 1)
			TriggerClientEvent('QBCore:Notify', src, "You have repaired your phone", "success")
		else
			TriggerClientEvent('QBCore:Notify', src, "You don't have enough money to repair your phone", "error")
		end
	end
end)
