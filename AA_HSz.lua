local versionx = "1.1.0"

---// Loading Section \\---
task.wait(2)
repeat  task.wait() until game:IsLoaded()
if game.PlaceId == 8304191830 then
    repeat task.wait() until game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name)
    repeat task.wait() until game.Players.LocalPlayer.PlayerGui:FindFirstChild("collection"):FindFirstChild("grid"):FindFirstChild("List"):FindFirstChild("Outer"):FindFirstChild("UnitFrames")
else
    repeat task.wait() until game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name)
    game:GetService("ReplicatedStorage").endpoints.client_to_server.vote_start:InvokeServer()
    repeat task.wait() until game:GetService("Workspace")["_waves_started"].Value == true
end
------------------------------
local HttpService = game:GetService("HttpService")
local Workspace = game:GetService("Workspace") 
local plr = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local mouse = game.Players.LocalPlayer:GetMouse()
local UserInputService = game:GetService("UserInputService")

getgenv().savefilename = "Anime-Adventures_HSz_UPD10_fix"..game.Players.LocalPlayer.Name..".json"
getgenv().door = "_lobbytemplategreen1"

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


--#region Webhook Sender
local function webhook()
	pcall(function()
		local url = tostring(getgenv().weburl) --webhook
		print("webhook?")
		if url == "" then return end 
        
		local Time = os.date('!*t', OSTime);

		local thumbnails_avatar = HttpService:JSONDecode(game:HttpGet("https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds=" .. game:GetService("Players").LocalPlayer.UserId .. "&size=150x150&format=Png&isCircular=true", true))

    	XP = tostring(game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Holder.LevelRewards.ScrollingFrame.XPReward.Main.Amount.Text)
        if XP == "+99999" then
			XP = "+0"
		end
		gems = tostring(game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Holder.LevelRewards.ScrollingFrame.GemReward.Main.Amount.Text)
        if gems == "+99999" then
			gems = "+0"
		end
		gold = tostring(game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Holder.LevelRewards.ScrollingFrame.GoldReward.Main.Amount.Text)
		if gold == "+99999" then
			gold = "+0"
		end
		cwaves = game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Holder.Middle.WavesCompleted.Text
		ctime = game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Holder.Middle.Timer.Text
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

		local data = {
			["content"] = "",
			["username"] = "Anime Adventures",
			["avatar_url"] = "https://tr.rbxcdn.com/33e128db5189ee794a9d8255e4b80044/150/150/Image/Png",
			["embeds"] = {
				{
					["author"] = {
						["name"] = "Anime Adventures | แจ้งเตือน ✔",
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
                            ["value"] = tostring(ttime[2]) .. " ⏳",
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
                            ["name"] = "Ice Star:",
                            ["value"] = tostring(game.Players.LocalPlayer._stats._resourceHolidayStars.Value).. " ⭐",
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
    getgenv().AutoReplay = data.AutoReplay
    getgenv().AutoChallenge = data.AutoChallenge  
    getgenv().selectedreward = data.selectedreward
    getgenv().AutoChallengeAll = data.AutoChallengeAll
    getgenv().disableatuofarm = false
    getgenv().sellatwave = data.sellatwave 
    getgenv().autosell = data.autosell
    getgenv().AutoFarm = data.autofarm
    getgenv().AutoFarmIC = data.autofarmic
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
    --\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\--

    -- Uilib Shits

    local exec = tostring(identifyexecutor())

    local DiscordLib = loadstring(game:HttpGet "https://raw.githubusercontent.com/siradaniy/HSz/main/DiscordLid2.lua")()
    local win = DiscordLib:Window("HSz Member [👊UPD 10] Anime Adventures "..versionx.." - "..exec)
       
    if exec == "Synapse X" or exec == "ScriptWare" or exec == "Trigon" then
        print("Good boi")
    else
        local gettrigonserver = win:Server("Support Member Ship!", "http://www.roblox.com/asset/?id=12281640494")
        local gettrigon = gettrigonserver:Channel(" HOLYSHz Member Only")
        gettrigon:Label("Thank for Support")
        gettrigon:Label("อย่าลืมต่อ Member กันด้วยละ")
        gettrigon:Button("👉 Copy HOLYSHz Member Link!", function()
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

        local function loadUnit()
            repeat task.wait() until game.Players.LocalPlayer.PlayerGui:FindFirstChild("collection"):FindFirstChild("grid"):FindFirstChild("List"):FindFirstChild("Outer"):FindFirstChild("UnitFrames")
            task.wait(2)
            table.clear(Units)
            for i, v in pairs(game:GetService("Players")[game.Players.LocalPlayer.Name].PlayerGui.collection.grid.List.Outer.UnitFrames:GetChildren()) do
                if v.Name == "CollectionUnitFrame" then
                    repeat task.wait() until v:FindFirstChild("_uuid")
                    table.insert(Units, v.name.Text .. " #" .. v._uuid.Value)
                end
            end
        end

        loadUnit()

        local function Check(x, y)
            for i, v in ipairs(game:GetService("Players").LocalPlayer.PlayerGui.collection.grid.List.Outer.UnitFrames:GetChildren()) do
                if v:IsA("ImageButton") then
                    if v.EquippedList.Equipped.Visible == true then
                        if v.Main.petimage:GetChildren()[2].Name == x then
                            --print(v.name.Text.." #"..v._uuid.Value)
                            getgenv().SelectedUnits["U"..tostring(y)] = tostring(v.name.Text.." #"..v._uuid.Value)
                            updatejson()
                            return true
                        end
                    end
                end
            end
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
            for i, v in ipairs(game:GetService("Players").LocalPlayer.PlayerGui["spawn_units"].Lives.Frame.Units:GetChildren()) do
                if v:IsA("ImageButton") then
                    local unitxx = v.Main.petimage.WorldModel:GetChildren()[1]
                    if unitxx ~= nil then
                        if Check(unitxx.Name,v) then
                            print(unitxx, v)
                        end
                    end
                end
            end
            DiscordLib:Notification("ใส่ Units ที่เลือกแล้ว!", "เมนูแบบเลื่อนลงอาจไม่แสดงชื่อหน่วยในขณะนี้ แต่จะแสดงในครั้งต่อไปที่คุณดำเนินการ!", "Okay!")

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

            loadUnit()
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
--------------- Select World Tab -----------------
--------------------------------------------------
--#region Select world tab
        getgenv().levels = {"nill"}

        getgenv().diff = slectworld:Dropdown("Select Difficulty", {"Normal", "Hard"}, getgenv().difficulty, function(diff)
            getgenv().difficulty = diff
            updatejson()
        end)

        local worlddrop = slectworld:Dropdown("Select World", {"Plannet Namak", "Shiganshinu District", "Snowy Town","Hidden Sand Village", "Marine's Ford",
        "Ghoul City", "Hollow World", "Ant Kingdom", "Magic Town", "Cursed Academy","Clover Kingdom", "Clover Legend - HARD","Hollow Legend - HARD","Cape Canaveral",
        "JoJo Legend - HARD","Alien Spaceship"}, getgenv().world, function(world)
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
                getgenv().levels = {"bleach_legend_1","bleach_legend_2","bleach_legend_3","bleach_legend_4","bleach_legend_5",}
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
            end
        end)

      
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
------------------ Auto Farm Tab -----------------
--------------------------------------------------
--#region Auto Farm Tab
autofarmtab:Toggle("Auto Replay เล่นซ้ำ", getgenv().AutoReplay, function(bool)
    getgenv().AutoReplay = bool
    updatejson()
end)
autofarmtab:Toggle("Auto Leave", getgenv().AutoLeave, function(bool)
    getgenv().AutoLeave = bool
    updatejson()
end)
autofarmtab:Toggle("Auto Farm ประตูน้ำแข็ง", getgenv().AutoFarmTP, function(bool)
    getgenv().AutoFarmTP = bool
    updatejson()
end)

autofarmtab:Toggle("Auto Start หอคอย", getgenv().AutoFarmIC, function(bool)
    getgenv().AutoFarmIC = bool
    updatejson()
end)
autofarmtab:Toggle("Auto Farm วางตัว [ต้องเปิด]", getgenv().AutoFarm, function(bool)
    getgenv().AutoFarm = bool
    updatejson()
end)

autofarmtab:Toggle("Auto Start", getgenv().autostart, function(bool)
    getgenv().autostart = bool
    updatejson()
end)

autofarmtab:Toggle("Auto Abilities", getgenv().autoabilities, function(bool)
    getgenv().autoabilities = bool
    updatejson()
end)

autofarmtab:Toggle("Auto Upgrade Units", getgenv().autoupgrade, function(bool)
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
        --queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/siradaniy/HSz/main/AA_HSz.lua'))()")
        getgenv().AutoLoadTP = bool
        updatejson()
        if exec == "Synapse X" and getgenv().AutoLoadTP then
            syn.queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/siradaniy/HSz/main/AA_HSz.lua'))()")
        elseif exec ~= "Synapse X" and getgenv().AutoLoadTP then
            queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/siradaniy/HSz/main/AA_HSz.lua'))()")
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
        misc:Toggle("Auto Summon {Use Ticket 1}", getgenv().autosummonticketse, function(bool)
            getgenv().autosummonticketse = bool
            while getgenv().autosummonticketse do
                autobuyfunc("EventClover", "ticket")
            end
            updatejson()
        end)

        misc:Toggle("Auto Summon {Buy 1}", getgenv().autosummongeme, function(bool)
            getgenv().autosummongeme = bool
            while getgenv().autosummongeme do
                autobuyfunc("EventClover", "gems")
            end
            updatejson()
        end)

        misc:Toggle("Auto Summon {Buy 10}", getgenv().autosummongem10e, function(bool)
            getgenv().autosummongem10 = bool
            while getgenv().autosummongem10 do
                autobuyfunc("EventClover", "gems10")
            end
            updatejson()
        end)
        misc:Label("Standard")
        misc:Toggle("Auto Summon {Use Ticket 1}", getgenv().autosummontickets, function(bool)
            getgenv().autosummontickets = bool
            while getgenv().autosummontickets do
                autobuyfunc("Standard", "ticket")
            end
            updatejson()
        end)

        misc:Toggle("Auto Summon {Buy 1}", getgenv().autosummongem, function(bool)
            getgenv().autosummongem = bool
            while getgenv().autosummongem do
                autobuyfunc("Standard", "gems")
            end
            updatejson()
        end)

        misc:Toggle("Auto Summon {Buy 10}", getgenv().autosummongem10, function(bool)
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
                syn.queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/siradaniy/HSz/main/AA_HSz.lua'))()")
            elseif exec ~= "Synapse X" and getgenv().AutoLoadTP then
                queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/siradaniy/HSz/main/AA_HSz.lua'))()")
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
    
    devilcity:Toggle("Auto Farm ประตู Devil", getgenv().farmprotal, function(bool)
        getgenv().farmprotal = bool
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
autofarmtab:Toggle("Auto Replay เล่นซ้ำ", getgenv().AutoReplay, function(bool)
    getgenv().AutoReplay = bool
    updatejson()
end)
autofarmtab:Toggle("Auto Leave", getgenv().AutoLeave, function(bool)
    getgenv().AutoLeave = bool
    updatejson()
end)
autofarmtab:Toggle("Auto Farm ประตูน้ำแข็ง", getgenv().AutoFarmTP, function(bool)
    getgenv().AutoFarmTP = bool
    updatejson()
end)

autofarmtab:Toggle("Auto Start หอคอย", getgenv().AutoFarmIC, function(bool)
    getgenv().AutoFarmIC = bool
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

autofarmtab:Toggle("Auto Start", getgenv().autostart, function(bool)
    getgenv().autostart = bool
    updatejson()
end)

autofarmtab:Toggle("Auto Upgrade Units", getgenv().autoupgrade, function(bool)
    getgenv().autoupgrade = bool
    updatejson()
end)


        function MouseClick(UnitPos)
            local connection
            local _map = game:GetService("Workspace")["_BASES"].player.base["fake_unit"]:WaitForChild("HumanoidRootPart")
            connection = UserInputService.InputBegan:Connect(
                function(input, gameProcessed)
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

                        if game.Workspace._map:FindFirstChild("namek mushroom model") then
                            print("Namak")
                            SpawnUnitPos["Namak"][UnitPos]["x"] = a.Position.X
                            SpawnUnitPos["Namak"][UnitPos]["y"] = a.Position.Y
                            SpawnUnitPos["Namak"][UnitPos]["z"] = a.Position.Z
                        elseif game.Workspace._map:FindFirstChild("houses_new") then
                            print("Aot")
                            SpawnUnitPos["Aot"][UnitPos]["x"] = a.Position.X
                            SpawnUnitPos["Aot"][UnitPos]["y"] = a.Position.Y
                            SpawnUnitPos["Aot"][UnitPos]["z"] = a.Position.Z
                        elseif game.Workspace._map:FindFirstChild("Snow Particles") then
                            print("Snowy")
                            SpawnUnitPos["Snowy"][UnitPos]["x"] = a.Position.X
                            SpawnUnitPos["Snowy"][UnitPos]["y"] = a.Position.Y
                            SpawnUnitPos["Snowy"][UnitPos]["z"] = a.Position.Z
                        elseif game.Workspace._map:FindFirstChild("sand_gate") then
                            warn("Sand")
                            SpawnUnitPos["Sand"][UnitPos]["x"] = a.Position.X
                            SpawnUnitPos["Sand"][UnitPos]["y"] = a.Position.Y
                            SpawnUnitPos["Sand"][UnitPos]["z"] = a.Position.Z
                        elseif game.Workspace._map:FindFirstChild("icebergs") then
                            print("Marine")
                            SpawnUnitPos["Marine"][UnitPos]["x"] = a.Position.X
                            SpawnUnitPos["Marine"][UnitPos]["y"] = a.Position.Y
                            SpawnUnitPos["Marine"][UnitPos]["z"] = a.Position.Z
                        elseif game.Workspace._map:FindFirstChild("Helicopter Pad") then
                            print("Ghoul")
                            SpawnUnitPos["Ghoul"][UnitPos]["x"] = a.Position.X
                            SpawnUnitPos["Ghoul"][UnitPos]["y"] = a.Position.Y
                            SpawnUnitPos["Ghoul"][UnitPos]["z"] = a.Position.Z
                        elseif game.Workspace._map:FindFirstChild("Bones/dust") then
                            print("Hollow")
                            SpawnUnitPos["Hollow"][UnitPos]["x"] = a.Position.X
                            SpawnUnitPos["Hollow"][UnitPos]["y"] = a.Position.Y
                            SpawnUnitPos["Hollow"][UnitPos]["z"] = a.Position.Z
                        elseif game.Workspace._map:FindFirstChild("Ant Nest") then
                            print("Ant")
                            SpawnUnitPos["Ant"][UnitPos]["x"] = a.Position.X
                            SpawnUnitPos["Ant"][UnitPos]["y"] = a.Position.Y
                            SpawnUnitPos["Ant"][UnitPos]["z"] = a.Position.Z
                        elseif game.Workspace._map:FindFirstChild("light poles") then
                            print("Magic")
                            SpawnUnitPos["Magic"][UnitPos]["x"] = a.Position.X
                            SpawnUnitPos["Magic"][UnitPos]["y"] = a.Position.Y
                            SpawnUnitPos["Magic"][UnitPos]["z"] = a.Position.Z
                        elseif game.Workspace._map:FindFirstChild("LanternsGround") then
                            print("Cursed")    
                            SpawnUnitPos["Cursed"][UnitPos]["x"] = a.Position.X
                            SpawnUnitPos["Cursed"][UnitPos]["y"] = a.Position.Y
                            SpawnUnitPos["Cursed"][UnitPos]["z"] = a.Position.Z
                        elseif game.Workspace._map:FindFirstChild("pumpkins") then
                            print("thriller_park")    
                            SpawnUnitPos["thriller_park"][UnitPos]["x"] = a.Position.X
                            SpawnUnitPos["thriller_park"][UnitPos]["y"] = a.Position.Y
                            SpawnUnitPos["thriller_park"][UnitPos]["z"] = a.Position.Z
                        elseif game.Workspace._map:FindFirstChild("skeleton") then
                            print("black_clover")    
                            SpawnUnitPos["black_clover"][UnitPos]["x"] = a.Position.X
                            SpawnUnitPos["black_clover"][UnitPos]["y"] = a.Position.Y
                            SpawnUnitPos["black_clover"][UnitPos]["z"] = a.Position.Z
                        elseif game.Workspace._map:FindFirstChild("graves") then
                            print("hollow_leg")    
                            SpawnUnitPos["hollow_leg"][UnitPos]["x"] = a.Position.X
                            SpawnUnitPos["hollow_leg"][UnitPos]["y"] = a.Position.Y
                            SpawnUnitPos["hollow_leg"][UnitPos]["z"] = a.Position.Z
                        elseif game.Workspace._map:FindFirstChild("SpaceCenter") then
                            print("Cape Canaveral")    
                            SpawnUnitPos["jojo"][UnitPos]["x"] = a.Position.X
                            SpawnUnitPos["jojo"][UnitPos]["y"] = a.Position.Y
                            SpawnUnitPos["jojo"][UnitPos]["z"] = a.Position.Z
                        elseif game.Workspace._map:FindFirstChild("vending machines") then
                            print("chainsaw")    
                            SpawnUnitPos["chainsaw"][UnitPos]["x"] = a.Position.X
                            SpawnUnitPos["chainsaw"][UnitPos]["y"] = a.Position.Y
                            SpawnUnitPos["chainsaw"][UnitPos]["z"] = a.Position.Z
                        elseif game.Workspace._map:FindFirstChild("SpaceCenter") then
                            print("JoJo Legend - HARD")    
                            SpawnUnitPos["jojo_leg"][UnitPos]["x"] = a.Position.X
                            SpawnUnitPos["jojo_leg"][UnitPos]["y"] = a.Position.Y
                            SpawnUnitPos["jojo_leg"][UnitPos]["z"] = a.Position.Z    
                        elseif game.Workspace._map:FindFirstChild("portal_boros_g") then
                            print("Alien Portal")    
                            SpawnUnitPos["opm_leg"][UnitPos]["x"] = a.Position.X
                            SpawnUnitPos["opm_leg"][UnitPos]["y"] = a.Position.Y
                            SpawnUnitPos["opm_leg"][UnitPos]["z"] = a.Position.Z        
                        elseif game.Workspace._map:FindFirstChild("secret") then
                            print("Alien Spaceship")    
                            SpawnUnitPos["opm"][UnitPos]["x"] = a.Position.X
                            SpawnUnitPos["opm"][UnitPos]["y"] = a.Position.Y
                            SpawnUnitPos["opm"][UnitPos]["z"] = a.Position.Z
                        end
                        

                        updatejson()
                    end
                end)
        end

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
    setclipboard("https://farm.starbuxstore.com/shop?tab=shop&q=Anime%20Adventures%20ID")
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
    setclipboard("shorturl.at/EMQ17")
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
        autostart = false,
        autoloadtp = false,
        autoupgrade = false,
        difficulty = "nil",
        world = "nil",
        level = "nil",
        door = "nil",
    
        xspawnUnitPos  = {
            black_clover  = {
                UP1  = {
                    y  = 4.233243942260742,
                    x  = -59.31547927856445,
                    z  = -14.749141693115234
                 },
                  UP3  = {
                    y  = 4.232996940612793,
                    x  = -38.23970031738281,
                    z  = 12.037586212158203
                 },
                  UP2  = {
                    y  = 9.241189002990723,
                    x  = -66.3019027709961,
                    z  = -19.23602867126465
                 },
                  UP6  = {
                    y  = 4.233219146728516,
                    x  = -65.29586791992188,
                    z  = -40.6997184753418
                 },
                  UP5  = {
                    y  = 4.233260154724121,
                    x  = -55.7475700378418,
                    z  = -35.305747985839844
                 },
                  UP4  = {
                    y  = 9.900957107543945,
                    x  = -37.22032165527344,
                    z  = 3.945315361022949
             }
           },
           hollow_leg = {
            UP1 = {
                x = -192.57211303710938,
                y = 39.043453216552734, 
                z = 522.3894653320312
            },
            UP2 = {
                x = -189.09117126464844, 
                y = 43.49571228027344, 
                z = 508.0011291503906
            },
            UP3 = {
                x = -196.6421661376953, 
                y = 39.04340744018555, 
                z = 482.28411865234375
               
            },
            UP4 = {
                x = -189.88270568847656, 
                y = 43.49575424194336, 
                z = 500.2121276855469
            },
            UP5 = {
                x = -233.00912475585938, 
                y = 39.04327392578125, 
                z = 502.5986633300781
            },
            UP6 = {
                x = -231.87318420410156, 
                y = 39.04328155517578, 
                z = 495.189208984375
            }
           },
            Cursed  = {
                UP1  = {
                    y  = 124.89727020263672,
                    x  = 351.5869140625,
                    z  = -160.93724060058594
                 },
                  UP3  = {
                    y  = 124.97206115722656,
                    x  = 307.2110900878906,
                    z  = -109.24397277832031
                 },
                  UP2  = {
                    y  = 129.0974884033203,
                    x  = 340.3296813964844,
                    z  = -161.85208129882812
                 },
                  UP6  = {
                    y  = 124.95498657226562,
                    x  = 332.0729064941406,
                    z  = -93.70829772949219
                 },
                  UP5  = {
                    y  = 124.95631408691406,
                    x  = 330.1289367675781,
                    z  = -106.5566635131836
                 },
                  UP4  = {
                    y  = 127.7710952758789,
                    x  = 312.7218933105469,
                    z  = -99.5513687133789
             }
           },
            Sand  = {
                UP1  = {
                    y  = 28.28097915649414,
                    x  = -890.0916137695312,
                    z  = 314.10345458984375
                 },
                  UP3  = {
                    y  = 28.280975341796875,
                    x  = -893.39208984375,
                    z  = 287.6628112792969
                 },
                  UP2  = {
                    y  = 32.56867599487305,
                    x  = -894.2457885742188,
                    z  = 318.3748779296875
                 },
                  UP6  = {
                    y  = 28.280914306640625,
                    x  = -869.957763671875,
                    z  = 318.6862487792969
                 },
                  UP5  = {
                    y  = 28.280654907226562,
                    x  = -876.4010009765625,
                    z  = 318.6846618652344
                 },
                  UP4  = {
                    y  = 34.5429573059082,
                    x  = -880.2827758789062,
                    z  = 297.32562255859375
             }
           },
            Namak  = {
                UP1  = {
                    y  = 94.80620574951172,
                    x  = -2956.620849609375,
                    z  = -714.4996337890625
                 },
                  UP3  = {
                    y  = 94.80618286132812,
                    x  = -2918.517333984375,
                    z  = -730.8157348632812
                 },
                  UP2  = {
                    y  = 97.41859436035156,
                    x  = -2951.377197265625,
                    z  = -716.8060913085938
                 },
                  UP6  = {
                    y  = 94.80619812011719,
                    x  = -2925.846435546875,
                    z  = -701.25390625
                 },
                  UP5  = {
                    y  = 94.81072998046875,
                    x  = -2925.618896484375,
                    z  = -709.9654541015625
                 },
                  UP4  = {
                    y  = 97.39073944091797,
                    x  = -2879.582275390625,
                    z  = -737.7210693359375
             }
           },
            Hollow  = {
                UP1  = {
                    y  = 135.66392517089844,
                    x  = -165.0266571044922,
                    z  = -715.7265625
                 },
                  UP3  = {
                    y  = 135.66384887695312,
                    x  = -233.5709686279297,
                    z  = -660.9861450195312
                 },
                  UP2  = {
                    y  = 139.34066772460938,
                    x  = -175.31907653808594,
                    z  = -708.5353393554688
                 },
                  UP6  = {
                    y  = 135.66390991210938,
                    x  = -148.3011474609375,
                    z  = -719.6495361328125
                 },
                  UP5  = {
                    y  = 135.66392517089844,
                    x  = -157.43101501464844,
                    z  = -732.3544921875
                 },
                  UP4  = {
                    y  = 140.4937744140625,
                    x  = -220.6124267578125,
                    z  = -651.38330078125
             }
           },
            Ant  = {
                UP1  = {
                    y  = 26.012632369995117,
                    x  = -169.46522521972656,
                    z  = 2963.9541015625
                 },
                  UP3  = {
                    y  = 26.012632369995117,
                    x  = -141.493896484375,
                    z  = 3005.433349609375
                 },
                  UP2  = {
                    y  = 34.05636215209961,
                    x  = -172.1795196533203,
                    z  = 2971.837158203125
                 },
                  UP6  = {
                    y  = 26.01263427734375,
                    x  = -162.243896484375,
                    z  = 2943.75634765625
                 },
                  UP5  = {
                    y  = 26.012632369995117,
                    x  = -177.58714294433594,
                    z  = 2951.063232421875
                 },
                  UP4  = {
                    y  = 29.16413688659668,
                    x  = -140.66038513183594,
                    z  = 2989.589599609375
             }
           },
            Aot  = {
                UP1  = {
                    y  = 36.74178695678711,
                    x  = -3010.0390625,
                    z  = -684.7892456054688
                 },
                  UP3  = {
                    y  = 36.74178695678711,
                    x  = -2977.2900390625,
                    z  = -711.2384033203125
                 },
                  UP2  = {
                    y  = 41.23928451538086,
                    x  = -3014.18359375,
                    z  = -687.8216552734375
                 },
                  UP6  = {
                    y  = 36.74179458618164,
                    x  = -3004.541748046875,
                    z  = -661.7230834960938
                 },
                  UP5  = {
                    y  = 36.741798400878906,
                    x  = -3011.074951171875,
                    z  = -661.494140625
                 },
                  UP4  = {
                    y  = 41.83006286621094,
                    x  = -2990.846923828125,
                    z  = -723.219970703125
             }
           },
            Snowy  = {
                UP1  = {
                    y  = 37.34696960449219,
                    x  = -2864.549560546875,
                    z  = -124.55713653564453
                 },
                  UP3  = {
                    y  = 37.359893798828125,
                    x  = -2933.601318359375,
                    z  = -154.97682189941406
                 },
                  UP2  = {
                    y  = 42.06093215942383,
                    x  = -2877.109375,
                    z  = -125.04695892333984
                 },
                  UP6  = {
                    y  = 37.34697723388672,
                    x  = -2891.855712890625,
                    z  = -133.81826782226562
                 },
                  UP5  = {
                    y  = 37.34696960449219,
                    x  = -2894.031005859375,
                    z  = -142.91297912597656
                 },
                  UP4  = {
                    y  = 40.24900817871094,
                    x  = -2929.740478515625,
                    z  = -148.74620056152344
             }
           },
            Ghoul  = {
                UP1  = {
                    y  = 61.58512878417969,
                    x  = -2997.47900390625,
                    z  = -81.828857421875
                 },
                  UP3  = {
                    y  = 61.584571838378906,
                    x  = -2945.214599609375,
                    z  = -90.4542236328125
                 },
                  UP2  = {
                    y  = 65.84390258789062,
                    x  = -2992.01904296875,
                    z  = -76.64124298095703
                 },
                  UP6  = {
                    y  = 61.585121154785156,
                    x  = -3018.08349609375,
                    z  = -71.79875183105469
                 },
                  UP5  = {
                    y  = 61.585121154785156,
                    x  = -3017.391845703125,
                    z  = -64.38458251953125
                 },
                  UP4  = {
                    y  = 64.84632873535156,
                    x  = -2958.0888671875,
                    z  = -104.31985473632812
             }
           },
            Magic  = {
                UP1  = {
                    y  = 9.749897956848145,
                    x  = -600.001220703125,
                    z  = -819.3095703125
                 },
                  UP3  = {
                    y  = 9.753203392028809,
                    x  = -638.4988403320312,
                    z  = -804.590576171875
                 },
                  UP2  = {
                    y  = 15.93001937866211,
                    x  = -595.7818603515625,
                    z  = -823.0579833984375
                 },
                  UP6  = {
                    y  = 9.747742652893066,
                    x  = -651.8687744140625,
                    z  = -829.0013427734375
                 },
                  UP5  = {
                    y  = 9.750102043151855,
                    x  = -652.0703735351562,
                    z  = -818.4439086914062
                 },
                  UP4  = {
                    y  = 15.903207778930664,
                    x  = -625.4501953125,
                    z  = -824.5261840820312
             }
           },
           --เซ็ทเงินติดถนน
            Marine  = {
                UP1  = {
                    y  = 28.21086883544922,
                    x  = -2576.212158203125,
                    z  = -70.02584075927734
                 },
                  UP3  = {
                    y  = 28.210960388183594,
                    x  = -2612.01513671875,
                    z  = -35.47972869873047
                 },
                  UP2  = {
                    y  = 34.377342224121094,
                    x  = -2582.0732421875,
                    z  = -60.22590255737305
                 },
                  UP6  = {
                    y  = 28.21086883544922,
                    x  = -2561.314453125,
                    z  = -58.36928939819336
                 },
                  UP5  = {
                    y  = 28.210874557495117,
                    x  = -2613.655517578125,
                    z  = -52.236820220947266
                 },
                  UP4  = {
                    y  = 31.358009338378906,
                    x  = -2603.824951171875,
                    z  = -46.777408599853516
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
           chainsaw  = {
            UP1  = {
                x = -357.9891357421875, 
                y = 3.9999992847442627,
                z = -539.1539916992188
                
           },
            UP3  = {
                x = -299.34271240234375,
                y = 3.9999992847442627,
                z = -551.524658203125
           },
            UP2  = {
                x = -358.3482666015625,
                y = 6.915028095245361,
                z = -544.3803100585938
           },
            UP6  = {
                x = -336.8035583496094,
                y = 3.9999992847442627,
                z = -550.25341796875
           },
            UP5  = {
                x = -312.9244384765625,
                y = 3.9999992847442627,
                z = -554.5629272460938
           },
            UP4  = {
                x = -299.5885925292969,
                y = 15.455354690551758,
                z = -565.4340209960938
           }
         },
           jojo = {
            UP1  = {
                x = -93.5505142211914, 
                y = 17.90195655822754, 
                z = -582.4182739257812
             },
              UP3  = {
                x = -47.614036560058594, 
                y = 17.899141311645508, 
                z = -592.3721313476562
             },
              UP2  = {
                x = -89.10867309570312, 
                y = 23.173965454101562, 
                z = -583.8086547851562
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
           jojo_leg = {
            UP1  = {
                x = -93.5505142211914, 
                y = 17.90195655822754, 
                z = -582.4182739257812
             },
              UP3  = {
                x = -47.614036560058594, 
                y = 17.899141311645508, 
                z = -592.3721313476562
             },
              UP2  = {
                x = -89.10867309570312, 
                y = 23.173965454101562, 
                z = -583.8086547851562
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
         opm_leg = {
            UP1  = {
                x = -339.7117614746094, 
                y = 364.21185302734375, 
                z = 1396.416748046875
             },
              UP3  = {
                x = -281.6949462890625, 
                y = 364.21185302734375, 
                z = 1436.8084716796875
             },
              UP2  = {
                x = -334.77142333984375, 
                y = 368.2612609863281, 
                z = 1391.615234375
             },
              UP6  = {
                x = -312.58642578125, 
                y = 364.21185302734375, 
                z = 1425.9600830078125
             },
              UP5  = {
                x = -293.9329833984375, 
                y = 364.21185302734375, 
                z = 1437.103759765625               
             },
              UP4  = {
                x = -261.8616027832031, 
                y = 369.92950439453125, 
                z = 1433.202392578125
           }
         },
           opm = {
            UP1  = {
                x = -339.7117614746094, 
                y = 364.21185302734375, 
                z = 1396.416748046875
             },
              UP3  = {
                x = -281.6949462890625, 
                y = 364.21185302734375, 
                z = 1436.8084716796875
             },
              UP2  = {
                x = -334.77142333984375, 
                y = 368.2612609863281, 
                z = 1391.615234375
             },
              UP6  = {
                x = -312.58642578125, 
                y = 364.21185302734375, 
                z = 1425.9600830078125
             },
              UP5  = {
                x = -293.9329833984375, 
                y = 364.21185302734375, 
                z = 1437.103759765625               
             },
              UP4  = {
                x = -261.8616027832031, 
                y = 369.92950439453125, 
                z = 1433.202392578125
            }
           }
         },

        xselectedUnits = {
            U1 = nil,
            U2 = nil,
            U3 = nil,
            U4 = nil,
            U5 = nil,
            U6 = nil
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
            x = 1.7
            y = 0
            z = 1.7
            print("AutoFarming")
            if game.Workspace._map:FindFirstChild("namek mushroom model") then
                print("Namak")
                for i = 1, 6 do
                    local unitinfo = getgenv().SelectedUnits["U" .. i]
                    if unitinfo ~= nil then
                        local unitinfo_ = unitinfo:split(" #")
                        local pos = getgenv().SpawnUnitPos["Namak"]["UP" .. i]

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
            elseif game.Workspace._map:FindFirstChild("houses_new") then
                print("Aot")
                for i = 1, 6 do
                    local unitinfo = getgenv().SelectedUnits["U" .. i]
                    if unitinfo ~= nil then
                        local unitinfo_ = unitinfo:split(" #")
                        local pos = getgenv().SpawnUnitPos["Aot"]["UP" .. i]

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
                            [2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y"] - y , pos["z"]), Vector3.new(0, 0, -1))
                        }
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                    end
                end
            elseif game.Workspace._map:FindFirstChild("Snow Particles") then
                print("Snowy")
                for i = 1, 6 do
                    local unitinfo = getgenv().SelectedUnits["U" .. i]
                    if unitinfo ~= nil then
                        local unitinfo_ = unitinfo:split(" #")
                        local pos = getgenv().SpawnUnitPos["Snowy"]["UP" .. i]

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
            elseif game.Workspace._map:FindFirstChild("sand_gate") then
                print("Sand")
                for i = 1, 6 do
                    local unitinfo = getgenv().SelectedUnits["U" .. i]
                    if unitinfo ~= nil then
                        local unitinfo_ = unitinfo:split(" #")
                        local pos = getgenv().SpawnUnitPos["Sand"]["UP" .. i]

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
            elseif game.Workspace._map:FindFirstChild("icebergs") then
                print("Marine")
                for i = 1, 6 do
                    local unitinfo = getgenv().SelectedUnits["U" .. i]
                    if unitinfo ~= nil then
                        local unitinfo_ = unitinfo:split(" #")
                        local pos = getgenv().SpawnUnitPos["Marine"]["UP" .. i]

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
            elseif game.Workspace._map:FindFirstChild("Helicopter Pad") then
                print("Ghoul")
                for i = 1, 6 do
                    local unitinfo = getgenv().SelectedUnits["U" .. i]
                    if unitinfo ~= nil then
                        local unitinfo_ = unitinfo:split(" #")
                        local pos = getgenv().SpawnUnitPos["Ghoul"]["UP" .. i]

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
            elseif game.Workspace._map:FindFirstChild("Bones/dust") then
                print("Hollow")
                for i = 1, 6 do
                    local unitinfo = getgenv().SelectedUnits["U" .. i]
                    if unitinfo ~= nil then
                        local unitinfo_ = unitinfo:split(" #")
                        local pos = getgenv().SpawnUnitPos["Hollow"]["UP" .. i]

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
            elseif game.Workspace._map:FindFirstChild("Ant Nest") then
                print("Ant")
                for i = 1, 6 do
                    local unitinfo = getgenv().SelectedUnits["U" .. i]
                    if unitinfo ~= nil then
                        local unitinfo_ = unitinfo:split(" #")
                        local pos = getgenv().SpawnUnitPos["Ant"]["UP" .. i]

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
            elseif game.Workspace._map:FindFirstChild("light poles") then
                print("Magic")
                for i = 1, 6 do
                    local unitinfo = getgenv().SelectedUnits["U" .. i]
                    if unitinfo ~= nil then
                        local unitinfo_ = unitinfo:split(" #")
                        local pos = getgenv().SpawnUnitPos["Magic"]["UP" .. i]

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
            elseif game.Workspace._map:FindFirstChild("LanternsGround") then
                print("Cursed")    
                for i = 1, 6 do
                    local unitinfo = getgenv().SelectedUnits["U" .. i]
                    if unitinfo ~= nil then
                        local unitinfo_ = unitinfo:split(" #")
                        local pos = getgenv().SpawnUnitPos["Cursed"]["UP" .. i]

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
            elseif game.Workspace._map:FindFirstChild("pumpkins") then
                    print("thriller_park")    
                    for i = 1, 6 do
                        local unitinfo = getgenv().SelectedUnits["U" .. i]
                        if unitinfo ~= nil then
                            local unitinfo_ = unitinfo:split(" #")
                            local pos = getgenv().SpawnUnitPos["thriller_park"]["UP" .. i]
    
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
            elseif game.Workspace._map:FindFirstChild("skeleton") then
                print("black_clover")    
                for i = 1, 6 do
                    local unitinfo = getgenv().SelectedUnits["U" .. i]
                    if unitinfo ~= nil then
                        local unitinfo_ = unitinfo:split(" #")
                        local pos = getgenv().SpawnUnitPos["black_clover"]["UP" .. i]

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
            elseif game.Workspace._map:FindFirstChild("graves") then
                print("Hollow Legend")
                for i = 1, 6 do
                    local unitinfo = getgenv().SelectedUnits["U" .. i]
                    if unitinfo ~= nil then
                        local unitinfo_ = unitinfo:split(" #")
                        local pos = getgenv().SpawnUnitPos["hollow_leg"]["UP" .. i]

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
            elseif game.Workspace._map:FindFirstChild("vending machines") then
                print("chainsaw")
                for i = 1, 6 do
                    local unitinfo = getgenv().SelectedUnits["U" .. i]
                    if unitinfo ~= nil then
                        local unitinfo_ = unitinfo:split(" #")
                        local pos = getgenv().SpawnUnitPos["chainsaw"]["UP" .. i]

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
            elseif game.Workspace._map:FindFirstChild("SpaceCenter") then
                print("Cape Canaveral")
                for i = 1, 6 do
                    local unitinfo = getgenv().SelectedUnits["U" .. i]
                    if unitinfo ~= nil then
                        local unitinfo_ = unitinfo:split(" #")
                        local pos = getgenv().SpawnUnitPos["jojo"]["UP" .. i]

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
            elseif game.Workspace._map:FindFirstChild("portal_boros_g") then
                print("Alien Portal")
                for i = 1, 6 do
                    local unitinfo = getgenv().SelectedUnits["U" .. i]
                    if unitinfo ~= nil then
                        local unitinfo_ = unitinfo:split(" #")
                        local pos = getgenv().SpawnUnitPos["opm_leg"]["UP" .. i]
                        task.wait()
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
            elseif game.Workspace._map:FindFirstChild("secret") then
                print("opm")
                for i = 1, 6 do
                    local unitinfo = getgenv().SelectedUnits["U" .. i]
                    if unitinfo ~= nil then
                        local unitinfo_ = unitinfo:split(" #")
                        local pos = getgenv().SpawnUnitPos["opm"]["UP" .. i]
                        task.wait()
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



--- Made by "CharWar" # Modified by "binsfr" (V3rm)
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
            elseif getgenv().AutoLeave and getgenv().AutoReplay ~= true then
                --
                Teleport()
                -- game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
            end
        end
	end)
end))
--#endregion

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
    if getgenv().farmprotal == false and getgenv().autostart and getgenv().AutoFarm and getgenv().teleporting 
                           and getgenv().AutoFarmTP == false and getgenv().AutoFarmIC == false then

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
    elseif getgenv().autostart and getgenv().AutoFarm and getgenv().teleporting 
                           and getgenv().AutoFarmTP == false and getgenv().AutoFarmIC == false and getgenv().farmprotal or getgenv().farmprotal then

        for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.items.grid.List.Outer.ItemFrames:GetChildren()) do
            if v.Name == "portal_csm" or v.Name == "portal_csm1" or v.Name == "portal_csm2" or v.Name == "portal_csm3" or v.Name == "portal_csm4" or v.Name == "portal_csm5"  then
                print(v._uuid_or_id.value)
                getgenv().PortalID = v._uuid_or_id.value
                break;
            end
        end
          task.wait(1.5)

          local args = {
            [1] = tostring(getgenv().PortalID),
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
        

        task.wait(7)
    end
end

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
        syn.queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/siradaniy/HSz/main/AA_HSz.lua'))()")
    else
        queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/siradaniy/HSz/main/AA_HSz.lua'))()")
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

print("Successfully Loaded!!")
---------------------------------------------------------------------
