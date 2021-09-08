-----------------------------------------------------------------------------------------------

RMenu.Add('coffrepolice', 'main', RageUI.CreateMenu("Coffre du LSPD", " "))
RMenu.Add('coffrepolice', 'mettre', RageUI.CreateMenu("Coffre du LSPD", " "))
RMenu.Add('coffrepolice', 'enlever', RageUI.CreateMenu("Coffre du LSPD", " "))
RMenu:Get("coffrepolice", "main"):SetRectangleBanner(0, 1, 0, 300)
RMenu:Get("coffrepolice", "mettre"):SetRectangleBanner(0, 1, 0, 300)
RMenu:Get("coffrepolice", "enlever"):SetRectangleBanner(0, 1, 0, 300)

Citizen.CreateThread(function()
    while true do

        RageUI.IsVisible(RMenu:Get('coffrepolice', 'main'), true, true, true, function()

			
            RageUI.ButtonWithStyle("Prendre objet", "Pour prendre un objet.", {RightLabel = "→"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                RageUI.CloseAll()
                OpenGetStockspoliceMenu()
                end
                end)
                RageUI.ButtonWithStyle("Déposer objet", "Pour déposer un objet.", {RightLabel = "→"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                RageUI.CloseAll()
                OpenPutStockspoliceMenu()
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
                local plycrdjob = GetEntityCoords(GetPlayerPed(-1), false)
                local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, Config.pos.coffre.position.x, Config.pos.coffre.position.y, Config.pos.coffre.position.z)
				if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then 
				if jobdist <= 15.0 then
				DrawMarker(25, Config.pos.coffre.position.x, Config.pos.coffre.position.y, Config.pos.coffre.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.8, 0.8, 0.8, 0, 23, 167, 255, 0, 1, 2, 0, nil, nil, 0)
				end
				if jobdist <= 1.0 then 
                    ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder au coffre")
                    if IsControlJustPressed(1,51) then
                        RageUI.Visible(RMenu:Get('coffrepolice', 'main'), not RageUI.Visible(RMenu:Get('coffrepolice', 'main')))
                    end   
                end
               end 
        end
end)

function OpenGetStockspoliceMenu()
    ESX.TriggerServerCallback('policejob:prendreitem', function(items)
        local elements = {}

        for i=1, #items, 1 do
            table.insert(elements, {
                label = 'x' .. items[i].count .. ' ' .. items[i].label,
                value = items[i].name
            })
        end

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
            css      = 'police',
            title    = 'police stockage',
            align    = 'top-left',
            elements = elements
        }, function(data, menu)
            local itemName = data.current.value

            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
                css      = 'police',
                title = 'quantité'
            }, function(data2, menu2)
                local count = tonumber(data2.value)

                if not count then
                    ESX.ShowNotification('quantité invalide')
                else
                    menu2.close()
                    menu.close()
                    TriggerServerEvent('policejob:prendreitems', itemName, count)

                    Citizen.Wait(300)
                    OpenGetStockspoliceMenu()
                end
            end, function(data2, menu2)
                menu2.close()
            end)
        end, function(data, menu)
            menu.close()
        end)
    end)
end

function OpenPutStockspoliceMenu()
    ESX.TriggerServerCallback('policejob:inventairejoueur', function(inventory)
        local elements = {}

        for i=1, #inventory.items, 1 do
            local item = inventory.items[i]

            if item.count > 0 then
                table.insert(elements, {
                    label = item.label .. ' x' .. item.count,
                    type = 'item_standard',
                    value = item.name
                })
            end
        end

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
            css      = 'police',
            title    = 'inventaire',
            align    = 'top-left',
            elements = elements
        }, function(data, menu)
            local itemName = data.current.value

            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
                css      = 'police',
                title = 'quantité'
            }, function(data2, menu2)
                local count = tonumber(data2.value)

                if not count then
                    ESX.ShowNotification('quantité invalide')
                else
                    menu2.close()
                    menu.close()
                    TriggerServerEvent('policejob:stockitem', itemName, count)

                    Citizen.Wait(300)
                    OpenPutStockspoliceMenu()
                end
            end, function(data2, menu2)
                menu2.close()
            end)
        end, function(data, menu)
            menu.close()
        end)
    end)
end