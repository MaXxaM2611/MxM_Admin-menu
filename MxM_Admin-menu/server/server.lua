ESX = nil
MxM_Pj = {}
local savedCoords = {}




TriggerEvent(MxM_Pj_Admin_Menu.ESX.getSharedObject, function(obj) ESX = obj end)

_print = function (msg,type)
    if msg ~= nil then
        if type == "error" then
            print("[^2MxM_Admin_Menu:^1 | [ERROR] |^0] "..msg)
        elseif type == "inform" then
            print("[^2MxM_Admin_Menu:^4 | [WARNING] |^0] "..msg)
        elseif type == "success" then
            print("[^MxM_Admin_Menu:^2 | [INFO] |^0] "..msg)
        end
    end
end
 

MxM_Pj.BanListCreator = function()
    local File = LoadResourceFile(GetCurrentResourceName(), "mxmban.json")
    if not File or File == "" then
		SaveResourceFile(GetCurrentResourceName(), "mxmban.json", "[]", -1)
		_print(MxM_Lang["regenerating_file_ban.json"],"error")
	else
		local Table = json.decode(File)
		if not Table then
			SaveResourceFile(GetCurrentResourceName(), "mxmban.json", "[]", -1)
			Table = {}
            _print(MxM_Lang["corrupted_file_mxmban.json"],"error")
		end
	end
end



AddEventHandler('playerConnecting', function (playerName,setKickReason,deferrals)
	local _src = source
	local File = LoadResourceFile(GetCurrentResourceName(), "mxmban.json")
	local Banned = false
	if MxM_Pj_Admin_Menu.PrintConnecting then
		_print(MxM_Lang["player"]..GetPlayerName(_src)..MxM_Lang["connecting"],"success")  
	end
    if MxM_Pj_Admin_Menu.WebhookConnecting then
        local license,identifier,liveid,xblid,discord,ip = "N/A","N/A","N/A","N/A","N/A","N/A"
        for k,v in ipairs(GetPlayerIdentifiers(_src))do
            if string.sub(v, 1, string.len("license:")) == "license:" then
                license = v
            elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
                identifier = v
            elseif string.sub(v, 1, string.len("live:")) == "live:" then
                liveid = v
            elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
                xblid  = v
            elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
                discord = v
            elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
                ip = v
            end
        end
        local embed = {
	    	{
                author = {
                    name = "| [MxM_Admin_Menu] | Version: " .. MxM_Pj_Admin_Menu.Version,
                    url = "https://www.fenixhub.dev/",
                    icon_url = "https://cdn.discordapp.com/attachments/636955559626670080/795310131704627231/logo-fen.png"
                },
	    		color = 696969,
	    		title = MxM_Lang["title_webhook_connect"],
	    		description = "**Nome :** ".. playerName .. "\n**Steam Hex :** ".. identifier .. "\n**Licenza :** " .. license .. "\n**Discord :**" .. '<@' .. string.sub(discord, 9) .. '>' .. "\n**IP :** ||".. string.sub(ip, 3) .. '||\n\n **'..MxM_Pj_Admin_Menu.ServerName.."**:| **[MxM_Admin_Menu]** | Version: "..MxM_Pj_Admin_Menu.Version,
	    		footer = {
                    text = "[MxM_Admin_Menu]  By MaXxaM#0511 - " .. os.date("%x %X %p"),
                    icon_url = 'https://cdn.discordapp.com/attachments/636955559626670080/795310131704627231/logo-fen.png'
                }
	    	}
	    }

	PerformHttpRequest(MxM_Pj_Admin_Menu_table.Log.Discord.webhook_connecting, function(err, text, headers)
		end, 'POST', json.encode({embeds = embed}), { ['Content-Type'] = 'application/json' }
	)
    end
	if File ~= nil then
		local Table = json.decode(File)
		if type(Table) == "table" then
			local Playertokens = {}
			if MxM_Pj_Admin_Menu.BanToken then
				for i=1,GetNumPlayerTokens(_src) do
					table.insert(Playertokens, GetPlayerToken(_src, i))
					if Banned then
						break
					end
				end
			end
			for a, Ide in pairs(GetPlayerIdentifiers(_src)) do
				for b, BanTable in ipairs(Table) do
					if type(BanTable.identifier) == "table"  then
						for c, IdeBanlist in pairs(BanTable.identifier) do
							if IdeBanlist == Ide then
                                if BanTable.scadenzaban ~= nil and os.time() > BanTable.scadenzaban then
                                    if not BanTable.perma then
                                        table.remove(Table, BanTable.banId)
                                        SaveResourceFile(GetCurrentResourceName(), 'mxmban.json', json.encode(Table, { indent = true }), -1)
                                        _print(MxM_Lang["player"]..GetPlayerName(_src)..MxM_Lang["sban_for_scadenzaban"],"inform")
                                        Banned = true
                                        break
                                    else
                                        if BanTable.offlineban ~= nil and BanTable.offlineban then                     
                                            if GetPlayerName(_src) ~= nil then BanTable.name = GetPlayerName(_src).." (Offline Ban)" end
                                            BanTable.offlineban = false
                                            BanTable.identifier = GetPlayerIdentifiers(_src)
                                            BanTable.token = Playertokens
                                            SaveResourceFile(GetCurrentResourceName(), 'mxmban.json', json.encode(Table, { indent = true }), -1)
                                        end
                                        CancelEvent()
                                        setKickReason("[MxM_Admin_Menu] | "..MxM_Lang["you_banned_from_this_server"]..BanTable.reason.."\n"..MxM_Lang["banned_by"]..BanTable.bannedbyName.."\n"..MxM_Lang["time_rimanente"]..os.date("%x", BanTable.scadenzaban).." "..os.date("%X", BanTable.scadenzaban).."\n Ban ID: "..BanTable.banId)
                                        _print(MxM_Lang["player"]..GetPlayerName(_src)..MxM_Lang["connecting_banned_identifier"],"inform")
                                    end
                                else
                                    if BanTable.offlineban ~= nil and BanTable.offlineban then
                                        if GetPlayerName(_src) ~= nil then BanTable.name = GetPlayerName(_src).." (Offline Ban)" end
                                        BanTable.offlineban = false
                                        BanTable.identifier = GetPlayerIdentifiers(_src)
                                        BanTable.token = Playertokens
                                        SaveResourceFile(GetCurrentResourceName(), 'mxmban.json', json.encode(Table, { indent = true }), -1)
                                    end
                                    CancelEvent()
                                    setKickReason("[MxM_Admin_Menu] | "..MxM_Lang["you_banned_from_this_server"]..BanTable.reason.."\n"..MxM_Lang["banned_by"]..BanTable.bannedbyName.."\n"..MxM_Lang["time_rimanente"]..os.date("%x", BanTable.scadenzaban).." "..os.date("%X", BanTable.scadenzaban).."\n Ban ID: "..BanTable.banId)
                                    _print(MxM_Lang["player"]..GetPlayerName(_src)..MxM_Lang["connecting_banned_identifier"],"inform")
                                    Banned = true
                                    break
                                end
							end
						end
                        if not Banned and MxM_Pj_Admin_Menu.BanToken then
                            if BanTable.perma then
                                if type(BanTable.token) == "table" then
                                    for d, TokenBanlist in pairs(BanTable.token) do
                                        for g, aa in pairs(Playertokens) do
                                            if aa == TokenBanlist then
                                                CancelEvent()
                                                setKickReason("[MxM_Admin_Menu] | "..MxM_Lang["you_banned_from_this_server"].."\n"..MxM_Lang["banned_by"]..BanTable.bannedbyName.."\n"..BanTable.reason..MxM_Lang["perma_ban"].."\n Ban ID: "..BanTable.banId)
                                                _print(MxM_Lang["player"]..GetPlayerName(_src)..MxM_Lang["connecting_banned_tokens"],"inform") 
                                                Banned = true
                                                break
                                            end
                                        end
                                        if Banned then
                                            break
                                        end
                                    end
                                end
                            end 
                        end
					end
					if Banned then
						break
					end
				end
				if Banned then
					break
				end
			end
		else
			MxM_Pj.BanListCreator()
		end
	else
		MxM_Pj.BanListCreator()
	end
end)




