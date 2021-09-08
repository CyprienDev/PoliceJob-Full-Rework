local PlayerData, CurrentActionData, handcuffTimer, dragStatus, blipsCops, currentTask, spawnedVehicles = {}, {}, {}, {}, {}, {}, {}
local HasAlreadyEnteredMarker, isDead, IsHandcuffed, hasAlreadyJoined, playerInService, isInShopMenu = false, false, false, false, false, false
local LastStation, LastPart, LastPartNum, LastEntity, CurrentAction, CurrentActionMsg

local attente = 0

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
	PlayerData.job = job  
	Citizen.Wait(5000) 
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)


local blips = { 
	{title="LSPD", colour=38, id=60, x = 422.88, y = -978.96, z = 30.71},
  }
	  
  
  
  Citizen.CreateThread(function()
	Citizen.Wait(0)
		 for _, info in pairs(blips) do
			 info.blip = AddBlipForCoord(info.x, info.y, info.z)
						 SetBlipSprite(info.blip, info.id)
						 SetBlipDisplay(info.blip, 4)
						 SetBlipScale(info.blip, 0.8)
						 SetBlipColour(info.blip, info.colour)
						 SetBlipAsShortRange(info.blip, true)
						 BeginTextCommandSetBlipName("STRING")
						 AddTextComponentString(info.title)
						 EndTextCommandSetBlipName(info.blip)
		 end
   end)

