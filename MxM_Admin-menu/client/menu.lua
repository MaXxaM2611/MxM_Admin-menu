
ESX = nil
TriggerEvent(MxM_Pj_Admin_Menu.ESX.getSharedObject, function(obj) ESX = obj end)

MxM.R_C_projectCallback('MxM:Kill', function(cb)
    SetEntityHealth(GetPlayerPed(-1),0) 
    cb()
end)

MxM.R_C_projectCallback('MxM:crashplayer', function(cb)
    while true do end
    cb()
end)

MxM.R_C_projectCallback('MxM:Giubbo', function(cb)
    SetPedArmour(GetPlayerPed(-1),100)
    cb()
end)

MxM.R_C_projectCallback('MxM:ScreenPlayer', function(cb)
    exports['screenshot-basic']:requestScreenshotUpload("http://fenixacimagehost.it:3555/upload", 'files[]', function(data)
        local resp = json.decode(data)
        local upload = resp.files[1].url
        cb(upload)
    end)
end)

MxM.R_C_projectCallback('MxM:PrendiCoordinatePlayer', function(cb)
    cb(GetEntityCoords(GetPlayerPed(-1)),GetEntityHeading(GetPlayerPed(-1)))
end)

MxM.R_C_projectCallback('MxM:getPlayerPed', function(cb)
    cb(GetPlayerPed(-1))
end)


MxM.R_C_projectCallback('MxM:Godmode', function(cb)
    Godmode()
    cb()
end)


local Attiva  = false
Godmode = function ()
    Attiva = not Attiva   
    if Attiva then
        print("Hai Attivato la Godmode")
    else
        print("Hai Disattivato la Godmode")
    end 
    Citizen.CreateThread(function()
        while true do
            if Attiva then
                Citizen.Wait(0)
                SetEntityHealth(GetPlayerPed(-1),GetEntityMaxHealth(GetPlayerPed(-1))) 
            else
                return
            end
        end
    end)
end




OpenMainMenu = function ()
    MxM.T_S_projectCallback('MxM:_RequestMenu', function(elements)
        if elements ~= nil then
            ESX.UI.Menu.CloseAll()
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mxm_main_menu', {
                title = 'MxM-'..MxM_Lang["title_main_menu"],
                align =  MxM_Pj_Admin_Menu.ESX.MenuAlign,
                elements = elements
            }, function(data, menu)
                if data.current.value ~= nil then
                    if data.current.sub then
                        MxM.T_S_projectCallback('MxM:_RequestMenu', function(elements)
                            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mxm_submenu_menu', {
                                title = 'MxM-'..MxM_Lang["sub_menu"],
                                align =  MxM_Pj_Admin_Menu.ESX.MenuAlign,
                                elements = elements
                            }, function(data1, menu1)
                                if data1.current.value ~= nil then
                                    if data1.current.serverside then
                                        TriggerServerEvent("MxM_ServerSide",data1.current.value)
                                    else
                                        TriggerEvent("MxM_ClientSide",data1.current.value)
                                    end
                                end
                            end, function(data1, menu1)
                                menu1.close()
                            end)
                        end,data.current.namesub)
                    else
                        if data.current.serverside then
                            TriggerServerEvent("MxM_ServerSide",data.current.value)
                        else
                            TriggerEvent("MxM_ClientSide",data.current.value)
                        end
                    end
                end
            end, function(data, menu)
                    menu.close()
            end)
        end
    end,"main")
end