GetAllJob = function ()
    if MxM_Pj_Admin_Menu.ESX.enable  then
        if ESX.GetJobs then
            return ESX.GetJobs
        else
            _print(MxM_Lang["esx_get_job_nil"],"error") 
        end
    else
        --Aggiungi la tua tabella con la lista dei job/gradi
    end
end



GetAllVehicle = function ()
    local Table = {}
    for a, b in pairs(MxM_Pj_Admin_Menu_table.Vehicle) do
        table.insert(Table,{label = b.label, value = b.value})
    end
    return Table
end


CheckIdentifier = function (_src,type)
for k,v in ipairs(GetPlayerIdentifiers(_src))  do
    for l, n in pairs(MxM_Pj_Admin_Menu_table.IdentiFier[type]) do
        if n == v  then
            return true
        end
    end
    end
end


MxM_Pj.LogImage = function (description,image)
    if MxM_Pj_Admin_Menu_table.Log.Discord.enable then
        PerformHttpRequest(MxM_Pj_Admin_Menu_table.Log.Discord.webhook_image, function()
        end, "POST", json.encode({
            embeds = {{
                author = {
                    name = "| [MxM_Admin_Menu] | Version: " .. MxM_Pj_Admin_Menu.Version,
                    url = "https://www.fenixhub.dev/",
                    icon_url = "https://cdn.discordapp.com/attachments/636955559626670080/795310131704627231/logo-fen.png"
                },
                title = MxM_Lang["title_webhook_image"],
                description = description,
                color = 179870,
                image = {
                    url = image
                },
                footer = {
                    text = "**[MxM_Admin_Menu]  By MaXxaM#0511 - **" .. os.date("%x %X %p"),
                    icon_url = 'https://cdn.discordapp.com/attachments/636955559626670080/795310131704627231/logo-fen.png'
                }
            }}
        }), {
            ["Content-Type"] = "application/json"
        })        
    end
end


MxM_Pj.LogSistem = function(_src,reason,admin,ban,sban,Other)     
   if MxM_Pj_Admin_Menu_table.Log.Discord.enable then
    
        if admin == nil then admin = _src end
        local steam ,discord ,license ,live ,xbl ,ip, Descrizione	= "n/a","n/a","n/a","n/a","n/a","n/a","n/a"
        local PlayerName,Color,Title,Webhook,AdminName = GetPlayerName(_src) ,16711680,"n/a","n/a",GetPlayerName(admin)
        if PlayerName == nil  then PlayerName = "n/a"  end 
        for m, n in ipairs(GetPlayerIdentifiers(_src)) do
            if n:match("steam") then
                steam = n
            elseif n:match("discord") then
                discord = n:gsub("discord:", "")
            elseif n:match("license") then
                license = n
            elseif n:match("live") then
                live = n
            elseif n:match("xbl") then
                xbl = n
            elseif n:match("ip") then
                ip = n:gsub("ip:", "")
            end
        end
        if ban then
            Color = 16711680
            Title = MxM_Lang["title_webhook_banned"] 
            Webhook	= MxM_Pj_Admin_Menu_table.Log.Discord.webhook_ban    
            Descrizione = "``Player:`` **"..PlayerName.."** \n ``ServerID:`` **".._src.."** \n ``Banned By:`` **"..AdminName.."** \n ``Reason:`` **"..reason.."** \n ``SteamID:`` **"..steam.."** \n ``Discord:`` <@"..discord..">".."  \n ``Rockstar License:`` **"..license.."** \n ``Live Id:`` **"..live.."** \n ``Xbox Id:`` **"..xbl.."** \n ``Ip:`` **"..ip.."**".."\n``Sban:`` **"..os.date("%x", sban).." "..os.date("%X", sban).."\n ``Ban ID:`` "..Other.."**\n\n **"..MxM_Pj_Admin_Menu.ServerName.."**:| **[MxM_Admin_Menu]** | Version: "..MxM_Pj_Admin_Menu.Version
        else
            Color = 1769216
            Title = MxM_Lang["title_webhook_admin"]
            Webhook	= MxM_Pj_Admin_Menu_table.Log.Discord.webhook_admin
            Descrizione = "``Player:`` **"..PlayerName.."** \n ``ServerID:`` **".._src.."**\n``SteamID:`` **"..steam.."** \n ``Discord:`` <@"..discord..">".."  \n ``Rockstar License:`` **"..license.."**\n"..Other.."\n\n **"..MxM_Pj_Admin_Menu.ServerName.."**:| **[MxM_Admin_Menu]** | Version: "..MxM_Pj_Admin_Menu.Version
        end 
        
        PerformHttpRequest(Webhook, function()
        end, "POST", json.encode({
            embeds = {{
                author = {
                    name = "| [MxM_Admin_Menu] | Version: " .. MxM_Pj_Admin_Menu.Version,
                    url = "https://www.fenixhub.dev/",
                    icon_url = "https://cdn.discordapp.com/attachments/636955559626670080/795310131704627231/logo-fen.png"
                },
                title = Title,
                description = Descrizione,
                color = Color,
  
                footer = {
                    text = "[MxM_Admin_Menu]  By MaXxaM#0511 - " .. os.date("%x %X %p"),
                    icon_url = 'https://cdn.discordapp.com/attachments/636955559626670080/795310131704627231/logo-fen.png'
                }
            }}
        }), {
            ["Content-Type"] = "application/json"
        }) 
    

    end
