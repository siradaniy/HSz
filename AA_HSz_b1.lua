--updatefix

local versionx = "11.0.0h2"

---// Loading Section \\---
task.wait(2)
repeat task.wait() until game:IsLoaded()
if game.PlaceId == 8304191830 then
    repeat task.wait() until game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name)
    repeat task.wait() until game.Players.LocalPlayer.PlayerGui:FindFirstChild("collection"):FindFirstChild("grid"):FindFirstChild("List"):FindFirstChild("Outer"):FindFirstChild("UnitFrames")
else
    repeat task.wait() until game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name)
    game:GetService("ReplicatedStorage").endpoints.client_to_server.vote_start:InvokeServer()
    repeat task.wait() until game:GetService("Workspace")["_waves_started"].Value == true
end
---### Loading Section End ###---
------------------------------
local HttpService = game:GetService("HttpService")
local Workspace = game:GetService("Workspace")
local plr = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local mouse = game.Players.LocalPlayer:GetMouse()
local UserInputService = game:GetService("UserInputService")

getgenv().savefilename = "Anime-Adventures_HSz_UPD_"..game.Players.LocalPlayer.Name.."-"..versionx..".json"
getgenv().door = "_lobbytemplategreen1"
getgenv().doorraid = "_lobbytemplate211"
getgenv().doorjjk = "_lobbytemplate_event222"


--test fixportal

function getBorosPortals()
    local reg = getreg()

    for i,v in next, reg do
        if type(v) == 'function' then 
            if getfenv(v).script then
                    for _, v in pairs(debug.getupvalues(v)) do 
                        if type(v) == 'table' then
                            if v["session"] then
                                local portals = {}
                                for _, item in pairs(v["session"]["inventory"]['inventory_profile_data']['unique_items']) do
                                  if item["item_id"] == "portal_boros_g" then
                                    table.insert(portals, item)
                                  end
                                end
                                return portals
                            end
                        end
                    end
            end
        end
    end
end

function getCSMPortals()
    local reg = getreg() 

    for i,v in next, reg do
        if type(v) == 'function' then 
            if getfenv(v).script then 
                    for _, v in pairs(debug.getupvalues(v)) do
                        if type(v) == 'table' then
                            if v["session"] then
                                local portals = {}
                                for _, item in pairs(v["session"]["inventory"]['inventory_profile_data']['unique_items']) do
                                  if item["item_id"] == "portal_csm" then
                                    table.insert(portals, item)
                                  end
                                end
                                return portals
                            end
                        end
                    end
            end
        end
    end
end



------------item drop result
function get_inventory_items()
	for i,v in next, getgc() do
		if type(v) == 'function' then 
			if getfenv(v).script then 
				if getfenv(v).script:GetFullName() == "ReplicatedStorage.src.client.Services.NPCServiceClient" then
					for _, v in pairs(debug.getupvalues(v)) do 
						if type(v) == 'table' then
							if v["session"] then
								return v["session"]["inventory"]['inventory_profile_data']['normal_items']
							end
						end
					end
				end
			end
		end
	end
end

local Table_Items_Name_data = {}
local Old_Inventory_table = {}
for v2, v3 in pairs(game:GetService("ReplicatedStorage").src.Data.Items:GetDescendants()) do
	if v3:IsA("ModuleScript") then
		for v4, v5 in pairs(require(v3)) do
		    Table_Items_Name_data[v4] = v5.name
		end;
	end;
end;
for i,v in pairs(get_inventory_items()) do
	Old_Inventory_table[i] = v
end
---------------------end webhook

----------------Map & ID Map

local function GetCurrentLevelId()
    if game.Workspace._MAP_CONFIG then
        return game:GetService("Workspace")._MAP_CONFIG.GetLevelData:InvokeServer()["id"]
    end
end

local function GetCurrentLevelName()
    if game.Workspace._MAP_CONFIG then
        return game:GetService("Workspace")._MAP_CONFIG.GetLevelData:InvokeServer()["name"]
    end
end
----------------endMap & ID Map

--#region Webhook Sender
local function webhook()
	pcall(function()
		local url = tostring(getgenv().weburl) --webhook
		print("webhook?")
		if url == "" then return end 
        
		local Time = os.date('!*t', OSTime);

		local thumbnails_avatar = HttpService:JSONDecode(game:HttpGet("https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds=" .. game:GetService("Players").LocalPlayer.UserId .. "&size=150x150&format=Png&isCircular=true", true))


        current_wave = tostring(game:GetService("Workspace")["_wave_num"].Value)
    	XP = tostring(game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Holder.LevelRewards.ScrollingFrame.XPReward.Main.Amount.Text)
		gems = tostring(game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Holder.LevelRewards.ScrollingFrame.GemReward.Main.Amount.Text)
        if gems == "+99999" then
			gems = "+0"
		end
		gold = tostring(game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Holder.LevelRewards.ScrollingFrame.GoldReward.Main.Amount.Text)
		if gold == "+99999" then
			gold = "+0"
		end
		cwaves = game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Holder.Middle.WavesCompleted.Text
        resultx = game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Holder.Title.Text
		ctime = game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Holder.Middle.Timer.Text
        mapid = game:GetService("Workspace")._MAP_CONFIG.GetLevelData:InvokeServer()["id"]
        mapname = game:GetService("Workspace")._MAP_CONFIG.GetLevelData:InvokeServer()["name"]
		waves = cwaves:split(": ")
		ttime = ctime:split(": ")

		local TextDropLabel = ""
		local CountAmount = 1
		for i,v in pairs(get_inventory_items()) do
			if (v - Old_Inventory_table[i]) > 0 then
				for NameData, NameShow in pairs(Table_Items_Name_data) do
					if (v - Old_Inventory_table[i]) > 0 and tostring(NameData) == tostring(i) then
						TextDropLabel = TextDropLabel .. tostring(CountAmount) .. ". " .. tostring(string.gsub(i, i, NameShow)) .. " : x" .. tostring(v - Old_Inventory_table[i]) .. "\n"
						CountAmount = CountAmount + 1
					end
				end;
			end
		end
		if TextDropLabel == "" then
			TextDropLabel = "Not Have Items Drops"
		end

        --updatefix

		local data = {
			["content"] = "",
			["username"] = "Anime Adventures",
			["avatar_url"] = "https://tr.rbxcdn.com/59ef1ccab6ac14595231fcfc338c3bb7/150/150/Image/Png",
			["embeds"] = {
				{
					["author"] = {
						["name"] = "Anime Adventures |  แจ้งเตือน ✔️",
						["icon_url"] = "https://cdn.discordapp.com/emojis/997123585476927558.webp?size=96&quality=lossless"
					},
					["thumbnail"] = {
						['url'] = thumbnails_avatar.data[1].imageUrl,
					},
					["image"] = {
						['url'] = "https://tr.rbxcdn.com/bc2ea8300bfaea9fb3193d7f801f0e8b/768/432/Image/Png"
					},
					["description"] = "🎮 ||**"..game:GetService("Players").LocalPlayer.Name.."**|| 🎮",
					["color"] = 110335,
					["timestamp"] = string.format('%d-%d-%dT%02d:%02d:%02dZ', Time.year, Time.month, Time.day, Time.hour, Time.min, Time.sec),
					['footer'] = {
						['text'] = "// Made by Negative & HOLYSHz", 
						['icon_url'] = "https://yt3.ggpht.com/mApbVVD8mT92f50OJuTObnBbc3j7nDCXMJFBk2SCDpSPcaoH9DB9rxVpJhsB5SxAQo1UN2GzyA=s48-c-k-c0x00ffffff-no-rj"
					},
          ["fields"] = {
						{
                            ["name"] = "Current Level:",
                            ["value"] = tostring(game.Players.LocalPlayer.PlayerGui.spawn_units.Lives.Main.Desc.Level.Text).. " ✨",
                            ["inline"] = true		
                        }, {
							["name"] = "Total Waves:",
							["value"] = tostring(waves[2]) ..
								" <:wave:997136622363627530>",
							["inline"] = true
						}, {
                            ["name"] = "Total Time:",
                            ["value"] = tostring(ttime[2]) .. " ⌛",
                            ["inline"] = true
                        }, {
                            ["name"] = "Recieved XP:",
                            ["value"] = XP .. " 🧪",
                            ["inline"] = true
                        }, {
                            ["name"] = "Current Gems:",
                            ["value"] = tostring(game.Players.LocalPlayer._stats.gem_amount.Value).." <:gem:997123585476927558>",
                            ["inline"] = true
						}, {
                            ["name"] = "Current Gold:",
                            ["value"] = tostring(game.Players.LocalPlayer._stats.gold_amount.Value).." 💰",
                            ["inline"] = true
                        }, {
                            ["name"] = "ผลการต่อสู้:",
                            ["value"] = resultx .. " ⚔️",
                            ["inline"] = true    	
                        }, {
							["name"] = "Recieved Gems:",
							["value"] = gems .. " <:gem:997123585476927558>",
							["inline"] = true
						}, {
							["name"] = "Recieved Gold:",
							["value"] = gold .. " 💰",
							["inline"] = true  	   
                        }, {
                            ["name"] = "Map Name:",
                            ["value"] = mapname .. " 🗺️",
                            ["inline"] = falseye
                        }, {
                            ["name"] = "Map Id:",
                            ["value"] = mapid .. " 🗺️",
                            ["inline"] = falseye                       
                        }, {
                            ["name"] = "Items Drop:",
                            ["value"] = "```ini\n" .. TextDropLabel .. "```",
                            ["inline"] = falseye                  
                        }
					}
				}
			}
		}

		local porn = game:GetService("HttpService"):JSONEncode(data)

		local headers = {["content-type"] = "application/json"}
		request = http_request or request or HttpPost or syn.request or http.request
		local sex = {Url = url, Body = porn, Method = "POST", Headers = headers}
		warn("Sending webhook notification...")
		request(sex)
	end)
end
--#endregion

getgenv().UnitCache = {}

for _, Module in next, game:GetService("ReplicatedStorage"):WaitForChild("src"):WaitForChild("Data"):WaitForChild("Units"):GetDescendants() do
    if Module:IsA("ModuleScript") and Module.Name ~= "UnitPresets" then
        for UnitName, UnitStats in next, require(Module) do
            getgenv().UnitCache[UnitName] = UnitStats
        end
    end
end

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\--
--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\--
--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\--

function sex()
    -- reads jsonfile
    local jsonData = readfile(savefilename)
    local data = HttpService:JSONDecode(jsonData)

	--#region global values

    --DEVIL CITY
    getgenv().portalnameX = data.portalnameX
    getgenv().farmprotal = data.farmportal
    getgenv().buyportal = data.buyportal
    getgenv().PortalID = data.PortalID

    --Aline
    getgenv().portalnameA = data.portalnameA
    getgenv().farmaline = data.farmaline
    getgenv().PortalIDA = data.PortalIDA


    getgenv().AutoLeave = data.AutoLeave
    getgenv().AutoNext = data.AutoNext
    getgenv().AutoContinue = data.AutoContinue
    getgenv().AutoReplay = data.AutoReplay
    getgenv().AutoChallenge = data.AutoChallenge  
    getgenv().selectedreward = data.selectedreward
    getgenv().AutoChallengeAll = data.AutoChallengeAll
    getgenv().disableatuofarm = false
    getgenv().sellatwave = data.sellatwave 
    getgenv().autosell = data.autosell
    getgenv().AutoFarm = data.autofarm
    getgenv().AutoFarmIC = data.autofarmic
    getgenv().AutoFarmJJK = data.AutoFarmJJK --AutoFarmJJK
    getgenv().AutoFarmRaid = data.AutoFarmRaid --AutoFarmRaid
    getgenv().AutoFarmTP = data.autofarmtp
    getgenv().AutoLoadTP = data.autoloadtp
    getgenv().weburl = data.webhook
    getgenv().autostart = data.autostart
    getgenv().autoupgrade = data.autoupgrade
    getgenv().difficulty = data.difficulty
    getgenv().world = data.world
    getgenv().level = data.level
    --getgenv().door = data.door

    getgenv().SpawnUnitPos = data.xspawnUnitPos
    getgenv().SelectedUnits = data.xselectedUnits
    getgenv().autoabilities = data.autoabilities
	--#endregion

	---// updates the json file
	--#region update json
    function updatejson()

        local xdata = {
            --Devil City
            portalnameX = getgenv().portalnameX,
            farmportal = getgenv().farmprotal,
            buyportal = getgenv().buyportal,
            PortalID = getgenv().PortalID,

            --Aline Portal
            portalnameA = getgenv().portalnameA,
            farmaline = getgenv().farmaline,
            PortalIDA = getgenv().PortalIDA,

            -- unitname = getgenv().unitname,
            -- unitid = getgenv().unitid,
            AutoContinue = getgenv().AutoContinue,
            AutoNext = getgenv().AutoNext,
            autoloadtp = getgenv().AutoLoadTP,
            AutoLeave = getgenv().AutoLeave,
            AutoReplay = getgenv().AutoReplay,
            AutoChallenge  = getgenv().AutoChallenge, 
            selectedreward = getgenv().selectedreward,
            AutoChallengeAll = getgenv().AutoChallengeAll, 
            sellatwave = getgenv().sellatwave,
            autosell = getgenv().autosell,
            webhook = getgenv().weburl,
            autofarm = getgenv().AutoFarm,
            autofarmic = getgenv().AutoFarmIC,
            AutoFarmJJK = getgenv().AutoFarmJJK, --AutoFarmJJK
            AutoFarmRaid = getgenv().AutoFarmRaid, --AutoFarmRaid
            autofarmtp = getgenv().AutoFarmTP,
            autostart = getgenv().autostart,
            autoupgrade = getgenv().autoupgrade,
            difficulty = getgenv().difficulty,
            world = getgenv().world,
            level = getgenv().level,
            
            --door = getgenv().door,

            xspawnUnitPos = getgenv().SpawnUnitPos,
            xselectedUnits = getgenv().SelectedUnits,
            autoabilities = getgenv().autoabilities
        }

        local json = HttpService:JSONEncode(xdata)
        writefile(savefilename, json)
    end