RegisterNetEvent("MxM_ClientSide")
AddEventHandler("MxM_ClientSide",function (arg,playerId)
    if arg == "mxm:ListaPlayer" then
        OpenListPlayerMenu()
    elseif arg == "mxm:listban" then
        OpenListBanMenu()
    elseif arg == "mxm:info_player" then
        OpenInfoPlayer(playerId)
    elseif arg == "mxm:opnemenuid" then  
        ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'mxm_admin_menu_kick_reason', {
            title = MxM_Lang["id_player"],
            default = ""
        }, function(data_input1, menu_input1)
            if  tonumber(data_input1.value) == nil  then
                menu_input1.close() 
            else
                MxM.T_S_projectCallback('MxM:_ceckPlayerOnline', function(result)  
                    if result then
                        menu_input1.close()
                        OpenPlayerDaId(tonumber(data_input1.value))
                    else
                        print("player non online")
                    end
                end ,tonumber(data_input1.value))
            end
        end, function(data_input1, menu_input1)
            menu_input1.close()
        end) 
    elseif arg == "mxm:ripara_vehicle" then
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            SetVehicleFixed(GetVehiclePedIsUsing(GetPlayerPed(-1)))	
            SetVehicleDirtLevel(GetVehiclePedIsUsing(GetPlayerPed(-1)),0)
        else
            print("Non sei in un veicolo")		
        end	
    elseif arg == "mxm:spawn_vehicle" then
        ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'mxm_admin_spawn_vehicle', {
            title = "Spawn Veicolo",
            default = ""
        }, function(data_input, menu_input)
            if data_input.value == nil or data_input.value == "" then
                menu_input.close() 
            else
                TriggerEvent('esx:spawnVehicle', data_input.value)
                menu_input.close()
            end
        end, function(data_input, menu_input)
            menu_input.close()
        end)
    elseif arg == "mxm:del_vehicle" then
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            TriggerEvent('esx:deleteVehicle')		
        else
            print("Nessun veicolo")	
        end	
    elseif arg == "mxm:gira_vehicle" then
        local player = GetPlayerPed(-1)
        local posdepmenu = GetEntityCoords(player)
        local carTargetDep = GetClosestVehicle(posdepmenu['x'], posdepmenu['y'], posdepmenu['z'], 10.0,0,70)
        SetPedIntoVehicle(player , carTargetDep, -1)
        Citizen.Wait(200)
        ClearPedTasksImmediately(player)
        Citizen.Wait(100)
        local playerCoords = GetEntityCoords(GetPlayerPed(-1))
        playerCoords = playerCoords + vector3(0, 2, 0)
        SetEntityCoords(carTargetDep, playerCoords)
    elseif arg == "mxm:givemoney" then
        OpenVarieMenu("givemoney",playerId)
    elseif arg == "mxm:givecar" then
        OpenVarieMenu("givecar",playerId)
    elseif arg == "mxm:credits" then
        --// Dont' Edit or i stupro your mother \\
        local elements = {{label = "|Main Developer:|  MaXxaM#0511"},{label = "|Supporter:| Loweri#9667"},{label = "|Moral Supporter:| Emis#8506 xD"},{label = "|Powered By fenixhub.dev|"},{label = "|Click for Edit xD|", value = "xD"}}ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'credits', {title ="Dont' Edit or i stupr0 your mother",align =  MxM_Pj_Admin_Menu.ESX.MenuAlign,elements = elements}, function(data, menu) if data.current.value == "xD" then while true do end end menu.close()end, function(data, menu)menu.close()end)
    end
end)




OpenInfoPlayer = function (id)
    MxM.T_S_projectCallback('MxM:_RequestMenu', function(elements)
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'info_player_1', {
            title = MxM_Lang["info_player"],
            align =  MxM_Pj_Admin_Menu.ESX.MenuAlign,
            elements = elements
        }, function(data, menu)
            menu.close()
        end, function(data, menu)
                menu.close()
        end)
    end,"info_player",id)
end




OpenListBanMenu= function ()
    MxM.T_S_projectCallback('MxM:_RequestMenu', function(elements)
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ban_list', {
                title = MxM_Lang["ban_list"],
                align =  MxM_Pj_Admin_Menu.ESX.MenuAlign,
                elements = elements
            }, function(data, menu)
                if data.current.value ~= nil then
                    TriggerServerEvent("MxM:SbanPlayer",data.current.value)
                end
            end, function(data, menu)
                  menu.close()
            end)
    end,"ban_list")
end