end



MxM_Pj.Ban = function(src,target,reason,timeban,perma)
    local File = LoadResourceFile(GetCurrentResourceName(), "mxmban.json")
    if File ~= nil then
        local Table = json.decode(File)
        if type(Table) == "table" then
			local PlayerName = GetPlayerName(target)
            local bannedbyName = GetPlayerName(src)
            local DIO = GeneratebanId()
            local AbanId = tonumber(DIO)
            MxM_Pj.LogSistem(target,reason,src,true,timeban,AbanId) 
			if PlayerName ~= nil then
				PlayerName = GetPlayerName(target)
			else
				PlayerName = MxM_Lang["player_name_not_available"]
			end
            if bannedbyName ~= nil then
				bannedbyName = GetPlayerName(src)
			else
				bannedbyName = MxM_Lang["player_name_not_available"]
			end
			if reason ~= nil then
				reason = reason
			else
				reason = "n/a"
			end
			local tokens
			if MxM_Pj_Admin_Menu.BanToken then
				tokens = {}
				for i=1,GetNumPlayerTokens(target) do
					table.insert(tokens, GetPlayerToken(target, i))
				end
			else
				tokens = "Option disabling"
			end
            table.insert(Table, {
                offlineban = false,
                bannedbyName = bannedbyName,
                banId = AbanId,
                perma = perma,
				name = PlayerName,
				reason = reason,
				data = os.date("%x %X %p"),
                bannedby =  GetPlayerIdentifier(src, 1),
                scadenzaban = timeban,
				identifier = GetPlayerIdentifiers(target),
				token = tokens
			})
			SaveResourceFile(GetCurrentResourceName(), 'mxmban.json', json.encode(Table, { indent = true }), -1)

            DropPlayer(target,reason.."\n"..MxM_Lang["drop_message"])     
        else
            MxM_Pj.BanListCreator()
        end
    else
        MxM_Pj.BanListCreator()
    end
end

GeneratebanId = function ()
    
	local function IsNumberTaken(number)
        local Table = json.decode(File)
        if type(Table) == "table" then
            for a, b in pairs(Table) do
                if b.banId == number then
                    return true
                end
            end
        end
	end

	local function GenerateNumber()
		local numBase1 = math.random(100,999)
		local numBase2 = math.random(1000,9999)
		local num = string.format(numBase1.. "" ..numBase2)
		return num
	end

	local banid = GenerateNumber()

	if IsNumberTaken(banid) then
		SetTimeout(5, GeneratebanId())
	end

	return banid
end

CheckIdentifer = function (src,id) 
    for k,v in ipairs(GetPlayerIdentifiers(src))  do
        if id == v  then
            return true
        end
    end
end


CheckGroup = function (source,type)
    local xPlayer = ESX.GetPlayerFromId(source)
    local group = xPlayer.getGroup()
    if MxM_Pj_Admin_Menu_table.Permission[type][group] then
        return true
    end
end

spairs = function(t, order)
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end


MxM.R_S_projectCallback('MxM:_ceckPlayerOnline', function(src, cb,target_source)
    local xPlayer = ESX.GetPlayerFromId(target_source)
    if xPlayer then
        cb(true)
    else
        cb(false)   
    end
end)



MxM.R_S_projectCallback('MxM:PermsCheck', function(src, cb)
    if CheckGroup(src,"Open") or CheckIdentifier(src,"Open") then
        cb(true)
    end
end)


MxM.R_S_projectCallback('MxM:_RequestMenu', function(src, cb,type,target_source)
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer then
        if type == "main" then
            local  elements = {}
            for a, b in pairs(MenuConfig.Element.HomeMenu) do
                for c, d in pairs(b.group) do
                    if xPlayer.getGroup() == d then
                        table.insert(elements,b)
                    end
                end
                for e, f in pairs(b.identifier) do
                    if CheckIdentifer(src,f) then  
                        table.insert(elements,b)
                    end
                end
            end 
            cb(elements)
        elseif type == "list_player" then
            local  elements = {}
            for k,v in spairs(GetPlayers()) do
                local name = GetPlayerName(v)
                if name ~= nil then
                    table.insert(elements,{label = "Nome: "..name.." ID: "..v, value = v})   
                end
            end        
            cb(elements)
        elseif type == "player_option" then
            local  elements = {}
            for a, b in pairs(MenuConfig.Element.listplayer) do
                for c, d in pairs(b.group) do
                    if xPlayer.getGroup() == d then
                        table.insert(elements,b)
                    end
                end
                for e, f in pairs(b.identifier) do
                    if CheckIdentifer(src,f) then  
                        table.insert(elements,b)
                    end
                end
            end 
            cb(elements) 
   
        elseif string.match(type, 'submenu_') then
            local  elements = {}
            for a, b in pairs(MenuConfig.SubMenu[type]) do
                for c, d in pairs(b.group) do
                    if xPlayer.getGroup() == d then
                        table.insert(elements,b)
                    end
                end
                for e, f in pairs(b.identifier) do
                    if CheckIdentifer(src,f) then  
                        table.insert(elements,b)
                    end
                end
            end 
            cb(elements) 
        elseif type == "ban_list" then
            local  elements = {}
            local File = LoadResourceFile(GetCurrentResourceName(), "mxmban.json")
            local Table = json.decode(File)
            for a, b in pairs(Table) do
                if b ~= nil then
                    table.insert(elements,{label = "Nome:"..b.name.."| Sban: "..os.date("%x", b.scadenzaban).."| By:"..b.bannedbyName.."| Ban ID: "..b.banId, value =b.banId })
                end   
            end 
            cb(elements) 
        elseif type == "info_player" then
            local TPlayer = ESX.GetPlayerFromId(target_source)
            if TPlayer ~= nil then
              local  elements = {}
                local steam = "//"
                local discord = "//"
                local license = "//"
                local live = "//"
                local xbl = "//"
                local ip = "//"
                for m, n in ipairs(GetPlayerIdentifiers(target_source)) do
                    if n:match("steam") then
                        steam = n:gsub("steam:", "")
                    elseif n:match("discord") then
                        discord = n:gsub("discord:", "")
                    elseif n:match("license") then
                        license = n:gsub("license2:", "")
                    elseif n:match("live") then
                        live = n:gsub("live:", "")
                    elseif n:match("xbl") then
                        xbl = n:gsub("xbl:", "")
                    elseif n:match("ip") then
                        ip = n:gsub("ip:", "")
                    end
                end
                table.insert(elements,{ label = "Steam: "..steam })
                table.insert(elements,{ label = "Discord: "..discord })
                table.insert(elements,{ label = "license: "..license })
                table.insert(elements,{ label = "Live Id: "..live })
                table.insert(elements,{ label = "Xbox ID: "..xbl })
                table.insert(elements,{ label = "IP: "..ip })
                if MxM_Pj_Admin_Menu.ESX.v1 then
                    local money = TPlayer.getAccount("money").money
                    if money ~= nil then  else money = "//" end
                    table.insert(elements,{ label = "Contanti: "..money })
        
                    local bank = TPlayer.getAccount("bank").money
                    if bank ~= nil then  else bank = "//" end
                    table.insert(elements,{ label = "Banca: "..bank })
                
                    local black_money = TPlayer.getAccount("black_money").money
                    if black_money ~= nil then  else black_money = "//" end
                    table.insert(elements,{ label = "Soldi Sporchi: "..black_money })
                
                else
                    local money = TPlayer.getMoney()
                    if money ~= nil then  else money = "//" end
                    table.insert(elements,{ label = "Contanti: "..money })
        
                    local bank = TPlayer.getAccount("bank").money
                    if bank ~= nil then  else bank = "//" end
                    table.insert(elements,{ label = "Banca: "..bank })
                
                    local black_money = TPlayer.getAccount("black_money").money
                    if black_money ~= nil then  else black_money = "//" end
                    table.insert(elements,{ label = "Soldi Sporchi: "..black_money })
                end
        
                    local Group = TPlayer.getGroup()  
                    if Group ~= nil then  else Group = "//" end
                    table.insert(elements,{ label = "Gruppo: "..Group })
        
                    local Job = TPlayer.getJob()   
                    if Job ~= nil then  else Job = "//" end
                    table.insert(elements,{ label = "Lavoro: "..Job.name })
        
                    local Grade = TPlayer.getJob()    
                    if Grade ~= nil then  else Job = "//" end
                    table.insert(elements,{ label = "Grado: "..Job.grade_label })     
                cb(elements)
            end
        elseif type == "car_list" then
            cb(GetAllVehicle())
        end
    end
end)



