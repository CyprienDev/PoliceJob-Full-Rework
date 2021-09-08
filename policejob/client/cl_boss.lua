ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}
local societypolicemoney = nil

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
	PlayerData.job = job  
	Citizen.Wait(5000) 
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)
---------------- FONCTIONS ------------------
RMenu.Add('boss', 'main', RageUI.CreateMenu("Actions LSPD", "LSPD"))
RMenu:Get("boss", "main"):SetRectangleBanner(0, 1, 0, 300)

  

Citizen.CreateThread(function ()
    while true do
        RageUI.IsVisible(RMenu:Get('boss', 'main'), true, true, true, function()   

            RageUI.ButtonWithStyle("Retirer argent de société",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                if Selected then
                    local amount = KeyboardInput("Montant", "", 10)
                    amount = tonumber(amount)
                    if amount == nil then
                        RageUI.Popup({message = "Montant invalide"})
                    else
                        TriggerServerEvent('esx_society:withdrawMoney', 'police', amount)
                        RefreshpoliceMoney()
                    end
                end
            end)
            
            RageUI.ButtonWithStyle("Déposer argent de société",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                if Selected then
                    local amount = KeyboardInput("Montant", "", 10)
                    amount = tonumber(amount)
                    if amount == nil then
                        RageUI.Popup({message = "Montant invalide"})
                    else
                        TriggerServerEvent('esx_society:depositMoney', 'police', amount)
                        RefreshpoliceMoney()
                    end
                end
            end)


            
    

        end, function()
        end)
    Citizen.Wait(0)
    end
end)

---------------------------------------------

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(0)
    
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' and ESX.PlayerData.job.grade_name == 'boss' then
		    local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Config.pos.boss.position.x, Config.pos.boss.position.y, Config.pos.boss.position.z)
            if dist <= 15.0 then
            DrawMarker(25, Config.pos.boss.position.x, Config.pos.boss.position.y, Config.pos.boss.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.8, 0.8, 0.8, 0, 23, 167, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist <= 1.0 then
			    ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au Actions Patron")
			    if IsControlJustPressed(1,51) then          
                    RefreshpoliceMoney()
                    RageUI.Visible(RMenu:Get('boss', 'main'), not RageUI.Visible(RMenu:Get('boss', 'main')))
                end   
            end
        end 
        
    end
end)

function RefreshpoliceMoney()
    if ESX.PlayerData.job == 'police' and ESX.PlayerData.job.grade_name == 'boss' then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            UpdateSocietypoliceMoney(money)
        end, ESX.PlayerData.job.name)
    end
end

function UpdateSocietypoliceMoney(money)
    societypolicemoney = ESX.Math.GroupDigits(money)
end

function aboss()
    TriggerEvent('esx_society:openBossMenu', 'police', function(data, menu)
        menu.close()
    end, {wash = false})
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