--#endregion

    --\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\--
    --\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\--updatefix 

    -- Uilib Shits

    local exec = tostring(identifyexecutor())

    local DiscordLib = loadstring(game:HttpGet "https://raw.githubusercontent.com/siradaniy/HSz/main/DiscordLid2.lua")()
    local win = DiscordLib:Window("[HSz Member] Anime Adventures_UPD_ "..versionx.." - "..exec)
       
    if exec == "ScriptWare" then
        print("Good boi")
    else
        local homeserver = win:Server("Support Member Ship!", "http://www.roblox.com/asset/?id=12281640494")
        local home = homeserver:Channel(" HOLYSHz Member Only")
        home:Label("Welcome "..game:GetService("Players").LocalPlayer.Name.." ")
        home:Label("Thank for Support")
        home:Label("อย่าลืมต่อ Member กันด้วยละ")
        home:Label("Fix Update "..versionx.."")
        home:Label("[+]Fix Devil & Aline Portal cab open \n[+]Add JJK Finger Dungeon Farm ")
        home:Label(" ")

        home:Button("👉 Copy HOLYSHz Member Link!", function()
            setclipboard("https://www.youtube.com/channel/UC8IbVYA7y2q67zcsgsWbycA/join")
            DiscordLib:Notification("Copied!!", "✔ ลิ้งสมัคร Member ของ HOLYSHz Copy ไว้แล้ว เอาไปวางแล้วกดสมัครได้เลย!!", "Okay!")
        end)
    end

    local autofrmserver = win:Server("⚙️Auto Farm Section", "http://www.roblox.com/asset/?id=11347197194")
    local webhookserver = win:Server("🌐Discord Wehhook  ", "http://www.roblox.com/asset/?id=10507357657")
    local macroserver = win:Server("Discord   ", "http://www.roblox.com/asset/?id=8387379647")
    local youtubesserver = win:Server("Youtube         ", "http://www.roblox.com/asset/?id=1275974017")
    local starbuxserver = win:Server("StarBux         ", "http://www.roblox.com/asset/?id=12281970113")


    if game.PlaceId == 8304191830 then

        local unitselecttab = autofrmserver:Channel("🧙‍ Select Units")
        local slectworld = autofrmserver:Channel("🌏 Select World")
        local devilcity = autofrmserver:Channel("😈 Devil City")
        local alinecity = autofrmserver:Channel("👽 Aline Portal")
        local autofarmtab = autofrmserver:Channel("🤖 Auto Farm")
        local autoclngtab = autofrmserver:Channel("⌛ Auto Challenge")
    

--------------------------------------------------
--------------- Select Units Tab -----------------
--------------------------------------------------
--#region Select Units Tab
        local Units = {}
        local profile_data = { equipped_units = {} }; repeat
            do
                for i, v in pairs(getgc(true)) do
                    if type(v) == "table" and rawget(v, "xp") then wait()
                        table.insert(profile_data.equipped_units, v)
                    end
                end
            end
        until #profile_data.equipped_units > 0
    
        local function LoadUnits()
            local DataUnits = require(game:GetService("ReplicatedStorage").src.Data.Units)
            table.clear(Units)
            for i, v in pairs(profile_data.equipped_units) do
                if DataUnits[v.unit_id] then
                    table.insert(Units, DataUnits[v.unit_id].name .. " #" .. tostring(v.uuid))
                end
            end
        end
        LoadUnits()

        local function Check()
            local DataUnits = require(game:GetService("ReplicatedStorage").src.Data.Units)

            for i, v in pairs(profile_data.equipped_units) do
                if DataUnits[v.unit_id] and v.equipped_slot then
                    getgenv().SelectedUnits["U"..tostring(v.equipped_slot)] = tostring(DataUnits[v.unit_id].name) .. " #" .. tostring(v.uuid)
                end
            end
            updatejson()
        end

        local function Equip()
            game:GetService("ReplicatedStorage").endpoints.client_to_server.unequip_all:InvokeServer()
            
            for i = 1, 6 do
                local unitinfo = getgenv().SelectedUnits["U" .. i]
                warn(unitinfo)
                if unitinfo ~= nil then
                    local unitinfo_ = unitinfo:split(" #")
                    task.wait(0.5)
                    game:GetService("ReplicatedStorage").endpoints.client_to_server.equip_unit:InvokeServer(unitinfo_[2])
                end
            end
            updatejson()
        end

        unitselecttab:Button("เลือก Units ที่ใส่อยู่ตอนนี้", function()
            DiscordLib:Notification("ใส่ Units ที่เลือกแล้ว!", "เมนูแบบเลื่อนลงอาจไม่แสดงชื่อหน่วยในขณะนี้ แต่จะแสดงในครั้งต่อไปที่คุณดำเนินการ!", "Okay!")
            Check()
        end)

        local drop = unitselecttab:Dropdown("Unit 1", Units, getgenv().SelectedUnits["U1"], function(bool)
            getgenv().SelectedUnits["U1"] = bool
            Equip()
        end)

        local drop2 = unitselecttab:Dropdown("Unit 2", Units, getgenv().SelectedUnits["U2"], function(bool)
            getgenv().SelectedUnits["U2"] = bool
            Equip()
        end)

        local drop3 = unitselecttab:Dropdown("Unit 3", Units, getgenv().SelectedUnits["U3"], function(bool)
            getgenv().SelectedUnits["U3"] = bool
            Equip()
        end)

        local drop4 = unitselecttab:Dropdown("Unit 4", Units, getgenv().SelectedUnits["U4"], function(bool)
            getgenv().SelectedUnits["U4"] = bool
            Equip()
        end)

        local axx =  game.Players.LocalPlayer.PlayerGui["spawn_units"].Lives.Main.Desc.Level.Text:split(" ")
        _G.drop5 = nil
        _G.drop6 = nil
        if tonumber(axx[2]) >= 20 then
            _G.drop5 = unitselecttab:Dropdown("Unit 5", Units, getgenv().SelectedUnits["U5"], function(bool)
                getgenv().SelectedUnits["U5"] = bool
                Equip()
            end)
        end

        if tonumber(axx[2]) >= 50 then
            _G.drop6 = unitselecttab:Dropdown("Unit 6", Units, getgenv().SelectedUnits["U6"], function(bool)
                getgenv().SelectedUnits["U6"] = bool
                Equip()
            end)
        end
--------------// Refresh Unit List \\------------- 
        unitselecttab:Button("Refresh Unit List", function()
            drop:Clear()
            drop2:Clear()
            drop3:Clear()
            drop4:Clear()
            if _G.drop5 ~= nil then
                _G.drop5:Clear()
            end
            if _G.drop6 ~= nil then
                _G.drop6:Clear()
            end 

            LoadUnits()
            game:GetService("ReplicatedStorage").endpoints.client_to_server.unequip_all:InvokeServer()
            for i, v in ipairs(Units) do
                drop:Add(v)
                drop2:Add(v)
                drop3:Add(v)
                drop4:Add(v)
                if _G.drop5 ~= nil then
                    _G.drop5:Add(v)
                end
                if _G.drop6 ~= nil then
                    _G.drop6:Add(v)
                end 
            end
            getgenv().SelectedUnits = {
                U1 = nil,
                U2 = nil,
                U3 = nil,
                U4 = nil,
                U5 = nil,
                U6 = nil
            }
        end) 
        unitselecttab:Label(" ")
        unitselecttab:Label(" ")
--#endregion

--------------------------------------------------
--------------- Select World Tab ----------------- updatefix fixmap
--------------------------------------------------
--#region Select world tab
        getgenv().levels = {"nill"}

        getgenv().diff = slectworld:Dropdown("เลือกระดับ [ต้องเลือกให้ตรงกับด่าน ไม่งั้นมันจะไม่วาป]", {"Normal", "Hard"}, getgenv().difficulty, function(diff)
            getgenv().difficulty = diff
            updatejson()
        end)

        local worlddrop = slectworld:Dropdown("Select World", {"Plannet Namak", "Shiganshinu District", "Snowy Town","Hidden Sand Village", "Marine's Ford",
        "Ghoul City", "Hollow World", "Ant Kingdom", "Magic Town", "Cursed Academy","Clover Kingdom", "Clover Legend - HARD","Hollow Legend - HARD","Cape Canaveral",
        "JoJo Legend - HARD","Alien Spaceship","[RAID] West City","[RAID] Infinity Train","[RAID] Hidden Sand Village","[RAID] Shiganshinu District",
        "[RAID] Storm Hideout","Fabled Kingdom","Fabled Kingdom (Ten Commandments)"}, getgenv().world, function(world)
            getgenv().world = world
            updatejson()
            if world == "Plannet Namak" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"namek_infinite", "namek_level_1", "namek_level_2", "namek_level_3",
                                    "namek_level_4", "namek_level_5", "namek_level_6"}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end
            elseif world == "Shiganshinu District" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"aot_infinite", "aot_level_1", "aot_level_2", "aot_level_3", "aot_level_4",
                                    "aot_level_5", "aot_level_6"}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end
            elseif world == "Snowy Town" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"demonslayer_infinite", "demonslayer_level_1", "demonslayer_level_2",
                                    "demonslayer_level_3", "demonslayer_level_4", "demonslayer_level_5",
                                    "demonslayer_level_6"}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end
            elseif world == "Hidden Sand Village" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"naruto_infinite", "naruto_level_1", "naruto_level_2", "naruto_level_3",
                                    "naruto_level_4", "naruto_level_5", "naruto_level_6"}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end
            elseif world == "Marine's Ford" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"marineford_infinite","marineford_level_1","marineford_level_2","marineford_level_3",
                "marineford_level_4","marineford_level_5","marineford_level_6",}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end
            elseif world == "Ghoul City" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"tokyoghoul_infinite","tokyoghoul_level_1","tokyoghoul_level_2","tokyoghoul_level_3",
                                    "tokyoghoul_level_4","tokyoghoul_level_5","tokyoghoul_level_6",}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end
            elseif world == "Hollow World" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"hueco_infinite","hueco_level_1","hueco_level_2","hueco_level_3",
                                    "hueco_level_4","hueco_level_5","hueco_level_6",}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end
            elseif world == "Ant Kingdom" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"hxhant_infinite","hxhant_level_1","hxhant_level_2","hxhant_level_3",
                                    "hxhant_level_4","hxhant_level_5","hxhant_level_6",}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end
               
            elseif world == "Magic Town" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"magnolia_infinite","magnolia_level_1","magnolia_level_2","magnolia_level_3",
                                    "magnolia_level_4","magnolia_level_5","magnolia_level_6",}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end
            elseif world == "Cursed Academy" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"jjk_infinite","jjk_level_1","jjk_level_2","jjk_level_3",
                                    "jjk_level_4","jjk_level_5","jjk_level_6",}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end
            elseif world == "Clover Kingdom" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"clover_infinite","clover_level_1","clover_level_2","clover_level_3",
                                    "clover_level_4","clover_level_5","clover_level_6",}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end
            elseif world == "Clover Legend - HARD" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"clover_legend_1","clover_legend_2","clover_legend_3",}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end
            elseif world == "Hollow Legend - HARD" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"bleach_legend_1","bleach_legend_2","bleach_legend_3","bleach_legend_4","bleach_legend_5","bleach_legend_6",}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end
            elseif world =="Cape Canaveral" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"jojo_infinite","jojo_level_1","jojo_level_2","jojo_level_3","jojo_level_4","jojo_level_5","jojo_level_6",}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end
            elseif world =="JoJo Legend - HARD" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"jojo_legend_1","jojo_legend_2","jojo_legend_3",}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end	        
            elseif world =="Alien Spaceship" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"opm_infinite","opm_level_1","opm_level_2","opm_level_3","opm_level_4","opm_level_5","opm_level_6",}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end
            elseif world =="[RAID] West City" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"west_city_raid"}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end    
            elseif world =="[RAID] Infinity Train" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"demonslayer_raid_1"}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end 
            elseif world =="[RAID] Hidden Sand Village" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"naruto_raid_1"}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end 
            elseif world =="[RAID] Shiganshinu District" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"aot_raid_1"}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end  
            elseif world =="[RAID] Storm Hideout" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"uchiha_level_1","uchiha_level_2","uchiha_level_3","uchiha_level_4","uchiha_level_5"}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end 
            elseif world =="Fabled Kingdom" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"7ds_infinite","7ds_level_1","7ds_level_2","7ds_level_3","7ds_level_4","7ds_level_5","7ds_level_6"}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end    
            elseif world =="Fabled Kingdom (Ten Commandments)" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"7ds_legend_1","7ds_legend_2","7ds_legend_3"}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end                        
            end
        end)


        ---updatefix fixmap
      
            getgenv().leveldrop = slectworld:Dropdown("Select Level", getgenv().levels, getgenv().level, function(level)
            getgenv().level = level
            updatejson()
            
        end)
--#endregion

------Devil City

getgenv().portalname = devilcity:Dropdown("Select Portal", {"csm_contract_0", "csm_contract_1","csm_contract_2","csm_contract_3","csm_contract_4","csm_contract_5"}, getgenv().portalnameX, function(pornname)
    getgenv().portalnameX = pornname
    updatejson()
end)

devilcity:Button("Buy Devil Portal", function(bool)
    local string_1 = getgenv().portalnameX
    local Target = game:GetService("ReplicatedStorage").endpoints["client_to_server"]["buy_csmportal_shop_item"];
    Target:InvokeServer(string_1);
end)

devilcity:Toggle("Auto Farm Devil Portal", getgenv().farmprotal, function(bool)
    getgenv().farmprotal = bool
    updatejson()
end)