SetConvar("AdminMenu", "This is Server using MxM Admin Menu By FenixDevHub!")

RegisterServerEvent("MxM_ServerSide")
AddEventHandler("MxM_ServerSide",function(arg,playerId)
    local src =  source
    if arg == "mxm:crash_player" then
        if CheckGroup(src,"Crash") or CheckIdentifier(src,"Crash") then
            MxM.T_C_projectCallback(playerId, 'MxM:crashplayer', function(playerPed)
                MxM_Pj.LogSistem(src,nil,nil,false,false,"``Ha fatto crashare ID:`` **"..playerId.."** \n``Nome:`` **"..GetPlayerName(playerId).."**")
            end)
        end
    elseif arg == "mxm:skin_menu"  then 
        if CheckGroup(src,"Skin") or CheckIdentifier(src,"Skin") then
            if playerId ~= nil then
                TriggerClientEvent(MxM_Pj_S.ESX.skinTrigger ,playerId) 
                MxM_Pj.LogSistem(src,nil,nil,false,false,"``Ha dato lo skin menu a ID:`` **"..playerId.."** \n``Nome:`` **"..GetPlayerName(playerId).."**")
            else
                TriggerClientEvent(MxM_Pj_S.ESX.skinTrigger,src)
                MxM_Pj.LogSistem(src,nil,nil,false,false,"``Ha dato lo skin menu a se stesso``")
            end
        end
    elseif arg == "mxm:revive"  then 
        if CheckGroup(src,"Revive") or CheckIdentifier(src,"Revive") then
            if playerId ~= nil then
                TriggerClientEvent(MxM_Pj_S.ESX.ReviveTrigger ,playerId)  
                MxM_Pj.LogSistem(src,nil,nil,false,false,"``Ha rianimato ID:`` **"..playerId.."** \n``Nome:`` **"..GetPlayerName(playerId).."**")
            else
                TriggerClientEvent(MxM_Pj_S.ESX.ReviveTrigger,src)
                MxM_Pj.LogSistem(src,nil,nil,false,false,"``Ha rianimato se stesso``")
            end
        end
    elseif arg == "mxm:heal"  then 
        if CheckGroup(src,"Heal") or CheckIdentifier(src,"Heal") then
            if playerId ~= nil then
                TriggerClientEvent('cd_playerhud:status:add', playerId ,"thirst", 100)  --thirst
				TriggerClientEvent('cd_playerhud:status:add', playerId ,"hunger", 100)  --hunger 
                MxM_Pj.LogSistem(src,nil,nil,false,false,"``Ha sfamato ID:`` **"..playerId.."** \n``Nome:`` **"..GetPlayerName(playerId).."**")
            else
                TriggerClientEvent('cd_playerhud:status:add', src,"thirst", 100)  --thirst
				TriggerClientEvent('cd_playerhud:status:add', src,"hunger", 100)  --hunger
                MxM_Pj.LogSistem(src,nil,nil,false,false,"``Ha sfamato se stesso``")
            end  
        end
    elseif arg == "mxm:giubbo"  then 
        if CheckGroup(src,"Giubbo") or CheckIdentifier(src,"Giubbo") then
            if playerId ~= nil then
                MxM.T_C_projectCallback(playerId, 'MxM:Giubbo', function(playerPed) 
                    MxM_Pj.LogSistem(src,nil,nil,false,false,"``Ha dato il giubbotto ad ID:`` **"..playerId.."** \n``Nome:`` **"..GetPlayerName(playerId).."**")
                end)
            else
                MxM.T_C_projectCallback(src, 'MxM:Giubbo', function(playerPed)
                    MxM_Pj.LogSistem(src,nil,nil,false,false,"``Ha dato il giubbotto a se stesso``")
                end)
            end  
        end
    elseif arg == "mxm:kill"  then 
        if CheckGroup(src,"Kill") or CheckIdentifier(src,"Kill") then
            if playerId ~= nil then
                MxM.T_C_projectCallback(playerId, 'MxM:Kill', function(playerPed)
                    MxM_Pj.LogSistem(src,nil,nil,false,false,"``Ha killato ID:`` **"..playerId.."** \n``Nome:`` **"..GetPlayerName(playerId).."**")
                end)
            else
                MxM.T_C_projectCallback(src, 'MxM:Kill', function(playerPed)
                    MxM_Pj.LogSistem(src,nil,nil,false,false,"``Ha killato se stesso``")
                end)
            end  
        end
    elseif arg == "mxm:tptowp"  then 
        if CheckGroup(src,"TpToWp") or CheckIdentifier(src,"TpToWp") then
            if playerId ~= nil then 
                MxM.T_C_projectCallback(src, 'MxM:GetWaipoint', function(GetWaipoint)
                    MxM.T_C_projectCallback(tonumber(playerId), 'MxM:getPlayerPed', function(playerPed)
                        MxM.T_C_projectCallback(tonumber(playerId), 'MxM:TpPlayerToWaipoint', function(playerPed)
                            MxM_Pj.LogSistem(src,nil,nil,false,false,"``Ha Teletrasportato il player su un Waitpoint ID:`` **"..playerId.."** \n``Nome:`` **"..GetPlayerName(playerId).."**")
                        end,playerPed,GetWaipoint)
                    end)
                end)
            else
                MxM.T_C_projectCallback(src, 'MxM:GetWaipoint', function(GetWaipoint)
                    MxM.T_C_projectCallback(tonumber(src), 'MxM:getPlayerPed', function(playerPed)
                        MxM.T_C_projectCallback(tonumber(src), 'MxM:TpPlayerToWaipoint', function(playerPed)
                            MxM_Pj.LogSistem(src,nil,nil,false,false,"``Si è Teletrasportato su un Waitpoint``")                    
                        end,playerPed,GetWaipoint)
                    end)
                end)
            end  
        end    
    elseif arg == "mxm:freecam"  then 
        if CheckGroup(src,"FreeCam") or CheckIdentifier(src,"FreeCam") then
            if playerId ~= nil then
                MxM.T_C_projectCallback(playerId, 'MxM:getPlayerPed', function(playerPed)
                    MxM.T_C_projectCallback(playerId, 'MxM:PrendiCoordinatePlayer', function(playerCoords)
                        MxM.T_C_projectCallback(src, 'MxM:PrendiCoordinatePlayer', function(coordsvecchie)
                            TriggerClientEvent('MxM:spectatePlayer', src, playerId,playerCoords.x, playerCoords.y, playerCoords.z,playerPed,coordsvecchie)  
                            
                        end)                    
                    end)
                end)
            end 
        end
    elseif arg == "mxm:tpdate"  then 
        if CheckGroup(src,"TpDate") or CheckIdentifier(src,"TpDate") then
            if playerId ~= nil then
                MxM.T_C_projectCallback(playerId, 'MxM:getPlayerPed', function(playerPed)
                    MxM.T_C_projectCallback(src, 'MxM:PrendiCoordinatePlayer', function(playerCoords)
                        MxM.T_C_projectCallback(playerId, 'MxM:TeleportToPlayer', function() end,playerCoords)
                    end)
                end)
            end 
        end
    elseif arg == "mxm:tpto"  then 
        if CheckGroup(src,"TpTo") or CheckIdentifier(src,"TpTo") then
            if playerId ~= nil then
                MxM.T_C_projectCallback(playerId, 'MxM:PrendiCoordinatePlayer', function(playerCoords)
                    MxM.T_C_projectCallback(src, 'MxM:TeleportToPlayer', function() end,playerCoords)
                    MxM_Pj.LogSistem(src,nil,nil,false,false,"``Ha Teletrasportato a se il player: ``**"..playerId.." Nome: "..GetPlayerName(playerId).."**")
                end)
            end 
        end
    elseif arg == "mxm:ped_clear"  then 
        if CheckGroup(src,"DelPed") or CheckIdentifier(src,"DelPed") then
            MxM.T_C_projectCallback(src, 'MxM:DelAllPed', function(ped)
                MxM_Pj.LogSistem(src,nil,nil,false,false,"``Ha Eliminato: ``**"..ped.." Ped**")    
            end)
        end
    elseif arg == "mxm:vehicle_clear"  then 
        if CheckGroup(src,"DelVeh") or CheckIdentifier(src,"DelVeh") then
            MxM.T_C_projectCallback(src, 'MxM:DelAllvehicle', function(veh)
                MxM_Pj.LogSistem(src,nil,nil,false,false,"``Ha Eliminato: ``**"..veh.." Veicoli**")
            end)
        end
    elseif arg == "mxm:props_clear"  then 
        if CheckGroup(src,"DelProps") or CheckIdentifier(src,"DelProps") then
            MxM.T_C_projectCallback(src, 'MxM:DelAllProps', function(props)
                MxM_Pj.LogSistem(src,nil,nil,false,false,"``Ha Eliminato: ``**"..props.." Props**")
            end)
        end
    elseif arg == "mxm:all_clear"  then 
        if CheckGroup(src,"DelAll") or CheckIdentifier(src,"DelAll") then
            MxM.T_C_projectCallback(src, 'MxM:DelAllAll', function()
                MxM_Pj.LogSistem(src,nil,nil,false,false,"``Ha Eliminato Tutti i Veicoli/Props/Peds Presenti nel server``")
            end)
        end
    elseif arg == "mxm:noclip"  then 
        if CheckGroup(src,"NoClip") or CheckIdentifier(src,"NoClip") then
            MxM.T_C_projectCallback(src, 'MxM:Noclip', function()
            end)
        end
    elseif arg == "mxm:godmode"  then 
        if CheckGroup(src,"Godmode") or CheckIdentifier(src,"Godmode") then
            MxM.T_C_projectCallback(src, 'MxM:Godmode', function()
                MxM_Pj.LogSistem(src,nil,nil,false,false,"``Ha Attivato/Disattivato La Godmode``")
            end)
        end
    elseif arg == "mxm:blip"  then 
        if CheckGroup(src,"Blip") or CheckIdentifier(src,"Blip") then   
            MxM.T_C_projectCallback(src, 'MxM:Blip', function()
                MxM_Pj.LogSistem(src,nil,nil,false,false,"``Ha Attivato/Disattivato i Blip``")
            end)
        end
    elseif arg == "mxm:nomi"  then 
        if CheckGroup(src,"Nomi") or CheckIdentifier(src,"Nomi") then
            MxM.T_C_projectCallback(src, 'MxM:Nomi', function()
                MxM_Pj.LogSistem(src,nil,nil,false,false,"``Ha Attivato/Disattivato i nomi``")
            end)
        end
    elseif arg == "mxm:wash"  then 
        if CheckGroup(src,"Wash") or CheckIdentifier(src,"Wash") then
            MxM.T_C_projectCallback(src, 'MxM:ClearAllPedProps', function()
                MxM_Pj.LogSistem(src,nil,nil,false,false,"``Ha pulito il ped``")
            end)
        end
    elseif arg == "mxm:fulkit"  then 
        if CheckGroup(src,"Nomi") or CheckIdentifier(src,"Nomi") then
            TriggerClientEvent("FulKit", src)
            MxM_Pj.LogSistem(src,nil,nil,false,false,"``Ha Aperto il menu FullKit``")
        end
    elseif arg == "mxm:screen"  then 
        if CheckGroup(src,"Screen") or CheckIdentifier(src,"Screen") then
            if playerId ~= nil then
                MxM.T_C_projectCallback(playerId, 'MxM:ScreenPlayer', function(image)
                    local srcname = GetPlayerName(src)
                    local tatgetname = GetPlayerName(playerId)
                    local Description = "``Player:`` **"..tatgetname.."** \n``ID: ``**"..playerId.."**\n``Identifier:`` **"..GetPlayerIdentifier(playerId,1).."**\n ``Screen Richiesto da: ``**"..srcname.."**"
                    MxM_Pj.LogImage(Description,image)
                end)
            else
                MxM.T_C_projectCallback(src, 'MxM:ScreenPlayer', function(image)
                    local srcname = GetPlayerName(src)
                    local Description = "``Player:`` **"..srcname.."** \n``ID: ``**"..src.."**\n``Identifier:`` **"..GetPlayerIdentifier(src,1).."**\n ``Screen Richiesto da: ``**"..srcname.."**"
                    MxM_Pj.LogImage(Description,image)
                end)
            end  
        end
    end
end)