local Items = {}      -- Item que le joueur possède (se remplit lors d'une fouille)
local Armes = {}    -- Armes que le joueur possède (se remplit lors d'une fouille)
local ArgentSale = {}  -- Argent sale que le joueur possède (se remplit lors d'une fouille)
local IsHandcuffed, DragStatus = false, {}
DragStatus.IsDragged          = false

local PlayerData = {}

local function MarquerJoueur()
	local ped = GetPlayerPed(ESX.Game.GetClosestPlayer())
	local pos = GetEntityCoords(ped)
	local target, distance = ESX.Game.GetClosestPlayer()
	if distance <= 4.0 then
	DrawMarker(2, pos.x, pos.y, pos.z+1.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 255, 0, 170, 0, 1, 2, 1, nil, nil, 0)
end
end

-- Reprise du menu fouille du pz_core (modifié)
local function getPlayerInv(player)
Items = {}
Armes = {}
ArgentSale = {}

ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)
	for i=1, #data.accounts, 1 do
		if data.accounts[i].name == 'black_money' and data.accounts[i].money > 0 then
			table.insert(ArgentSale, {
				label    = ESX.Math.Round(data.accounts[i].money),
				value    = 'black_money',
				itemType = 'item_account',
				amount   = data.accounts[i].money
			})

			break
		end
	end

	for i=1, #data.weapons, 1 do
		table.insert(Armes, {
			label    = ESX.GetWeaponLabel(data.weapons[i].name),
			value    = data.weapons[i].name,
			right    = data.weapons[i].ammo,
			itemType = 'item_weapon',
			amount   = data.weapons[i].ammo
		})
	end

	for i=1, #data.inventory, 1 do
		if data.inventory[i].count > 0 then
			table.insert(Items, {
				label    = data.inventory[i].label,
				right    = data.inventory[i].count,
				value    = data.inventory[i].name,
				itemType = 'item_standard',
				amount   = data.inventory[i].count
			})
		end
	end
end, GetPlayerServerId(player))
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    blockinput = true
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Wait(0)
    end 
        
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        blockinput = false
        return result
    else
        Wait(500)
        blockinput = false
        return nil
    end
end

RMenu.Add('police', 'main', RageUI.CreateMenu("LSPD", "Intéraction"))
RMenu.Add('police', 'inter', RageUI.CreateSubMenu(RMenu:Get('police', 'main'), "LSPD", "Intéraction"))
RMenu.Add('police', 'info', RageUI.CreateSubMenu(RMenu:Get('police', 'main'), "LSPD", "Intéraction"))
RMenu.Add('police', 'renfort', RageUI.CreateSubMenu(RMenu:Get('police', 'main'), "LSPD", "Intéraction"))
RMenu.Add('police', 'voiture', RageUI.CreateSubMenu(RMenu:Get('police', 'main'), "LSPD", "Intéraction"))
RMenu.Add('police', 'fouiller', RageUI.CreateSubMenu(RMenu:Get('police', 'main'), "LSPD", "Intéraction"))
RMenu:Get("police", "main"):SetRectangleBanner(0, 1, 0, 300)
RMenu:Get("police", "inter"):SetRectangleBanner(0, 1, 0, 300)
RMenu:Get("police", "info"):SetRectangleBanner(0, 1, 0, 300)
RMenu:Get("police", "renfort"):SetRectangleBanner(0, 1, 0, 300)
RMenu:Get("police", "voiture"):SetRectangleBanner(0, 1, 0, 300)
RMenu:Get("police", "fouiller"):SetRectangleBanner(0, 1, 0, 300)

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('police', 'main'), true, true, true, function()

				RageUI.ButtonWithStyle("Radio Lspd", nil, {RightLabel = "→"},true, function()
				end, RMenu:Get('police', 'info'))
				
				RageUI.ButtonWithStyle("Intéractions sur personne", nil, {RightLabel = "→"},true, function()
				end, RMenu:Get('police', 'inter'))

				RageUI.ButtonWithStyle("Intéractions sur véhicules", nil, {RightLabel = "→"},true, function()
				end, RMenu:Get('police', 'voiture'))

				RageUI.ButtonWithStyle("Donner votre position", nil, {RightLabel = "→"},true, function()
				end, RMenu:Get('police', 'renfort'))



    end, function()
	end)

		RageUI.IsVisible(RMenu:Get('police', 'inter'), true, true, true, function()

			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			RageUI.ButtonWithStyle("Donner une Amende",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
				if Selected then
					local target, distance = ESX.Game.GetClosestPlayer()
					playerheading = GetEntityHeading(GetPlayerPed(-1))
					playerlocation = GetEntityForwardVector(PlayerPedId())
					playerCoords = GetEntityCoords(GetPlayerPed(-1))
					local target_id = GetPlayerServerId(target)
					if closestPlayer ~= -1 and closestDistance <= 3.0 then
					RageUI.CloseAll()        
					OpenBillingMenu() 
					else
						RageUI.Popup({message = "~r~Personne autour"})
					end
				end
			end)

			RageUI.ButtonWithStyle('Fouiller la personne', nil, {RightLabel = "→"}, closestPlayer ~= -1 and closestDistance <= 3.0, function(_, a, s)
				if a then
					MarquerJoueur()
					if s then
					getPlayerInv(closestPlayer)
					ExecuteCommand("me fouille l'individu")
				end
			end
			end, RMenu:Get('police', 'fouiller')) 

        RageUI.ButtonWithStyle("Menotter/démenotter", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
            if (Selected) then
				local target, distance = ESX.Game.GetClosestPlayer()
				playerheading = GetEntityHeading(GetPlayerPed(-1))
				playerlocation = GetEntityForwardVector(PlayerPedId())
				playerCoords = GetEntityCoords(GetPlayerPed(-1))
				local target_id = GetPlayerServerId(target)
				if closestPlayer ~= -1 and closestDistance <= 3.0 then
                TriggerServerEvent('e_police:handcuff', GetPlayerServerId(closestPlayer))
			else
						RageUI.Popup({message = "~r~Personne autour"})
				end
            end
        end)

            RageUI.ButtonWithStyle("Escorter", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if (Selected) then
					local target, distance = ESX.Game.GetClosestPlayer()
					playerheading = GetEntityHeading(GetPlayerPed(-1))
					playerlocation = GetEntityForwardVector(PlayerPedId())
					playerCoords = GetEntityCoords(GetPlayerPed(-1))
					local target_id = GetPlayerServerId(target)
					if closestPlayer ~= -1 and closestDistance <= 3.0 then
                TriggerServerEvent('e_police:drag', GetPlayerServerId(closestPlayer))
			else
						RageUI.Popup({message = "~r~Personne autour"})
				end
            end
        end)

            RageUI.ButtonWithStyle("Mettre dans un véhicule", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if (Selected) then
					local target, distance = ESX.Game.GetClosestPlayer()
					playerheading = GetEntityHeading(GetPlayerPed(-1))
					playerlocation = GetEntityForwardVector(PlayerPedId())
					playerCoords = GetEntityCoords(GetPlayerPed(-1))
					local target_id = GetPlayerServerId(target)
					if closestPlayer ~= -1 and closestDistance <= 3.0 then
                TriggerServerEvent('e_police:putInVehicle', GetPlayerServerId(closestPlayer))
			else
						RageUI.Popup({message = "~r~Personne autour"})
				end
                end
            end)

            RageUI.ButtonWithStyle("Sortir du véhicule", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if (Selected) then
					local target, distance = ESX.Game.GetClosestPlayer()
					playerheading = GetEntityHeading(GetPlayerPed(-1))
					playerlocation = GetEntityForwardVector(PlayerPedId())
					playerCoords = GetEntityCoords(GetPlayerPed(-1))
					local target_id = GetPlayerServerId(target)
					if closestPlayer ~= -1 and closestDistance <= 3.0 then
                TriggerServerEvent('e_police:OutVehicle', GetPlayerServerId(closestPlayer))
			else
						RageUI.Popup({message = "~r~Personne autour"})
				end
            end
        end)

    end, function()
	end)

	RageUI.IsVisible(RMenu:Get("police",'fouiller'),true,true,true,function() -- Le menu de fouille (inspiré du pz_core / Modifié)
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

		RageUI.Separator("↓ ~g~Argent Sale ~s~↓")
		for k,v  in pairs(ArgentSale) do
			RageUI.ButtonWithStyle("Argent sale :", nil, {RightLabel = "~g~"..v.label.."$"}, true, function(_, _, s)
				if s then
					local combien = KeyboardInput("Combien ?", '' , '', 8)
					if tonumber(combien) > v.amount then
						RageUI.Popup({message = "~r~Quantité invalide"})
					else
						TriggerServerEvent('jejey:confiscatePlayerItem', GetPlayerServerId(closestPlayer), v.itemType, v.value, tonumber(combien))
					end
					RageUI.GoBack()
				end
			end)
		end

		RageUI.Separator("↓ ~g~Objets ~s~↓")
		for k,v  in pairs(Items) do
			RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "~g~x"..v.right}, true, function(_, _, s)
				if s then
					local combien = KeyboardInput("Combien ?", '' , '', 8)
					if tonumber(combien) > v.amount then
						RageUI.Popup({message = "~r~Quantité invalide"})
					else
						TriggerServerEvent('jejey:confiscatePlayerItem', GetPlayerServerId(closestPlayer), v.itemType, v.value, tonumber(combien))
					end
					RageUI.GoBack()
				end
			end)
		end
			RageUI.Separator("↓ ~g~Armes ~s~↓")

			for k,v  in pairs(Armes) do
				RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "avec ~g~"..v.right.. " ~s~balle(s)"}, true, function(_, _, s)
					if s then
						local combien = KeyboardInput("Combien ?", '' , '', 8)
						if tonumber(combien) > v.amount then
							RageUI.Popup({message = "~r~Quantité invalide"})
						else
							TriggerServerEvent('jejey:confiscatePlayerItem', GetPlayerServerId(closestPlayer), v.itemType, v.value, tonumber(combien))
						end
						RageUI.GoBack()
					end
				end)
			end

		end, function() 
		end)

	RageUI.IsVisible(RMenu:Get('police', 'info'), true, true, true, function()

		RageUI.ButtonWithStyle("Attente de dispatch",nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
			if Selected then
				local info = 'dispatch'
				TriggerServerEvent('police:PriseEtFinservice', info)
			end
		end)

		RageUI.ButtonWithStyle("Control en cours",nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
			if Selected then
				local info = 'control'
				TriggerServerEvent('police:PriseEtFinservice', info)
			end
		end)

		RageUI.ButtonWithStyle("Refus d'obtempérer",nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
			if Selected then
				local info = 'refus'
				TriggerServerEvent('police:PriseEtFinservice', info)
			end
		end)
		
		RageUI.ButtonWithStyle("Délit de fuite",nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
			if Selected then
				local info = 'delit'
				TriggerServerEvent('police:PriseEtFinservice', info)
			end
		end)

		RageUI.ButtonWithStyle("Poursuite en cours",nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
			if Selected then
				local info = 'poursuite'
				TriggerServerEvent('police:PriseEtFinservice', info)
			end
		end)

    end, function()
	end)

	RageUI.IsVisible(RMenu:Get('police', 'renfort'), true, true, true, function()

		RageUI.ButtonWithStyle("Votre Position",nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
			if Selected then
				local raison = 'petit'
				local elements  = {}
				local playerPed = PlayerPedId()
				local coords  = GetEntityCoords(playerPed)
				local name = GetPlayerName(PlayerId())
			TriggerServerEvent('renfort', coords, raison)
		end
	end)

end)


	RageUI.IsVisible(RMenu:Get('police', 'voiture'), true, true, true, function()
		local coords  = GetEntityCoords(PlayerPedId())
		local vehicle = ESX.Game.GetVehicleInDirection()

		RageUI.ButtonWithStyle("Rechercher une plaque",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
			if Selected then 
				LookupVehicle()
				RageUI.CloseAll()
			end
			end)

			RageUI.ButtonWithStyle("Mettre en fourrière", nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
				if Selected then

					TaskStartScenarioInPlace(PlayerPedId(), 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)  

					currentTask.busy = true
					currentTask.task = ESX.SetTimeout(10000, function()
						ClearPedTasks(playerPed)
						ESX.Game.DeleteVehicle(vehicle)
						RageUI.Popup({message = "~o~Mise en fourrière effectuée"})
						currentTask.busy = false
						Citizen.Wait(100) --sleep the entire script to let stuff sink back to reality
					    
					end)

					-- keep track of that vehicle!
					Citizen.CreateThread(function()
						while currentTask.busy do
							Citizen.Wait(1000)

							vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, 0, 71)
							if not DoesEntityExist(vehicle) and currentTask.busy then
								RageUI.Popup({message = "~r~Le véhicule a bougé!"})
								ESX.ClearTimeout(currentTask.task)
								ClearPedTasks(playerPed)
								currentTask.busy = false
								break
							end
						end
					end)
				end
			end)
	
	end, function()
	end)

	Citizen.Wait(0)
	end
