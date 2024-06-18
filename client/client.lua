/*
 *   Copyright (c) Foxxite | Articca
 *   All rights reserved.
 */

QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
	while true do
		if LocalPlayer.state.isLoggedIn then
			local ped = PlayerPedId()

			if IsEntityInWater(ped) then
				QBCore.Functions.Notify("Maybe you should take your phone out of your pocket before you go swimming...",
					"error")
				TriggerServerEvent("wet-phone:server:MakePhonesWet")
			end
		end

		Wait(5000)
	end
end)

CreateThread(function()
	exports['qb-target']:AddBoxZone("repair_phone",
		vector3(Config.RepairPoint.x, Config.RepairPoint.y, Config.RepairPoint.z),
		1.0, 1.0, {
			name = "repair_phone",
			heading = 0,
			debugPoly = false,
			minZ = Config.RepairPoint.z - 0.5,
			maxZ = Config.RepairPoint.z + 0.5
		}, {
			options = {
				{
					event = "wet-phone:client:RepairPhone",
					icon = "fas fa-tools",
					label = "Repair Phone"
				}
			},
			distance = 1.5
		})
end)

RegisterNetEvent("wet-phone:client:RepairPhone", function()
	TriggerServerEvent("wet-phone:server:RepairPhone")
end)