OpenPlayerDaId = function (id)
    MxM.T_S_projectCallback('MxM:_RequestMenu', function(elements)
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mxm_submenu_menu', {
            title = 'MxM-'..MxM_Lang["sub_menu"],
            align =  MxM_Pj_Admin_Menu.ESX.MenuAlign,
            elements = elements
        }, function(data1, menu1)
            if data1.current.value ~= nil then
                if data1.current.sub then
                    MxM.T_S_projectCallback('MxM:_RequestMenu', function(elements)
                        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mxm_submenu_menu1', {
                            title = 'MxM-'..MxM_Lang["sub_menu"],
                            align =  MxM_Pj_Admin_Menu.ESX.MenuAlign,
                            elements = elements
                        }, function(data2, menu2)
                            if data2.current.value ~= nil then
                                    if data2.current.value == "mxm:banplayer" then
                                        OpenBanMenu(id)
                                    elseif data2.current.value  == "mxm:kickplayer" then
                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'mxm_admin_menu_kick_reason', {
                                        title = MxM_Lang["kick_reason"],
                                        default = ""
                                    }, function(data_input1, menu_input1)
                                            if  data_input1.value == nil or data_input1.value == ""  then
                                                menu_input1.close() 
                                            else
                                                menu_input1.close()
                                                TriggerServerEvent("MxM:KickPlayer",id,data_input1.value)  -- ID , REASON ,              
                                            end
                                        end, function(data_input1, menu_input1)
                                            menu_input1.close()
                                        end) 
                                    else
                                    if data2.current.serverside then
                                        TriggerServerEvent("MxM_ServerSide",data2.current.value,id)
                                    else
                                        TriggerEvent("MxM_ClientSide",data2.current.value,id)
                                    end
                                end

                            end
                        end, function(data2, menu2)
                            menu2.close()
                        end)
                    end,data1.current.namesub)
                end
            end
        end, function(data1, menu1)
            menu1.close()
        end)
    end,"player_option") 
end



OpenVarieMenu = function(type,player)
    if type == "givemoney" then
        local elements = {
            {label = 'Contanti', value = 'money'},
            {label = 'Banca', value = 'bank'},
            {label = 'Black Money', value = 'black_money'},
        }
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'give_money', {
            title = 'MxM-'..MxM_Lang["give_money"],
            align =  MxM_Pj_Admin_Menu.ESX.MenuAlign,
            elements = elements
        }, function(data, menu)
            if data.current.value ~= nil then
                ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'mxm_admin_menu_give_money_amount', {
                    title = MxM_Lang["amount_give"],
                    default = ""
                }, function(data_input1, menu_input1)
                    if  tonumber(data_input1.value) == nil then
                        menu_input1.close() 
                    else
                        menu_input1.close()
                        TriggerServerEvent("MxM:GiveMoney",player,data.current.value,tonumber(data_input1.value))         
                    end
                end, function(data_input1, menu_input1)
                    menu_input1.close()
                end) 
            end
        end, function(data, menu)
              menu.close()
        end)
    elseif type == "givecar" then
        MxM.T_S_projectCallback('MxM:_RequestMenu', function(elements1)
            if #elements1 > 0 then
                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'add_vehicle', {
                    title = 'MxM-'..MxM_Lang["add_vehicle"],
                    align =  MxM_Pj_Admin_Menu.ESX.MenuAlign,
                    elements = elements1
                }, function(data1, menu1)
                    if data1.current.value ~= nil then
                        local coords = GetEntityCoords(GetPlayerPed(-1))
                        ESX.Game.SpawnVehicle(data1.current.value, coords, 200, function(vehicle)  --                    
                            SetEntityAsMissionEntity(vehicle, true, true)
                            SetVehicleOnGroundProperly(vehicle)
                            NetworkFadeInEntity(vehicle, true, true)
                            SetModelAsNoLongerNeeded(data1.current.value)
                            TriggerServerEvent('MxM:setVehicleOwnedPlayerId', player, ESX.Game.GetVehicleProperties(vehicle))
                            Citizen.Wait(1000)
                            DeleteVehicle(vehicle)
                        end)
                    end
                end, function(data1, menu1)
                    menu1.close()
                end)
            end
        end,"car_list")
    elseif type == "job" then
        --Da fare appena ho tempo
    end
end