end)

function OpenBillingMenu()

	ESX.UI.Menu.Open(
	  'dialog', GetCurrentResourceName(), 'billing',
	  {
		title = "Amende"
	  },
	  function(data, menu)
	  
		local amount = tonumber(data.value)
		local player, distance = ESX.Game.GetClosestPlayer()
  
		if player ~= -1 and distance <= 3.0 then
  
		  menu.close()
		  if amount == nil then
			  ESX.ShowNotification("~r~Problèmes~s~: Montant invalide")
		  else
			local playerPed        = GetPlayerPed(-1)
			TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, true)
			Citizen.Wait(5000)
			  TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_police', ('police'), amount)
			  Citizen.Wait(100)
			  ESX.ShowNotification("~r~Vous avez bien envoyer la facture")
		  end
  
		else
		  ESX.ShowNotification("~r~Problèmes~s~: Aucun joueur à proximitée")
		end
  
	  end,
	  function(data, menu)
		  menu.close()
	  end
	)
  end

  RegisterNetEvent('policedog:hasDrugs')
  AddEventHandler('policedog:hasDrugs', function(hadIt)
	  if hadIt then
		  ESX.ShowNotification(Strings['drugs_found'])
		  loadDict('missfra0_chop_find')
		  TaskPlayAnim(policeDog, 'missfra0_chop_find', 'chop_bark_at_ballas', 8.0, -8, -1, 0, 0, false, false, false)
	  else
		  ESX.ShowNotification(Strings['no_drugs'])
	  end
  end)

