RMenu.Add('mirage', 'cam', RageUI.CreateMenu("Caméra du LSPD", "Caméra"))
RMenu:Get("mirage", "cam"):SetRectangleBanner(0, 1, 0, 300)
RMenu:Get('mirage', 'cam').Closable = false
Citizen.CreateThread(function()
    while true do

        RageUI.IsVisible(RMenu:Get('mirage', 'cam'), true, true, true, function() 


			RageUI.ButtonWithStyle("~r~Déconnexion des caméras", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
                if Selected then
					TriggerEvent('cctv:camera')
	        	end
				if Selected then
					RageUI.CloseAll()
	        	end
         	end)
	

	        RageUI.ButtonWithStyle("Caméra 1", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
		        if Selected then   
			        TriggerEvent('cctv:camera', 25) 
		        end
	        end)

	        RageUI.ButtonWithStyle("Caméra 2", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
		        if Selected then   
			        TriggerEvent('cctv:camera', 26) 
		        end
	        end)

	        RageUI.ButtonWithStyle("Caméra 3", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
		        if Selected then   
			        TriggerEvent('cctv:camera', 27) 
		        end
	        end)

	        RageUI.ButtonWithStyle("Caméra 4", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
		        if Selected then   
			        TriggerEvent('cctv:camera', 1) 
		        end
	        end)


	        RageUI.ButtonWithStyle("Caméra 5", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
		        if Selected then   
			        TriggerEvent('cctv:camera', 2) 
		        end
	        end)

	        RageUI.ButtonWithStyle("Caméra 6", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
		        if Selected then   
			        TriggerEvent('cctv:camera', 3) 
		        end
	        end)

	        RageUI.ButtonWithStyle("Caméra 7", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
		        if Selected then   
			        TriggerEvent('cctv:camera', 4) 
		        end
	        end)

	        RageUI.ButtonWithStyle("Caméra 8", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
		        if Selected then   
			        TriggerEvent('cctv:camera', 5) 
		        end
	        end)

	        RageUI.ButtonWithStyle("Caméra 9", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
		        if Selected then   
			        TriggerEvent('cctv:camera', 6) 
		        end
	        end)

	        RageUI.ButtonWithStyle("Caméra 10", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
		        if Selected then   
			        TriggerEvent('cctv:camera', 7) 
		        end
	        end)

	        RageUI.ButtonWithStyle("Caméra 11", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
		        if Selected then   
			        TriggerEvent('cctv:camera', 8) 
		        end
	        end)

	        RageUI.ButtonWithStyle("Caméra 12", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
		        if Selected then   
			        TriggerEvent('cctv:camera', 9) 
		        end
	        end)

	        RageUI.ButtonWithStyle("Caméra 13", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
		        if Selected then   
			        TriggerEvent('cctv:camera', 10) 
		        end
	        end)

	        RageUI.ButtonWithStyle("Caméra 14", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
		        if Selected then   
			        TriggerEvent('cctv:camera', 11) 
		        end
	        end)

	        RageUI.ButtonWithStyle("Caméra 15", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
		        if Selected then   
			        TriggerEvent('cctv:camera', 12) 
		        end
	        end)

	        RageUI.ButtonWithStyle("Caméra 16", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
		        if Selected then   
			        TriggerEvent('cctv:camera', 13) 
		        end
	        end)

	        RageUI.ButtonWithStyle("Caméra 17", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
		        if Selected then   
			        TriggerEvent('cctv:camera', 14) 
	        	end
        	end)

         	RageUI.ButtonWithStyle("Caméra 18", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
	        	if Selected then   
	        		TriggerEvent('cctv:camera', 15) 
	        	end
        	end)

        	RageUI.ButtonWithStyle("Caméra 19", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
        		if Selected then   
	        		TriggerEvent('cctv:camera', 16) 
	        	end
        	end)

        	RageUI.ButtonWithStyle("Caméra 20", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
        		if Selected then   
	        		TriggerEvent('cctv:camera', 17) 
	        	end
         	end)

        	RageUI.ButtonWithStyle("Caméra 21", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
	        	if Selected then   
  	        		TriggerEvent('cctv:camera', 18) 
        		end
        	end)

        	RageUI.ButtonWithStyle("Caméra 22", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
        		if Selected then   
        			TriggerEvent('cctv:camera', 19) 
	        	end
        	end)

        	RageUI.ButtonWithStyle("Caméra 23", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
        		if Selected then   
	        		TriggerEvent('cctv:camera', 20) 
	        	end
        	end)

        	RageUI.ButtonWithStyle("Caméra 24", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
         		if Selected then   
	        		TriggerEvent('cctv:camera', 22) 
	        	end
	        end)

         	RageUI.ButtonWithStyle("Caméra 25", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
                if Selected then   
		        	TriggerEvent('cctv:camera', 23) 
	        	end
         	end)

			

        end, function()
        end, 1)
                        Citizen.Wait(0)
                                end
                            end)