RegisterServerEvent("MxM:GiveMoney")
AddEventHandler("MxM:GiveMoney", function(player,type,totale)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(player)
    if CheckGroup(src,"GiveMoney") or CheckIdentifier(src,"GiveMoney") then
        if xPlayer ~= nil then
            if totale ~= nil then
                if MxM_Pj_Admin_Menu.ESX.v1 then
                    if xPlayer.getAccount(type) ~= nil  then
                        xPlayer.addAccountMoney(type,tonumber(totale))
                        Notify(src, "Hai givvato "..totale.."$ Contanti a: "..GetPlayerName(player).." ID: "..player)
                        Notify(player, "Ti sono stati givvati "..totale.."$ Contanti da: "..GetPlayerName(src).." ID: "..src)
                    end
                else
                    if  type == "money" then
                        xPlayer.addMoney(tonumber(totale))
                        Notify(src, "Hai givvato "..totale.."$ Contanti a: "..GetPlayerName(player).." ID: "..player)
                        Notify(player, "Ti sono stati givvati "..totale.."$ Contanti da: "..GetPlayerName(src).." ID: "..src)
                    else
                        if xPlayer.getAccount(type) ~= nil  then
                            xPlayer.addAccountMoney(type,tonumber(totale))
                            Notify(src, "Hai givvato "..totale.."$ Contanti a: "..GetPlayerName(player).." ID: "..player)
                            Notify(player, "Ti sono stati givvati "..totale.."$ Contanti da: "..GetPlayerName(src).." ID: "..src)
                        end
                    end
                end
                MxM_Pj.LogSistem(src,nil,nil,false,false,"Ha givvato : "..totale.." a"..GetPlayerName(player).." ID: "..player)
            else
                Notify(src, "Inserisci una quantita\' valida")
            end
        end 
    end  
end)