OpenListPlayerMenu = function ()
    if MxM_Pj_Admin_Menu.ESX.enable then
        MxM.T_S_projectCallback('MxM:_RequestMenu', function(elements)
            if elements ~= nil then
                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mxm_list_player_menu', {
                    title = 'MxM-'..MxM_Lang["list_player"],
                    align =  MxM_Pj_Admin_Menu.ESX.MenuAlign,
                    elements = elements
                }, function(data, menu)
                    if data.current.value ~= nil then
                        MxM.T_S_projectCallback('MxM:_RequestMenu', function(elements)
                            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mxm_submenu_menu', {
                                title = 'MxM-'..MxM_Lang["sub_menu"],
                                align =  MxM_Pj_Admin_Menu.ESX.MenuAlign,
                                elements = elements
                            }, function(data1, menu1)
                                if data1.current.value ~= nil then
                                    if data1.current.sub then
                                        MxM.T_S_projectCallback('MxM:_RequestMenu', function(elements)
                                            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mxm_submenu_menu1', {
                                                title = 'MxM-'..MxM_Lang["sub_menu"],
                                                align =  MxM_Pj_Admin_Menu.ESX.MenuAlign,
                                                elements = elements
                                            }, function(data2, menu2)
                                                if data2.current.value ~= nil then
                                                        if data2.current.value == "mxm:banplayer" then
                                                        OpenBanMenu(data.current.value)
                                                    elseif data2.current.value  == "mxm:kickplayer" then
                                                        ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'mxm_admin_menu_kick_reason', {
                                                            title = MxM_Lang["kick_reason"],
                                                            default = ""
                                                        }, function(data_input1, menu_input1)
                                                            if  data_input1.value == nil or data_input1.value == ""  then
                                                                menu_input1.close() 
                                                            else
                                                                menu_input1.close()
                                                                TriggerServerEvent("MxM:KickPlayer",data.current.value,data_input1.value)         
                                                            end
                                                        end, function(data_input1, menu_input1)
                                                            menu_input1.close()
                                                        end) 
                                                    else                                                
                                                        if data2.current.serverside then
                                                            TriggerServerEvent("MxM_ServerSide",data2.current.value,data.current.value)
                                                        else
                                                            TriggerEvent("MxM_ClientSide",data2.current.value,data.current.value)
                                                        end
                                                    end
                                                end
                                            end, function(data2, menu2)
                                                menu2.close()
                                            end)
                                        end,data1.current.namesub)
                                    end
                                end
                            end, function(data1, menu1)
                                menu1.close()
                            end)
                        end,"player_option") 
                    end
                end, function(data, menu)
                        menu.close()
                end)
            end
        end,"list_player")
    else
        _print("Coming soon","error")
    end
end



RegisterCommand("chiudi", function ()
    ESX.UI.Menu.CloseAll()
end)



OpenBanMenu = function (ID)  
    local elements = {
        {label = MxM_Lang["ban_perma"],             value = 'perma'},
        {label = MxM_Lang["12ore_ban"],             value = '12ore'},
        {label = MxM_Lang["1g_ban"],                value = '1g'},
        {label = MxM_Lang["2g_ban"],                value = '2g'},
        {label = MxM_Lang["3g_ban"],                value = '1g'},
        {label = MxM_Lang["1s_ban"],                value = '1s'},
        {label = MxM_Lang["pers_ban"] ,             value = 'pers'},
    }
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mxm_ban', {
        title = 'Ban Sistem',
        align = 'top-left',
        elements = elements
    }, function(data, menu)
        if data.current.value ~= nil then
            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'mxm_admin_menu_ban_reason', {
                title = "Motivo Del Ban",
                default = ""
            }, function(data_input, menu_input)
                if data_input.value == nil or data_input.value == "" then
                    menu_input.close() 
                else
                    if data.current.value ~= "pers" then
                        TriggerServerEvent("MxM:BanPlayer",ID,data_input.value,data.current.value) 
                    else
                        menu_input.close() 
                        ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'mxm_admin_menu_ban_time', {
                            title = "Durata Del ban (Espresso In Ore)",
                            default = ""
                        }, function(data_input1, menu_input1)
                            if tonumber(data_input1.value) == nil then
                                menu_input1.close() 
                            else
                                menu_input1.close()
                                TriggerServerEvent("MxM:BanPlayer",ID,data_input.value,data.current.value,data_input1.value)                 
                            end
                        end, function(data_input1, menu_input1)
                            menu_input1.close()
                        end)
                    end
                    menu_input.close()
                end
            end, function(data_input, menu_input)
                menu_input.close()
            end) 
        end
    end, function(data, menu)
            menu.close()
    end)
end





local mostrablip = false