devilcity:Label("เฉพาะประตูที่ปลดล็อค Rank แล้วเท่านั้น")
devilcity:Label("หากมีประตูเก่า มันอาจจะเริ่มทำงาน ดังนั้นอย่าซื้อประตูระดับต่ำที่คุณไม่ต้องการทำฟาร์ม.")

-- Aline Portal ------------------------------------

getgenv().portalnameA = alinecity:Dropdown("Select Portal", {"boros_ship_portal"}, getgenv().portalnameA, function(pornname)
    getgenv().portalnameA = pornname
    updatejson()
end)

alinecity:Toggle("Auto Farm Aline Portal", getgenv().farmaline, function(bool)
    getgenv().farmaline = bool
    updatejson()
end)

alinecity:Label("ต้องมีประตูในกระเป๋าเท่านั้น ฟาร์มได้จาก inf Aline Spacship.")

--------------------------------------------------
------------------ Auto Farm Tab -----------------AutoFarmJJK
--------------------------------------------------
--#region Auto Farm Tab
autofarmtab:Label("```DUNGEON JJK Finger ดันนิ้วสุคุนะ```")

autofarmtab:Toggle("Auto Start JJK เปิดฟาร์ม ดันนิ้ว", getgenv().AutoFarmJJK, function(bool)
    getgenv().AutoFarmJJK = bool
    updatejson()
end)

autofarmtab:Label("```Infinity Castle หอคอย```")

autofarmtab:Toggle("Auto Next Level หอคอย", getgenv().AutoContinue, function(bool)
    getgenv().AutoContinue = bool
    updatejson()
end)

autofarmtab:Toggle("Auto Start หอคอย", getgenv().AutoFarmIC, function(bool)
    getgenv().AutoFarmIC = bool
    updatejson()
end)

autofarmtab:Label("```ฟังชั่น Auto Start Story,Inf & Raid```")

autofarmtab:Toggle("Auto Start Raid เปิดฟาร์ม RAID", getgenv().AutoFarmRaid, function(bool)
    getgenv().AutoFarmRaid = bool
    updatejson()
end)

autofarmtab:Toggle("Auto Start Story & Inf เปิดฟาร์ม ธรรมดา", getgenv().autostart, function(bool)
    getgenv().autostart = bool
    updatejson()
end)

autofarmtab:Toggle("Auto Next Story ถัดไป", getgenv().AutoNext, function(bool)
    getgenv().AutoNext = bool
    updatejson()
end)

autofarmtab:Toggle("Auto Replay เล่นซ้ำ", getgenv().AutoReplay, function(bool)
    getgenv().AutoReplay = bool
    updatejson()
end)


autofarmtab:Toggle("Auto Leave ออก", getgenv().AutoLeave, function(bool)
    getgenv().AutoLeave = bool
    updatejson()
end)

autofarmtab:Toggle("Auto Farm วางตัว [ต้องเปิด]", getgenv().AutoFarm, function(bool)
    getgenv().AutoFarm = bool
    updatejson()
end)

autofarmtab:Toggle("Auto Abilities ใช้สกิล", getgenv().autoabilities, function(bool)
    getgenv().autoabilities = bool
    updatejson()
end)

autofarmtab:Toggle("Auto Upgrade Units อัปตัว", getgenv().autoupgrade, function(bool)
    getgenv().autoupgrade = bool
    updatejson()
end)

autofarmtab:Toggle("Auto Sell ขายเมื่อถึง Wave", getgenv().autosell, function(x)
    getgenv().autosell = x
    updatejson()
    if getgenv().autosell == false then
        getgenv().disableatuofarm = false
    end
end)

        ---- 
        autofarmtab:Textbox("ใส่ตัวเลขเพื่อ Auto Sell {ใส่เลขแล้วกด Enter}", tostring(getgenv().sellatwave), false, function(t)
            getgenv().sellatwave = tonumber(t)
            updatejson()
        end)
        
        local autoloadtab = autofrmserver:Channel("⌛ Auto Load Script")
    autoloadtab:Label("รันสคริปต์โดยอัตโนมัติเมื่อออกจากMap.")
    autoloadtab:Label("ไม่จำเป็นต้องใส่สคริปต์ในโฟลเดอร์ AutoExec!")
    autoloadtab:Toggle("Auto Load Script", getgenv().AutoLoadTP, function(bool)
        --queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/siradaniy/HSz/main/AA_HSz_b1.lua'))()")
        getgenv().AutoLoadTP = bool
        updatejson()
        if exec == "Synapse X" and getgenv().AutoLoadTP then
            syn.queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/siradaniy/HSz/main/AA_HSz_b1.lua'))()")
        elseif exec ~= "Synapse X" and getgenv().AutoLoadTP then
            queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/siradaniy/HSz/main/AA_HSz_b1.lua'))()")
        end

    end)
    autoloadtab:Label("⚠️ หากสคริปต์ทำงานไม่ถูกต้องให้ใส่สคริปต์เข้าไป Autoexec\nfolder!!! ⚠️")

    

    local webhooktab = webhookserver:Channel("🌐 Webhook")
    webhooktab:Label("Webhook จะส่งแจ้งเตือนทุกครั้งที่เกมจบลง!")
		
		local webhoolPlaceholder
		if getgenv().weburl == "" then
			webhoolPlaceholder = "Insert url here!"
		else
			webhoolPlaceholder = getgenv().weburl
		end
		webhooktab:Textbox("Webhook URL {Press Enter}" , webhoolPlaceholder, false, function(web_url)
            getgenv().weburl = web_url
            updatejson()
        end)
        webhooktab:Button("Test Webhook", function()
            webhook()
        end)

        autofarmtab:Label(" ")
        autofarmtab:Label(" ")
        autofarmtab:Label(" ")
        autofarmtab:Label(" ")
--#endregion
--------------------------------------------------
-------------------- Auto Challenge --------------
--------------------------------------------------
--#region Auto Challenge
        autoclngtab:Toggle("Auto Challenge", getgenv().AutoChallenge, function(bool)
            getgenv().AutoChallenge = bool
            updatejson()
        end)
        local worlddrop = autoclngtab:Dropdown("Select Reward", {"star_fruit_random","star_remnant","gems", "gold"}, getgenv().selectedreward, function(reward)
            getgenv().selectedreward = reward
            updatejson()
        end)

        autoclngtab:Toggle("Farm All Rewards", getgenv().AutoChallengeAll, function(bool)
            getgenv().AutoChallengeAll = bool
            updatejson()
        end)
--#endregion
--------------------------------------------------
-------------------- Auto Buy/Sell ---------------
--------------------------------------------------
--#region Auto Buy/Sell
        getgenv().UnitSellTog = false
        getgenv().autosummontickets = false
        getgenv().autosummongem = false
        getgenv().autosummongem10 = false

        getgenv().autosummonticketse = false
        getgenv().autosummongeme = false
        getgenv().autosummongem10e = false

        local misc = autofrmserver:Channel("💸 Auto Buy/Sell")


        local function autobuyfunc(xx, item)
            task.wait()

            local args = {
                [1] = xx,
                [2] = item
            }
            game:GetService("ReplicatedStorage").endpoints.client_to_server.buy_from_banner:InvokeServer(unpack(args))
            
        end

        misc:Label("Special - 2x Mythic")
        misc:Toggle("Auto Summon {ใช้ตั๋ว 1}", getgenv().autosummonticketse, function(bool)
            getgenv().autosummonticketse = bool
            while getgenv().autosummonticketse do
                autobuyfunc("EventClover", "ticket")
            end
            updatejson()
        end)

        misc:Toggle("Auto Summon {เพชร 1}", getgenv().autosummongeme, function(bool)
            getgenv().autosummongeme = bool
            while getgenv().autosummongeme do
                autobuyfunc("EventClover", "gems")
            end
            updatejson()
        end)

        misc:Toggle("Auto Summon {เพชร 10}", getgenv().autosummongem10e, function(bool)
            getgenv().autosummongem10 = bool
            while getgenv().autosummongem10 do
                autobuyfunc("EventClover", "gems10")
            end
            updatejson()
        end)
        misc:Label("Standard")
        misc:Toggle("Auto Summon {ใช้ตั๋ว 1}", getgenv().autosummontickets, function(bool)
            getgenv().autosummontickets = bool
            while getgenv().autosummontickets do
                autobuyfunc("Standard", "ticket")
            end
            updatejson()
        end)

        misc:Toggle("Auto Summon {เพชร 1}", getgenv().autosummongem, function(bool)
            getgenv().autosummongem = bool
            while getgenv().autosummongem do
                autobuyfunc("Standard", "gems")
            end
            updatejson()
        end)

        misc:Toggle("Auto Summon {เพชร 10}", getgenv().autosummongem10, function(bool)
            getgenv().autosummongem10 = bool
            while getgenv().autosummongem10 do
                autobuyfunc("Standard", "gems10")
            end
            updatejson()
        end)

        misc:Label("Sell Units")
        local utts = misc:Dropdown("Select Rarity", {"Rare", "Epic"}, getgenv().UnitToSell, function(u)
            getgenv().UnitToSell = u
        end)

        misc:Toggle("Auto Sell Units", getgenv().UnitSellTog, function(bool)
            getgenv().UnitSellTog = bool
        end) 
--#endregion
--------------------------------------------------
--------------------------------------------------
--------------------------------------------------
--#region --- Inside match ---
    else -- When in a match
        game.Players.LocalPlayer.PlayerGui.MessageGui.Enabled = false
        game:GetService("ReplicatedStorage").packages.assets["ui_sfx"].error.Volume = 0
        game:GetService("ReplicatedStorage").packages.assets["ui_sfx"].error_old.Volume = 0


        local autofarmtab = autofrmserver:Channel("🤖 Auto Farm")
        local devilcity = autofrmserver:Channel("😈 Devil City")
        local alinecity = autofrmserver:Channel("👽 Aline Portal")
        local autoclngtab = autofrmserver:Channel("🎯 Auto Challenge")
        local autoloadtab = autofrmserver:Channel("⌛ Auto Load Script_")
        local autoseltab = autofrmserver:Channel("💸 Auto Sell")
        local webhooktab = webhookserver:Channel("🌐 Webhook")

    
	autoloadtab:Label("รันสคริปต์โดยอัตโนมัติเมื่อออกจากMap.")
    autoloadtab:Label("ไม่จำเป็นต้องใส่สคริปต์ในโฟลเดอร์ AutoExec!")
    autoloadtab:Toggle("Auto Load Script", getgenv().AutoLoadTP, function(bool)
            getgenv().AutoLoadTP = bool
            updatejson()
            if exec == "Synapse X" and getgenv().AutoLoadTP then
                syn.queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/siradaniy/HSz/main/AA_HSz_b1.lua'))()")
            elseif exec ~= "Synapse X" and getgenv().AutoLoadTP then
                queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/siradaniy/HSz/main/AA_HSz_b1.lua'))()")
            end

        end)
        autoloadtab:Label("⚠️ หากสคริปต์ทำงานไม่ถูกต้องให้ใส่สคริปต์เข้าไป Autoexec\nfolder!!! ⚠️")







    getgenv().portalname = devilcity:Dropdown("Select Portal", {"csm_contract_0", "csm_contract_1","csm_contract_2","csm_contract_3","csm_contract_4","csm_contract_5"}, getgenv().portalnameX, function(pornname)
        getgenv().portalnameX = pornname
        updatejson()
    end)
    
    devilcity:Button("Buy Portal", function()
        if getgenv().buyportal then
            local args = {
                [1] = tostring(getgenv().portalnameX)
            }
            
            game:GetService("ReplicatedStorage").endpoints.client_to_server.buy_csmportal_shop_item:InvokeServer(unpack(args))
        end
    end)
    
    devilcity:Toggle("Auto Farm ประตู Devil", getgenv().farmportal, function(bool)
        getgenv().farmportal = bool
        updatejson()
    end)
    
    devilcity:Label("เฉพาะประตูที่ปลดล็อค Rank แล้วเท่านั้น")
    devilcity:Label("หากมีประตูเก่า มันอาจจะเริ่มทำงาน ดังนั้นอย่าซื้อประตูระดับต่ำที่คุณไม่ต้องการฟาร์ม.")

    -- Aline Portal

    getgenv().portalnameA = alinecity:Dropdown("Select Portal", {"boros_ship_portal"}, getgenv().portalnameA, function(pornname)
        getgenv().portalnameA = pornname
        updatejson()
    end)

    alinecity:Toggle("Auto Farm Aline Portal", getgenv().farmaline, function(bool)
        getgenv().farmaline = bool
        updatejson()
    end)

    alinecity:Label("ต้องมีประตูในกระเป๋าเท่านั้น ฟาร์มได้จาก inf Aline Spacship.")


        

        
--#region Auto Farm Tab

autofarmtab:Label("```DUNGEON JJK Finger ดันนิ้วสุคุนะ```")

autofarmtab:Toggle("Auto Start JJK เปิดฟาร์ม ดันนิ้ว", getgenv().AutoFarmJJK, function(bool)
    getgenv().AutoFarmJJK = bool
    updatejson()
end)

autofarmtab:Label("```Infinity Castle หอคอย```")

autofarmtab:Toggle("Auto Next Level หอคอย", getgenv().AutoContinue, function(bool)
    getgenv().AutoContinue = bool
    updatejson()
end)

autofarmtab:Toggle("Auto Start หอคอย", getgenv().AutoFarmIC, function(bool)
    getgenv().AutoFarmIC = bool
    updatejson()
end)

autofarmtab:Label("```ฟังชั่น Auto Start Story,Inf & Raid```")

autofarmtab:Toggle("Auto Start Raid เปิดฟาร์ม RAID", getgenv().AutoFarmRaid, function(bool)
    getgenv().AutoFarmRaid = bool
    updatejson()
end)

autofarmtab:Toggle("Auto Start Story & Inf เปิดฟาร์ม ธรรมดา", getgenv().autostart, function(bool)
    getgenv().autostart = bool
    updatejson()
end)