RegisterServerEvent('MxM:setVehicleOwnedPlayerId')
AddEventHandler('MxM:setVehicleOwnedPlayerId', function(playerId, vehicleProps)
    local src = source
    local xTarget = ESX.GetPlayerFromId(playerId)
    if CheckGroup(src,"AddCar") or CheckIdentifier(src,"AddCar") then    
        if xTarget then
            MySQL.Async.execute('INSERT INTO '..MxM_Pj_S.AddVehicle.table..' (owner, plate, vehicle, garage_id,garage_type,in_garage) VALUES (@owner, @plate, @vehicle, @garage_id,@garage_type,@in_garage)', {
                ['@owner']   = xTarget.identifier,
                ['@plate']   = vehicleProps.plate,
                ['@vehicle'] = json.encode(vehicleProps),
                ['@garage_id'] = "",
                ["garage_type"] = "car",
                ["in_garage"] = true
            }, function(ok)
                Notify(src, "Hai givvato un auto targata "..vehicleProps.plate.."  a: "..GetPlayerName(playerId).." ID: "..playerId)
                Notify(playerId, "Ti è stata givvata un auto targata "..vehicleProps.plate.."  da: "..GetPlayerName(src).." ID: "..src)
            end)
        end
    end
end)


RegisterServerEvent("MxM:BanPlayer")
AddEventHandler("MxM:BanPlayer",function (ID ,REASON ,Value ,DurataPersonalizzata)
    local src = source
    local expire = 0 
    local reason = REASON
    local perma = false
    if ID ~= src  then
        if CheckGroup(src,"Ban") or CheckIdentifier(src,"Ban") then
            if DurataPersonalizzata == nil then
                if Value == "1g" then
                    expire = 86400 + os.time()
                elseif Value == "2g" then
                    expire = 172800  + os.time()
                elseif Value == "3g" then
                    expire = 259200  + os.time()
                elseif Value == "12ore" then
                    expire = 43200  + os.time()
                elseif Value == "1s" then
                    expire = 604800 + os.time()
                elseif Value == "perma" then
                    expire = 999999999 + os.time()
                    perma = true
                end
            else 
                local Secondi = DurataPersonalizzata * 3600 
                expire = Secondi + os.time()
            end
            if reason == nil or reason == ""  then
                reason = "Banned By Staff"
            end
            MxM_Pj.Ban(src,tonumber(ID),reason,expire,perma)
            Notify(src,"Hai bannato l Id: "..ID)
        end
    end
end)


RegisterServerEvent("MxM:KickPlayer")
AddEventHandler("MxM:KickPlayer",function (ID , REASON )
    local src = source
    if REASON == nil then REASON = "Kicked by Staff" end
     if ID ~= src  then
        if CheckGroup(src,"Kick") or CheckIdentifier(src,"Kick") then
            DropPlayer(ID, REASON)
            MxM_Pj.LogSistem(src,nil,nil,false,false,"Ha Kickato ID: "..ID.." \nNome: "..GetPlayerName(ID).." Motivo: "..REASON)
        end
    end
end)


RegisterServerEvent("MxM:SbanPlayer")
AddEventHandler("MxM:SbanPlayer",function (ID)
    local src = source
    if ID ~= nil then
        if CheckGroup(src,"Sban") or CheckIdentifier(src,"Sban") then
            local File = LoadResourceFile(GetCurrentResourceName(), "mxmban.json")
            local Table = json.decode(File)
            for index, value in pairs(Table) do
                if value.banId == ID then
                    table.remove(Table, index)
                    SaveResourceFile(GetCurrentResourceName(), 'mxmban.json', json.encode(Table, { indent = true }), -1)               
                    if src ~= nil then
                        MxM_Pj.LogSistem(src,nil,nil,false,false,"Ha Sbannato un player\n Id Ban: "..ID)
                        Notify(src,"Hai Sbannato l Id Ban: "..ID)
                    end                 
                    break
                end
            end
        end
    end
end)


Notify = function (src,msg)
    if MxM_Pj_Admin_Menu.ESX.v1 then
        local xPlayer = ESX.GetPlayerFromId(src)
        xPlayer.showNotification(msg,"inform")
    else
        print("Se non usi esx v1 Final usa il tuo sistema di notifiche")
    end
end


local Noclip = false
RegisterServerEvent("NoclipStatus")
AddEventHandler("NoclipStatus",function (arg)
    Noclip = arg
end)



