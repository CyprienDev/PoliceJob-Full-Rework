RMenu.Add('lspd', 'main', RageUI.CreateMenu("Armurerie", " "))
RMenu:Get("lspd", "main"):SetRectangleBanner(0, 1, 0, 300)


Citizen.CreateThread(function ()
    while true do
        RageUI.IsVisible(RMenu:Get('lspd', 'main'), true, true, true, function()   

            RageUI.ButtonWithStyle("Equipement de base", nil, { },true, function(Hovered, Active, Selected)
                if (Selected) then   
                    TriggerServerEvent('equipementbase')
                end
            end)

            RageUI.ButtonWithStyle("Munitions M4, SMG, Pistolet", nil, { },true, function(Hovered, Active, Selected)
                if (Selected) then   
                    TriggerServerEvent('mun')
                end
            end)


            if ESX.PlayerData.job.grade_name == 'officer' then
                for k,v in pairs(Config.armurerie) do
                RageUI.ButtonWithStyle(v.nom, nil, { },true, function(Hovered, Active, Selected)
                    if (Selected) then   
                        TriggerServerEvent('armurerie', v.arme, v.prix)
                    end
                end)
            end
        end

            if ESX.PlayerData.job.grade_name == 'sergeant' then
                for k,v in pairs(Config.arm) do
                RageUI.ButtonWithStyle(v.nom, nil, { },true, function(Hovered, Active, Selected)
                    if (Selected) then   
                        TriggerServerEvent('armurerie', v.arme, v.prix)
                    end
                end)
            end
        end

            if ESX.PlayerData.job.grade_name == 'lieutenant' then
                for k,v in pairs(Config.arm) do
                RageUI.ButtonWithStyle(v.nom, nil, { },true, function(Hovered, Active, Selected)
                    if (Selected) then   
                        TriggerServerEvent('armurerie', v.arme, v.prix)
                    end
                end)
            end
        end

		    if ESX.PlayerData.job.grade_name == 'capitaine' then
			    for k,v in pairs(Config.arm) do
			    RageUI.ButtonWithStyle(v.nom, nil, { },true, function(Hovered, Active, Selected)
				    if (Selected) then   
					    TriggerServerEvent('armurerie', v.arme, v.prix)
				    end
			    end)
		    end
	    end


            if ESX.PlayerData.job.name == 'police' and ESX.PlayerData.job.grade_name == 'boss' then
                for k,v in pairs(Config.armi) do
                RageUI.ButtonWithStyle(v.nom, nil, { },true, function(Hovered, Active, Selected)
                    if (Selected) then   
                        TriggerServerEvent('armurerie', v.arme, v.prix)
                    end
                end)
            end
        end

		RageUI.ButtonWithStyle("Deposer vos Armes", nil, { },true, function(Hovered, Active, Selected)
			if (Selected) then   
				TriggerServerEvent('deposer')
			end
		end)

        end, function()
        end)
    Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
                local plyCoords2 = GetEntityCoords(GetPlayerPed(-1), false)
                local dist2 = Vdist(plyCoords2.x, plyCoords2.y, plyCoords2.z, Config.pos.armurerie.position.x, Config.pos.armurerie.position.y, Config.pos.armurerie.position.z)
				if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then 
                if dist2 <= 15.0 then
                    DrawMarker(25, Config.pos.armurerie.position.x, Config.pos.armurerie.position.y, Config.pos.armurerie.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.8, 0.8, 0.8, 0, 23, 167, 255, 0, 1, 2, 0, nil, nil, 0)
                    end
		    if dist2 <= 1.0 then	
                    ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour demander vos armes a Bob")
                    if IsControlJustPressed(1,51) then
                        RageUI.Visible(RMenu:Get('lspd', 'main'), not RageUI.Visible(RMenu:Get('lspd', 'main')))
                    end   
                end
            end 
        end
end)


Citizen.CreateThread(function()
    local hash = GetHashKey("s_m_y_cop_01")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVMALE", "s_m_y_cop_01",484.61,-1003.66,24.73, 4.01, false, true) 
    SetBlockingOfNonTemporaryEvents(ped, true) 
    FreezeEntityPosition(ped, true) 
    SetEntityInvincible(ped, true) 
end)