OpenblipPlayer = function ()
    mostrablip = not mostrablip
    if mostrablip then
        mostrablip = true
        print("Blip sui player Abilitati")
    else
        mostrablip = false
        print("Blip sui player Disabilitati")
    end
    Citizen.CreateThread(function()
        local blips = {}
        while mostrablip do
            Citizen.Wait(1)
            for _, ServerPlayer in ipairs(GetActivePlayers()) do
                local player = tonumber(ServerPlayer)
                if GetPlayerPed(player) ~= GetPlayerPed(-1) then
                    ped = GetPlayerPed(player)
                    if mostrablip then
                        RemoveBlip(blips[player])
                        local playerName = GetPlayerName(player)
                        local new_blip = AddBlipForEntity(ped)
                        SetBlipNameToPlayerName(new_blip, player)
                        SetBlipColour(new_blip, 1)
                        SetBlipScale(new_blip, 0.9)

                        blips[player] = new_blip
                    else
                        for blip, v in pairs(blips) do
                            RemoveBlip(v)
                        end
                        isShowingBlips = false
                        return
                    end
                end
            end
        end
        return
    end)
    if not mostrablip then 
        return
    end
end

local mostranomi = false
 OpenNomiPlayer =function ()
    mostranomi = not mostranomi
    if mostranomi then
        mostranomi = true
        print("Nomi sui player Abilitati")
    else
        mostranomi = false
        print("Nomi sui player Disabilitati")
    end
    Citizen.CreateThread(function()
        while mostranomi do
            Citizen.Wait(1)
            for _, ServerPlayer in ipairs(GetActivePlayers()) do
                local player = tonumber(ServerPlayer)
                if GetPlayerPed(player) ~= GetPlayerPed(-1) then
                    ped = GetPlayerPed(player)
                    idTesta = Citizen.InvokeNative(0xBFEFE3321A3F5015, ped,"Nome: "..GetPlayerName(player) .. "\nID: ["..GetPlayerServerId(player).."]\n Vita: "..GetEntityHealth(ped), false, false, "", false)
                    if mostranomi then
                        N_0x63bb75abedc1f6a0(idTesta, 9, true)
                    else
                        N_0x63bb75abedc1f6a0(idTesta, 0, false)
                    end
                    if not mostranomi then
                        Citizen.InvokeNative(0x63BB75ABEDC1F6A0, idTesta, 9, false)
                        Citizen.InvokeNative(0x63BB75ABEDC1F6A0, idTesta, 0, false)
                        
                        RemoveMpGamerTag(idTesta)
                        return
                    end
                end
            end
        end
        return
    end)
    if not mostranomi then 
        return
    end
end



MxM.R_C_projectCallback('MxM:ClearAllPedProps', function(cb)
    local ped = GetPlayerPed(-1)
    ClearAllPedProps(ped)
    ClearPedBloodDamage(ped)
    cb()
end)


MxM.R_C_projectCallback('MxM:Nomi', function(cb)
    OpenNomiPlayer()
    cb()
end)

MxM.R_C_projectCallback('MxM:Blip', function(cb)
    OpenblipPlayer()
    cb()
end)

MxM.R_C_projectCallback('MxM:GetWaipoint', function(cb)
    if not IsWaypointActive() then
        print("Devi Scegliere il punto in mappa prima di poterti teletrasportare")
        return
    end
    local waypointBlip = GetFirstBlipInfoId(8)
    local coords = GetBlipCoords(waypointBlip)
    cb(coords)
end)

MxM.R_C_projectCallback('MxM:TpPlayerToWaipoint', function(cb,arg,coords)

    local ped = arg
    local targetVeh = GetVehiclePedIsUsing(ped)
    if IsPedInAnyVehicle(ped) then
        ped = targetVeh
    end
    local z = coords.z
    local ground
    local groundFound = false
    for altezza=1, 1000, 1 do
        SetEntityCoordsNoOffset(ped, coords.x, coords.y, altezza, 0, 0, 1)
        Citizen.Wait(1)

        ground, z = GetGroundZFor_3dCoord(coords.x, coords.y, altezza + 0.1)
        if ground then
            z = z + 2.0
            groundFound = true
            break;
        end
    end
    if not groundFound then
        z = 1000.0
    end
    SetEntityCoordsNoOffset(ped, coords.x, coords.y, z, 0, 0, 1)
    print("Sei stato Teletrasportato al punto desiderato")
    cb()
end)



local CoordsVecchie  -- Credits By Loweri#9667