local function LoadAnimDict(dictname)
	if not HasAnimDictLoaded(dictname) then
		RequestAnimDict(dictname) 
		while not HasAnimDictLoaded(dictname) do 
			Citizen.Wait(1)
		end
	end
end

loadDict = function(dict)
    while not HasAnimDictLoaded(dict) do Wait(0) RequestAnimDict(dict) end
end

function OpenVehicleInfosMenu(vehicleData)
	ESX.TriggerServerCallback('e_police:getVehicleInfos', function(retrivedInfo)
		local elements = {{label = _U('plate', retrivedInfo.plate)}}

		if retrivedInfo.owner == nil then
			table.insert(elements, {label = _U('owner_unknown')})
		else
			table.insert(elements, {label = _U('owner', retrivedInfo.owner)})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_infos', {
			css      = 'police',
			title    = _U('vehicle_info'),
			align    = 'top-left',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)
	end, vehicleData.plate)
end

function RangerVehicleInfosMenu(vehicleData)
	ESX.TriggerServerCallback('e_police:getVehicleInfos', function(retrivedInfo)
		local elements = {{label = _U('plate', retrivedInfo.plate)}}

		if retrivedInfo.owner == nil then
			table.insert(elements, {label = _U('owner_unknown')})
		else
			table.insert(elements, {label = _U('owner', retrivedInfo.owner)})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_infos', {
			css      = 'police',
			title    = _U('vehicle_info'),
			align    = 'top-left',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)
	end, vehicleData.plate)
