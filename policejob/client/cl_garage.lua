------------------------------------------

function SetVehicleMaxMods(vehicle)
    local props = {
      modEngine       = 2,
      modBrakes       = 2,
      modTransmission = 2,
      modSuspension   = 3,
      modTurbo        = true,
    }
    ESX.Game.SetVehicleProperties(vehicle, props)
end

local police_garage = false

RMenu.Add('police_garage', 'main', RageUI.CreateMenu("Garage du LSPD", ""))
RMenu:Get("police_garage", "main"):SetRectangleBanner(0, 1, 0, 300)
RMenu:Get('police_garage', 'main'):SetSubtitle("Véhicules")

RMenu:Get('police_garage', 'main').EnableMouse = false
RMenu:Get('police_garage', 'main').Closed = function()
	police_garage = false
end


function openVeh()
	if not police_garage then
		police_garage = true
		RageUI.Visible(RMenu:Get('police_garage', 'main'), true)
	Citizen.CreateThread(function()
		while police_garage do
			Citizen.Wait(1)
					RageUI.IsVisible(RMenu:Get('police_garage', 'main'), true, true, true, function()
						local pCo = GetEntityCoords(PlayerPedId())
	
						for index,infos in pairs(police.vehicles.car) do
							if infos.category ~= nil then 
								RageUI.Separator(infos.category)
							else 
								RageUI.ButtonWithStyle(infos.label,nil, {RightBadge = RageUI.BadgeStyle.Car}, ESX.PlayerData.job.grade >= infos.minimum_grade, function(_,_,s)
									if s then
										Citizen.CreateThread(function()
											local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                                            if dist4 < 3 then
                                                DeleteEntity(veh)
                                            end   
											local model = GetHashKey(infos.model)
											RequestModel(model)
											while not HasModelLoaded(model) do Citizen.Wait(1) end
											local vehicle = CreateVehicle(model, Config.spawn.voiture.position.x, Config.spawn.voiture.position.y, Config.spawn.voiture.position.z, Config.spawn.voiture.position.h, true, false)
											SetModelAsNoLongerNeeded(model)
                                            SetPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
                                            TriggerServerEvent('ddx_vehiclelock:givekey', 'no', GetVehicleNumberPlateText(vehicle))
                                            SetVehicleMaxMods(vehicle)
											police_garage = false
											RageUI.CloseAll()
										end)
	
									end
								end)
							end
						end

						
					end, function()    
					end, 1)
			end
		end)
	end
end

function rangerVeh()
	if not police_garage then
		police_garage = true
		RageUI.Visible(RMenu:Get('police_garage', 'main'), true)
	Citizen.CreateThread(function()
		while police_garage do
			Citizen.Wait(1)
					RageUI.IsVisible(RMenu:Get('police_garage', 'main'), true, true, true, function()
						local pCo = GetEntityCoords(PlayerPedId())
	
						

						RageUI.ButtonWithStyle("Ranger le véhicule", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
							if (Selected) then   
							local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
							if dist4 < 5 then
								DeleteEntity(veh)
                                TriggerServerEvent('ddx_vehiclelock:deletekeyjobs', 'no')
							end 
						end
					end) 
					end, function()    
					end, 1)
			end
		end)
	end