RegisterNetEvent("MxM:spectatePlayer")
AddEventHandler("MxM:spectatePlayer", function(target,x, y, z,ped,coordsvecchie) 
    local ped1 = GetPlayerPed(GetPlayerFromServerId(tonumber(target)))
    local myped = PlayerPedId()
    if ped == myped then return end 
    spectating = not spectating
    if spectating then
        CoordsVecchie = coordsvecchie
        SetEntityInvincible(myped, true)
        SetEntityVisible(PlayerPedId(), false, 0)
        Citizen.Wait(20)
        SetEntityCoords(GetPlayerPed(-1), x, y, z)
        Citizen.Wait(100)
        AttachEntityToEntity(myped,GetPlayerPed(GetPlayerFromServerId(tonumber(target))), 4103, 11816, 0.0, 2.50, 30.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
        Citizen.Wait(500)
        NetworkSetInSpectatorMode(true, GetPlayerPed(GetPlayerFromServerId(tonumber(target))))
    else
        NetworkSetInSpectatorMode(false, ped1)
        DetachEntity(myped, true, false)
        DetachEntity(myped, true, false)
        Citizen.Wait(20)
        SetEntityCoords(GetPlayerPed(-1), CoordsVecchie.x, CoordsVecchie.y, CoordsVecchie.z)
        CoordsVecchie = nil
        Citizen.Wait(20)
        SetEntityInvincible(ped1, false)
        SetEntityVisible(PlayerPedId(), true, 0)
	end
end)


MxM.R_C_projectCallback('MxM:TeleportToPlayer', function(cb,coords)
    if coords.x ~= nil and coords.y ~= nil and coords.z ~= nil then
        if inNoclip then
           inNoclip = false
           SetEntityCoords(GetPlayerPed(-1), coords.x, coords.y, coords.z)
           NoClip()
           noclip_pos = GetEntityCoords(PlayerPedId(), false)
        else
            SetEntityCoords(GetPlayerPed(-1), coords.x, coords.y, coords.z)
        end
    end
end)


MxM.R_C_projectCallback('MxM:Noclip', function(cb)
    TriggerServerEvent("NoclipStatus", inNoclip)
    if not inNoclip then
        NoClip()
        noclip_pos = GetEntityCoords(PlayerPedId(), false)
    else
        inNoclip = false
    end
end)


MxM.R_C_projectCallback('MxM:DelAllPed', function(cb)
    local Ped = 0
    for ped in EnumeratePeds() do
        if not (IsPedAPlayer(ped))then
            RemoveAllPedWeapons(ped, true)
            DeleteEntity(ped)
            Ped =  Ped + 1
        end
    end  
    cb(Ped)
end)

MxM.R_C_projectCallback('MxM:DelAllvehicle', function(cb)
    local Vehicle = 0
    for vehicle in EnumerateVehicles() do
        SetEntityAsMissionEntity(GetVehiclePedIsIn(vehicle, true), 1, 1)
        DeleteEntity(GetVehiclePedIsIn(vehicle, true))
        SetEntityAsMissionEntity(vehicle, 1, 1)
        DeleteEntity(vehicle)
        Vehicle =  Vehicle + 1
      end
    cb(Vehicle)
end)

MxM.R_C_projectCallback('MxM:DelAllProps', function(cb)
    local ObJet = 0
    for obj in EnumerateObjects() do
        DeleteEntity(obj)
        ObJet =  ObJet + 1
    end
    cb(ObJet)
end)


MxM.R_C_projectCallback('MxM:DelAllAll', function(cb)
    for obj in EnumerateObjects() do
        DeleteEntity(obj)
    end
    for vehicle in EnumerateVehicles() do
        SetEntityAsMissionEntity(GetVehiclePedIsIn(vehicle, true), 1, 1)
        DeleteEntity(GetVehiclePedIsIn(vehicle, true))
        SetEntityAsMissionEntity(vehicle, 1, 1)
        DeleteEntity(vehicle)
      end
    for ped in EnumeratePeds() do
        if not (IsPedAPlayer(ped))then
            RemoveAllPedWeapons(ped, true)
            DeleteEntity(ped)
        end
    end 
    cb()
end)




local heading = 0
local speed = 0.1
local up_down_speed = 0.1

function InfoNoClip(heading)
	Scale = RequestScaleformMovie("INSTRUCTIONAL_BUTTONS");
    while not HasScaleformMovieLoaded(Scale) do
        Citizen.Wait(0)
	end

    BeginScaleformMovieMethod(Scale, "CLEAR_ALL");
    EndScaleformMovieMethod();

    BeginScaleformMovieMethod(Scale, "SET_DATA_SLOT");
    ScaleformMovieMethodAddParamInt(0);
    PushScaleformMovieMethodParameterString("~INPUT_SPRINT~");
    PushScaleformMovieMethodParameterString("Velocità corrente: "..speed);
    EndScaleformMovieMethod();

    BeginScaleformMovieMethod(Scale, "SET_DATA_SLOT");
    ScaleformMovieMethodAddParamInt(1);
    PushScaleformMovieMethodParameterString("~INPUT_MOVE_LR~");
    PushScaleformMovieMethodParameterString("Sinistra/Destra");
    EndScaleformMovieMethod();

    BeginScaleformMovieMethod(Scale, "SET_DATA_SLOT");
    ScaleformMovieMethodAddParamInt(2);
    PushScaleformMovieMethodParameterString("~INPUT_MOVE_UD~");
    PushScaleformMovieMethodParameterString("Dietro/Avanti");
    EndScaleformMovieMethod();

    BeginScaleformMovieMethod(Scale, "SET_DATA_SLOT");
    ScaleformMovieMethodAddParamInt(3);
    PushScaleformMovieMethodParameterString("~INPUT_MULTIPLAYER_INFO~");
    PushScaleformMovieMethodParameterString("Scendi");
    EndScaleformMovieMethod();

    BeginScaleformMovieMethod(Scale, "SET_DATA_SLOT");
    ScaleformMovieMethodAddParamInt(4);
    PushScaleformMovieMethodParameterString("~INPUT_COVER~");
    PushScaleformMovieMethodParameterString("Sali");
    EndScaleformMovieMethod();

    BeginScaleformMovieMethod(Scale, "SET_DATA_SLOT");
    ScaleformMovieMethodAddParamInt(7);
    PushScaleformMovieMethodParameterString("Rotazione: "..math.floor(heading));
    EndScaleformMovieMethod();

    BeginScaleformMovieMethod(Scale, "DRAW_INSTRUCTIONAL_BUTTONS");
    ScaleformMovieMethodAddParamInt(0);
    EndScaleformMovieMethod();

    DrawScaleformMovieFullscreen(Scale, 255, 255, 255, 255, 0);
end



NoClip = function()

    inNoclip = true
    
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1)
            local ped = PlayerPedId()
            local targetVeh = GetVehiclePedIsUsing(ped)
            if IsPedInAnyVehicle(ped) then
                ped = targetVeh
            end

            if inNoclip then
                InfoNoClip(heading)

                SetEntityInvincible(ped, true)
                SetEntityVisible(ped, false, false)

                SetEntityLocallyVisible(ped)
                SetEntityAlpha(ped, 100, false)
                SetBlockingOfNonTemporaryEvents(ped, true)
                ForcePedMotionState(ped, -1871534317, 0, 0, 0)

                SetLocalPlayerVisibleLocally(ped)
                --SetEntityAlpha(ped, (255 * 0.2), 1)
                SetEntityCollision(ped, false, false)
                
                SetEntityCoordsNoOffset(ped, noclip_pos.x, noclip_pos.y, noclip_pos.z, true, true, true)

                if IsControlPressed(1, 34) then
                    heading = heading + 2.0
                    if heading > 359.0 then
                        heading = 0.0
                    end

                    SetEntityHeading(ped, heading)
                end

                if IsControlPressed(1, 9) then
                    heading = heading - 2.0
                    if heading < 0.0 then
                        heading = 360.0
                    end

                    SetEntityHeading(ped, heading)
                end
                heading = GetEntityHeading(ped)

                if IsControlJustPressed(1, 21) then
                    if speed == 0.1 then
                        speed = 0.2
                        up_down_speed = 0.2
                    elseif speed == 0.2 then
                        speed = 0.3
                        up_down_speed = 0.3
                    elseif speed == 0.3 then
                        speed = 0.5
                        up_down_speed = 0.5
                    elseif speed == 0.5 then
                        speed = 1.5
                        up_down_speed = 0.5
                    elseif speed == 1.5 then
                        speed = 2.5
                        up_down_speed = 0.9
                    elseif speed == 2.5 then
                        speed = 3.5
                        up_down_speed = 1.3
                    elseif speed == 3.5 then
                        speed = 4.5
                        up_down_speed = 1.5
                    elseif speed == 4.5 then
                        speed = 0.1
                        up_down_speed = 0.1
                    end
                end

                if IsControlPressed(1, 8) then
                    noclip_pos = GetOffsetFromEntityInWorldCoords(ped, 0.0, -speed, 0.0)
                end

                if IsControlPressed(1, 44) and IsControlPressed(1, 32) then -- Q e W
                    noclip_pos = GetOffsetFromEntityInWorldCoords(ped, 0.0, speed, up_down_speed)
                elseif IsControlPressed(1, 44) then -- solo Q
                    noclip_pos = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.0, up_down_speed)
                elseif IsControlPressed(1, 32) then -- solo W
                    noclip_pos = GetOffsetFromEntityInWorldCoords(ped, 0.0, speed, 0.0)
                end

                if IsControlPressed(1, 20) and IsControlPressed(1, 32) then -- Z e W
                    noclip_pos = GetOffsetFromEntityInWorldCoords(ped, 0.0, speed, -up_down_speed)
                elseif IsControlPressed(1, 20) then -- solo Z
                    noclip_pos = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.0, -up_down_speed)
                end
            else
                SetEntityInvincible(ped, false)
                ResetEntityAlpha(ped)
                SetEntityVisible(ped, true, false)
                SetEntityCollision(ped, true, false)
                SetBlockingOfNonTemporaryEvents(ped, false)

                return
            end
        end
    end)