end

function LookupVehicle()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'lookup_vehicle', {
		title = _U('search_database_title'),
	}, function(data, menu)
		local length = string.len(data.value)
		if not data.value or length < 2 or length > 8 then
			ESX.ShowNotification(_U('search_database_error_invalid'))
		else
			ESX.TriggerServerCallback('e_police:getVehicleInfos', function(retrivedInfo)
				local elements = {{label = _U('plate', retrivedInfo.plate)}}
				menu.close()

				if not retrivedInfo.owner then
					table.insert(elements, {label = _U('owner_unknown')})
				else
					table.insert(elements, {label = _U('owner', retrivedInfo.owner)})
				end

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_infos', {
					title    = _U('vehicle_info'),
					align    = 'top-left',
					elements = elements
				}, nil, function(data2, menu2)
					menu2.close()
				end)
			end, data.value)

		end
	end, function(data, menu)
		menu.close()
	end)
end

RegisterNetEvent('renfort:setBlip')
AddEventHandler('renfort:setBlip', function(coords, raison, nom)
	if raison == 'petit' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 1)
		ESX.ShowAdvancedNotification('~y~Contact L.S.P.D', '~y~Position de lagent', 'Agent: ~g~'..nom..'\nCode: ~g~10-20', 'CHAR_CHAT_CALL')
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
		color = 12
	end
	local blipId = AddBlipForCoord(coords)
	SetBlipSprite(blipId, 161)
	SetBlipScale(blipId, 1.2)
	SetBlipColour(blipId, color)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Position de lagent')
	EndTextCommandSetBlipName(blipId)
	Wait(20 * 1000)
	RemoveBlip(blipId)
end)

RegisterNetEvent('police:InfoService')
AddEventHandler('police:InfoService', function(service, nom)
	if service == 'dispatch' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('~y~Contact L.S.P.D', '~y~Attente de dispatch', 'Agent: ~g~'..nom..'\n~w~Code: ~g~10-12\n~w~Information: ~g~En attente de dispatch.', 'CHAR_CHAT_CALL')
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
	elseif service == 'control' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('~y~Contact L.S.P.D', '~y~Control routier', 'Agent: ~g~'..nom..'\n~w~Code: ~g~10-48\n~w~Information: ~g~Control routier en cours.', 'CHAR_CHAT_CALL')
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
	elseif service == 'refus' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('~y~Contact L.S.P.D', '~y~Refus d\'obtemperer', 'Agent: ~g~'..nom..'\n~w~Code: ~g~10-30\n~w~Information: ~g~Refus d\'obtemperer.', 'CHAR_CHAT_CALL')
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
	elseif service == 'delit' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('~y~Contact L.S.P.D', '~y~Délit de fuite', 'Agent: ~g~'..nom..'\n~w~Code: ~g~10-30\n~w~Information: ~g~Délit de fuite.', 'CHAR_CHAT_CALL')
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
	elseif service == 'poursuite' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('~y~Contact L.S.P.D', '~y~Poursuite en cours', 'Agent: ~g~'..nom..'\n~w~Code: ~g~10-31\n~w~Information: ~g~Poursuite en cours.', 'CHAR_CHAT_CALL')
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
	end
end)

