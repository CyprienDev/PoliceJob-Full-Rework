Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then 
            DrawMarker(25, Config.pos.vestiaire.position.x, Config.pos.vestiaire.position.y, Config.pos.vestiaire.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.8, 0.8, 0.8, 0, 23, 167, 255, 0, 1, 2, 0, nil, nil, 0)
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Config.pos.vestiaire.position.x, Config.pos.vestiaire.position.y, Config.pos.vestiaire.position.z)
        
            if dist <= 1.0 then
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au vestiaire")
                if IsControlJustPressed(1,51) then
                    OpenVestiaire()
                end
        end
    end
    end
end)


local police_vestiaire = false

RMenu.Add('police_vestiaire', 'main', RageUI.CreateMenu("Vestiaires du LSPD", "", 10,80))
RMenu:Get("police_vestiaire", "main"):SetRectangleBanner(0, 1, 0, 300)
RMenu:Get('police_vestiaire', 'main'):SetSubtitle("Vestiaires")

RMenu:Get('police_vestiaire', 'main').EnableMouse = false
RMenu:Get('police_vestiaire', 'main').Closed = function()
	police_vestiaire = false
end


function OpenVestiaire()
	if not police_vestiaire then
		police_vestiaire = true
		RageUI.CloseAll()
		RageUI.Visible(RMenu:Get('police_vestiaire', 'main'), true)
	Citizen.CreateThread(function()
		while police_vestiaire do
			Citizen.Wait(1)
				local pCo = GetEntityCoords(PlayerPedId())
				RageUI.IsVisible(RMenu:Get('police_vestiaire', 'main'), true, true, true, function()

					RageUI.Separator("~b~"..GetPlayerName(PlayerId()).. "~w~ - ~b~" ..ESX.PlayerData.job.grade_label.. "")

						for index,infos in pairs(police.clothes.specials) do
							RageUI.ButtonWithStyle(infos.label,nil, {RightBadge = RageUI.BadgeStyle.Clothes}, ESX.PlayerData.job.grade >= infos.minimum_grade, function(_,_,s)
								if s then
									ApplySkin(infos)
								end
							end)
						end

                        RageUI.Separator("~b~↓ Gestion du Gilet par balle ↓")

						for index,infos in pairs(police.clothes.grades) do
							RageUI.ButtonWithStyle(infos.label,nil, {RightBadge = RageUI.BadgeStyle.Clothes}, ESX.PlayerData.job.grade >= infos.minimum_grade, function(_,_,s)
							if s then
								ApplySkin(infos)
								SetPedArmour(PlayerPedId(), 100)
							end
						end)
					end
				end)
			end
		end)
	end
end

function ApplySkin(infos)
	TriggerEvent('skinchanger:getSkin', function(skin)
		local uniformObject

		if skin.sex == 0 then
			uniformObject = infos.variations.male
		else
			uniformObject = infos.variations..female
		end

		if uniformObject then
			TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
		end

		infos.onEquip()
	end)
end