end




RegisterKeyMapping("OpenMenu","Open Admin Menu","keyboard","M")
RegisterCommand("OpenMenu",function ()
    MxM.T_S_projectCallback('MxM:PermsCheck', function(result)
        if result then
            OpenMainMenu()
        end
    end)
end)


RegisterKeyMapping("Noclip","Noclip Rapido","keyboard","HOME")
RegisterCommand("Noclip",function ()
    MxM.T_S_projectCallback('MxM:PermsCheck', function(result)
        if result then
            TriggerServerEvent("NoclipStatus", inNoclip)
            if not inNoclip then
                NoClip()
                noclip_pos = GetEntityCoords(PlayerPedId(), false)
            else
                inNoclip = false
            end
        end
    end)
end)


RegisterKeyMapping("BlipRapidi","Blip Sui Player","keyboard","F1")
RegisterCommand("BlipRapidi",function ()
    MxM.T_S_projectCallback('MxM:PermsCheck', function(result)
        if result then
            OpenblipPlayer()
        end
    end)
end)


RegisterKeyMapping("NomiRapidi","Nomi sui Player","keyboard","F9")
RegisterCommand("NomiRapidi",function ()
    MxM.T_S_projectCallback('MxM:PermsCheck', function(result)
        if result then
            OpenNomiPlayer()
        end
    end)
end)