autofarmtab:Toggle("Auto Next Story ถัดไป", getgenv().AutoNext, function(bool)
    getgenv().AutoNext = bool
    updatejson()
end)
autofarmtab:Toggle("Auto Replay เล่นซ้ำ", getgenv().AutoReplay, function(bool)
    getgenv().AutoReplay = bool
    updatejson()
end)
autofarmtab:Toggle("Auto Leave ออก", getgenv().AutoLeave, function(bool)
    getgenv().AutoLeave = bool
    updatejson()
end)

autofarmtab:Toggle("Auto Farm วางตัว [ต้องเปิด]", getgenv().AutoFarm, function(bool)
    getgenv().AutoFarm = bool
    updatejson()
end)

autofarmtab:Toggle("Auto Abilities ใช้สกิล", getgenv().autoabilities, function(bool)
    getgenv().autoabilities = bool
    updatejson()
end)

autofarmtab:Toggle("Auto Upgrade Units อัปตัว", getgenv().autoupgrade, function(bool)
    getgenv().autoupgrade = bool
    updatejson()
end)

--updatefix mapfix

function MouseClick(UnitPos)
    local connection
	local GetLevelData = game.workspace._MAP_CONFIG:WaitForChild("GetLevelData"):InvokeServer()
    local _map = game:GetService("Workspace")["_BASES"].player.base["fake_unit"]:WaitForChild("HumanoidRootPart")

    task.wait(0.5)
    local x = getgenv().posX
    local z = getgenv().posZ

    connection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            connection:Disconnect()
            local a = Instance.new("Part", game.Workspace)
            a.Size = Vector3.new(1, 1, 1)
            a.Material = Enum.Material.Neon
            a.Position = mouse.hit.p
            task.wait()
            a.Anchored = true
            DiscordLib:Notification("Spawn Unit Posotion:", tostring(a.Position), "Okay!")
            a.CanCollide = false
            for i = 0, 1, 0.1 do
                a.Transparency = i
                task.wait()
            end
            a:Destroy()

            world = GetLevelData.world or GetLevelData.name
            print(world)
            getgenv().SpawnUnitPos[tostring(world)][UnitPos]["x"] = a.Position.X
            getgenv().SpawnUnitPos[tostring(world)][UnitPos]["y"] = a.Position.Y
            getgenv().SpawnUnitPos[tostring(world)][UnitPos]["z"] = a.Position.Z
			
            updatejson()
        end
    end)
end
        ----updatefix fixmap
        --// Set Position \\--
        autofarmtab:Button("Set จุดวางตัว Unit 1", function()
            DiscordLib:Notification("Set จุดวางตัวที่ 1 ",
                "คลิ๊ก บนแผนที่ ในจุดที่จะวางตัวละคร!\n (ห้ามกด \"Done\" เพราะมันจะเซ็ทจุด)",
                "Done")
                warn(1)
            MouseClick("UP1")
            warn(2)
        end)

        autofarmtab:Button("Set จุดวางตัว Unit 2", function()
            DiscordLib:Notification("Set จุดวางตัว Unit 2 ",
                "คลิ๊ก บนแผนที่ ในจุดที่จะวางตัวละคร!\n (ห้ามกด \"Done\" เพราะมันจะเซ็ทจุด)",
                "Done")
            MouseClick("UP2")
        end)
        autofarmtab:Button("Set จุดวางตัว Unit 3", function()
            DiscordLib:Notification("Set จุดวางตัว Unit 3 ",
                "คลิ๊ก บนแผนที่ ในจุดที่จะวางตัวละคร!\n (ห้ามกด \"Done\" เพราะมันจะเซ็ทจุด)",
                "Done")
            MouseClick("UP3")
        end)
        autofarmtab:Button("Set จุดวางตัว Unit 4", function()
            DiscordLib:Notification("Set จุดวางตัว Unit 4 ",
                "คลิ๊ก บนแผนที่ ในจุดที่จะวางตัวละคร!\n (ห้ามกด \"Done\" เพราะมันจะเซ็ทจุด)",
                "Done")
            MouseClick("UP4")
        end)

        
        local axxc = game.Players.LocalPlayer.PlayerGui["spawn_units"].Lives.Main.Desc.Level.Text:split(" ")

        if tonumber(axxc[2]) >= 20 then
            autofarmtab:Button("Set จุดวางตัว Unit 5", function()
                DiscordLib:Notification("Set จุดวางตัว Unit 5 ",
                    "คลิ๊ก บนแผนที่ ในจุดที่จะวางตัวละคร!\n (ห้ามกด \"Done\" เพราะมันจะเซ็ทจุด)",
                    "Done")
                MouseClick("UP5")
            end)
        end

        if tonumber(axxc[2]) >= 50 then
            autofarmtab:Button("Set จุดวางตัว Unit 6", function()
                DiscordLib:Notification("Set จุดวางตัว Unit 6 ",
                    "คลิ๊ก บนแผนที่ ในจุดที่จะวางตัวละคร!\n (ห้ามกด \"Done\" เพราะมันจะเซ็ทจุด)",
                    "Done")
                MouseClick("UP6")
            end)
        end


        -- set unit position end--
        autofarmtab:Label("--- Saved Config (Doesn't Refresh) ---")
        autofarmtab:Label("Auto Sell at Wave: " .. tostring(getgenv().sellatwave))
        autofarmtab:Label("Webhook: " .. tostring(getgenv().weburl))
        autofarmtab:Label("Auto Farm: " .. tostring(getgenv().AutoFarm))
        autofarmtab:Label("Auto Start: " .. tostring(getgenv().autostart))
        autofarmtab:Label("Auto Sell: " .. tostring(getgenv().autosell))
        autofarmtab:Label("Auto Upgrade: " .. tostring(getgenv().autoupgrade))
        autofarmtab:Label("Difficulty: " .. tostring(getgenv().difficulty))
        autofarmtab:Label("Selected World: " .. tostring(getgenv().world))
        autofarmtab:Label("Selected Level: " .. tostring(getgenv().level))
        autofarmtab:Label(" ")
        autofarmtab:Label(" ")

--#endregion

--#region Auto Challenge 
autoclngtab:Toggle("Auto Challenge", getgenv().AutoChallenge, function(bool)
    getgenv().AutoChallenge = bool
    updatejson()
end)
local worlddrop = autoclngtab:Dropdown("Select Reward", {"star_fruit_random","star_remnant","gems", "gold"}, getgenv().selectedreward, function(reward)
    getgenv().selectedreward = reward
    updatejson()
end)

autoclngtab:Toggle("Farm All Rewards", getgenv().AutoChallengeAll, function(bool)
    getgenv().AutoChallengeAll = bool
    updatejson()
end)
--#endregion

--#region Auto Sell Tab
autoseltab:Toggle("Auto Sell ขายเมื่อถึง Wave", getgenv().autosell, function(x)
    getgenv().autosell = x
    updatejson()
    if getgenv().autosell == false then
        getgenv().disableatuofarm = false
    end
end)

autoseltab:Textbox("ใส่ตัวเลขเพื่อ Auto Sell {ใส่เลขแล้วกด Enter", getgenv().sellatwave, false, function(t)
    getgenv().sellatwave = tonumber(t)
    updatejson()
end)
--#endregion



--#region Webhook
		--//Webhook Tab (in-game)\\--
		webhooktab:Label("Webhook จะส่งแจ้งเตือน ทุกครั้ง ที่จบรอบ.")
		local webhoolPlaceholder
		if getgenv().weburl == "" then
			webhoolPlaceholder = "Insert url here!"
		else
			webhoolPlaceholder = getgenv().weburl
		end
		webhooktab:Textbox("Webhook URL {Press Enter}" , webhoolPlaceholder, false, function(web_url)
            getgenv().weburl = web_url
            updatejson()
        end)
        webhooktab:Button("Test Webhook", function()
            webhook()
        end)
--#endregion


    end
--#endregion  Discord
local macro = macroserver:Channel("👾 Discord ")
macro:Label("Discord HOLYSHz - Community นะครับ")
macro:Label("เข้ามาแล้ว ต้องทำตัวดี ๆ นะงั๊บ")
macro:Button("👉 HOLYSHz Discord Link!", function()
    setclipboard("https://discord.gg/6V8nzm5ZYB")
    DiscordLib:Notification("Copied!!", "✔ คำเชิญ Discord ถูก Copy แล้ว!!", "Okay!")
end)

--#region Youtube
local youtubes = youtubesserver:Channel("✨ Youtube")
youtubes:Label("ช่อง HOLYSHz นะครับ")
youtubes:Label("กดติดตาม ไว้เป็นกำลังใจให้กันด้วยนะครับ")
youtubes:Label("ถ้าใจดีก็สมัครสมาชิกช่องด้วยนะครับ มี 3 ราคา ให้เลือกเลย")
youtubes:Button("👉 HOLYSHz Youtube Link!", function()
    setclipboard("https://www.youtube.com/@HOLYSHz")
    DiscordLib:Notification("Copied!!", "✔ Link ช่อง Youtube ถูก Copy แล้ว!!", "Okay!")	
end)

--#endregion

--#region Starbux

local starbux = starbuxserver:Channel(" Discord StarBux ")
starbux:Label("Discord 🌟 StarBux 🌟 Store")
starbux:Label("ติดต่อยศส้มเพื่อชื้อ GamePass ได้เลยครับ")
starbux:Label("มีแอดมินให้บริการตลอดเวลาทำการ")
starbux:Label("✅ รับของผ่านเซิร์ฟ วี จ่ายปุ๊บรับเลย แค่เรท 9 เท่านั้นเอง")
starbux:Button("👉 Discord StarBux Link!", function()
    setclipboard("https://discord.gg/eGKGE2sQtX")
    DiscordLib:Notification("Copied!!", "✔ Link Discord StarBux ถูก Copy แล้ว!!", "Okay!")	  
end)

local starbux = starbuxserver:Channel(" ชื้อ GamePass ")
starbux:Label("👑ร้าน 🌟 STARBUX 🌟 🛒 เปิด Gift Game Pass เรท 9  [ ROBLOX ]")
starbux:Label("✅ ร้านเปิดบริการเวลา 12:00 - 22:00 ทุกวัน")
starbux:Label("✅ ไม่ต้องใช้ ID - PASS")
starbux:Label("✅ รับของผ่านเซิร์ฟ วี จ่ายปุ๊บรับเลย")
starbux:Label("✅ Anime Adventures , Blox Fruits , BedWars , Anime Dimension , 9ล9")
starbux:Button("👉 StarBux Facebook Link!", function()
    setclipboard("https://www.facebook.com/StarBux.Store/")
    DiscordLib:Notification("Copied!!", "✔ Link Facebook StarBux Store ถูก Copy แล้ว!!", "Okay!")	
end)

local starbux = starbuxserver:Channel(" ชื้อ ID ไก่เพชร ")
starbux:Label("👑ร้าน 🌟 STARBUX 🌟 🛒 เปิดขายไก่เพชร [Anime Adventures]")
starbux:Label("🐣 ไก่ 40,000 เพชร + 2 Mythic & Random Traits ราคา 250 บาท")
starbux:Label("🐣 ไก่ 60,000 เพชร + 2 Mythic & Random Traits ราคา 375 บาท")
starbux:Label("🐣 ไก่ 100,000 เพชร + 2-4 Mythic & Random Traits ราคา 699 บาท")
starbux:Label("💳 บัตรเติม ROBUX 10$ + ของแถม [ได้พรีเมี่ยม Roblox] ราคา 279 บาท")
starbux:Label("💳 บัตรเติม ROBUX 10$ จะได้รับ ROBUX 1000 และพรีเมี่ยม 1เดือน  ")
starbux:Button("👉 ชื้อไก่เพชร & บัตร ROBUX 10$  StarBux ", function()
    setclipboard("https://starbuxstore.com/categories/clduzowwu0033jxn22a9llwis")
    DiscordLib:Notification("Copied!!", "✔ Link ไก่เพชร StarBux Store ถูก Copy แล้ว!!", "Okay!")	
end)

local starbux = starbuxserver:Channel(" บริการฟาร์มเพชร ")
starbux:Label("👑ร้าน 🌟 STARBUX 🌟 🛒 เปิดบริการรับฟาร์มเพชร [Anime Adventures]")
starbux:Label("✅ ต้องใช้ ID - PASS")
starbux:Label("✅ ต้องปิด 2FA ก่อนเติมทุกๆครั้งเพื่อให้แอดมินได้ทำการฟาร์มตามคิวอย่างรวดเร็ว")
starbux:Label("🌟 บริการ ราคา และจำนวน วัน ที่ต้องใช้ในการฟาร์ม 🌟")
starbux:Label("💎 20,000 เพชร (ใช้เวลา 3วัน) ราคา 125 บาท")
starbux:Label("💎 30,000 เพชร (ใช้เวลา 4วัน) ราคา 185 บาท")
starbux:Label("💎 40,000 เพชร (ใช้เวลา 5วัน) ราคา 249 บาท")
starbux:Label("💎 50,000 เพชร (ใช้เวลา 6วัน) ราคา 309 บาท")
starbux:Button("👉 บริการฟาร์มเพชร StarBux Link!", function()
    setclipboard("https://starbuxstore.com/categories/clduzowt00000jxn2aaruqdjr")
    DiscordLib:Notification("คำเตือน!!", "ต้อง ล็อคอิน StarBux ก่อนเอาลิ้งค์ไปวาง!!", "Okay!")	
end)

local starbux = starbuxserver:Channel(" ROBUX แบบกลุ่ม ")
starbux:Label("👑ร้าน 🌟 STARBUX 🌟 🛒 กำลังจะเปิดขาย ROBUX แบบกลุ่ม [ROBLOX]")
starbux:Label("ROBUX กลุ่ม ใครสนใจเข้ากลุ่มไว้เลยนะ ")
starbux:Label("เรทยังไม่บอก แต่เข้ากลุ่มมากันก่อนน้าทุกคน  ")
starbux:Button("👉 กลุ่มชื้อ ROBUX StarBux Link!", function()
    setclipboard("https://www.roblox.com/groups/16807082/STARBUX-STORE#!/about")
    DiscordLib:Notification("Copied!!", "✔ Link กลุ่ม ROBUX StarBux ถูก Copy แล้ว!!", "Okay!")	
end)
--#endregion