RegisterCommand("sban", function(src, args, rawCommand)	
	if src ~= 0 then
	  	if CheckGroup(src,"Sban") or CheckIdentifier(src,"Sban") then
	    	if args[1] and tonumber(args[1]) then
                local File = LoadResourceFile(GetCurrentResourceName(), "mxmban.json")
                local Table = json.decode(File)
                for index, value in pairs(Table) do
                    if value.banId == tonumber(args[1]) then
                        table.remove(Table, index)
                        SaveResourceFile(GetCurrentResourceName(), 'mxmban.json', json.encode(Table, { indent = true }), -1)               
                        MxM_Pj.LogSistem(src,nil,nil,false,false,"Ha Sbannato un player\n Id Ban: "..tonumber(args[1]))     
                        Notify(src,"Hai Sbannato l Id Ban: "..tonumber(args[1]))       
                        break
                    end
                end
	    	end
	  	end
	end
end, false)


RegisterCommand("ban", function(source, args, rawCommand)	
	if source ~= 0 then
        if CheckGroup(source,"Ban") or CheckIdentifier(source,"Ban") then
	    	if tonumber(args[1]) then
                if args[2]  then
                    local expire = 999999999 + os.time()
                    MxM_Pj.Ban(source,tonumber(args[1]),args[2],expire,true)
                end              
	    	end
	  	end
	end
end, false)


RegisterCommand("tempban", function(source, args, rawCommand)	
	if source ~= 0 then
        if CheckGroup(source,"TempBan") or CheckIdentifier(source,"TempBan") then
	    	if tonumber(args[1]) then
                if args[2]  then
                    if args[3]  then
                        local expire = args[3]*86400 + os.time()
                        MxM_Pj.Ban(source,tonumber(args[1]),args[2],expire,true)
                    end
                end              
	    	end
	  	end
	end
end, false)



RegisterCommand("offlinetempban", function(source, args, rawCommand)	
	if source ~= 0 then
        if CheckGroup(source,"Offlinetempban") or CheckIdentifier(source,"Offlinetempban") then
	    	if args[1] then
                if args[2] then
                    if args[3] then
                        local File = LoadResourceFile(GetCurrentResourceName(), "mxmban.json")
                        if File ~= nil then
                            local Table = json.decode(File)
                            if type(Table) == "table" then
                                local DIO = GeneratebanId()
                                local AbanId = tonumber(DIO)
                                local PlayerName = "Offline Temp Ban"
                                local bannedbyName = GetPlayerName(source)
                                local reason = args[2]
                                local expire = args[3]*86400 + os.time()
                                if bannedbyName ~= nil then
                                    bannedbyName = GetPlayerName(source)
                                else
                                    bannedbyName = MxM_Lang["player_name_not_available"]
                                end
                                if reason ~= nil then
                                    reason = reason
                                else
                                    reason = "Offline Temp Ban"
                                end
                                local tokens = {}
                            
                            
                                table.insert(Table, {
                                    offlineban = true,
                                    bannedbyName = bannedbyName,
                                    banId = AbanId,
                                    perma = false,
                                    name = PlayerName,
                                    reason = reason,
                                    data = os.date("%x %X %p"),
                                    bannedby =  GetPlayerIdentifier(source, 1),
                                    scadenzaban = expire,
                                    identifier = {args[1]},
                                    token = tokens
                                })
                                SaveResourceFile(GetCurrentResourceName(), 'mxmban.json', json.encode(Table, { indent = true }), -1)

                                MxM_Pj.LogSistem(source,nil,nil,false,false,"Ha Bannato Offline (Temp Ban) Un Player \n Identifier: "..args[1].." \n Motivo: "..reason.." \n Ban ID: "..AbanId)
                            else
                                MxM_Pj.BanListCreator()
                            end
                        else
                            MxM_Pj.BanListCreator()
                        end  
                    end
                end         
	    	end
	  	end
	end
end, false)




RegisterCommand("offlineban", function(source, args, rawCommand)	
	if source ~= 0 then
        if CheckGroup(source,"OfflineBan") or CheckIdentifier(source,"OfflineBan") then
	    	if args[1] then
                if args[2] then
                    local File = LoadResourceFile(GetCurrentResourceName(), "mxmban.json")
                    if File ~= nil then
                        local Table = json.decode(File)
                        if type(Table) == "table" then
                            local DIO = GeneratebanId()
                            local AbanId = tonumber(DIO)
                            local PlayerName = "Offline Ban"
                            local bannedbyName = GetPlayerName(source)
                            local reason = args[2]
                            local expire = 999999999 + os.time()
                            if bannedbyName ~= nil then
                                bannedbyName = GetPlayerName(source)
                            else
                                bannedbyName = MxM_Lang["player_name_not_available"]
                            end
                            if reason ~= nil then
                                reason = reason
                            else
                                reason = "Offline Ban"
                            end
                            local tokens = {}
                           
                        
                            table.insert(Table, {
                                offlineban = true,
                                bannedbyName = bannedbyName,
                                banId = AbanId,
                                perma = true,
                                name = PlayerName,
                                reason = reason,
                                data = os.date("%x %X %p"),
                                bannedby =  GetPlayerIdentifier(source, 1),
                                scadenzaban = expire,
                                identifier = {args[1]},
                                token = tokens
                            })
                            SaveResourceFile(GetCurrentResourceName(), 'mxmban.json', json.encode(Table, { indent = true }), -1)

                            MxM_Pj.LogSistem(source,nil,nil,false,false,"Ha Bannato Offline Un Player \n Identifier: "..args[1].." \n Motivo: "..reason.." \n Ban ID: "..AbanId)
                        else
                            MxM_Pj.BanListCreator()
                        end
                    else
                        MxM_Pj.BanListCreator()
                    end  
                end         
	    	end
	  	end
	end
end, false)





RegisterCommand("bring", function(source, args, rawCommand)	
	if source ~= 0 then
	  	local xPlayer = ESX.GetPlayerFromId(source)
	  	if CheckGroup(source,"TpDate") or CheckIdentifier(source,"TpDate") then
	    	if args[1] and tonumber(args[1]) then
	      		local targetId = tonumber(args[1])
	      		local xTarget = ESX.GetPlayerFromId(targetId)
	      		if xTarget then
                    MxM.T_C_projectCallback(source, 'MxM:PrendiCoordinatePlayer', function(playerCoords)
                        MxM.T_C_projectCallback(args[1], 'MxM:TeleportToPlayer', function() end,playerCoords)
                        --TriggerClientEvent('MxM:TeleportToPlayer', args[1], playerCoords.x, playerCoords.y, playerCoords.z)
                    end)
                    MxM.T_C_projectCallback(args[1], 'MxM:PrendiCoordinatePlayer', function(targetCoords)
                        savedCoords[targetId] = targetCoords
                    end)
	      		end
	    	end
	  	end
	end
end, false)