end

Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
    

    
                local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
                local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Config.pos.garagevoiture.position.x, Config.pos.garagevoiture.position.y, Config.pos.garagevoiture.position.z)
				if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'police' then
                if dist3 <= 15.0 then
                DrawMarker(25, Config.pos.garagevoiture.position.x, Config.pos.garagevoiture.position.y, Config.pos.garagevoiture.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.8, 0.8, 0.8, 0, 23, 167, 255, 0, 1, 2, 0, nil, nil, 0)
                end
            if dist3 <= 3.0 then    
                    ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder au garage")
                    if IsControlJustPressed(1,51) then           
                        openVeh()
                    end   
                end
               end 
        end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)



			local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
			local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Config.pos.rangervoiture.position.x, Config.pos.rangervoiture.position.y, Config.pos.rangervoiture.position.z)
		if dist3 <= 3.0 then
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'police' then    
				ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour ranger le véhicule")
				if IsControlJustPressed(1,51) then           
					rangerVeh()
				end   
			end
		   end 
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)



			local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
			local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Config.pos.rangervoiture1.position.x, Config.pos.rangervoiture1.position.y, Config.pos.rangervoiture1.position.z)
		if dist3 <= 3.0 then
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'police' then    
				ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour ranger le véhicule")
				if IsControlJustPressed(1,51) then           
					rangerVeh()
				end   
			end
		   end 
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)



			local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
			local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Config.pos.rangervoiture2.position.x, Config.pos.rangervoiture2.position.y, Config.pos.rangervoiture2.position.z)
		if dist3 <= 3.0 then
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'police' then    
				ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour ranger le véhicule")
				if IsControlJustPressed(1,51) then           
					rangerVeh()
				end   
			end
		   end 
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)



			local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
			local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Config.pos.rangervoiture3.position.x, Config.pos.rangervoiture3.position.y, Config.pos.rangervoiture3.position.z)
		if dist3 <= 3.0 then
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'police' then    
				ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour ranger le véhicule")
				if IsControlJustPressed(1,51) then           
					rangerVeh()
				end   
			end
		   end 
	end
end)
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)



			local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
			local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Config.pos.rangervoiture4.position.x, Config.pos.rangervoiture4.position.y, Config.pos.rangervoiture4.position.z)
		if dist3 <= 3.0 then
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'police' then    
				ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour ranger le véhicule")
				if IsControlJustPressed(1,51) then           
					rangerVeh()
				end   
			end
		   end 
	end
end)


RMenu.Add('garageheli', 'main', RageUI.CreateMenu("Garage", "Garage du LSPD"))
RMenu:Get("garageheli", "main"):SetRectangleBanner(0, 1, 0, 300)

  Citizen.CreateThread(function()
      while true do
          RageUI.IsVisible(RMenu:Get('garageheli', 'main'), true, true, true, function() 
  
              RageUI.ButtonWithStyle("Ranger au garage", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
              if (Selected) then   
              local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
              if dist4 < 4 then
                  DeleteEntity(veh)
                  RageUI.CloseAll()
              end 
          end
      end) 
  
              RageUI.ButtonWithStyle("Hélicoptère", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
              if (Selected) then
              Citizen.Wait(1)  
              spawnuniCarre("polmav")
              RageUI.CloseAll()
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
      
  
      
                  local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
                  local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Config.pos.garageheli.position.x, Config.pos.garageheli.position.y, Config.pos.garageheli.position.z)
                  if dist3 <= 15.0 then
                    DrawMarker(25, Config.pos.garageheli.position.x, Config.pos.garageheli.position.y, Config.pos.garageheli.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.8, 0.8, 0.8, 0, 23, 167, 255, 0, 1, 2, 0, nil, nil, 0)
                    end
              if dist3 <= 3.0 then
              if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'police' then    
                      ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder au garage")
                      if IsControlJustPressed(1,51) then           
                          RageUI.Visible(RMenu:Get('garageheli', 'main'), not RageUI.Visible(RMenu:Get('garageheli', 'main')))
                      end   
                  end
                 end 
          end
  end)
  
  function spawnuniCarre(car)
      local car = GetHashKey(car)
      RequestModel(car)
      while not HasModelLoaded(car) do
          RequestModel(car)
          Citizen.Wait(0)
      end
      local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
      local vehicle = CreateVehicle(car, Config.spawn.spawnheli.position.x, Config.spawn.spawnheli.position.y, Config.spawn.spawnheli.position.z, Config.spawn.spawnheli.position.h, true, false)
      SetEntityAsMissionEntity(vehicle, true, true)
      local plaque = "police"..math.random(1,9)
      SetVehicleNumberPlateText(vehicle, plaque) 
      SetPedIntoVehicle(GetPlayerPed(-1),vehicle,-1)
      SetVehicleMaxMods(vehicle)
end