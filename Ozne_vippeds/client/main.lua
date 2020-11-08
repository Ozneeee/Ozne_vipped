ESX = nil
local currentAction, currentActionMsg, hasPaid

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

TriggerEvent('chat:addSuggestion', '/ped', 'Ouvre la console sur F8 et fait /ped !')

RegisterCommand("/ped", function(source, args, rawCommand)
	TriggerEvent('ozne_vipped:menu')
end, true)


RegisterNetEvent("ozne_vipped:menu")
AddEventHandler("ozne_vipped:menu", function()
	ESX.TriggerServerCallback('pxrp_vip:getVIPStatus', function(isVIP)
		if isVIP then
			OpenPedsMenu()
		else
			ESX.ShowNotification("~p~Tu n est pas~s~ ~y~VIP !")
		end
	end, GetPlayerServerId(PlayerId()), '1')
    local source = GetPlayerServerId();
end)

function OpenPedsMenu()
	hasPaid = false

	TriggerEvent('esx_skin:openRestrictedMenu', function(data, menu)
		menu.close()

		TriggerEvent('esx_skin:openRestrictedMenu', function(data, menu)
			menu.close()
			currentAction    = 'peds_menu'
			--currentActionMsg  = '~INPUT_CONTEXT~ Peds'
		end, {
			'sex',
		})
	end)
end

AddEventHandler('ozne_vipped:hasEnteredMarker', function(zone)
	currentAction = 'peds_menu'
	currentActionMsg = '~INPUT_CONTEXT~ Peds'
end)

AddEventHandler('ozne_vipped:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
	currentAction = nil

	if not hasPaid then
		ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
			TriggerEvent('vipPed:loadSkin', skin)
		end)
	end
end)