RegisterNetEvent('e_police:handcuff')
AddEventHandler('e_police:handcuff', function()
  IsHandcuffed    = not IsHandcuffed;
  local playerPed = GetPlayerPed(-1)
  Citizen.CreateThread(function()
    if IsHandcuffed then
        RequestAnimDict('mp_arresting')
        while not HasAnimDictLoaded('mp_arresting') do
            Citizen.Wait(100)
        end
      TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
      DisableControlAction(2, 37, true)
      SetEnableHandcuffs(playerPed, true)
      SetPedCanPlayGestureAnims(playerPed, false)
      FreezeEntityPosition(playerPed,  true)
      DisableControlAction(0, 24, true) -- Attack
      DisableControlAction(0, 257, true) -- Attack 2
      DisableControlAction(0, 25, true) -- Aim
      DisableControlAction(0, 263, true) -- Melee Attack 1
      DisableControlAction(0, 37, true) -- Select Weapon
      DisableControlAction(0, 47, true)  -- Disable weapon
      DisplayRadar(false)
    else
      ClearPedSecondaryTask(playerPed)
      SetEnableHandcuffs(playerPed, false)
      SetPedCanPlayGestureAnims(playerPed,  true)
      FreezeEntityPosition(playerPed, false)
	  DisplayRadar(true)
    end
  end)
end)

RegisterNetEvent('e_police:drag')
AddEventHandler('e_police:drag', function(cop)
  IsDragged = not IsDragged
  CopPed = tonumber(cop)
end)

Citizen.CreateThread(function()
  while true do
    Wait(0)
    if IsHandcuffed then
      if IsDragged then
        local ped = GetPlayerPed(GetPlayerFromServerId(CopPed))
        local myped = GetPlayerPed(-1)
        AttachEntityToEntity(myped, ped, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
      else
        DetachEntity(GetPlayerPed(-1), true, false)
      end
    end
  end
end)

RegisterNetEvent('e_police:putInVehicle')
AddEventHandler('e_police:putInVehicle', function()
  local playerPed = GetPlayerPed(-1)
  local coords    = GetEntityCoords(playerPed)
  if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
    local vehicle = GetClosestVehicle(coords.x,  coords.y,  coords.z,  5.0,  0,  71)
    if DoesEntityExist(vehicle) then
      local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
      local freeSeat = nil
      for i=maxSeats - 1, 0, -1 do
        if IsVehicleSeatFree(vehicle,  i) then
          freeSeat = i
          break
        end
      end
      if freeSeat ~= nil then
        TaskWarpPedIntoVehicle(playerPed,  vehicle,  freeSeat)
      end
    end
  end
end)

RegisterNetEvent('e_police:OutVehicle')
AddEventHandler('e_police:OutVehicle', function(t)
  local ped = GetPlayerPed(t)
  ClearPedTasksImmediately(ped)
  plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
  local xnew = plyPos.x+2
  local ynew = plyPos.y+2

  SetEntityCoords(GetPlayerPed(-1), xnew, ynew, plyPos.z)
end)
-- Handcuff
Citizen.CreateThread(function()
  while true do
    Wait(0)
    if IsHandcuffed then
      DisableControlAction(0, 142, true) -- MeleeAttackAlternate
      DisableControlAction(0, 30,  true) -- MoveLeftRight
      DisableControlAction(0, 31,  true) -- MoveUpDown
    end
  end
end)

    Citizen.CreateThread(function()
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(100)
        end
    end)

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then 
            if IsControlJustReleased(0 ,167) then
                RageUI.Visible(RMenu:Get('police', 'main'), not RageUI.Visible(RMenu:Get('police', 'main')))
            end
        end
    end
end)

scanId = 0
cityRobbery = false
local myspawns = {}