-----------------------------------------

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0) 

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Config.pos.cam.position.x, Config.pos.cam.position.y, Config.pos.cam.position.z)
			if ESX.PlayerData.job.grade_name == 'sergeant' or ESX.PlayerData.job.grade_name == 'capitaine' or ESX.PlayerData.job.grade_name == 'lieutenant'  or ESX.PlayerData.job.name == 'police' and ESX.PlayerData.job.grade_name == 'boss' then
            if dist <= 15.0 then
            DrawMarker(25, Config.pos.cam.position.x, Config.pos.cam.position.y, Config.pos.cam.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.8, 0.8, 0.8, 0, 23, 167, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist <= 3.0 then
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au Caméra")
                if IsControlJustPressed(1,51) then
                    RageUI.Visible(RMenu:Get('mirage', 'cam'), not RageUI.Visible(RMenu:Get('mirage', 'cam')))
                end
            end
        end
    end
end)


CCTVCamLocations = {
	[1] =  { ['x'] = 24.18,['y'] = -1347.35,['z'] = 29.5,['h'] = 271.32, ['info'] = ' Store Camera 1', ["recent"] = false },
	[2] =  { ['x'] = -46.56,['y'] = -1757.98,['z'] = 29.43,['h'] = 48.68, ['info'] = ' Store Camera 2', ["recent"] = false },
	[3] =  { ['x'] = -706.02,['y'] = -913.61,['z'] = 19.22,['h'] = 85.61, ['info'] = ' Store Camera 3', ["recent"] = false },
	[4] =  { ['x'] = -1221.97,['y'] = -908.42,['z'] = 12.33,['h'] = 31.1, ['info'] = ' Store Camera 4', ["recent"] = false },
	[5] =  { ['x'] = 1164.99,['y'] = -322.78,['z'] = 69.21,['h'] = 96.91, ['info'] = ' Store Camera 5', ["recent"] = false },
	[6] =  { ['x'] = 372.25,['y'] = 326.43,['z'] = 103.57,['h'] = 252.9, ['info'] = ' Store Camera 6', ["recent"] = false },
	[7] =  { ['x'] = -1819.98,['y'] = 794.57,['z'] = 138.09,['h'] = 126.56, ['info'] = ' Store Camera 7', ["recent"] = false },
	[8] =  { ['x'] = -2966.24,['y'] = 390.94,['z'] = 15.05,['h'] = 84.58, ['info'] = ' Store Camera 8', ["recent"] = false },
	[9] =  { ['x'] = -3038.92,['y'] = 584.21,['z'] = 7.91,['h'] = 19.43, ['info'] = ' Store Camera 9', ["recent"] = false },
	[10] =  { ['x'] = -3242.48,['y'] = 999.79,['z'] = 12.84,['h'] = 351.35, ['info'] = ' Store Camera 10', ["recent"] = false },
	[11] =  { ['x'] = 2557.14,['y'] = 380.64,['z'] = 108.63,['h'] = 353.01, ['info'] = ' Store Camera 11', ["recent"] = false },
	[12] =  { ['x'] = 1166.02,['y'] = 2711.15,['z'] = 38.16,['h'] = 175.0, ['info'] = ' Store Camera 12', ["recent"] = false },
	[13] =  { ['x'] = 549.32,['y'] = 2671.3,['z'] = 42.16,['h'] = 94.96, ['info'] = ' Store Camera 13', ["recent"] = false },
	[14] =  { ['x'] = 1959.96,['y'] = 3739.99,['z'] = 32.35,['h'] = 296.38, ['info'] = ' Store Camera 14', ["recent"] = false },
	[15] =  { ['x'] = 2677.98,['y'] = 3279.28,['z'] = 55.25,['h'] = 327.81, ['info'] = ' Store Camera 15', ["recent"] = false },
	[16] =  { ['x'] = 1392.88,['y'] = 3606.7,['z'] = 34.99,['h'] = 201.69, ['info'] = ' Store Camera 16', ["recent"] = false },
	[17] =  { ['x'] = 1697.8,['y'] = 4922.69,['z'] = 42.07,['h'] = 322.95, ['info'] = ' Store Camera 17', ["recent"] = false },
	[18] =  { ['x'] = 1728.82,['y'] = 6417.38,['z'] = 35.04,['h'] = 233.94, ['info'] = ' Store Camera 18', ["recent"] = false },
	[19] =  { ['x'] = 733.45,['y'] = 127.58,['z'] = 80.69,['h'] = 285.51, ['info'] = ' Cam Power' },
	[20] =  { ['x'] = 1887.25,['y'] = 2605.35,['z'] = 50.40,['h'] = 111.88, ['info'] = ' Cam Jail Front' },
	[21] =  { ['x'] = 1709.37,['y'] = 2569.90,['z'] = 56.18,['h'] = 50.18, ['info'] = ' Cam Jail Prisoner Drop Off' },
	[22] =  { ['x'] = -644.24,['y'] = -241.11,['z'] = 37.97,['h'] = 282.81, ['info'] = ' Cam Jewelry Store' },
	[23] =  { ['x'] = -115.3,['y'] = 6441.41,['z'] = 31.53,['h'] = 341.95, ['info'] = ' Cam Paleto Bank Outside' },
	[24] =  { ['x'] = 240.07,['y'] = 218.97,['z'] = 106.29,['h'] = 276.14, ['info'] = ' Cam Main Bank 1' },
	[25] =  { ['x'] = 92.17,['y'] = -1923.14,['z'] = 29.5,['h'] = 205.95, ['info'] = ' Ballas', ["recent"] = false },
	[26] =  { ['x'] = -176.26,['y'] = -1681.15,['z'] = 47.43,['h'] = 313.29, ['info'] = ' Famillies', ["recent"] = false },
	[27] =  { ['x'] = 285.95,['y'] = -2003.95,['z'] = 35.0,['h'] = 226.0, ['info'] = ' Vagos', ["recent"] = false },	
}

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
	  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	  Citizen.Wait(0)
	  PlayerData = ESX.GetPlayerData()
	end