end

--------------------------------------------------
--------------------------------------------------
getgenv().posX = 1.5
getgenv().posZ = 1.5
---// Checks if file exist or not\\---
if isfile(savefilename) then 

    local jsonData = readfile(savefilename)
    local data = HttpService:JSONDecode(jsonData)

    sex()

else
--#region CREATES JSON
    local xdata = {
        --Devil City
        portalnameX = "csm_contract_0",
        farmportal = false,
        buyportal = false,
        PortalID = "nil",

        --Aline protal
        portalnameA = "boros_ship_portal",
        farmaline = false,
        PortalIDA = "nil",
        
        -- unitname = "name",
        -- unitid = "id",
        AutoContinue = false,
        AutoNext = false,
        AutoReplay = false,
        AutoLeave = true,
        AutoChallenge = false,
        selectedreward = "star_fruit_random",
        AutoChallengeAll = false,
        autoabilities = false,
        autofarmtp = false,
        webhook = "",
        sellatwave = 0,
        autosell = false,
        autofarm = false,
        autofarmic = false,
        AutoFarmJJK = false,
        AutoFarmRaid = false,
        autostart = false,
        autoloadtp = false,
        autoupgrade = false,
        difficulty = "nil",
        world = "nil",
        level = "nil",
        door = "nil",
        doorraid = "nil",

    
        xspawnUnitPos  = {
            clover_legend  = {
                UP1  = {
                    y  = 1.5824745893478394,
                    x  = -60.936012268066409,
                    z  = -17.815866470336915
                 },
                 UP2  = {
                    y  = 6.592540740966797,
                    x  = -64.9782943725586,
                    z  = -16.04295539855957
                 },
                 UP3  = {
                    y  = 1.584641933441162,
                    x  = -41.46944808959961,
                    z  = 10.981884002685547
                 },
                  UP6  = {
                    y  = 1.5806325674057007,
                    x  = -64.90975952148438,
                    z  = -28.657577514648439
                 },
                  UP5  = {
                    y  = 1.5820542573928834,
                    x  = -50.67249298095703,
                    z  = -3.3209869861602785
                 },
                  UP4  = {
                    y  = 7.245049476623535,
                    x  = -39.465126037597659,
                    z  = 2.65594482421875
             }
           },
           clover  = {
            UP1  = {
                y  = 1.5824745893478394,
                x  = -60.936012268066409,
                z  = -17.815866470336915
             },
             UP2  = {
                y  = 6.592540740966797,
                x  = -64.9782943725586,
                z  = -16.04295539855957
             },
             UP3  = {
                y  = 1.584641933441162,
                x  = -41.46944808959961,
                z  = 10.981884002685547
             },
              UP6  = {
                y  = 1.5806325674057007,
                x  = -64.90975952148438,
                z  = -28.657577514648439
             },
              UP5  = {
                y  = 1.5820542573928834,
                x  = -50.67249298095703,
                z  = -3.3209869861602785
             },
              UP4  = {
                y  = 7.245049476623535,
                x  = -39.465126037597659,
                z  = 2.65594482421875
         }
       },
           bleach_legend = {
            UP1 = {
                x = -171.5882110595703,
                y = 36.42063903808594, 
                z = 567.2667236328125
            },
            UP2 = {
                x = -179.63491821289063, 
                y = 45.001708984375, 
                z = 556.821533203125
            },
            UP3 = {
                x = -190.62969970703126, 
                y = 36.437957763671878, 
                z = 523.1019287109375
               
            },
            UP4 = {
                x = -189.09657287597657, 
                y = 40.85203170776367, 
                z = 507.2735290527344
            },
            UP5 = {
                x = -163.5642852783203, 
                y = 36.42695617675781, 
                z = 536.5643310546875
            },
            UP6 = {
                x = -202.01222229003907, 
                y = 36.42416000366211, 
                z = 501.7930908203125
            }
           },
           ["Cursed Womb"]  = {
            UP1  = {
                y  = 122.2491226196289,
                x  = 351.5147399902344,
                z  = -160.02197265625
             },
              UP2  = {
                y  = 126.45492553710938,
                x  = 341.98614501953127,
                z  = -159.98648071289063
             },
              UP3  = {
                y  = 122.38652801513672,
                x  = 307.7061462402344,
                z  = -109.55415344238281
             },
              UP6  = {
                y  = 122.25238037109375,
                x  = 369.2683410644531,
                z  = -157.04066467285157
             },
              UP5  = {
                y  = 122.46334075927735,
                x  = 309.8368835449219,
                z  = -155.8525848388672
             },
              UP4  = {
                y  = 125.9574966430664,
                x  = 313.8759460449219,
                z  = -101.04281616210938
         }
       },
           jjk  = {
                UP1  = {
                    y  = 122.2491226196289,
                    x  = 351.5147399902344,
                    z  = -160.02197265625
                 },
                  UP2  = {
                    y  = 126.45492553710938,
                    x  = 341.98614501953127,
                    z  = -159.98648071289063
                 },
                  UP3  = {
                    y  = 122.38652801513672,
                    x  = 307.7061462402344,
                    z  = -109.55415344238281
                 },
                  UP6  = {
                    y  = 122.25238037109375,
                    x  = 369.2683410644531,
                    z  = -157.04066467285157
                 },
                  UP5  = {
                    y  = 122.46334075927735,
                    x  = 309.8368835449219,
                    z  = -155.8525848388672
                 },
                  UP4  = {
                    y  = 125.9574966430664,
                    x  = 313.8759460449219,
                    z  = -101.04281616210938
             }
           },
           naruto  = {
                UP1  = {
                    y  = 25.633787155151368,
                    x  = -890.8043823242188,
                    z  = 313.8632507324219
                 },
                 UP2  = {
                    y  = 29.9185791015625,
                    x  = -894.8745727539063,
                    z  = 320.17279052734377
                 },
                  UP3  = {
                    y  = 25.63469886779785,
                    x  = -890.8817138671875,
                    z  = 288.5116882324219
                 },
                  UP6  = {
                    y  = 25.634540557861329,
                    x  = -917.6568603515625,
                    z  = 289.572998046875
                 },
                  UP5  = {
                    y  = 25.628511428833009,
                    x  = -888.9928588867188,
                    z  = 327.1591491699219
                 },
                  UP4  = {
                    y  = 31.52829933166504,
                    x  = -882.33154296875,
                    z  = 297.2707824707031
             }
           },
           namek  = {
                UP1  = {
                    y  = 92.15834045410156,
                    x  = -2956.73193359375,
                    z  = -716.7922973632813
                 },
                 UP2  = {
                    y  = 94.77137756347656,
                    x  = -2951.260986328125,
                    z  = -717.804443359375
                 },
                  UP3  = {
                    y  = 92.15702819824219,
                    x  = -2920.022216796875,
                    z  = -729.0972900390625
                 },
                  UP6  = {
                    y  = 92.16128540039063,
                    x  = -2947.30712890625,
                    z  = -699.580078125
                 },
                  UP5  = {
                    y  = 92.15274047851563,
                    x  = -2942.784423828125,
                    z  = -734.842529296875
                 },
                  UP4  = {
                    y  = 94.7423324584961,
                    x  = -2913.096923828125,
                    z  = -716.473388671875
             }
           },
           hueco  = {
                UP1  = {
                    y  = 133.0173797607422,
                    x  = -164.7485809326172,
                    z  = -708.7227172851563
                 },
                 UP2  = {
                    y  = 136.68968200683595,
                    x  = -175.1417999267578,
                    z  = -708.4566650390625
                 },
                  UP3  = {
                    y  = 133.02149963378907,
                    x  = -236.7266845703125,
                    z  = -669.0444946289063
                 },
                  UP6  = {
                    y  = 133.49078369140626,
                    x  = -187.76791381835938,
                    z  = -690.4931640625
                 },
                  UP5  = {
                    y  = 133.02188110351563,
                    x  = -210.3648681640625,
                    z  = -685.1356201171875
                 },
                  UP4  = {
                    y  = 138.09869384765626,
                    x  = -218.16932678222657,
                    z  = -652.7559814453125
             }
           },
            hxhant  = {
                UP1  = {
                    y  = 23.364791870117189,
                    x  = -161.99302673339845,
                    z  = 2965.1572265625
                 },
                 UP2  = {
                    y  = 31.533567428588868,
                    x  = -171.0098419189453,
                    z  = 2972.414794921875
                 },
                  UP3  = {
                    y  = 23.37002182006836,
                    x  = -144.85105895996095,
                    z  = 2996.060546875
                 },
                  UP6  = {
                    y  = 23.363950729370118,
                    x  = -186.7503204345703,
                    z  = 2960.7900390625
                 },
                  UP5  = {
                    y  = 23.364818572998048,
                    x  = -149.97898864746095,
                    z  = 2981.40185546875
                 },
                  UP4  = {
                    y  = 26.514448165893556,
                    x  = -142.02455139160157,
                    z  = 2991.345947265625
             }
           },
            aot  = {
                UP1  = {
                    y  = 34.18759536743164,
                    x  = -3010.3740234375,
                    z  = -685.14599609375
                 },
                 UP2  = {
                    y  = 38.68673324584961,
                    x  = -3014.444580078125,
                    z  = -688.4807739257813
                 },
                  UP3  = {
                    y  = 34.18759536743164,
                    x  = -2993.00146484375,
                    z  = -713.3661499023438
                 },
                  UP6  = {
                    y  = 34.190486907958987,
                    x  = -3005.8330078125,
                    z  = -704.356201171875
                 },
                  UP5  = {
                    y  = 34.18759536743164,
                    x  = -3024.729248046875,
                    z  = -684.6459350585938
                 },
                  UP4  = {
                    y  = 39.27751159667969,
                    x  = -2990.29150390625,
                    z  = -723.272216796875
             }
           },
           demonslayer  = {
                UP1  = {
                    y  = 34.79566192626953,
                    x  = -2864.95166015625,
                    z  = -125.98533630371094
                 },
                 UP2  = {
                    y  = 39.736934661865237,
                    x  = -2877.181640625,
                    z  = -125.01622009277344
                 },
                  UP3  = {
                    y  = 34.805694580078128,
                    x  = -2934.28857421875,
                    z  = -155.3917999267578
                 },
                  UP6  = {
                    y  = 34.79277038574219,
                    x  = -2893.751220703125,
                    z  = -153.32833862304688
                 },
                  UP5  = {
                    y  = 34.79277038574219,
                    x  = -2876.128173828125,
                    z  = -134.00733947753907
                 },
                  UP4  = {
                    y  = 37.59779739379883,
                    x  = -2929.932373046875,
                    z  = -149.10423278808595
             }
           },
           tokyo_ghoul  = {
                UP1  = {
                    y  = 59.03092575073242,
                    x  = -2997.170654296875,
                    z  = -81.0949478149414
                 },
                 UP2  = {
                    y  = 63.28971481323242,
                    x  = -2991.822021484375,
                    z  = -75.84800720214844
                 },
                  UP3  = {
                    y  = 58.94676971435547,
                    x  = -2947.560791015625,
                    z  = -96.52957916259766
                 },
                  UP6  = {
                    y  = 59.03092575073242,
                    x  = -2980.928466796875,
                    z  = -91.56231689453125
                 },
                  UP5  = {
                    y  = 59.03092575073242,
                    x  = -3005.60205078125,
                    z  = -66.11444091796875
                 },
                  UP4  = {
                    y  = 62.38314437866211,
                    x  = -2954.241943359375,
                    z  = -103.43102264404297
             }
           },
           magnolia  = {
                UP1  = {
                    y  = 6.311758041381836,
                    x  = -600.5551147460938,
                    z  = -819.5928344726563
                 },
                 UP2  = {
                    y  = 14.233622550964356,
                    x  = -595.70947265625,
                    z  = -823.6626586914063
                 },
                  UP3  = {
                    y  = 6.315590858459473,
                    x  = -638.746337890625,
                    z  = -805.4141235351563
                 },
                  UP6  = {
                    y  = 6.3124308586120609,
                    x  = -592.890869140625,
                    z  = -818.8229370117188
                 },
                  UP5  = {
                    y  = 7.316053867340088,
                    x  = -614.5005493164063,
                    z  = -845.5903930664063
                 },
                  UP4  = {
                    y  = 13.594444274902344,
                    x  = -625.9210205078125,
                    z  = -823.851806640625
             }
           },
           --เน€เธเนเธ—เน€เธเธดเธเธ•เธดเธ”เธ–เธเธ
           marineford  = {
                UP1  = {
                    y  = 25.660118103027345,
                    x  = -2575.1875,
                    z  = -69.69309997558594
                 },
                 UP2  = {
                    y  = 31.823074340820314,
                    x  = -2583.66455078125,
                    z  = -61.25366973876953
                 },
                  UP3  = {
                    y  = 25.65696144104004,
                    x  = -2611.51806640625,
                    z  = -37.29831314086914
                 },
                  UP6  = {
                    y  = 25.65955924987793,
                    x  = -2598.91650390625,
                    z  = -75.78345489501953
                 },
                  UP5  = {
                    y  = 25.656665802001954,
                    x  = -2560.813232421875,
                    z  = -49.39942932128906
                 },
                  UP4  = {
                    y  = 31.82597541809082,
                    x  = -2596.2529296875,
                    z  = -53.688514709472659
             }
           },
            thriller_park  = {
              UP1  = {
                y  = 113.23728942871094,
                x  = -224.14295959472657,
                z  = -657.738037109375
             },
              UP3  = {
                y  = 109.37400817871094,
                x  = -224.78709411621095,
                z  = -640.7178955078125
             },
              UP2  = {
                y  = 109.37401580810547,
                x  = -229.42715454101563,
                z  = -649.636474609375
             },
              UP6  = {
                y  = 109.37400817871094,
                x  = -214.7626190185547,
                z  = -632.3900146484375
             },
              UP5  = {
                y  = 109.37401580810547,
                x  = -230.53053283691407,
                z  = -657.9769287109375
             },
              UP4  = {
                y  = 109.37400817871094,
                x  = -220.0915985107422,
                z  = -636.2127075195313
             }
           },
           ["[Contract] The Tomato Devil"]  = {
            UP1  = {
                x = -299.0365295410156, 
                y = 1.449868083000183,
                z = -558
           },
           UP2  = {
                x = -300.2853698730469,
                y = 12.720949172973633,
                z = -564.662841796875
           },
            UP3  = {
                x = -286.732666015625,
                y = 1.449868083000183,
                z = -588.205322265625
           },
            UP6  = {
                x = -282.1344909667969,
                y = 1.449868083000183,
                z = -572.3256225585938
           },
            UP5  = {
                x = -328.73968505859377,
                y = 1.4486867189407349,
                z = -557.7278442382813
           },
            UP4  = {
                x = -299.6959228515625,
                y = 12.950956344604493,
                z = -579.830322265625
           }
         },
         ["[Contract] The Marshmallow Devil"]  = {
            UP1  = {
                x = -299.0365295410156, 
                y = 1.449868083000183,
                z = -558
           },
           UP2  = {
                x = -300.2853698730469,
                y = 12.720949172973633,
                z = -564.662841796875
           },
            UP3  = {
                x = -286.732666015625,
                y = 1.449868083000183,
                z = -588.205322265625
           },
            UP6  = {
                x = -282.1344909667969,
                y = 1.449868083000183,
                z = -572.3256225585938
           },
            UP5  = {
                x = -328.73968505859377,
                y = 1.4486867189407349,
                z = -557.7278442382813
           },
            UP4  = {
                x = -299.6959228515625,
                y = 12.950956344604493,
                z = -579.830322265625
           }
         },
         ["[Contract] The Bat Devil"]  = {
            UP1  = {
                x = -299.0365295410156, 
                y = 1.449868083000183,
                z = -558
           },
           UP2  = {
                x = -300.2853698730469,
                y = 12.720949172973633,
                z = -564.662841796875
           },
            UP3  = {
                x = -286.732666015625,
                y = 1.449868083000183,
                z = -588.205322265625
           },
            UP6  = {
                x = -282.1344909667969,
                y = 1.449868083000183,
                z = -572.3256225585938
           },
            UP5  = {
                x = -328.73968505859377,
                y = 1.4486867189407349,
                z = -557.7278442382813
           },
            UP4  = {
                x = -299.6959228515625,
                y = 12.950956344604493,
                z = -579.830322265625
           }
         },
         ["[Contract] The Slug Devil"] = {
            UP1  = {
                x = -299.0365295410156, 
                y = 1.449868083000183,
                z = -558
           },
           UP2  = {
                x = -300.2853698730469,
                y = 12.720949172973633,
                z = -564.662841796875
           },
            UP3  = {
                x = -286.732666015625,
                y = 1.449868083000183,
                z = -588.205322265625
           },
            UP6  = {
                x = -282.1344909667969,
                y = 1.449868083000183,
                z = -572.3256225585938
           },
            UP5  = {
                x = -328.73968505859377,
                y = 1.4486867189407349,
                z = -557.7278442382813
           },
            UP4  = {
                x = -299.6959228515625,
                y = 12.950956344604493,
                z = -579.830322265625
           }
         },
           jojo = {
            UP1  = {
                x = -93.73455810546875, 
                y = 15.304971694946289, 
                z = -583.9602661132813
             },
             UP2  = {
                x = -85.22750091552735, 
                y = 20.571115493774415, 
                z = -584.2532348632813
             },
              UP3  = {
                x = -50.297454833984378, 
                y = 15.302647590637207, 
                z = -593.872802734375
             },
              UP6  = {
                x = -101.23492431640625, 
                y = 15.307596206665039, 
                z = -575.9161987304688
             },
              UP5  = {
                x = -66.3667221069336, 
                y = 15.30207633972168, 
                z = -593.6554565429688              
             },
              UP4  = {
                x = -54.90178680419922, 
                y = 20.58604621887207, 
                z = -582.2592163085938
             }
           },
           jojo_legend = {
            UP1  = {
                x = -93.5505142211914, 
                y = 17.90195655822754, 
                z = -582.4182739257812
             },
             UP2  = {
                x = -89.10867309570312, 
                y = 23.173965454101562, 
                z = -583.8086547851562
             },
              UP3  = {
                x = -47.614036560058594, 
                y = 17.899141311645508, 
                z = -592.3721313476562
             },
              UP6  = {
                x = -85.75068664550781, 
                y = 17.899860382080078, 
                z = -589.832763671875
             },
              UP5  = {
                x = -57.20876693725586, 
                y = 17.89964485168457, 
                z = -590.5894775390625                
             },
              UP4  = {
                x = -55.77149200439453, 
                y = 23.17935562133789, 
                z = -583.1688232421875
           }
         },  
         ["Alien Assault"] = {
            UP1  = {
                x = -284.7133483886719, 
                y = 361.8908386230469,
                z = 1363.6123046875
             },
             UP2  = {
                x = -292.390380859375, 
                y = 367.1618957519531, 
                z = 1348.3438720703126
             },
              UP3  = {
                x = -270.7325439453125, 
                y = 361.6577453613281, 
                z = 1332.7779541015626
             },
              UP6  = {
                x = -273.16748046875, 
                y = 361.6615295410156, 
                z = 1436.494140625
             },
              UP5  = {
                x = -313.2516784667969, 
                y = 361.6577453613281, 
                z = 1424.05078125           
             },
              UP4  = {
                x = -264.98199462890627, 
                y = 365.66925048828127, 
                z = 1325.1728515625
           }
         },
         cell = {
            UP1  = {
                x = 0, 
                y = 0, 
                z = 0
             },
             UP2  = {
                x = 0, 
                y = 0, 
                z = 0
             },
              UP3  = {
                x = -0, 
                y = 0, 
                z = 0
             },
              UP6  = {
                x = 0, 
                y = 0, 
                z = 0
             },
              UP5  = {
                x = 0, 
                y = 0, 
                z = 0           
             },
              UP4  = {
                x = 0, 
                y = 0, 
                z = 0
           }
         },
         Train = {
            UP1  = {
                x = 21.024063110351562, 
                y = -12.077807426452637, 
                z = 336.73907470703125
             },
             UP2  = {
                x = 2.1384387016296387, 
                y = -7.0199127197265625, 
                z = 348.75921630859375
             },
              UP3  = {
                x = 32.49996566772461, 
                y = -12.077810287475586, 
                z = 320.3133239746094
             },
              UP6  = {
                x = 14.163424491882324, 
                y = -12.077802658081055,
                z = 351.39495849609375
             },
              UP5  = {
                x = 88.87351989746094, 
                y = -12.078625679016113, 
                z = 350.60040283203125           
             },
              UP4  = {
                x = 41.927818298339844, 
                y = -6.658023357391357, 
                z = 334.2225341796875
           }
         },
         naruto_raid = {
            UP1  = {
                y  = 25.633787155151368,
                x  = -890.8043823242188,
                z  = 313.8632507324219
             },
             UP2  = {
                y  = 29.9185791015625,
                x  = -894.8745727539063,
                z  = 320.17279052734377
             },
              UP3  = {
                y  = 25.63469886779785,
                x  = -890.8817138671875,
                z  = 288.5116882324219
             },
              UP6  = {
                y  = 25.634540557861329,
                x  = -917.6568603515625,
                z  = 289.572998046875
             },
              UP5  = {
                y  = 25.628511428833009,
                x  = -888.9928588867188,
                z  = 327.1591491699219
             },
              UP4  = {
                y  = 31.52829933166504,
                x  = -882.33154296875,
                z  = 297.2707824707031
           }
         },
         aot_raid = {
            UP1  = {
                y  = 34.18759536743164,
                x  = -3010.3740234375,
                z  = -685.14599609375
             },
             UP2  = {
                y  = 38.68673324584961,
                x  = -3014.444580078125,
                z  = -688.4807739257813
             },
              UP3  = {
                y  = 34.18759536743164,
                x  = -2993.00146484375,
                z  = -713.3661499023438
             },
              UP6  = {
                y  = 34.190486907958987,
                x  = -3005.8330078125,
                z  = -704.356201171875
             },
              UP5  = {
                y  = 34.18759536743164,
                x  = -3024.729248046875,
                z  = -684.6459350585938
             },
              UP4  = {
                y  = 39.27751159667969,
                x  = -2990.29150390625,
                z  = -723.272216796875
           }
         },
         uchiha = {
            UP1  = {
                y  = 536.8999633789062,
                x  = 274.7554626464844,
                z  = -524.8792114257812
             },
              UP3  = {
                y  = 536.8999633789062,
                x  = 272.95831298828125,
                z  = -507.10980224609375
             },
              UP2  = {
                y  = 541.12939453125,
                x  = 260.9716491699219,
                z  = -535.1824951171875
             },
              UP6  = {
                y  = 536.8999633789062,
                x  = 271.78302001953125,
                z  = -538.1466674804688
             },
              UP5  = {
                y  = 536.8999633789062,
                x  = 289.496826171875,
                z  = -511.45074462890625
             },
              UP4  = {
                y  = 539.8976440429688,
                x  = 266.79241943359375,
                z  = -558.4491577148438
           }
         },
           opm = {
            UP1  = {
                x = -284.7133483886719, 
                y = 361.8908386230469, 
                z = 1363.6123046875
             },
             UP2  = {
                x = -292.390380859375, 
                y = 367.1618957519531, 
                z = 1348.3438720703126
             },
              UP3  = {
                x = -270.7325439453125, 
                y = 361.6577453613281, 
                z = 1332.7779541015626
             },
              UP6  = {
                x = -273.16748046875, 
                y = 361.6615295410156, 
                z = 1436.494140625
             },
              UP5  = {
                x = -313.2516784667969, 
                y = 361.6577453613281, 
                z = 1424.05078125           
             },
              UP4  = {
                x = -264.98199462890627, 
                y = 365.66925048828127, 
                z = 1325.1728515625
            }
        },
        ["7ds"] = {
           UP1  = {
               x = -100.60639190673828, 
               y = 212.9611053466797, 
               z = -195.98094177246095
            },
            UP2  = {
               x = -86.73683166503906, 
               y = 216.9965057373047, 
               z = -211.91287231445313
            },
             UP3  = {
               x = -118.31477355957031, 
               y = 212.861083984375, 
               z = -233.3929443359375
            },
             UP6  = {
               x = -100.40522003173828, 
               y = 212.96104431152345, 
               z = -187.8174591064453
            },
             UP5  = {
               x = -90.78057861328125, 
               y = 212.9611053466797, 
               z = -264.75848388671877       
            },
             UP4  = {
               x = -118.33492279052735, 
               y = 217.64389038085938, 
               z = -256.07647705078127
            }
           }
         },
--updatefix fixmap fixplaceunit
        xselectedUnits = {
            U1 = "nil #nil",
            U2 = "nil #nil",
            U3 = "nil #nil",
            U4 = "nil #nil",
            U5 = "nil #nil",
            U6 = "nil #nil"
        }
    
    }

    local json = HttpService:JSONEncode(xdata)
    writefile(savefilename, json)

    sex()