RegisterCommand("bringback", function(source, args, rawCommand)	
	if source ~= 0 then
  		local xPlayer = ESX.GetPlayerFromId(source)
  		if CheckGroup(source,"TpDate") or CheckIdentifier(source,"TpDate") then
    		if args[1] and tonumber(args[1]) then
      			local targetId = tonumber(args[1])
      			local xTarget = ESX.GetPlayerFromId(targetId)
      			if xTarget then
        			local playerCoords = savedCoords[targetId]
        			if playerCoords then
                        MxM.T_C_projectCallback(args[1], 'MxM:TeleportToPlayer', function() end,playerCoords)
                     -- TriggerClientEvent('MxM:TeleportToPlayer', args[1], playerCoords.x, playerCoords.y, playerCoords.z)
          			savedCoords[targetId] = nil
        			end
      			end
    		end
  		end
	end
end, false)





RegisterCommand("goto", function(source, args, rawCommand)	
	if source ~= 0 then
  		local xPlayer = ESX.GetPlayerFromId(source)
        if CheckGroup(source,"TpTo") or CheckIdentifier(source,"TpTo") then
    		if args[1] and tonumber(args[1]) then
      			local targetId = tonumber(args[1])
      			local xTarget = ESX.GetPlayerFromId(targetId)
      			if xTarget then
                    MxM.T_C_projectCallback(args[1], 'MxM:PrendiCoordinatePlayer', function(targetCoords)
                        Citizen.Wait(100)
                        if not Noclip then
                            MxM.T_C_projectCallback(source, 'MxM:Noclip', function() end)
                            Citizen.Wait(100)
                            MxM.T_C_projectCallback(source, 'MxM:TeleportToPlayer', function() end,targetCoords)
                           -- TriggerClientEvent('MxM:TeleportToPlayer', source, targetCoords.x, targetCoords.y, targetCoords.z)
                            Citizen.Wait(20)
                            MxM.T_C_projectCallback(source, 'MxM:Noclip', function() end)
                        else
                            MxM.T_C_projectCallback(source, 'MxM:TeleportToPlayer', function() end,targetCoords)
                            --TriggerClientEvent('MxM:TeleportToPlayer', source, targetCoords.x, targetCoords.y, targetCoords.z)
                        end
                      
                    end)
                    MxM.T_C_projectCallback(source, 'MxM:PrendiCoordinatePlayer', function(playerCoords)
                        savedCoords[source] = playerCoords
                    end)
      			end
    		end
  		end
	end
end, false)



RegisterCommand("gotoback", function(source, args, rawCommand)	
	if source ~= 0 then
	  	local xPlayer = ESX.GetPlayerFromId(source)
	  	if CheckGroup(source,"TpTo") or CheckIdentifier(source,"TpTo") then
	    	local playerCoords = savedCoords[source]
	    	if playerCoords then
                MxM.T_C_projectCallback(source, 'MxM:TeleportToPlayer', function() end,playerCoords)
               -- TriggerClientEvent('MxM:TeleportToPlayer', source, playerCoords.x, playerCoords.y, playerCoords.z)
	      		savedCoords[source] = nil
	    	end
	  	end
	end
end, false)



RegisterCommand("heal", function(source, args, rawCommand)	
	if source ~= 0 then
	  	if CheckGroup(source,"Heal") or CheckIdentifier(source,"Heal") then
			if args[1] == nil then
                TriggerClientEvent('cd_playerhud:status:add', source ,"thirst", 100)  --thirst
				TriggerClientEvent('cd_playerhud:status:add', source ,"hunger", 100)  --hunger
                MxM_Pj.LogSistem(source,nil,nil,false,false,"Ha usato il comando /heal su se stesso")
			else
                TriggerClientEvent('cd_playerhud:status:add', args[1] ,"thirst", 100)  --thirst
				TriggerClientEvent('cd_playerhud:status:add', args[1] ,"hunger", 100)  --hunger
                MxM_Pj.LogSistem(source,nil,nil,false,false,"Ha usato il comando /heal su ID: "..args[1])
			end

	  	end
	end
end, false)



RegisterCommand("reviveall", function(source, args, rawCommand)	
	if source ~= 0 then
	  	if CheckGroup(source,"Reviveall") or CheckIdentifier(source,"Reviveall") then
            for a, f in pairs(GetPlayers()) do
                local xPlayer = ESX.GetPlayerFromId(f)
                if xPlayer then
                    TriggerClientEvent(MxM_Pj_S.ESX.ReviveTrigger,f)
                    MxM_Pj.LogSistem(source,nil,nil,false,false,"Ha usato il comando /reviveall ed ha Rianimato tutti i player")
                end
                Citizen.Wait(250)
            end
	  	end
	end
end, false)


RegisterCommand("revive", function(source, args, rawCommand)	
	if source ~= 0 then
        if args ~= nil  then
            if tonumber(args[1])  ~= nil then
                if CheckGroup(source,"Revive") or CheckIdentifier(source,"Revive") then
                    local xPlayer = ESX.GetPlayerFromId(tonumber(args[1]))
                    if xPlayer then
                        TriggerClientEvent(MxM_Pj_S.ESX.ReviveTrigger,tonumber(args[1]))
                        MxM_Pj.LogSistem(source,nil,nil,false,false,"Ha usato il comando /revive su ID: "..args[1])
                    end
                end
            end
        end
	end
end, false)



RegisterCommand("wipe", function (source, args, rawCommand)
    if source ~= nil then
        local xPlayer = ESX.GetPlayerFromId(source)  
        if CheckGroup(source,"Wipe") or CheckIdentifier(source,"Wipe") then
            if args ~= nil  then
                if args[1]  ~= nil then
                    MySQL.Async.fetchAll("SELECT identifier FROM users WHERE identifier =@id", {
                        ["@id"] = args[1]
                    }, function (result)
                        if #result ~= 0 then
                            MySQL.Async.execute("DELETE FROM users WHERE identifier=@identifier", { ["@identifier"] = result[1].identifier })
                            MySQL.Async.execute("DELETE FROM datastore_data WHERE owner=@owner", { ["@owner"] = result[1].identifier })
                            MySQL.Async.execute("DELETE FROM owned_vehicles WHERE owner=@owner", { ["@owner"] = result[1].identifier })
                            MySQL.Async.execute("DELETE FROM addon_account_data WHERE owner=@owner", { ["@owner"] = result[1].identifier })

                            Notify(source,"Wipe avvenuto con successo","success")
                            MxM_Pj.LogSistem(source,nil,nil,false,false,"Ha Wipato  Un Player \n Identifier: "..result[1].identifier)
                        else
                            Notify(source,"ERROR hai sbagliato qualche argomento riprova","error")
                        end
                    end)
                end
            end 
        else
            return
        end
    end
end, false)