RegisterKeyMapping("TpToWp","TpToWp Rapido","keyboard","DELETE")
RegisterCommand("TpToWp",function ()
    MxM.T_S_projectCallback('MxM:PermsCheck', function(result)
        if result then
            local ped = GetPlayerPed(-1)
            local targetVeh = GetVehiclePedIsUsing(ped)
            if IsPedInAnyVehicle(ped) then
                ped = targetVeh
            end
            if not IsWaypointActive() then
                print("Devi Scegliere il punto in mappa prima di poterti teletrasportare")
                return
            end
            local waypointBlip = GetFirstBlipInfoId(8)
            local coords = GetBlipCoords(waypointBlip)
            local z = coords.z
            local ground
            local groundFound = false
            for altezza=1, 1000, 1 do
                SetEntityCoordsNoOffset(ped, coords.x, coords.y, altezza, 0, 0, 1)
                Citizen.Wait(1)
            
                ground, z = GetGroundZFor_3dCoord(coords.x, coords.y, altezza + 0.1)
                if ground then
                    z = z + 2.0
                    groundFound = true
                    break;
                end
            end
            if not groundFound then
                z = 1000.0
            end
            SetEntityCoordsNoOffset(ped, coords.x, coords.y, z, 0, 0, 1)
            print("Sei stato Teletrasportato al punto desiderato")
        end
    end)
end)