--#endregion
end

--#region ----------------------
--#endregion
--------------------------------------------------


function placesex()
    if getgenv().AutoFarm and not getgenv().disableatuofarm then
        print("a")
        if game.PlaceId ~= 8304191830 then
			local GetLevelData = game.workspace._MAP_CONFIG:WaitForChild("GetLevelData"):InvokeServer()
            x = 1.7
            y = 0
            z = 1.7
            print("AutoFarming")
            world = GetLevelData.world or GetLevelData.name
			print(tostring(world))
			for i = 1, 6 do
				local unitinfo = getgenv().SelectedUnits["U" .. i]
				if unitinfo ~= nil then
					local unitinfo_ = unitinfo:split(" #")
					local pos = getgenv().SpawnUnitPos[tostring(world)]["UP" .. i]

					--place units 0
					local args = {
						[1] = unitinfo_[2],
						[2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
					}
					game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

					--place units 1
					local args = {
						[1] = unitinfo_[2],
						[2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
					}
					game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

					--place units 2 
					local args = {
						[1] = unitinfo_[2],
						[2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
					}
					game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

					--place units 3 
					local args = {
						[1] = unitinfo_[2],
						[2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
					}
					game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

					--place units 4
					local args = {
						[1] = unitinfo_[2],
						[2] = CFrame.new(Vector3.new(pos["x"]+ x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
					}
					game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

					--place units 5
					local args = {
						[1] = unitinfo_[2],
						[2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
					}
					game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
				end
			end
        end
    end
end

--updatefix fixmap

---------test Unit Place Robot
function PlaceUnitsTEST(map)
    current_wave = game:GetService("Workspace")["_wave_num"]
    U1wave = 1
    U1ammount = 2
    
    if current_wave <= U1wave then
        if GetCurrentAmmount("U1") <= U1ammount then
            local unitinfo = Settings.SelectedUnits["U1"] --Unit _uuid
            if unitinfo ~= nil then
                local unitinfo_ = unitinfo:split(" #")
                local pos = Settings[map]["UP1"]
                PlacePos(map, unitinfo_[1], unitinfo_[2], pos)
            end
        end
    end
    
end

--unittest
function SpawnUnitPos(map)
    if getgenv().AutoFarm and not getgenv().disableatuofarm then
        x = getgenv().posX; z = getgenv().posZ
        for i = 1, 6 do
            local unitinfo = Settings.SelectedUnits["U" .. i]
            if unitinfo ~= nil then
                local unitinfo_ = unitinfo:split(" #")
                local pos = Settings[map]["UP" .. i]
                print(" ด่าน "..map.." กำลังวางตัว "..unitinfo_[1])

                if unitinfo_[1] ~= "metal_knight_evolved" then

                    --place units 0
                    local args = {
                        [1] = unitinfo_[2],
                        [2] = CFrame.new(Vector3.new(pos["x"], pos["y"], pos["z"]) )
                    }
                    game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
        
                    --place units 1
                    local args = {
                        [1] = unitinfo_[2],
                        [2] = CFrame.new(Vector3.new(pos["x"], pos["y2"], pos["z"] + z) )
                    }
                    game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
        
                    --place units 2 
                    local args = {
                        [1] = unitinfo_[2],
                        [2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y3"], pos["z"]) )
                    }
                    game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
        
                    --place units 3 
                    local args = {
                        [1] = unitinfo_[2],
                        [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y4"], pos["z"]) )
                    }
                    game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
        
                    --place units 4
                    local args = {
                        [1] = unitinfo_[2],
                        [2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y5"], pos["z"] + z) )
                    }
                    game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
        
                    --place units 5
                    local args = {
                        [1] = unitinfo_[2],
                        [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y6"], pos["z"] + z) )
                    }
                    game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                elseif unitinfo_[1] == "metal_knight_evolved" then
                    task.spawn(function()
                        --place units 0
                        local args = {
                            [1] = unitinfo_[2],
                            [2] = CFrame.new(Vector3.new(pos["x"], pos["y"], pos["z"]) )
                        }
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                    end)

                    task.spawn(function()
                        --place units 1
                        task.wait(2)
                        local args = {
                            [1] = unitinfo_[2],
                            [2] = CFrame.new(Vector3.new(pos["x"], pos["y"], pos["z"] + z) )
                        }
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                    end)

                    task.spawn(function()
                        --place units 2
                        task.wait(3)
                        local args = {
                            [1] = unitinfo_[2],
                            [2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y"], pos["z"]) )
                        }
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                    end)
                end
            end
        end
    end
end


------// Auto Farm \\------
--#region Auto Farm Loop
coroutine.resume(coroutine.create(function()
    while task.wait(1.5) do
        local _wave = game:GetService("Workspace"):WaitForChild("_wave_num")
        repeat task.wait() until game:GetService("Workspace"):WaitForChild("_map")

        placesex()

        print("function called")
    end
end))


--#endregion



------// Auto Leave \\------
--#region Auto Leave 


local PlaceID = 8304191830
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false

local last

local File = pcall(function()
   AllIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
end)
if not File then
   table.insert(AllIDs, actualHour)
   writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
end

function TPReturner()
   local Site;
   if foundAnything == "" then
       Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
   else
       Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
   end
   local ID = ""
   if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
       foundAnything = Site.nextPageCursor
   end
   local num = 0;
   local extranum = 0
   for i,v in pairs(Site.data) do
       extranum += 1
       local Possible = true
       ID = tostring(v.id)
       if tonumber(v.maxPlayers) > tonumber(v.playing) then
           if extranum ~= 1 and tonumber(v.playing) < last or extranum == 1 then
               last = tonumber(v.playing)
           elseif extranum ~= 1 then
               continue
           end
           for _,Existing in pairs(AllIDs) do
               if num ~= 0 then
                   if ID == tostring(Existing) then
                       Possible = false
                   end
               else
                   if tonumber(actualHour) ~= tonumber(Existing) then
                       local delFile = pcall(function()
                           delfile("NotSameServers.json")
                           AllIDs = {}
                           table.insert(AllIDs, actualHour)
                       end)
                   end
               end
               num = num + 1
           end
           if Possible == true then
               table.insert(AllIDs, ID)
               wait()
               pcall(function()
                   writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                   wait()
                   game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
               end)
               wait(4)
           end
       end
   end
end

function Teleport()
   while wait() do
       pcall(function()
           TPReturner()
           if foundAnything ~= "" then
               TPReturner()
           end
       end)
   end
end
-------------------------------------------

coroutine.resume(coroutine.create(function()
	local GameFinished = game:GetService("Workspace"):WaitForChild("_DATA"):WaitForChild("GameFinished")
    GameFinished:GetPropertyChangedSignal("Value"):Connect(function()
        print("Changed", GameFinished.Value == true)
        if GameFinished.Value == true then
            repeat task.wait() until  game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Enabled == true
            task.wait()
            pcall(function() webhook() end)
            print("next")
            task.wait(2.1)
            if getgenv().AutoReplay then
                local a={[1]="replay"} game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
                local a={[1]="replay"} game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
            elseif getgenv().AutoNext then
                local a={[1]="next_story"} game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
                local a={[1]="next_story"} game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))        
            elseif getgenv().AutoContinue then
                local a={[1]="NextRetry"} game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_infinite_tower_from_game:InvokeServer(unpack(a))
                local a={[1]="NextRetry"} game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_infinite_tower_from_game:InvokeServer(unpack(a))
            elseif getgenv().AutoLeave and getgenv().AutoReplay ~= true and getgenv().AutoNext ~= true and getgenv().AutoContinue ~= true then
                --
                Teleport()
                -- game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
            end
        end
	end)
end))
--#endregion

--unittest metal_knight_evolved

function PlacePos(map,name,_uuid,pos)
    if getgenv().AutoFarm and not getgenv().disableatuofarm then
        x = getgenv().posX; z = getgenv().posZ
       
        print(" ด่าน "..map.." กำลังวางตัว " ..name)

        if name ~= "metal_knight_evolved" then
            warn("x")
            --place units 0
            local args = {
                [1] = _uuid,
                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"], pos["z"]) )
            }
            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

            --place units 1
            local args = {
                [1] = _uuid,
                [2] = CFrame.new(Vector3.new(pos["x"], pos["y2"], pos["z"] + z) )
            }
            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

            --place units 2 
            local args = {
                [1] = _uuid,
                [2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y3"], pos["z"]) )
            }
            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

            --place units 3 
            local args = {
                [1] = _uuid,
                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y4"], pos["z"]) )
            }
            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

            --place units 4
            local args = {
                [1] = _uuid,
                [2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y5"], pos["z"] + z) )
            }
            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

            --place units 5
            local args = {
                [1] = _uuid,
                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y6"], pos["z"] + z) )
            }
            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

        elseif name == "metal_knight_evolved" then
            warn("y")
            task.spawn(function()
                --place units 0
                local args = {
                    [1] = _uuid,
                    [2] = CFrame.new(Vector3.new(pos["x"], pos["y"], pos["z"]) )
                }
                game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
            end)

            task.spawn(function()
                --place units 1
                task.wait(2)
                local args = {
                    [1] = _uuid,
                    [2] = CFrame.new(Vector3.new(pos["x"], pos["y"], pos["z"] + z) )
                }
                game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
            end)

            task.spawn(function()
                --place units 2
                task.wait(3)
                local args = {
                    [1] = _uuid,
                    [2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y"], pos["z"]) )
                }
                game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
            end)
        end

    end
end

--unittest metal_knight_evolved

function PlacePos(map,name,_uuid,pos)
    if getgenv().AutoFarm and not getgenv().disableatuofarm then
        x = getgenv().posX; z = getgenv().posZ
       
        print(" ด่าน "..map.." กำลังวางตัว "..name)

        if name ~= "metal_knight" then
            warn("x")
            --place units 0
            local args = {
                [1] = _uuid,
                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"], pos["z"]) )
            }
            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

            --place units 1
            local args = {
                [1] = _uuid,
                [2] = CFrame.new(Vector3.new(pos["x"], pos["y2"], pos["z"] + z) )
            }
            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

            --place units 2 
            local args = {
                [1] = _uuid,
                [2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y3"], pos["z"]) )
            }
            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

            --place units 3 
            local args = {
                [1] = _uuid,
                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y4"], pos["z"]) )
            }
            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

            --place units 4
            local args = {
                [1] = _uuid,
                [2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y5"], pos["z"] + z) )
            }
            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

            --place units 5
            local args = {
                [1] = _uuid,
                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y6"], pos["z"] + z) )
            }
            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

        elseif name == "metal_knight" then
            warn("y")
            task.spawn(function()
                --place units 0
                local args = {
                    [1] = _uuid,
                    [2] = CFrame.new(Vector3.new(pos["x"], pos["y"], pos["z"]) )
                }
                game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
            end)

            task.spawn(function()
                --place units 1
                task.wait(2)
                local args = {
                    [1] = _uuid,
                    [2] = CFrame.new(Vector3.new(pos["x"], pos["y"], pos["z"] + z) )
                }
                game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
            end)

            task.spawn(function()
                --place units 2
                task.wait(3)
                local args = {
                    [1] = _uuid,
                    [2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y"], pos["z"]) )
                }
                game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
            end)
        end

    end
end


------// Auto Sell Units \\------
coroutine.resume(coroutine.create(function()
while task.wait() do
    if getgenv().UnitSellTog then

        for i, v in pairs(game:GetService("Players")[game.Players.LocalPlayer.Name].PlayerGui.collection.grid.List.Outer.UnitFrames:GetChildren()) do
            if v.Name == "CollectionUnitFrame" then
                repeat task.wait() until v:FindFirstChild("name")
                for _, Info in next, getgenv().UnitCache do
                    if Info.name == v.name.Text and Info.rarity == getgenv().UnitToSell then
                        local args = {
                            [1] = {
                                [1] = tostring(v._uuid.Value)
                            }
                        }
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.sell_units:InvokeServer(unpack(args))
                     end
                end
            end
        end
        
    end
end
end))

------// Auto Upgrade \\------
--#region Auto Upgrade Loop
getgenv().autoupgradeerr = false

function autoupgradefunc()
    local success, err = pcall(function() --///

        repeat task.wait() until game:GetService("Workspace"):WaitForChild("_UNITS")
        for i, v in ipairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do
           if v:FindFirstChild("_stats") then
                if tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name and v["_stats"].xp.Value >= 0 then
                    game:GetService("ReplicatedStorage").endpoints.client_to_server.upgrade_unit_ingame:InvokeServer(v)
                end
            end
        end

    end)

    if err then
        warn("//////////////////////////////////////////////////")
        warn("//////////////////////////////////////////////////")
        getgenv().autoupgradeerr = true
        error(err)
    end
end

coroutine.resume(coroutine.create(function()
    while task.wait(2) do
        if getgenv().autoupgrade then
            if game.PlaceId ~= 8304191830 then
                pcall(function()
                    autoupgradefunc()
                end)
            end
            if  getgenv().autoupgradeerr == true then
                task.wait()
                autoupgradefunc()
                getgenv().autoupgradeerr = false
            end
        end
    end
end))
--#endregion


------// Auto Sell \\------
--#region Auto Sell loop
coroutine.resume(coroutine.create(function()
    while task.wait() do
        local _wave = game:GetService("Workspace"):WaitForChild("_wave_num")
        if getgenv().autosell and tonumber(getgenv().sellatwave) <= _wave.Value then
            getgenv().disableatuofarm = true
            if game.PlaceId ~= 8304191830 then
                repeat task.wait() until game:GetService("Workspace"):WaitForChild("_UNITS")
                for i, v in ipairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do
                    repeat
                        task.wait()
                    until v:WaitForChild("_stats")
                    if tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name then
                        repeat
                            task.wait()
                        until v:WaitForChild("_stats"):WaitForChild("upgrade")
            
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.sell_unit_ingame:InvokeServer(v)
                    end
                end
            end
        end
    end
end))
--#endregion

--//Auto Abilities--
--#region Auto Abilities loop
getgenv().autoabilityerr = false

function autoabilityfunc()
    local success, err = pcall(function() --///
        repeat task.wait() until game:GetService("Workspace"):WaitForChild("_UNITS")
        for i, v in ipairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do
            if v:FindFirstChild("_stats") then
                if v._stats:FindFirstChild("player") and v._stats:FindFirstChild("xp") then
                    if tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name and v["_stats"].xp.Value > 0 then
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.use_active_attack:InvokeServer(v)
                    end
                end
            end
        end
    end)
     
     if err then
         warn("//////////////////////////////////////////////////")
         warn("//////////////////////////////////////////////////")
         getgenv().autoabilityerr = true
         error(err)
     end

end

coroutine.resume(coroutine.create(function()

    while task.wait(2) do
        if getgenv().autoabilities then
            if game.PlaceId ~= 8304191830 then
                pcall(function()
                    autoabilityfunc()
                end)
            end
            if  getgenv().autoabilityerr == true then
                task.wait()
                autoabilityfunc()
                getgenv().autoabilityerr = false
            end
        end
    end   

end))
--#endregion


getgenv().teleporting = true

------// Auto Start \\------
--#region Auto Start loop

local function checkChallenge()
    for i,v in pairs(game.Players.LocalPlayer.PlayerGui:GetChildren()) do
        if v:IsA("SurfaceGui") then
            if v:FindFirstChild("ChallengeCleared") then
                --print(v.ChallengeCleared.Visible)
                return v.ChallengeCleared.Visible
            end
        end
    end
end

local function checkReward()
    if checkChallenge() == false then
        if getgenv().selectedreward == game:GetService("Workspace")["_LOBBIES"]["_DATA"]["_CHALLENGE"]["current_reward"].Value then
            return true
        elseif getgenv().AutoChallengeAll then
            return true
        else
            return false
        end
    else
        return false
    end
end


local function startfarming()
    if getgenv().farmprotal == false and getgenv().autostart and getgenv().farmaline == false and getgenv().AutoFarm and getgenv().teleporting  
                           and getgenv().AutoFarmTP == false and getgenv().AutoFarmIC == false and getgenv().AutoFarmRaid == false and getgenv().AutoFarmJJK == false  then

        if game.PlaceId == 8304191830 then
            local cpos = plr.Character.HumanoidRootPart.CFrame

            if tostring(Workspace._LOBBIES.Story[getgenv().door].Owner.Value) ~= plr.Name then
                for i, v in pairs(game:GetService("Workspace")["_LOBBIES"].Story:GetDescendants()) do
                    if v.Name == "Owner" and v.Value == nil then

                        local args = {
                            [1] = tostring(v.Parent.Name)
                        }
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.request_join_lobby:InvokeServer(unpack(args))
                    
                        task.wait()
                    
                        if getgenv().level:match("infinite") then
                            local args = {
                                [1] = tostring(v.Parent.Name), -- Lobby 
                                [2] = getgenv().level, -- World
                                [3] = true, -- Friends Only or not
                                [4] = "Hard"
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.request_lock_level:InvokeServer(unpack(args))
                        else
                            local args = {
                                [1] = tostring(v.Parent.Name), -- Lobby 
                                [2] = getgenv().level, -- World
                                [3] = true, -- Friends Only or not
                                [4] = getgenv().difficulty
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.request_lock_level:InvokeServer(unpack(args))
                        end

                        local args = { 
                            [1] =tostring(v.Parent.Name)
                        }
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:InvokeServer(unpack(args))
                        getgenv().door = v.Parent.Name print(v.Parent.Name) --v.Parent:GetFullName()
                        plr.Character.HumanoidRootPart.CFrame = v.Parent.Door.CFrame
                        break
                    end
                end
            end

            task.wait()

            plr.Character.HumanoidRootPart.CFrame = cpos

            if Workspace._LOBBIES.Story[getgenv().door].Owner == plr.Name then
                if Workspace._LOBBIES.Story[getgenv().door].Teleporting.Value == true then
                    getgenv().teleporting = false
                else
                    getgenv().teleporting = true
                end
            end

            warn("farming")
            task.wait(3)
        end

    ----------//test starraid \\-------------- game:GetService("Workspace")["_RAID"].Raid

elseif getgenv().autostart == false and getgenv().AutoFarmRaid and getgenv().AutoFarm  then
    if game.PlaceId == 8304191830 then
        local cpos = plr.Character.HumanoidRootPart.CFrame

        if tostring(Workspace._RAID.Raid[getgenv().doorraid].Owner.Value) ~= plr.Name then
            for i, v in pairs(game:GetService("Workspace")["_RAID"].Raid:GetDescendants()) do
                if v.Name == "Owner" and v.Value == nil then

                    local args = {
                        [1] = tostring(v.Parent.Name)
                    }
                    game:GetService("ReplicatedStorage").endpoints.client_to_server.request_join_lobby:InvokeServer(unpack(args))

                    task.wait()

                    if getgenv().level:match("RAID") then
                        local args = {
                            [1] = tostring(v.Parent.Name), -- Lobby 
                            [2] = getgenv().level, -- World
                            [3] = true, -- Friends Only or not
                            [4] = "Hard"
                        }
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.request_lock_level:InvokeServer(unpack(args))
                    else
                        local args = {
                            [1] = tostring(v.Parent.Name), -- Lobby 
                            [2] = getgenv().level, -- World
                            [3] = true, -- Friends Only or not
                            [4] = getgenv().difficulty
                        }
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.request_lock_level:InvokeServer(unpack(args))
                    end

                    local args = { 
                        [1] =tostring(v.Parent.Name)
                    }
                    game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:InvokeServer(unpack(args))
                    getgenv().doorraid = v.Parent.Name print(v.Parent.Name) --v.Parent:GetFullName()
                    plr.Character.HumanoidRootPart.CFrame = v.Parent.door.CFrame
                    break
                end
            end
        end

        task.wait()

        plr.Character.HumanoidRootPart.CFrame = cpos

        if Workspace._RAID.Raid[getgenv().doorraid].Owner == plr.Name then
            if Workspace._RAID.Raid[getgenv().doorraid].Teleporting.Value == true then
                getgenv().teleporting = false
            else
                getgenv().teleporting = true
            end
        end

        warn("raid farming")
        task.wait(3)
    end
    --end raid game:GetService("Workspace")["_RAID"].Raid 

        ----------//test star นิ้ว jjkfinger \\-------------- 

elseif getgenv().autostart == false and getgenv().AutoFarmJJK and getgenv().AutoFarm  then
    if game.PlaceId == 8304191830 then
        local cpos = plr.Character.HumanoidRootPart.CFrame
        local string_1 = "_lobbytemplate_event222";
        local table_1 = {
        ["selected_key"] = 'key_jjk_finger'
        };
        local Target = game:GetService("ReplicatedStorage").endpoints["client_to_server"]["request_join_lobby"];
        Target:InvokeServer(string_1, table_1);


        if tostring(Workspace._DUNGEONS.Lobbies[getgenv().doorjjk].Owner.Value) ~= plr.Name then
            for i, v in pairs(game:GetService("Workspace")["_DUNGEONS"].Lobbies:GetDescendants()) do
                if v.Name == "Owner" and v.Value == nil then

                    local args = {
                        [1] = tostring(v.Parent.Name)
                    }
                    game:GetService("ReplicatedStorage").endpoints.client_to_server.request_join_lobby:InvokeServer(unpack(args))

                    task.wait()

                    if getgenv().level:match("Dungeon") then
                        local args = {
                            [1] = tostring(v.Parent.Name), -- Lobby 
                            [2] = getgenv().level, -- World
                            [3] = true, -- Friends Only or not
                            [4] = "Hard"
                        }
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.request_lock_level:InvokeServer(unpack(args))
                    else
                        local args = {
                            [1] = tostring(v.Parent.Name), -- Lobby 
                            [2] = getgenv().level, -- World
                            [3] = true, -- Friends Only or not
                            [4] = getgenv().difficulty
                        }
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.request_lock_level:InvokeServer(unpack(args))
                    end

                    local args = { 
                        [1] =tostring(v.Parent.Name)
                    }
                    game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:InvokeServer(unpack(args))
                    getgenv().doorjjk = v.Parent.Name print(v.Parent.Name) --v.Parent:GetFullName()
                    plr.Character.HumanoidRootPart.CFrame = v.Parent.door.CFrame
                    break
                end
            end
        end

        task.wait()

        plr.Character.HumanoidRootPart.CFrame = cpos

        if Workspace._DUNGEONS.Lobbies[getgenv().doorjjk].Owner == plr.Name then
            if Workspace._DUNGEONS.Lobbies[getgenv().doorjjk].Teleporting.Value == true then
                getgenv().teleporting = false
            else
                getgenv().teleporting = true
            end
        end

        warn("JJK farming")
        task.wait(3)
    end
    --end นิ้ว jjkfinger

--fixportal  ----Devil Portal

elseif getgenv().autostart == false and getgenv().farmprotal or getgenv().farmportal and getgenv().AutoFarm  then

        for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.items.grid.List.Outer.ItemFrames:GetChildren()) do
            if v.Name == "portal_csm" or v.Name == "portal_csm1" or v.Name == "portal_csm2" or v.Name == "portal_csm3" or v.Name == "portal_csm4" or v.Name == "portal_csm5"  then
                print(v._uuid_or_id.value)
                getgenv().PortalID = v._uuid_or_id.value
                break;
            end
        end
          task.wait(1.5)
          local args = {
            [1] = getCSMPortals()[1]["uuid"],
            [2] = {
                ["friends_only"] = true
            }
        }
		game:GetService("ReplicatedStorage").endpoints.client_to_server.use_portal:InvokeServer(unpack(args))

        task.wait(1.5)

        for i,v in pairs(game:GetService("Workspace")["_PORTALS"].Lobbies:GetDescendants()) do
            if v.Name == "Owner" then
                if tostring(v.value) == game.Players.LocalPlayer.Name then
                    local args = {
                        [1] = tostring(v.Parent.Name)
                    }
                    
                    game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:InvokeServer(unpack(args))
                    break;
                end
            end 
        end

        warn("Devil farming")
        task.wait(7)

        ---Aline PortalAutoFarmRaid
    elseif getgenv().autostart == false and getgenv().AutoFarm and getgenv().teleporting 
    and getgenv().AutoFarmTP == false and getgenv().AutoFarmIC == false and getgenv().AutoFarmRaid == false and getgenv().AutoFarmJJK == false and getgenv().farmprotal == false and getgenv().farmaline  then  


        for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.items.grid.List.Outer.ItemFrames:GetChildren()) do
            if v.Name == "portal_boros_g" then
                print(v._uuid_or_id.value)
                getgenv().PortalIDA = v._uuid_or_id.value
                break;
            end
        end
        task.wait(1.5)
        local args = {
            [1] = getBorosPortals()[1]["uuid"],
            [2] = {
                ["friends_only"] = true
            }
        }
        game:GetService("ReplicatedStorage").endpoints.client_to_server.use_portal:InvokeServer(unpack(args))

        task.wait(1.5)

        for i,v in pairs(game:GetService("Workspace")["_PORTALS"].Lobbies:GetDescendants()) do
            if v.Name == "Owner" then
                if tostring(v.value) == game.Players.LocalPlayer.Name then
                    local args = {
                        [1] = tostring(v.Parent.Name)
                    }
                    
                    game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:InvokeServer(unpack(args))
                    break;
                end
            end 
        end

        warn("Aline farming")
        task.wait(7)
    end
end

---------end Aline 

local function startChallenge()
    if game.PlaceId == 8304191830 then
        local cpos = plr.Character.HumanoidRootPart.CFrame

        if getgenv().AutoChallenge and getgenv().autostart and getgenv().AutoFarm  and checkReward() == true then

            for i, v in pairs(game:GetService("Workspace")["_CHALLENGES"].Challenges:GetDescendants()) do
                if v.Name == "Owner" and v.Value == nil then
                    --print(v.Parent.Name.." "..v.Parent:GetFullName())
                    local args = { 
                        [1] = tostring(v.Parent.Name)
                    }
                    game:GetService("ReplicatedStorage").endpoints.client_to_server.request_join_lobby:InvokeServer(unpack(args))

                    getgenv().chdoor = v.Parent.Name
                    break
                end
            end
            task.wait()
            plr.Character.HumanoidRootPart.CFrame = cpos
           
        end
    end
end

coroutine.resume(coroutine.create(function()
    while task.wait() do
        if getgenv().AutoFarmIC == false and getgenv().AutoFarmTP == false then
            if checkChallenge() == false  then --challenge is not cleared
                if  getgenv().AutoChallenge and checkReward() == true then
                    startChallenge() --start challenge
                else
                    startfarming()--regular farming
                end
            elseif checkChallenge() == true then
                startfarming()--regular farming
            end
        end
    end
end))
--#endregion

------// Auto Start Infiniy Castle && Thriller Park \\------

local function FarmCastlePark()
    if getgenv().AutoFarmIC and getgenv().AutoFarm then
        if game.PlaceId == 8304191830 then

            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(12423.1855, 155.24025, 3198.07593, -1.34111269e-06, -2.02512282e-08, 1, 3.91705386e-13, 1, 2.02512282e-08, -1, 4.18864542e-13, -1.34111269e-06)
            
            getgenv().infinityroom = 0

            for i, v in pairs(game:GetService("Players")[game.Players.LocalPlayer.Name].PlayerGui.InfiniteTowerUI.LevelSelect.InfoFrame.LevelButtons:GetChildren()) do
                if v.Name == "FloorButton" then
                    if v.clear.Visible == false and v.Locked.Visible == false then
                        local room = string.split(v.Main.text.Text, " ")

                        local args = {
                            [1] = tonumber(room[2])
                        }
                        
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_infinite_tower:InvokeServer(unpack(args))
                        getgenv().infinityroom = tonumber(room[2])
                        break
                    end
                end
            end
            
            task.wait(6)
        end
    elseif getgenv().AutoFarmTP and getgenv().AutoFarm then
        if game.PlaceId == 8304191830 then

            local cpos = plr.Character.HumanoidRootPart.CFrame

            for i, v in pairs(game:GetService("Workspace")["_EVENT_CHALLENGES"].Lobbies:GetDescendants()) do
                    if v.Name == "Owner" and v.Value == nil then

                        local args = {
                            [1] = tostring(v.Parent.Name)
                        }
                        
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.request_join_lobby:InvokeServer(unpack(args))

                        task.wait()

                        plr.Character.HumanoidRootPart.CFrame = v.Parent.Door.CFrame
                        break
                    end
                end

            task.wait()

            plr.Character.HumanoidRootPart.CFrame = cpos
            warn("farming")
            task.wait(5)

        end
    end
end

coroutine.resume(coroutine.create(function()
    while task.wait() do
        if checkChallenge() == false  then --challenge is not cleared
            if  getgenv().AutoChallenge and checkReward() == true then
                startChallenge() --start challenge
            else
                FarmCastlePark()--regular farming
            end
        elseif checkChallenge() == true then
            FarmCastlePark()--regular farming
        end
    end
end)) 

if getgenv().AutoLoadTP == true then
    local exec = tostring(identifyexecutor())

    if exec == "Synapse X" then
        syn.queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/siradaniy/HSz/main/AA_HSz_b1.lua'))()")
    else
        queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/siradaniy/HSz/main/AA_HSz_b1.lua'))()")
    end

end


--hide name
task.spawn(function()  -- Hides name for yters (not sure if its Fe)
    while task.wait() do
        pcall(function()
            if game.Players.LocalPlayer.Character.Head:FindFirstChild("_overhead") then
               workspace[game.Players.LocalPlayer.Name].Head["_overhead"]:Destroy()
            end
        end)
    end
end)


--anti afk
pcall(function()
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:connect(function()
    vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)

    game:GetService("ReplicatedStorage").endpoints.client_to_server.claim_daily_reward:InvokeServer()
end)

print("Successfully Loaded ใช้งานโลดดดดดดดด!!")
---------------------------------------------------------------------
