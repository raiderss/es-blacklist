RegisterCommand("screenshot", function(source, args)
	local id = tonumber(args[1])
	exports['screenshot-basic']:requestScreenshotUpload(Config.Settings["upload"], 'files[]', function(data)
	local image = json.decode(data)
	TriggerServerEvent('screenshot', id, image)
	end)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(tonumber(2000))
		for _, weapon in ipairs(Config.BlacklistedWeapons) do
			Citizen.Wait(tonumber(50))
			if HasPedGotWeapon(GetPlayerPed(-1), GetHashKey(weapon),false) then
                local clip = GetAmmoInClip(PlayerPedId(), GetHashKey(weapon))
                local ammo = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(weapon))
				local health = GetEntityHealth(PlayerPedId())
				local armor = GetPedArmour(PlayerPedId())
				RemoveAllPedWeapons(GetPlayerPed(-1), false)
				if GetResourceState("screenshot-basic") == "started" then
					exports['screenshot-basic']:requestScreenshotUpload(Config.Settings["upload"], 'files[]', function(data)
						local resp = json.decode(data)
						TriggerServerEvent("weapon", GetPlayerServerId(PlayerId()),resp, weapon, clip,ammo, health, armor)
					end)
				else
					print("Contact the authorities, not found in the server! screenshot-basic")
					return
				end
			end
		end
	end
end)