end)

inCam = false
cctvCam = 0
RegisterNetEvent("cctv:camera")
AddEventHandler("cctv:camera", function(camNumber)
	camNumber = tonumber(camNumber)
	if inCam then
		inCam = false
		PlaySoundFrontend(-1, "HACKING_SUCCESS", false)
		-- TriggerEvent('animation:tablet',false)
		Wait(250)
		ClearPedTasks(GetPlayerPed(-1))
	else
		if camNumber > 0 and camNumber < #CCTVCamLocations+1 then
			PlaySoundFrontend(-1, "HACKING_SUCCESS", false)
			TriggerEvent("cctv:startcamera",camNumber)
		else
			exports['mythic_notify']:SendAlert('error', "This camera appears to be faulty")
		end
	end
end)

RegisterNetEvent("cctv:startcamera")
AddEventHandler("cctv:startcamera", function(camNumber)

	TriggerEvent('animation:tablet',true)
	local camNumber = tonumber(camNumber)
	local x = CCTVCamLocations[camNumber]["x"]
	local y = CCTVCamLocations[camNumber]["y"]
	local z = CCTVCamLocations[camNumber]["z"]
	local h = CCTVCamLocations[camNumber]["h"]

	print("starting cam")
	inCam = true

	SetTimecycleModifier("heliGunCam")
	SetTimecycleModifierStrength(1.0)
	local scaleform = RequestScaleformMovie("TRAFFIC_CAM")
	while not HasScaleformMovieLoaded(scaleform) do
		Citizen.Wait(0)
	end

	local lPed = GetPlayerPed(-1)
	cctvCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
	SetCamCoord(cctvCam,x,y,z+1.2)						
	SetCamRot(cctvCam, -15.0,0.0,h)
	SetCamFov(cctvCam, 110.0)
	RenderScriptCams(true, false, 0, 1, 0)
	PushScaleformMovieFunction(scaleform, "PLAY_CAM_MOVIE")
	SetFocusArea(x, y, z, 0.0, 0.0, 0.0)
	PopScaleformMovieFunctionVoid()

	while inCam do
		SetCamCoord(cctvCam,x,y,z+1.2)						
		-- SetCamRot(cctvCam, -15.0,0.0,h)
		PushScaleformMovieFunction(scaleform, "SET_ALT_FOV_HEADING")
		PushScaleformMovieFunctionParameterFloat(GetEntityCoords(h).z)
		PushScaleformMovieFunctionParameterFloat(1.0)
		PushScaleformMovieFunctionParameterFloat(GetCamRot(cctvCam, 2).z)
		PopScaleformMovieFunctionVoid()
		DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
		Citizen.Wait(1)
	end
	ClearFocus()
	ClearTimecycleModifier()
	RenderScriptCams(false, false, 0, 1, 0)
	SetScaleformMovieAsNoLongerNeeded(scaleform)
	DestroyCam(cctvCam, false)
	SetNightvision(false)
	SetSeethrough(false)	

end)