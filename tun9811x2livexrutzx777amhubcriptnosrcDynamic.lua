if not LPH_OBFUSCATED then
	function LPH_JIT_MAX(...)
		return ...;
	end
	function LPH_NO_VIRTUALIZE(...)
		return ...;
	end
	function LPH_NO_UPVALUES(...)
		return ...;
	end
end
repeat
    task.wait()
until game:IsLoaded();
pcall(function()
local ok, hui = pcall(function() return gethui() end)
    if not ok or not hui then return end
    local imageButton = hui:FindFirstChild("ImageButton")
    if imageButton then
        imageButton:Destroy()
    else
        game:GetService("CoreGui"):FindFirstChild("ImageButton"):Destroy()
    end
    for i,v in pairs(gethui():GetChildren()) do
        if v.Name == "Cascade" then
        v:Destroy()
        end
    end
end)
print("Executor "..identifyexecutor())
Time = 1
repeat wait() until game:IsLoaded()
wait(Time)
local PlaceID = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false
function TPReturner()
    local Site
    if foundAnything == "" then
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' ..
            PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
    else
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' ..
            PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
    end
    local ID = ""
    if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
        foundAnything = Site.nextPageCursor
    end
    local num = 0
    for i, v in pairs(Site.data) do
        local Possible = true
        ID = tostring(v.id)
        if tonumber(v.maxPlayers) > tonumber(v.playing) then
            for _, Existing in pairs(AllIDs) do
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
function Rejoin()
    local TeleportService = game:GetService("TeleportService")
    local player = game.Players.LocalPlayer
    if player then
        pcall(function()
            TeleportService:Teleport(game.PlaceId, player)
        end)
    end
end
function Pirates()
    local args = {
        [1] = "SetTeam",
        [2] = "Pirates",
    }

    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
function Marines()
    local args = {
        [1] = "SetTeam",
        [2] = "Marines",
    }
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
local Noclip = nil
local Clip = nil
function noclip()
    if Noclip then Noclip:Disconnect() end
    Clip = false
    Noclip = game:GetService('RunService').Stepped:Connect(function()
        if game.Players.LocalPlayer.Character then
            for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if v:IsA('BasePart') and v.CanCollide and v.Name ~= floatName then
                    v.CanCollide = false
                end
            end
        end
    end)
end
function unnoclip()
    if Noclip then Noclip:Disconnect() end
    Clip = true
    if game.Players.LocalPlayer.Character then
        for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if v:IsA('BasePart') and v.Name ~= floatName then
                v.CanCollide = true
            end
        end
    end
end
local PlayerName = {}
local players = {}
function refreshPlayers()
    table.clear(PlayerName)
    for _, v in pairs(game:GetService("Players"):GetPlayers()) do
        table.insert(PlayerName, v.Name)
    end
end
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
local blackScreen = Instance.new("Frame")
local PlayerName = {}
for i, v in pairs(game.Players:GetChildren()) do
    if v.Name ~= game.Players.LocalPlayer.Name then
        table.insert(PlayerName, v.Name)
    end
end
local player = game.Players.LocalPlayer
local function getPlayers()
    local players = {}
    for _, v in pairs(game.Players:GetPlayers()) do
        if v.Name ~= player.Name then
            table.insert(players, v.Name)
        end
    end
    return players
end
if not game:IsLoaded() then repeat game.Loaded:Wait() until game:IsLoaded() end
getgenv().Config = {
    Save_Member = true
}

_G.Check_Save_Setting = "CheckSaveSetting"
getgenv()['JsonEncode'] = function(msg)
    return game:GetService("HttpService"):JSONEncode(msg)
end

getgenv()['JsonDecode'] = function(msg)
    return game:GetService("HttpService"):JSONDecode(msg)
end
getgenv()['Check_Setting'] = function(Name)
    if not _G.Dis then
        if not isfolder('Dynamic Hub') then
            makefolder('Dynamic Hub')
        end
        if not isfolder('Dynamic Hub/Blox Fruit') then
            makefolder('Dynamic Hub/Blox Fruit')
        end
        if not isfile('Dynamic Hub/Blox Fruit/'..Name..'.json') then
            writefile('Dynamic Hub/Blox Fruit/'..Name..'.json', JsonEncode(getgenv().Config))
        end
    end
end
getgenv()['Get_Setting'] = function(Name)
    if not _G.Dis then
        if isfolder('Dynamic Hub') and isfile('Dynamic Hub/Blox Fruit/'..Name..'.json') then
            getgenv().Config = JsonDecode(readfile('Dynamic Hub/Blox Fruit/'..Name..'.json'))
            return getgenv().Config
        else
            getgenv()['Check_Setting'](Name)
        end
    end
end
getgenv()['Update_Setting'] = function(Name)
    if not _G.Dis then
        if isfolder('Dynamic Hub') and isfile('Dynamic Hub/Blox Fruit/'..Name..'.json') then
            writefile('Dynamic Hub/Blox Fruit/'..Name..'.json', JsonEncode(getgenv().Config))
        else
            getgenv()['Check_Setting'](Name)
        end
    end
end
getgenv()['Check_Setting'](_G.Check_Save_Setting)
getgenv()['Get_Setting'](_G.Check_Save_Setting)
if getgenv().Config.Save_Member then
    getgenv()['MyName'] = game.Players.LocalPlayer.Name
elseif getgenv().Config.Save_All_Member then
    getgenv()['MyName'] = "AllMember"
else
    getgenv()['MyName'] = "None"
    _G.Dis = true
end
getgenv()['Check_Setting'](getgenv()['MyName'])
getgenv()['Get_Setting'](getgenv()['MyName'])
getgenv().Config.Key = _G.wl_key
getgenv()['Update_Setting'](getgenv()['MyName'])
function UpdateIslandESP()
    for i, v in pairs(game:GetService("Workspace")["_WorldOrigin"].Locations:GetChildren()) do
        pcall(function()
            if IslandESP then
                if v.Name ~= "Sea" then
                    if not v:FindFirstChild('NameEsp') then
                        local bill = Instance.new('BillboardGui', v)
                        bill.Name = 'NameEsp'
                        bill.ExtentsOffset = Vector3.new(0, 1, 0)
                        bill.Size = UDim2.new(1, 200, 1, 30)
                        bill.Adornee = v
                        bill.AlwaysOnTop = true
                        local name = Instance.new('TextLabel', bill)
                        name.Font = "GothamBold"
                        name.FontSize = "Size14"
                        name.TextWrapped = true
                        name.Size = UDim2.new(1, 0, 1, 0)
                        name.TextYAlignment = 'Top'
                        name.BackgroundTransparency = 1
                        name.TextStrokeTransparency = 0.5
                        name.TextColor3 = Color3.fromRGB(7, 236, 240)
                    else
                        v['NameEsp'].TextLabel.Text = (v.Name .. '   \n' .. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude / 3) .. ' Distance')
                    end
                end
            else
                if v:FindFirstChild('NameEsp') then
                    v:FindFirstChild('NameEsp'):Destroy()
                end
            end
        end)
    end
end
function isnil(thing)
    return (thing == nil)
end
local function round(n)
    return math.floor(tonumber(n) + 0.5)
end
Number = math.random(1, 1000000)
function UpdatePlayerChams()
    for i, v in pairs(game:GetService 'Players':GetChildren()) do
        pcall(function()
            if not isnil(v.Character) then
                if ESPPlayer then
                    if not isnil(v.Character.Head) and not v.Character.Head:FindFirstChild('NameEsp' .. Number) then
                        local bill = Instance.new('BillboardGui', v.Character.Head)
                        bill.Name = 'NameEsp' .. Number
                        bill.ExtentsOffset = Vector3.new(0, 1, 0)
                        bill.Size = UDim2.new(1, 200, 1, 30)
                        bill.Adornee = v.Character.Head
                        bill.AlwaysOnTop = true
                        local name = Instance.new('TextLabel', bill)
                        name.Font = Enum.Font.GothamSemibold
                        name.FontSize = "Size14"
                        name.TextWrapped = true
                        name.Text = (v.Name .. ' \n' .. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Character.Head.Position).Magnitude / 3) .. ' Distance')
                        name.Size = UDim2.new(1, 0, 1, 0)
                        name.TextYAlignment = 'Top'
                        name.BackgroundTransparency = 1
                        name.TextStrokeTransparency = 0.5
                        if v.Team == game.Players.LocalPlayer.Team then
                            name.TextColor3 = Color3.new(0, 255, 0)
                        else
                            name.TextColor3 = Color3.new(255, 0, 0)
                        end
                    else
                        v.Character.Head['NameEsp' .. Number].TextLabel.Text = (v.Name .. ' | ' .. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Character.Head.Position).Magnitude / 3) .. ' Distance\nHealth : ' .. round(v.Character.Humanoid.Health * 100 / v.Character.Humanoid.MaxHealth) .. '%')
                    end
                else
                    if v.Character.Head:FindFirstChild('NameEsp' .. Number) then
                        v.Character.Head:FindFirstChild('NameEsp' .. Number):Destroy()
                    end
                end
            end
        end)
    end
end
function UpdateChestChams()
    local player = game:GetService("Players").LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local head = character:FindFirstChild("Head")
    if not head then return end
    for _, chest in pairs(game.Workspace.ChestModels:GetChildren()) do
        pcall(function()
            if string.find(chest.Name, "Chest") then
                local distance = (head.Position - chest.PrimaryPart.Position).Magnitude / 3
                local distanceText = string.format("\n%d Distance", math.floor(distance))
                if ChestESP then
                    local espName = "NameEsp_ESP"
                    local existingBillboard = chest:FindFirstChild(espName)
                    if not existingBillboard then
                        local bill = Instance.new("BillboardGui")
                        bill.Name = espName
                        bill.ExtentsOffset = Vector3.new(0, 1, 0)
                        bill.Size = UDim2.new(1, 200, 1, 30)
                        bill.Adornee = chest.PrimaryPart
                        bill.AlwaysOnTop = true
                        bill.Parent = chest
                        local name = Instance.new("TextLabel")
                        name.Font = Enum.Font.GothamSemibold
                        name.TextSize = 14
                        name.TextWrapped = true
                        name.Size = UDim2.new(1, 0, 1, 0)
                        name.TextYAlignment = Enum.TextYAlignment.Top
                        name.BackgroundTransparency = 1
                        name.TextStrokeTransparency = 0.5
                        name.Parent = bill
                        existingBillboard = bill
                    end
                    local textLabel = existingBillboard:FindFirstChildOfClass("TextLabel")
                    if textLabel then
                        if chest.Name == "SilverChest" then
                            textLabel.TextColor3 = Color3.fromRGB(109, 109, 109)
                            textLabel.Text = "Silver Chest" .. distanceText
                        elseif chest.Name == "GoldChest" then
                            textLabel.TextColor3 = Color3.fromRGB(173, 158, 21)
                            textLabel.Text = "Gold Chest" .. distanceText
                        elseif chest.Name == "DiamondChest" then
                            textLabel.TextColor3 = Color3.fromRGB(85, 255, 255)
                            textLabel.Text = "Diamond Chest" .. distanceText
                        else
                            textLabel.Text = chest.Name .. distanceText
                        end
                    end
                else
                    local existingBillboard = chest:FindFirstChild("NameEsp_ESP")
                    if existingBillboard then
                        existingBillboard:Destroy()
                    end
                end
            end
        end)
    end
end
function UpdateDevilChams()
    for i, v in pairs(game.Workspace:GetChildren()) do
        pcall(function()
            if DevilFruitESP then
                if string.find(v.Name, "Fruit") then
                    if not v.Handle:FindFirstChild('NameEsp' .. Number) then
                        local bill = Instance.new('BillboardGui', v.Handle)
                        bill.Name = 'NameEsp' .. Number
                        bill.ExtentsOffset = Vector3.new(0, 1, 0)
                        bill.Size = UDim2.new(1, 200, 1, 30)
                        bill.Adornee = v.Handle
                        bill.AlwaysOnTop = true
                        local name = Instance.new('TextLabel', bill)
                        name.Font = Enum.Font.GothamSemibold
                        name.FontSize = "Size14"
                        name.TextWrapped = true
                        name.Size = UDim2.new(1, 0, 1, 0)
                        name.TextYAlignment = 'Top'
                        name.BackgroundTransparency = 1
                        name.TextStrokeTransparency = 0.5
                        name.TextColor3 = Color3.fromRGB(255, 255, 255)
                        name.Text = (v.Name .. ' \n' .. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude / 3) .. ' Distance')
                    else
                        v.Handle['NameEsp' .. Number].TextLabel.Text = (v.Name .. '   \n' .. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude / 3) .. ' Distance')
                    end
                end
            else
                if v.Handle:FindFirstChild('NameEsp' .. Number) then
                    v.Handle:FindFirstChild('NameEsp' .. Number):Destroy()
                end
            end
        end)
    end
end
function UpdateFlowerChams()
    for i, v in pairs(game.Workspace:GetChildren()) do
        pcall(function()
            if v.Name == "Flower2" or v.Name == "Flower1" then
                if FlowerESP then
                    if not v:FindFirstChild('NameEsp' .. Number) then
                        local bill = Instance.new('BillboardGui', v)
                        bill.Name = 'NameEsp' .. Number
                        bill.ExtentsOffset = Vector3.new(0, 1, 0)
                        bill.Size = UDim2.new(1, 200, 1, 30)
                        bill.Adornee = v
                        bill.AlwaysOnTop = true
                        local name = Instance.new('TextLabel', bill)
                        name.Font = Enum.Font.GothamSemibold
                        name.FontSize = "Size14"
                        name.TextWrapped = true
                        name.Size = UDim2.new(1, 0, 1, 0)
                        name.TextYAlignment = 'Top'
                        name.BackgroundTransparency = 1
                        name.TextStrokeTransparency = 0.5
                        name.TextColor3 = Color3.fromRGB(255, 0, 0)
                        if v.Name == "Flower1" then
                            name.Text = ("Blue Flower" .. ' \n' .. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude / 3) .. ' Distance')
                            name.TextColor3 = Color3.fromRGB(0, 0, 255)
                        end
                        if v.Name == "Flower2" then
                            name.Text = ("Red Flower" .. ' \n' .. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude / 3) .. ' Distance')
                            name.TextColor3 = Color3.fromRGB(255, 0, 0)
                        end
                    else
                        v['NameEsp' .. Number].TextLabel.Text = (v.Name .. '   \n' .. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude / 3) .. ' Distance')
                    end
                else
                    if v:FindFirstChild('NameEsp' .. Number) then
                        v:FindFirstChild('NameEsp' .. Number):Destroy()
                    end
                end
            end
        end)
    end
end
function UpdateRealFruitChams()
    for i, v in pairs(game.Workspace.AppleSpawner:GetChildren()) do
        if v:IsA("Tool") then
            if RealFruitESP then
                if not v.Handle:FindFirstChild('NameEsp' .. Number) then
                    local bill = Instance.new('BillboardGui', v.Handle)
                    bill.Name = 'NameEsp' .. Number
                    bill.ExtentsOffset = Vector3.new(0, 1, 0)
                    bill.Size = UDim2.new(1, 200, 1, 30)
                    bill.Adornee = v.Handle
                    bill.AlwaysOnTop = true
                    local name = Instance.new('TextLabel', bill)
                    name.Font = Enum.Font.GothamSemibold
                    name.FontSize = "Size14"
                    name.TextWrapped = true
                    name.Size = UDim2.new(1, 0, 1, 0)
                    name.TextYAlignment = 'Top'
                    name.BackgroundTransparency = 1
                    name.TextStrokeTransparency = 0.5
                    name.TextColor3 = Color3.fromRGB(255, 0, 0)
                    name.Text = (v.Name .. ' \n' .. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude / 3) .. ' Distance')
                else
                    v.Handle['NameEsp' .. Number].TextLabel.Text = (v.Name .. ' ' .. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude / 3) .. ' Distance')
                end
            else
                if v.Handle:FindFirstChild('NameEsp' .. Number) then
                    v.Handle:FindFirstChild('NameEsp' .. Number):Destroy()
                end
            end
        end
    end
    for i, v in pairs(game.Workspace.PineappleSpawner:GetChildren()) do
        if v:IsA("Tool") then
            if RealFruitESP then
                if not v.Handle:FindFirstChild('NameEsp' .. Number) then
                    local bill = Instance.new('BillboardGui', v.Handle)
                    bill.Name = 'NameEsp' .. Number
                    bill.ExtentsOffset = Vector3.new(0, 1, 0)
                    bill.Size = UDim2.new(1, 200, 1, 30)
                    bill.Adornee = v.Handle
                    bill.AlwaysOnTop = true
                    local name = Instance.new('TextLabel', bill)
                    name.Font = Enum.Font.GothamSemibold
                    name.FontSize = "Size14"
                    name.TextWrapped = true
                    name.Size = UDim2.new(1, 0, 1, 0)
                    name.TextYAlignment = 'Top'
                    name.BackgroundTransparency = 1
                    name.TextStrokeTransparency = 0.5
                    name.TextColor3 = Color3.fromRGB(255, 174, 0)
                    name.Text = (v.Name .. ' \n' .. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude / 3) .. ' Distance')
                else
                    v.Handle['NameEsp' .. Number].TextLabel.Text = (v.Name .. ' ' .. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude / 3) .. ' Distance')
                end
            else
                if v.Handle:FindFirstChild('NameEsp' .. Number) then
                    v.Handle:FindFirstChild('NameEsp' .. Number):Destroy()
                end
            end
        end
    end
    for i, v in pairs(game.Workspace.BananaSpawner:GetChildren()) do
        if v:IsA("Tool") then
            if RealFruitESP then
                if not v.Handle:FindFirstChild('NameEsp' .. Number) then
                    local bill = Instance.new('BillboardGui', v.Handle)
                    bill.Name = 'NameEsp' .. Number
                    bill.ExtentsOffset = Vector3.new(0, 1, 0)
                    bill.Size = UDim2.new(1, 200, 1, 30)
                    bill.Adornee = v.Handle
                    bill.AlwaysOnTop = true
                    local name = Instance.new('TextLabel', bill)
                    name.Font = Enum.Font.GothamSemibold
                    name.FontSize = "Size14"
                    name.TextWrapped = true
                    name.Size = UDim2.new(1, 0, 1, 0)
                    name.TextYAlignment = 'Top'
                    name.BackgroundTransparency = 1
                    name.TextStrokeTransparency = 0.5
                    name.TextColor3 = Color3.fromRGB(251, 255, 0)
                    name.Text = (v.Name .. ' \n' .. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude / 3) .. ' Distance')
                else
                    v.Handle['NameEsp' .. Number].TextLabel.Text = (v.Name .. ' ' .. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude / 3) .. ' Distance')
                end
            else
                if v.Handle:FindFirstChild('NameEsp' .. Number) then
                    v.Handle:FindFirstChild('NameEsp' .. Number):Destroy()
                end
            end
        end
    end
end
function UpdateIslandESP()
    for i, v in pairs(game:GetService("Workspace")["_WorldOrigin"].Locations:GetChildren()) do
        pcall(function()
            if IslandESP then
                if v.Name ~= "Sea" then
                    if not v:FindFirstChild('NameEsp') then
                        local bill = Instance.new('BillboardGui', v)
                        bill.Name = 'NameEsp'
                        bill.ExtentsOffset = Vector3.new(0, 1, 0)
                        bill.Size = UDim2.new(1, 200, 1, 30)
                        bill.Adornee = v
                        bill.AlwaysOnTop = true
                        local name = Instance.new('TextLabel', bill)
                        name.Font = "GothamBold"
                        name.FontSize = "Size14"
                        name.TextWrapped = true
                        name.Size = UDim2.new(1, 0, 1, 0)
                        name.TextYAlignment = 'Top'
                        name.BackgroundTransparency = 1
                        name.TextStrokeTransparency = 0.5
                        name.TextColor3 = Color3.fromRGB(7, 236, 240)
                    else
                        v['NameEsp'].TextLabel.Text = (v.Name .. '   \n' .. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude / 3) .. ' Distance')
                    end
                end
            else
                if v:FindFirstChild('NameEsp') then
                    v:FindFirstChild('NameEsp'):Destroy()
                end
            end
        end)
    end
end
function isnil(thing)
    return (thing == nil)
end
local function round(n)
    return math.floor(tonumber(n) + 0.5)
end
Number = math.random(1, 1000000)
function UpdatePlayerChams()
    for i, v in pairs(game:GetService 'Players':GetChildren()) do
        pcall(function()
            if not isnil(v.Character) then
                if ESPPlayer then
                    if not isnil(v.Character.Head) and not v.Character.Head:FindFirstChild('NameEsp' .. Number) then
                        local bill = Instance.new('BillboardGui', v.Character.Head)
                        bill.Name = 'NameEsp' .. Number
                        bill.ExtentsOffset = Vector3.new(0, 1, 0)
                        bill.Size = UDim2.new(1, 200, 1, 30)
                        bill.Adornee = v.Character.Head
                        bill.AlwaysOnTop = true
                        local name = Instance.new('TextLabel', bill)
                        name.Font = Enum.Font.GothamSemibold
                        name.FontSize = "Size14"
                        name.TextWrapped = true
                        name.Text = (v.Name .. ' \n' .. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Character.Head.Position).Magnitude / 3) .. ' Distance')
                        name.Size = UDim2.new(1, 0, 1, 0)
                        name.TextYAlignment = 'Top'
                        name.BackgroundTransparency = 1
                        name.TextStrokeTransparency = 0.5
                        if v.Team == game.Players.LocalPlayer.Team then
                            name.TextColor3 = Color3.new(0, 255, 0)
                        else
                            name.TextColor3 = Color3.new(255, 0, 0)
                        end
                    else
                        v.Character.Head['NameEsp' .. Number].TextLabel.Text = (v.Name .. ' | ' .. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Character.Head.Position).Magnitude / 3) .. ' Distance\nHealth : ' .. round(v.Character.Humanoid.Health * 100 / v.Character.Humanoid.MaxHealth) .. '%')
                    end
                else
                    if v.Character.Head:FindFirstChild('NameEsp' .. Number) then
                        v.Character.Head:FindFirstChild('NameEsp' .. Number):Destroy()
                    end
                end
            end
        end)
    end
end
function UpdateChestChams()
    local player = game:GetService("Players").LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local head = character:FindFirstChild("Head")
    if not head then return end
    for _, chest in pairs(game.Workspace.ChestModels:GetChildren()) do
        pcall(function()
            if string.find(chest.Name, "Chest") then
                local distance = (head.Position - chest.PrimaryPart.Position).Magnitude / 3
                local distanceText = string.format("\n%d Distance", math.floor(distance))
                if ChestESP then
                    local espName = "NameEsp_ESP"
                    local existingBillboard = chest:FindFirstChild(espName)
                    if not existingBillboard then
                        local bill = Instance.new("BillboardGui")
                        bill.Name = espName
                        bill.ExtentsOffset = Vector3.new(0, 1, 0)
                        bill.Size = UDim2.new(1, 200, 1, 30)
                        bill.Adornee = chest.PrimaryPart
                        bill.AlwaysOnTop = true
                        bill.Parent = chest
                        local name = Instance.new("TextLabel")
                        name.Font = Enum.Font.GothamSemibold
                        name.TextSize = 14
                        name.TextWrapped = true
                        name.Size = UDim2.new(1, 0, 1, 0)
                        name.TextYAlignment = Enum.TextYAlignment.Top
                        name.BackgroundTransparency = 1
                        name.TextStrokeTransparency = 0.5
                        name.Parent = bill
                        existingBillboard = bill
                    end
                    local textLabel = existingBillboard:FindFirstChildOfClass("TextLabel")
                    if textLabel then
                        if chest.Name == "SilverChest" then
                            textLabel.TextColor3 = Color3.fromRGB(109, 109, 109)
                            textLabel.Text = "Silver Chest" .. distanceText
                        elseif chest.Name == "Gold Chest" then
                            textLabel.TextColor3 = Color3.fromRGB(173, 158, 21)
                            textLabel.Text = "Gold Chest" .. distanceText
                        elseif chest.Name == "DiamondChest" then
                            textLabel.TextColor3 = Color3.fromRGB(85, 255, 255)
                            textLabel.Text = "Diamond Chest" .. distanceText
                        else
                            textLabel.Text = chest.Name .. distanceText
                        end
                    end
                else
                    local existingBillboard = chest:FindFirstChild("NameEsp_ESP")
                    if existingBillboard then
                        existingBillboard:Destroy()
                    end
                end
            end
        end)
    end
end
function UpdateDevilChams()
    for i, v in pairs(game.Workspace:GetChildren()) do
        pcall(function()
            if DevilFruitESP then
                if string.find(v.Name, "Fruit") then
                    if not v.Handle:FindFirstChild('NameEsp' .. Number) then
                        local bill = Instance.new('BillboardGui', v.Handle)
                        bill.Name = 'NameEsp' .. Number
                        bill.ExtentsOffset = Vector3.new(0, 1, 0)
                        bill.Size = UDim2.new(1, 200, 1, 30)
                        bill.Adornee = v.Handle
                        bill.AlwaysOnTop = true
                        local name = Instance.new('TextLabel', bill)
                        name.Font = Enum.Font.GothamSemibold
                        name.FontSize = "Size14"
                        name.TextWrapped = true
                        name.Size = UDim2.new(1, 0, 1, 0)
                        name.TextYAlignment = 'Top'
                        name.BackgroundTransparency = 1
                        name.TextStrokeTransparency = 0.5
                        name.TextColor3 = Color3.fromRGB(255, 255, 255)
                        name.Text = (v.Name .. ' \n' .. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude / 3) .. ' Distance')
                    else
                        v.Handle['NameEsp' .. Number].TextLabel.Text = (v.Name .. '   \n' .. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude / 3) .. ' Distance')
                    end
                end
            else
                if v.Handle:FindFirstChild('NameEsp' .. Number) then
                    v.Handle:FindFirstChild('NameEsp' .. Number):Destroy()
                end
            end
        end)
    end
end
function UpdateFlowerChams()
    for i, v in pairs(Workspace:GetChildren()) do
        pcall(function()
            if v.Name == "Flower2" or v.Name == "Flower1" then
                if FlowerESP then
                    if not v:FindFirstChild('NameEsp' .. Number) then
                        local bill = Instance.new('BillboardGui', v)
                        bill.Name = 'NameEsp' .. Number
                        bill.ExtentsOffset = Vector3.new(0, 1, 0)
                        bill.Size = UDim2.new(1, 200, 1, 30)
                        bill.Adornee = v
                        bill.AlwaysOnTop = true
                        local name = Instance.new('TextLabel', bill)
                        name.Font = Enum.Font.GothamSemibold
                        name.FontSize = "Size14"
                        name.TextWrapped = true
                        name.Size = UDim2.new(1, 0, 1, 0)
                        name.TextYAlignment = 'Top'
                        name.BackgroundTransparency = 1
                        name.TextStrokeTransparency = 0.5
                        name.TextColor3 = Color3.fromRGB(255, 0, 0)
                        if v.Name == "Flower1" then
                            name.Text = ("Blue Flower" .. ' \n' .. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude / 3) .. ' Distance')
                            name.TextColor3 = Color3.fromRGB(0, 0, 255)
                        end
                        if v.Name == "Flower2" then
                            name.Text = ("Red Flower" .. ' \n' .. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude / 3) .. ' Distance')
                            name.TextColor3 = Color3.fromRGB(255, 0, 0)
                        end
                    else
                        v['NameEsp' .. Number].TextLabel.Text = (v.Name .. '   \n' .. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude / 3) .. ' Distance')
                    end
                else
                    if v:FindFirstChild('NameEsp' .. Number) then
                        v:FindFirstChild('NameEsp' .. Number):Destroy()
                    end
                end
            end
        end)
    end
end
function UpdateRealFruitChams()
    for i, v in pairs(Workspace.AppleSpawner:GetChildren()) do
        if v:IsA("Tool") then
            if RealFruitESP then
                if not v.Handle:FindFirstChild('NameEsp' .. Number) then
                    local bill = Instance.new('BillboardGui', v.Handle)
                    bill.Name = 'NameEsp' .. Number
                    bill.ExtentsOffset = Vector3.new(0, 1, 0)
                    bill.Size = UDim2.new(1, 200, 1, 30)
                    bill.Adornee = v.Handle
                    bill.AlwaysOnTop = true
                    local name = Instance.new('TextLabel', bill)
                    name.Font = Enum.Font.GothamSemibold
                    name.FontSize = "Size14"
                    name.TextWrapped = true
                    name.Size = UDim2.new(1, 0, 1, 0)
                    name.TextYAlignment = 'Top'
                    name.BackgroundTransparency = 1
                    name.TextStrokeTransparency = 0.5
                    name.TextColor3 = Color3.fromRGB(255, 0, 0)
                    name.Text = (v.Name .. ' \n' .. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude / 3) .. ' Distance')
                else
                    v.Handle['NameEsp' .. Number].TextLabel.Text = (v.Name .. ' ' .. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude / 3) .. ' Distance')
                end
            else
                if v.Handle:FindFirstChild('NameEsp' .. Number) then
                    v.Handle:FindFirstChild('NameEsp' .. Number):Destroy()
                end
            end
        end
    end
    for i, v in pairs(Workspace.PineappleSpawner:GetChildren()) do
        if v:IsA("Tool") then
            if RealFruitESP then
                if not v.Handle:FindFirstChild('NameEsp' .. Number) then
                    local bill = Instance.new('BillboardGui', v.Handle)
                    bill.Name = 'NameEsp' .. Number
                    bill.ExtentsOffset = Vector3.new(0, 1, 0)
                    bill.Size = UDim2.new(1, 200, 1, 30)
                    bill.Adornee = v.Handle
                    bill.AlwaysOnTop = true
                    local name = Instance.new('TextLabel', bill)
                    name.Font = Enum.Font.GothamSemibold
                    name.FontSize = "Size14"
                    name.TextWrapped = true
                    name.Size = UDim2.new(1, 0, 1, 0)
                    name.TextYAlignment = 'Top'
                    name.BackgroundTransparency = 1
                    name.TextStrokeTransparency = 0.5
                    name.TextColor3 = Color3.fromRGB(255, 174, 0)
                    name.Text = (v.Name .. ' \n' .. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude / 3) .. ' Distance')
                else
                    v.Handle['NameEsp' .. Number].TextLabel.Text = (v.Name .. ' ' .. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude / 3) .. ' Distance')
                end
            else
                if v.Handle:FindFirstChild('NameEsp' .. Number) then
                    v.Handle:FindFirstChild('NameEsp' .. Number):Destroy()
                end
            end
        end
    end
    for i, v in pairs(Workspace.BananaSpawner:GetChildren()) do
        if v:IsA("Tool") then
            if RealFruitESP then
                if not v.Handle:FindFirstChild('NameEsp' .. Number) then
                    local bill = Instance.new('BillboardGui', v.Handle)
                    bill.Name = 'NameEsp' .. Number
                    bill.ExtentsOffset = Vector3.new(0, 1, 0)
                    bill.Size = UDim2.new(1, 200, 1, 30)
                    bill.Adornee = v.Handle
                    bill.AlwaysOnTop = true
                    local name = Instance.new('TextLabel', bill)
                    name.Font = Enum.Font.GothamSemibold
                    name.FontSize = "Size14"
                    name.TextWrapped = true
                    name.Size = UDim2.new(1, 0, 1, 0)
                    name.TextYAlignment = 'Top'
                    name.BackgroundTransparency = 1
                    name.TextStrokeTransparency = 0.5
                    name.TextColor3 = Color3.fromRGB(251, 255, 0)
                    name.Text = (v.Name .. ' \n' .. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude / 3) .. ' Distance')
                else
                    v.Handle['NameEsp' .. Number].TextLabel.Text = (v.Name .. ' ' .. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude / 3) .. ' Distance')
                end
            else
                if v.Handle:FindFirstChild('NameEsp' .. Number) then
                    v.Handle:FindFirstChild('NameEsp' .. Number):Destroy()
                end
            end
        end
    end
end
spawn(function()
    while wait() do
        pcall(function()
            if MobESP then
                for i, v in pairs(workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild('HumanoidRootPart') then
                        if not v:FindFirstChild("MobEap") then
                            local BillboardGui = Instance.new("BillboardGui")
                            local TextLabel = Instance.new("TextLabel")
                            BillboardGui.Parent = v
                            BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                            BillboardGui.Active = true
                            BillboardGui.Name = "MobEap"
                            BillboardGui.AlwaysOnTop = true
                            BillboardGui.LightInfluence = 1.000
                            BillboardGui.Size = UDim2.new(0, 200, 0, 50)
                            BillboardGui.StudsOffset = Vector3.new(0, 2.5, 0)
                            TextLabel.Parent = BillboardGui
                            TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            TextLabel.BackgroundTransparency = 1.000
                            TextLabel.Size = UDim2.new(0, 200, 0, 50)
                            TextLabel.Font = Enum.Font.GothamBold
                            TextLabel.TextColor3 = Color3.fromRGB(7, 236, 240)
                            TextLabel.Text.Size = 35
                        end
                        local Dis = math.floor((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position)
                            .Magnitude)
                        v.MobEap.TextLabel.Text = v.Name .. " - " .. Dis .. " Distance"
                    end
                end
            else
                for i, v in pairs(workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("MobEap") then
                        v.MobEap:Destroy()
                    end
                end
            end
        end)
    end
end)
spawn(function()
    while wait() do
        pcall(function()
            if SeaESP then
                for i, v in pairs(game:GetService("Workspace").SeaBeasts:GetChildren()) do
                    if v:FindFirstChild('HumanoidRootPart') then
                        if not v:FindFirstChild("Seaesps") then
                            local BillboardGui = Instance.new("BillboardGui")
                            local TextLabel = Instance.new("TextLabel")
                            BillboardGui.Parent = v
                            BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                            BillboardGui.Active = true
                            BillboardGui.Name = "Seaesps"
                            BillboardGui.AlwaysOnTop = true
                            BillboardGui.LightInfluence = 1.000
                            BillboardGui.Size = UDim2.new(0, 200, 0, 50)
                            BillboardGui.StudsOffset = Vector3.new(0, 2.5, 0)
                            TextLabel.Parent = BillboardGui
                            TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            TextLabel.BackgroundTransparency = 1.000
                            TextLabel.Size = UDim2.new(0, 200, 0, 50)
                            TextLabel.Font = Enum.Font.GothamBold
                            TextLabel.TextColor3 = Color3.fromRGB(7, 236, 240)
                            TextLabel.Text.Size = 35
                        end
                        local Dis = math.floor((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position)
                            .Magnitude)
                        v.Seaesps.TextLabel.Text = v.Name .. " - " .. Dis .. " Distance"
                    end
                end
            else
                for i, v in pairs(game:GetService("Workspace").SeaBeasts:GetChildren()) do
                    if v:FindFirstChild("Seaesps") then
                        v.Seaesps:Destroy()
                    end
                end
            end
        end)
    end
end)
spawn(function()
    while wait() do
        pcall(function()
            if NpcESP then
                for i, v in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
                    if v:FindFirstChild('HumanoidRootPart') then
                        if not v:FindFirstChild("NpcEspes") then
                            local BillboardGui = Instance.new("BillboardGui")
                            local TextLabel = Instance.new("TextLabel")
                            BillboardGui.Parent = v
                            BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                            BillboardGui.Active = true
                            BillboardGui.Name = "NpcEspes"
                            BillboardGui.AlwaysOnTop = true
                            BillboardGui.LightInfluence = 1.000
                            BillboardGui.Size = UDim2.new(0, 200, 0, 50)
                            BillboardGui.StudsOffset = Vector3.new(0, 2.5, 0)
                            TextLabel.Parent = BillboardGui
                            TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            TextLabel.BackgroundTransparency = 1.000
                            TextLabel.Size = UDim2.new(0, 200, 0, 50)
                            TextLabel.Font = Enum.Font.GothamBold
                            TextLabel.TextColor3 = Color3.fromRGB(7, 236, 240)
                            TextLabel.Text.Size = 35
                        end
                        local Dis = math.floor((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position)
                            .Magnitude)
                        v.NpcEspes.TextLabel.Text = v.Name .. " - " .. Dis .. " Distance"
                    end
                end
            else
                for i, v in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
                    if v:FindFirstChild("NpcEspes") then
                        v.NpcEspes:Destroy()
                    end
                end
            end
        end)
    end
end)
function isnil(thing)
    return (thing == nil)
end
local function round(n)
    return math.floor(tonumber(n) + 0.5)
end
Number = math.random(1, 1000000)
function UpdateIslandMirageESP()
    for i, v in pairs(game:GetService("Workspace")["_WorldOrigin"].Locations:GetChildren()) do
        pcall(function()
            if MirageIslandESP then
                if v.Name == "Mirage Island" then
                    if not v:FindFirstChild('NameEsp') then
                        local bill = Instance.new('BillboardGui', v)
                        bill.Name = 'NameEsp'
                        bill.ExtentsOffset = Vector3.new(0, 1, 0)
                        bill.Size = UDim2.new(1, 200, 1, 30)
                        bill.Adornee = v
                        bill.AlwaysOnTop = true
                        local name = Instance.new('TextLabel', bill)
                        name.Font = "Code"
                        name.FontSize = "Size14"
                        name.TextWrapped = true
                        name.Size = UDim2.new(1, 0, 1, 0)
                        name.TextYAlignment = 'Top'
                        name.BackgroundTransparency = 1
                        name.TextStrokeTransparency = 0.5
                        name.TextColor3 = Color3.fromRGB(80, 245, 245)
                    else
                        v['NameEsp'].TextLabel.Text = (v.Name .. '   \n' .. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude / 3) .. ' Distance')
                    end
                end
            else
                if v:FindFirstChild('NameEsp') then
                    v:FindFirstChild('NameEsp'):Destroy()
                end
            end
        end)
    end
end
function isnil(thing)
    return (thing == nil)
end
local function round(n)
    return math.floor(tonumber(n) + 0.5)
end
Number = math.random(1, 1000000)
function UpdateAfdESP()
    for i, v in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
        pcall(function()
            if AfdESP then
                if v.Name == "Advanced Fruit Dealer" then
                    if not v:FindFirstChild('NameEsp') then
                        local bill = Instance.new('BillboardGui', v)
                        bill.Name = 'NameEsp'
                        bill.ExtentsOffset = Vector3.new(0, 1, 0)
                        bill.Size = UDim2.new(1, 200, 1, 30)
                        bill.Adornee = v
                        bill.AlwaysOnTop = true
                        local name = Instance.new('TextLabel', bill)
                        name.Font = "Code"
                        name.FontSize = "Size14"
                        name.TextWrapped = true
                        name.Size = UDim2.new(1, 0, 1, 0)
                        name.TextYAlignment = 'Top'
                        name.BackgroundTransparency = 1
                        name.TextStrokeTransparency = 0.5
                        name.TextColor3 = Color3.fromRGB(80, 245, 245)
                    else
                        v['NameEsp'].TextLabel.Text = (v.Name .. '   \n' .. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude / 3) .. ' Distance')
                    end
                end
            else
                if v:FindFirstChild('NameEsp') then
                    v:FindFirstChild('NameEsp'):Destroy()
                end
            end
        end)
    end
end
function UpdateIslandPrehistoricESP() 
    if PrehistoricESP then
        pcall(function()
            for i,v in pairs(game:GetService("Workspace")["_WorldOrigin"].Locations:GetChildren()) do
                if v.Name == "Prehistoric Island" then
                    if not v:FindFirstChild("NameEsp") then
                        local BillboardGui = Instance.new("BillboardGui")
                        local TextLabel = Instance.new("TextLabel")
                        BillboardGui.Parent = v
                        BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                        BillboardGui.Active = true
                        BillboardGui.Name = "NameEsp"
                        BillboardGui.AlwaysOnTop = true
                        BillboardGui.LightInfluence = 1.000
                        BillboardGui.Size = UDim2.new(0, 200, 0, 50)
                        BillboardGui.StudsOffset = Vector3.new(0, 2.5, 0)
                        TextLabel.Parent = BillboardGui
                        TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        TextLabel.BackgroundTransparency = 1.000
                        TextLabel.Size = UDim2.new(0, 200, 0, 50)
                        TextLabel.Font = Enum.Font.GothamBold
                        TextLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
                        TextLabel.FontSize = "Size14"
                        TextLabel.TextStrokeTransparency = 0.5
                    end
                    local Dis = math.floor((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude / 10)
                    v.PrehistoricESPPart.TextLabel.Text = v.Name.."\n".."["..Dis..".."..Distance.."]"
                end
            end
        end)
    else
        for i,v in pairs (game:GetService("Workspace")["_WorldOrigin"].Locations:GetChildren()) do
            if v.Name == "Prehistoric Island" then
                if v:FindFirstChild("NameEsp") then
                    v.PrehistoricESPPart:Destroy()
                end
            end
        end
    end
end
function UpdateIslandKisuneESP() 
    for i,v in pairs(game:GetService("Workspace")["_WorldOrigin"].Locations:GetChildren()) do
        pcall(function()
            if KitsuneIslandEsp then 
                if v.Name == "Kitsune Island" then
                    if not v:FindFirstChild('NameEsp') then
                        local bill = Instance.new('BillboardGui',v)
                        bill.Name = 'NameEsp'
                        bill.ExtentsOffset = Vector3.new(0, 1, 0)
                        bill.Size = UDim2.new(1,200,1,30)
                        bill.Adornee = v
                        bill.AlwaysOnTop = true
                        local name = Instance.new('TextLabel',bill)
                        name.Font = "Code"
                        name.FontSize = "Size14"
                        name.TextWrapped = true
                        name.Size = UDim2.new(1,0,1,0)
                        name.TextYAlignment = 'Top'
                        name.BackgroundTransparency = 1
                        name.TextStrokeTransparency = 0.5
                        name.TextColor3 = Color3.fromRGB(80, 245, 245)
                    else
                        v['NameEsp'].TextLabel.Text = (v.Name ..'   \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude/3) ..' Distance')
                    end
                end
            else
                if v:FindFirstChild('NameEsp') then
                    v:FindFirstChild('NameEsp'):Destroy()
                end
            end
        end)
    end
end
function InfAb()
    if InfAbility then
        if not game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Agility") then
            local inf = Instance.new("ParticleEmitter")
            inf.Acceleration = Vector3.new(0, 0, 0)
            inf.Archivable = true
            inf.Drag = 20
            inf.EmissionDirection = Enum.NormalId.Top
            inf.Enabled = true
            inf.Lifetime = NumberRange.new(0, 0)
            inf.LightInfluence = 0
            inf.LockedToPart = true
            inf.Name = "Agility"
            inf.Rate = 500
            local numberKeypoints2 = {
                NumberSequenceKeypoint.new(0, 0),
                NumberSequenceKeypoint.new(1, 4),
            }
            inf.Size = NumberSequence.new(numberKeypoints2)
            inf.RotSpeed = NumberRange.new(9999, 99999)
            inf.Rotation = NumberRange.new(0, 0)
            inf.Speed = NumberRange.new(30, 30)
            inf.SpreadAngle = Vector2.new(0, 0, 0, 0)
            inf.Texture = ""
            inf.VelocityInheritance = 0
            inf.ZOffset = 2
            inf.Transparency = NumberSequence.new(0)
            inf.Color = ColorSequence.new(Color3.fromRGB(0, 0, 0), Color3.fromRGB(0, 0, 0))
            inf.Parent = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
        end
    else
        if game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Agility") then
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Agility"):Destroy()
        end
    end
end
if not game:IsLoaded() then repeat game.Loaded:Wait() until game:IsLoaded() end
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/tun9811/Fluent/refs/heads/main/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/tun9811/Fluent/refs/heads/main/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/tun9811/Fluent/refs/heads/main/InterfaceManager.lua"))()
--// Anti AFK
game:GetService("Players").LocalPlayer.Idled:connect(function()
    game:GetService("VirtualUser"):Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    wait(180)
    game:GetService("VirtualUser"):Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)
if game.PlaceId == 2753915549 then
    L_2753915549_ = true
elseif game.PlaceId == 4442272183 then
    L_4442272183_ = true
elseif game.PlaceId == 7449423635 then
    L_7449423635_ = true
end
function CheckQuest()
    MyLevel = game:GetService("Players").LocalPlayer.Data.Level.Value
    if L_2753915549_ then
        if MyLevel == 1 or MyLevel <= 9 or SelectMonster == "Bandit" then
            Mon = "Bandit"
            NameQuest = "BanditQuest1"
            LevelQuest = 1
            NameMon = "Bandit"
            CFrameQuest = CFrame.new(1059.37195, 15.4495068, 1550.4231, 0.939700544, -0, -0.341998369, 0, 1, -0,
                0.341998369, 0, 0.939700544)
        elseif MyLevel == 10 or MyLevel <= 14 or SelectMonster == "Monkey" then
            Mon = "Monkey"
            NameQuest = "JungleQuest"
            LevelQuest = 1
            NameMon = "Monkey"
            CFrameQuest = CFrame.new(-1598.08911, 35.5501175, 153.377838, 0, 0, 1, 0, 1, 0, -1, 0, 0)
        elseif MyLevel == 15 or MyLevel <= 29 or SelectMonster == "Gorilla" then
            Mon = "Gorilla"
            NameQuest = "JungleQuest"
            LevelQuest = 2
            NameMon = "Gorilla"
            CFrameQuest = CFrame.new(-1598.08911, 35.5501175, 153.377838, 0, 0, 1, 0, 1, 0, -1, 0, 0)
        elseif MyLevel == 30 or MyLevel <= 39 or SelectMonster == "Pirate" then
            Mon = "Pirate"
            NameQuest = "BuggyQuest1"
            LevelQuest = 1
            NameMon = "Pirate"
            CFrameQuest = CFrame.new(-1141.0752, 4.10001278, 3831.5498, 0.965929627, -0, -0.258804798, 0, 1, -0,
                0.258804798, 0, 0.965929627)
        elseif MyLevel == 40 or MyLevel <= 59 or SelectMonster == "Brute" then
            Mon = "Brute"
            NameQuest = "BuggyQuest1"
            LevelQuest = 2
            NameMon = "Brute"
            CFrameQuest = CFrame.new(-1141.0752, 4.10001278, 3831.5498, 0.965929627, -0, -0.258804798, 0, 1, -0,
                0.258804798, 0, 0.965929627)
        elseif MyLevel == 60 or MyLevel <= 74 or SelectMonster == "Desert Bandit" then
            Mon = "Desert Bandit"
            NameQuest = "DesertQuest"
            LevelQuest = 1
            NameMon = "Desert Bandit"
            CFrameQuest = CFrame.new(894.488647, 5.14000702, 4392.43359, 0.819155693, -0, -0.573571265, 0, 1, -0,
                0.573571265, 0, 0.819155693)
        elseif MyLevel == 75 or MyLevel <= 89 or SelectMonster == "Desert Officer" then
            Mon = "Desert Officer"
            NameQuest = "DesertQuest"
            LevelQuest = 2
            NameMon = "Desert Officer"
            CFrameQuest = CFrame.new(894.488647, 5.14000702, 4392.43359, 0.819155693, -0, -0.573571265, 0, 1, -0,
                0.573571265, 0, 0.819155693)
        elseif MyLevel == 90 or MyLevel <= 99 or SelectMonster == "Snow Bandit" then
            Mon = "Snow Bandit"
            NameQuest = "SnowQuest"
            LevelQuest = 1
            NameMon = "Snow Bandit"
            CFrameQuest = CFrame.new(1387.18835, 86.6207504, -1295.04456, -0.25917995, 0, 0.965829313, 0, 1, 0,
                -0.965829313, 0, -0.25917995)
        elseif MyLevel == 100 or MyLevel <= 119 or SelectMonster == "Snowman" then
            Mon = "Snowman"
            NameQuest = "SnowQuest"
            LevelQuest = 2
            NameMon = "Snowman"
            CFrameQuest = CFrame.new(1387.18835, 86.6207504, -1295.04456, -0.25917995, 0, 0.965829313, 0, 1, 0,
                -0.965829313, 0, -0.25917995)
        elseif MyLevel == 120 or MyLevel <= 149 or SelectMonster == "Chief Petty Officer" then
            Mon = "Chief Petty Officer"
            NameQuest = "MarineQuest2"
            LevelQuest = 1
            NameMon = "Chief Petty Officer"
            CFrameQuest = CFrame.new(-5039.58643, 27.3500385, 4324.68018, -0.422094226, -0, -0.906552136, 0, 1, -0,
                0.906552136, 0, -0.422094226)
        elseif MyLevel == 150 or MyLevel <= 174 or SelectMonster == "Sky Bandit" then
            Mon = "Sky Bandit"
            NameQuest = "SkyQuest"
            LevelQuest = 1
            NameMon = "Sky Bandit"
            CFrameQuest = CFrame.new(-4839.53027, 716.368591, -2619.44165, 0.139098823, 0, 0.990278423, 0, 1, 0,
                -0.990278423, 0, 0.139098823)
        elseif MyLevel == 175 or MyLevel <= 189 or SelectMonster == "Dark Master" then
            Mon = "Dark Master"
            NameQuest = "SkyQuest"
            LevelQuest = 2
            NameMon = "Dark Master"
            CFrameQuest = CFrame.new(-4839.53027, 716.368591, -2619.44165, 0.139098823, 0, 0.990278423, 0, 1, 0,
                -0.990278423, 0, 0.139098823)
        elseif MyLevel == 190 or MyLevel <= 209 or SelectMonster == "Prisoner" then
            Mon = "Prisoner"
            NameQuest = "PrisonerQuest"
            LevelQuest = 1
            NameMon = "Prisoner"
            CFrameQuest = CFrame.new(5310.60547, 0.350014925, 474.946594, 0.0175017118, 0, 0.999846935, 0, 1, 0,
                -0.999846935, 0, 0.0175017118)
        elseif MyLevel == 210 or MyLevel <= 249 or SelectMonster == "Dangerous Prisoner" then
            Mon = "Dangerous Prisoner"
            NameQuest = "PrisonerQuest"
            LevelQuest = 2
            NameMon = "Dangerous Prisoner"
            CFrameQuest = CFrame.new(5310.60547, 0.350014925, 474.946594, 0.0175017118, 0, 0.999846935, 0, 1, 0,
                -0.999846935, 0, 0.0175017118)
        elseif MyLevel == 250 or MyLevel <= 274 or SelectMonster == "Toga Warrior" then
            Mon = "Toga Warrior"
            NameQuest = "ColosseumQuest"
            LevelQuest = 1
            NameMon = "Toga Warrior"
            CFrameQuest = CFrame.new(-1580.04663, 6.35000277, -2986.47534, -0.515037298, 0, -0.857167721, 0, 1, 0,
                0.857167721, 0, -0.515037298)
        elseif MyLevel == 275 or MyLevel <= 299 or SelectMonster == "Gladiator" then
            Mon = "Gladiator"
            NameQuest = "ColosseumQuest"
            LevelQuest = 2
            NameMon = "Gladiator"
            CFrameQuest = CFrame.new(-1580.04663, 6.35000277, -2986.47534, -0.515037298, 0, -0.857167721, 0, 1, 0,
                0.857167721, 0, -0.515037298)
        elseif MyLevel == 300 or MyLevel <= 324 or SelectMonster == "Military Soldier" then
            Mon = "Military Soldier"
            NameQuest = "MagmaQuest"
            LevelQuest = 1
            NameMon = "Military Soldier"
            CFrameQuest = CFrame.new(-5313.37012, 10.9500084, 8515.29395, -0.363785148, 0, 0.93148309, 0, 1, 0,
                -0.93148309, 0, -0.363785148)
        elseif MyLevel == 325 or MyLevel <= 374 or SelectMonster == "Military Spy" then
            Mon = "Military Spy"
            NameQuest = "MagmaQuest"
            LevelQuest = 2
            NameMon = "Military Spy"
            CFrameQuest = CFrame.new(-5313.37012, 10.9500084, 8515.29395, -0.363785148, 0, 0.93148309, 0, 1, 0,
                -0.93148309, 0, -0.363785148)
        elseif MyLevel == 375 or MyLevel <= 399 or SelectMonster == "Fishman Warrior" then
            Mon = "Fishman Warrior"
            NameQuest = "FishmanQuest"
            LevelQuest = 1
            NameMon = "Fishman Warrior"
            CFrameQuest = CFrame.new(61121.1094, 17.953125, 1564.52637, -0.913477898, 0, -0.406888306, 0, 1, 0,
                0.406888306, 0, -0.913477898)
            if _G['Auto Farm Level'] and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",
                    Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
            end
        elseif MyLevel == 400 or MyLevel <= 449 or SelectMonster == "Fishman Commando" then
            Mon = "Fishman Commando"
            NameQuest = "FishmanQuest"
            LevelQuest = 2
            NameMon = "Fishman Commando"
            CFrameQuest = CFrame.new(61121.1094, 17.953125, 1564.52637, -0.913477898, 0, -0.406888306, 0, 1, 0,
                0.406888306, 0, -0.913477898)
            if _G['Auto Farm Level'] and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",
                    Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
            end
        elseif MyLevel == 450 or MyLevel <= 474 or SelectMonster == "God's Guard" then
            Mon = "God's Guard"
            NameQuest = "SkyExp1Quest"
            LevelQuest = 1
            NameMon = "God's Guard"
            CFrameQuest = CFrame.new(-4721.88867, 843.874695, -1949.96643, 0.996191859, -0, -0.0871884301, 0, 1, -0,
                0.0871884301, 0, 0.996191859)
            if _G['Auto Farm Level'] and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",
                    Vector3.new(-4607.82275, 872.54248, -1667.55688))
            end
        elseif MyLevel == 475 or MyLevel <= 524 or SelectMonster == "Shanda" then
            Mon = "Shanda"
            NameQuest = "SkyExp1Quest"
            LevelQuest = 2
            NameMon = "Shanda"
            CFrameQuest = CFrame.new(-7859.09814, 5544.19043, -381.476196, -0.422592998, 0, 0.906319618, 0, 1, 0,
                -0.906319618, 0, -0.422592998)
            if _G['Auto Farm Level'] and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",
                    Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047))
            end
        elseif MyLevel == 525 or MyLevel <= 549 or SelectMonster == "Royal Squad" then
            Mon = "Royal Squad"
            NameQuest = "SkyExp2Quest"
            LevelQuest = 1
            NameMon = "Royal Squad"
            CFrameQuest = CFrame.new(-7906.81592, 5634.6626, -1411.99194, 0, 0, -1, 0, 1, 0, 1, 0, 0)
        elseif MyLevel == 550 or MyLevel <= 624 or SelectMonster == "Royal Soldier" then
            Mon = "Royal Soldier"
            NameQuest = "SkyExp2Quest"
            LevelQuest = 2
            NameMon = "Royal Soldier"
            CFrameQuest = CFrame.new(-7906.81592, 5634.6626, -1411.99194, 0, 0, -1, 0, 1, 0, 1, 0, 0)
        elseif MyLevel == 625 or MyLevel <= 649 or SelectMonster == "Galley Pirate" then
            Mon = "Galley Pirate"
            NameQuest = "FountainQuest"
            LevelQuest = 1
            NameMon = "Galley Pirate"
            CFrameQuest = CFrame.new(5259.81982, 37.3500175, 4050.0293, 0.087131381, 0, 0.996196866, 0, 1, 0,
                -0.996196866, 0, 0.087131381)
        elseif MyLevel >= 650 or MyLevel >= 649 or SelectMonster == "Galley Captain" then
            Mon = "Galley Captain"
            NameQuest = "FountainQuest"
            LevelQuest = 2
            NameMon = "Galley Captain"
            CFrameQuest = CFrame.new(5259.81982, 37.3500175, 4050.0293, 0.087131381, 0, 0.996196866, 0, 1, 0,
                -0.996196866, 0, 0.087131381)
        end
    end
    if L_4442272183_ then
        if MyLevel == 700 or MyLevel <= 724 or SelectMonster == "Raider" then
            Mon = "Raider"
            NameQuest = "Area1Quest"
            LevelQuest = 1
            NameMon = "Raider"
            CFrameQuest = CFrame.new(-429.543518, 71.7699966, 1836.18188, -0.334363222, -0, -0.942444324, 0, 1, -0,
                0.942444324, 0, -0.334363222)
        elseif MyLevel == 725 or MyLevel <= 774 or SelectMonster == "Mercenary" then
            Mon = "Mercenary"
            NameQuest = "Area1Quest"
            LevelQuest = 2
            NameMon = "Mercenary"
            CFrameQuest = CFrame.new(-429.543518, 71.7699966, 1836.18188, -0.334363222, -0, -0.942444324, 0, 1, -0,
                0.942444324, 0, -0.334363222)
        elseif MyLevel == 775 or MyLevel <= 799 or SelectMonster == "Swan Pirate" then
            Mon = "Swan Pirate"
            NameQuest = "Area2Quest"
            LevelQuest = 1
            NameMon = "Swan Pirate"
            CFrameQuest = CFrame.new(638.43811, 71.769989, 918.282898, 0.139203906, 0, 0.99026376, 0, 1, 0,
                -0.99026376, 0, 0.139203906)
        elseif MyLevel == 800 or MyLevel <= 874 or SelectMonster == "Factory Staff" then
            Mon = "Factory Staff"
            NameQuest = "Area2Quest"
            LevelQuest = 2
            NameMon = "Factory Staff"
            CFrameQuest = CFrame.new(638.43811, 71.769989, 918.282898, 0.139203906, 0, 0.99026376, 0, 1, 0,
                -0.99026376, 0, 0.139203906)
        elseif MyLevel == 875 or MyLevel <= 899 or SelectMonster == "Marine Lieutenant" then
            Mon = "Marine Lieutenant"
            NameQuest = "MarineQuest3"
            LevelQuest = 1
            NameMon = "Marine Lieutenant"
            CFrameQuest = CFrame.new(-2440.79639, 71.7140732, -3216.06812, 0.866007268, 0, 0.500031412, 0, 1, 0,
                -0.500031412, 0, 0.866007268)
        elseif MyLevel == 900 or MyLevel <= 949 or SelectMonster == "Marine Captain" then
            Mon = "Marine Captain"
            NameQuest = "MarineQuest3"
            LevelQuest = 2
            NameMon = "Marine Captain"
            CFrameQuest = CFrame.new(-2440.79639, 71.7140732, -3216.06812, 0.866007268, 0, 0.500031412, 0, 1, 0,
                -0.500031412, 0, 0.866007268)
        elseif MyLevel == 950 or MyLevel <= 974 or SelectMonster == "Zombie" then
            Mon = "Zombie"
            NameQuest = "ZombieQuest"
            LevelQuest = 1
            NameMon = "Zombie"
            CFrameQuest = CFrame.new(-5497.06152, 47.5923004, -795.237061, -0.29242146, 0, -0.95628953, 0, 1, 0,
                0.95628953, 0, -0.29242146)
        elseif MyLevel == 975 or MyLevel <= 999 or SelectMonster == "Vampire" then
            Mon = "Vampire"
            NameQuest = "ZombieQuest"
            LevelQuest = 2
            NameMon = "Vampire"
            CFrameQuest = CFrame.new(-5497.06152, 47.5923004, -795.237061, -0.29242146, 0, -0.95628953, 0, 1, 0,
                0.95628953, 0, -0.29242146)
        elseif MyLevel == 1000 or MyLevel <= 1049 or SelectMonster == "Snow Trooper" then
            Mon = "Snow Trooper"
            NameQuest = "SnowMountainQuest"
            LevelQuest = 1
            NameMon = "Snow Trooper"
            CFrameQuest = CFrame.new(609.858826, 400.119904, -5372.25928, -0.589568138, 0, 0.807719052, 0, 1, 0,
                -0.807719052, 0, -0.589568138)
        elseif MyLevel == 1050 or MyLevel <= 1099 or SelectMonster == "Winter Warrior" then
            Mon = "Winter Warrior"
            NameQuest = "SnowMountainQuest"
            LevelQuest = 2
            NameMon = "Winter Warrior"
            CFrameQuest = CFrame.new(609.858826, 400.119904, -5372.25928, -0.589568138, 0, 0.807719052, 0, 1, 0,
                -0.807719052, 0, -0.589568138)
        elseif MyLevel == 1100 or MyLevel <= 1124 or SelectMonster == "Lab Subordinate" then
            Mon = "Lab Subordinate"
            NameQuest = "IceSideQuest"
            LevelQuest = 1
            NameMon = "Lab Subordinate"
            CFrameQuest = CFrame.new(-6064.06885, 15.2422857, -4902.97852, 0.453972578, 0, -0.891015649, 0, 1, 0,
                0.891015649, 0, 0.453972578)
        elseif MyLevel == 1125 or MyLevel <= 1174 or SelectMonster == "Horned Warrior" then
            Mon = "Horned Warrior"
            NameQuest = "IceSideQuest"
            LevelQuest = 2
            NameMon = "Horned Warrior"
            CFrameQuest = CFrame.new(-6064.06885, 15.2422857, -4902.97852, 0.453972578, 0, -0.891015649, 0, 1, 0,
                0.891015649, 0, 0.453972578)
        elseif MyLevel == 1175 or MyLevel <= 1199 or SelectMonster == "Magma Ninja" then
            Mon = "Magma Ninja"
            NameQuest = "FireSideQuest"
            LevelQuest = 1
            NameMon = "Magma Ninja"
            CFrameQuest = CFrame.new(-5428.03174, 15.0622921, -5299.43457, -0.882952213, 0, 0.469463557, 0, 1, 0,
                -0.469463557, 0, -0.882952213)
        elseif MyLevel == 1200 or MyLevel <= 1249 or SelectMonster == "Lava Pirate" then
            Mon = "Lava Pirate"
            NameQuest = "FireSideQuest"
            LevelQuest = 2
            NameMon = "Lava Pirate"
            CFrameQuest = CFrame.new(-5428.03174, 15.0622921, -5299.43457, -0.882952213, 0, 0.469463557, 0, 1, 0,
                -0.469463557, 0, -0.882952213)
        elseif MyLevel == 1250 or MyLevel <= 1274 or SelectMonster == "Ship Deckhand" then
            Mon = "Ship Deckhand"
            NameQuest = "ShipQuest1"
            LevelQuest = 1
            NameMon = "Ship Deckhand"
            CFrameQuest = CFrame.new(1040.55554, 124.942924, 32909.1055, -0.642763734, 0, 0.766064942, 0, 1, 0,
                -0.766064942, 0, -0.642763734)
        elseif MyLevel == 1275 or MyLevel <= 1299 or SelectMonster == "Ship Engineer" then
            Mon = "Ship Engineer"
            NameQuest = "ShipQuest1"
            LevelQuest = 2
            NameMon = "Ship Engineer"
            CFrameQuest = CFrame.new(1040.55554, 124.942924, 32909.1055, -0.642763734, 0, 0.766064942, 0, 1, 0,
                -0.766064942, 0, -0.642763734)
        elseif MyLevel == 1300 or MyLevel <= 1324 or SelectMonster == "Ship Steward" then
            Mon = "Ship Steward"
            NameQuest = "ShipQuest2"
            LevelQuest = 1
            NameMon = "Ship Steward"
            CFrameQuest = CFrame.new(974.075439, 124.93837, 33253.6211, 0.799319565, 0, 0.600906253, 0, 1, 0,
                -0.600906253, 0, 0.799319565)
            if _G['Auto Farm Level'] and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",
                    Vector3.new(923.212524, 125.086975, 32852.832))
            end
        elseif MyLevel == 1325 or MyLevel <= 1349 or SelectMonster == "Ship Officer" then
            Mon = "Ship Officer"
            NameQuest = "ShipQuest2"
            LevelQuest = 2
            NameMon = "Ship Officer"
            CFrameQuest = CFrame.new(974.075439, 124.93837, 33253.6211, 0.799319565, 0, 0.600906253, 0, 1, 0,
                -0.600906253, 0, 0.799319565)
        elseif MyLevel == 1350 or MyLevel <= 1374 or SelectMonster == "Arctic Warrior" then
            Mon = "Arctic Warrior"
            NameQuest = "FrostQuest"
            LevelQuest = 1
            NameMon = "Arctic Warrior"
            CFrameQuest = CFrame.new(5667.6582, 26.7997818, -6486.08984, -0.933587909, 0, -0.358349502, 0, 1, 0,
                0.358349502, 0, -0.933587909)
        elseif MyLevel == 1375 or MyLevel <= 1424 or SelectMonster == "Snow Lurker" then
            Mon = "Snow Lurker"
            NameQuest = "FrostQuest"
            LevelQuest = 2
            NameMon = "Snow Lurker"
            CFrameQuest = CFrame.new(5667.6582, 26.7997818, -6486.08984, -0.933587909, 0, -0.358349502, 0, 1, 0,
                0.358349502, 0, -0.933587909)
        elseif MyLevel == 1425 or MyLevel <= 1449 or SelectMonster == "Sea Soldier" then
            Mon = "Sea Soldier"
            NameQuest = "ForgottenQuest"
            LevelQuest = 1
            NameMon = "Sea Soldier"
            CFrameQuest = CFrame.new(-3054.44458, 238.344269, -10142.8193, 0.990270376, 0, -0.13915664, 0, 1, 0,
                0.13915664, 0, 0.990270376)
        elseif MyLevel == 1450 or MyLevel >= 1449 or SelectMonster == "Water Fighter" then
            Mon = "Water Fighter"
            NameQuest = "ForgottenQuest"
            LevelQuest = 2
            NameMon = "Water Fighter"
            CFrameQuest = CFrame.new(-3054.44458, 238.344269, -10142.8193, 0.990270376, 0, -0.13915664, 0, 1, 0,
                0.13915664, 0, 0.990270376)
        end
    end
    if L_7449423635_ then
        if MyLevel == 1500 or MyLevel <= 1524 or SelectMonster == "Pirate Millionaire" then
            Mon = "Pirate Millionaire"
            NameQuest = "PiratePortQuest"
            LevelQuest = 1
            NameMon = "Pirate Millionaire"
            CFrameQuest = CFrame.new(-450.104645, 107.681458, 5950.72607, 0.912899733, -0, -0.408183903, 0, 1, -0,
                0.408183903, 0, 0.912899733)
        elseif MyLevel == 1525 or MyLevel <= 1574 or SelectMonster == "Pistol Billionaire" then
            Mon = "Pistol Billionaire"
            NameQuest = "PiratePortQuest"
            LevelQuest = 2
            NameMon = "Pistol Billionaire"
            CFrameQuest = CFrame.new(-450.104645, 107.681458, 5950.72607, 0.912899733, -0, -0.408183903, 0, 1, -0,
                0.408183903, 0, 0.912899733)
        elseif MyLevel == 1575 or MyLevel <= 1599 or SelectMonster == "Dragon Crew Warrior" then
            Mon = "Dragon Crew Warrior"
            NameQuest = "DragonCrewQuest"
            LevelQuest = 1
            NameMon = "Dragon Crew Warrior"
            CFrameQuest = CFrame.new(6735.11084, 126.990463, -711.097961, 0.629286051, 0, -0.777173758, 0, 1, 0,
                0.777173758, 0, 0.629286051)
            if _G['Auto Farm Level'] and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",
                    Vector3.new(5753.5478515625, 610.7880859375, -282.33172607421875))
            end
        elseif MyLevel == 1600 or MyLevel <= 1624 or SelectMonster == "Dragon Crew Archer" then
            Mon = "Dragon Crew Archer"
            NameQuest = "DragonCrewQuest"
            LevelQuest = 2
            NameMon = "Dragon Crew Archer"
            CFrameQuest = CFrame.new(6735.11084, 126.990463, -711.097961, 0.629286051, 0, -0.777173758, 0, 1, 0,
                0.777173758, 0, 0.629286051)
        elseif MyLevel == 1625 or MyLevel <= 1649 or SelectMonster == "Hydra Enforcer" then
            Mon = "Hydra Enforcer"
            NameQuest = "VenomCrewQuest"
            LevelQuest = 1
            NameMon = "Hydra Enforcer"
            CFrameQuest = CFrame.new(5214.33936, 1003.46765, 759.507324, 0.92051065, 0, 0.390717506, 0, 1, 0,
                -0.390717506, 0, 0.92051065)
        elseif MyLevel == 1650 or MyLevel <= 1699 or SelectMonster == "Venomous Assailant" then
            Mon = "Venomous Assailant"
            NameQuest = "VenomCrewQuest"
            LevelQuest = 2
            NameMon = "Venomous Assailant"
            CFrameQuest = CFrame.new(5214.33936, 1003.46765, 759.507324, 0.92051065, 0, 0.390717506, 0, 1, 0,
                -0.390717506, 0, 0.92051065)
        elseif MyLevel == 1700 or MyLevel <= 1724 or SelectMonster == "Marine Commodore" then
            Mon = "Marine Commodore"
            NameQuest = "MarineTreeIsland"
            LevelQuest = 1
            NameMon = "Marine Commodore"
            CFrameQuest = CFrame.new(2485.7334, 73.345993, -6788.62549, -0.427591443, 0, 0.903972208, 0, 1, 0,
                -0.903972208, 0, -0.427591443)
        elseif MyLevel == 1725 or MyLevel <= 1774 or SelectMonster == "Marine Rear Admiral" then
            Mon = "Marine Rear Admiral"
            NameQuest = "MarineTreeIsland"
            LevelQuest = 2
            NameMon = "Marine Rear Admiral"
            CFrameQuest = CFrame.new(2485.7334, 73.345993, -6788.62549, -0.427591443, 0, 0.903972208, 0, 1, 0,
                -0.903972208, 0, -0.427591443)
        elseif MyLevel == 1775 or MyLevel <= 1799 or SelectMonster == "Fishman Raider" then
            Mon = "Fishman Raider"
            NameQuest = "DeepForestIsland3"
            LevelQuest = 1
            NameMon = "Fishman Raider"
            CFrameQuest = CFrame.new(-10582.759765625, 331.78845214844, -8757.666015625)
        elseif MyLevel == 1800 or MyLevel <= 1824 or SelectMonster == "Fishman Captain" then
            Mon = "Fishman Captain"
            NameQuest = "DeepForestIsland3"
            LevelQuest = 2
            NameMon = "Fishman Captain"
            CFrameQuest = CFrame.new(-10583.099609375, 331.78845214844, -8759.4638671875)
            if _G['Auto Farm Level'] and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",
                    Vector3.new(-12468.5380859375, 375.0094299316406, -7554.62548828125))
            end
        elseif MyLevel == 1825 or MyLevel <= 1849 or SelectMonster == "Forest Pirate" then
            Mon = "Forest Pirate"
            NameQuest = "DeepForestIsland"
            LevelQuest = 1
            NameMon = "Forest Pirate"
            CFrameQuest = CFrame.new(-13232.662109375, 332.40396118164, -7626.4819335938)
        elseif MyLevel == 1850 or MyLevel <= 1899 or SelectMonster == "Mythological Pirate" then
            Mon = "Mythological Pirate"
            NameQuest = "DeepForestIsland"
            LevelQuest = 2
            NameMon = "Mythological Pirate"
            CFrameQuest = CFrame.new(-13232.662109375, 332.40396118164, -7626.4819335938)
        elseif MyLevel == 1900 or MyLevel <= 1924 or SelectMonster == "Jungle Pirate" then
            Mon = "Jungle Pirate"
            NameQuest = "DeepForestIsland2"
            LevelQuest = 1
            NameMon = "Jungle Pirate"
            CFrameQuest = CFrame.new(-12682.096679688, 390.88653564453, -9902.1240234375)
        elseif MyLevel == 1925 or MyLevel <= 1974 or SelectMonster == "Musketeer Pirate" then
            Mon = "Musketeer Pirate"
            NameQuest = "DeepForestIsland2"
            LevelQuest = 2
            NameMon = "Musketeer Pirate"
            CFrameQuest = CFrame.new(-12682.096679688, 390.88653564453, -9902.1240234375)
        elseif MyLevel == 1975 or MyLevel <= 1999 or SelectMonster == "Reborn Skeleton" then
            Mon = "Reborn Skeleton"
            NameQuest = "HauntedQuest1"
            LevelQuest = 1
            NameMon = "Reborn Skeleton"
            CFrameQuest = CFrame.new(-9480.80762, 142.130661, 5566.37305, -0.00655503059, 4.52954225e-08,
                -0.999978542, 2.04920472e-08, 1, 4.51620679e-08, 0.999978542, -2.01955679e-08, -0.00655503059)
        elseif MyLevel == 2000 or MyLevel <= 2024 or SelectMonster == "Living Zombie" then
            Mon = "Living Zombie"
            NameQuest = "HauntedQuest1"
            LevelQuest = 2
            NameMon = "Living Zombie"
            CFrameQuest = CFrame.new(-9480.80762, 142.130661, 5566.37305, -0.00655503059, 4.52954225e-08,
                -0.999978542, 2.04920472e-08, 1, 4.51620679e-08, 0.999978542, -2.01955679e-08, -0.00655503059)
        elseif MyLevel == 2025 or MyLevel <= 2049 or SelectMonster == "Demonic Soul" then
            Mon = "Demonic Soul"
            NameQuest = "HauntedQuest2"
            LevelQuest = 1
            NameMon = "Demonic Soul"
            CFrameQuest = CFrame.new(-9516.9931640625, 178.00651550293, 6078.4653320313)
        elseif MyLevel == 2050 or MyLevel <= 2074 or SelectMonster == "Posessed Mummy" then
            Mon = "Posessed Mummy"
            NameQuest = "HauntedQuest2"
            LevelQuest = 2
            NameMon = "Posessed Mummy"
            CFrameQuest = CFrame.new(-9516.9931640625, 178.00651550293, 6078.4653320313)
        elseif MyLevel == 2075 or MyLevel <= 2099 or SelectMonster == "Peanut Scout" then
            Mon = "Peanut Scout"
            NameQuest = "NutsIslandQuest"
            LevelQuest = 1
            NameMon = "Peanut Scout"
            CFrameQuest = CFrame.new(-2105.53198, 37.2495995, -10195.5088, -0.766061664, 0, -0.642767608, 0, 1, 0,
                0.642767608, 0, -0.766061664)
        elseif MyLevel == 2100 or MyLevel <= 2124 or SelectMonster == "Peanut President" then
            Mon = "Peanut President"
            NameQuest = "NutsIslandQuest"
            LevelQuest = 2
            NameMon = "Peanut President"
            CFrameQuest = CFrame.new(-2105.53198, 37.2495995, -10195.5088, -0.766061664, 0, -0.642767608, 0, 1, 0,
                0.642767608, 0, -0.766061664)
        elseif MyLevel == 2125 or MyLevel <= 2149 or SelectMonster == "Ice Cream Chef" then
            Mon = "Ice Cream Chef"
            NameQuest = "IceCreamIslandQuest"
            LevelQuest = 1
            NameMon = "Ice Cream Chef"
            CFrameQuest = CFrame.new(-819.376709, 64.9259796, -10967.2832, -0.766061664, 0, 0.642767608, 0, 1, 0,
                -0.642767608, 0, -0.766061664)
        elseif MyLevel == 2150 or MyLevel <= 2199 or SelectMonster == "Ice Cream Commander" then
            Mon = "Ice Cream Commander"
            NameQuest = "IceCreamIslandQuest"
            LevelQuest = 2
            NameMon = "Ice Cream Commander"
            CFrameQuest = CFrame.new(-819.376709, 64.9259796, -10967.2832, -0.766061664, 0, 0.642767608, 0, 1, 0,
                -0.642767608, 0, -0.766061664)
        elseif MyLevel == 2200 or MyLevel <= 2224 or SelectMonster == "Cookie Crafter" then
            Mon = "Cookie Crafter"
            NameQuest = "CakeQuest1"
            LevelQuest = 1
            NameMon = "Cookie Crafter"
            CFrameQuest = CFrame.new(-2022.29858, 36.9275894, -12030.9766, -0.961273909, 0, -0.275594592, 0, 1, 0,
                0.275594592, 0, -0.961273909)
        elseif MyLevel == 2225 or MyLevel <= 2249 or SelectMonster == "Cake Guard" then
            Mon = "Cake Guard"
            NameQuest = "CakeQuest1"
            LevelQuest = 2
            NameMon = "Cake Guard"
            CFrameQuest = CFrame.new(-2022.29858, 36.9275894, -12030.9766, -0.961273909, 0, -0.275594592, 0, 1, 0,
                0.275594592, 0, -0.961273909)
        elseif MyLevel == 2250 or MyLevel <= 2274 or SelectMonster == "Baking Staff" then
            Mon = "Baking Staff"
            NameQuest = "CakeQuest2"
            LevelQuest = 1
            NameMon = "Baking Staff"
            CFrameQuest = CFrame.new(-1928.31763, 37.7296638, -12840.626, 0.951068401, -0, -0.308980465, 0, 1, -0,
                0.308980465, 0, 0.951068401)
        elseif MyLevel == 2275 or MyLevel <= 2299 or SelectMonster == "Head Baker" then
            Mon = "Head Baker"
            NameQuest = "CakeQuest2"
            LevelQuest = 2
            NameMon = "Head Baker"
            CFrameQuest = CFrame.new(-1928.31763, 37.7296638, -12840.626, 0.951068401, -0, -0.308980465, 0, 1, -0,
                0.308980465, 0, 0.951068401)
        elseif MyLevel == 2300 or MyLevel <= 2324 or SelectMonster == "Cocoa Warrior" then
            Mon = "Cocoa Warrior"
            NameQuest = "ChocQuest1"
            LevelQuest = 1
            NameMon = "Cocoa Warrior"
            CFrameQuest = CFrame.new(231.75, 23.9003029, -12200.292, -1, 0, 0, 0, 1, 0, 0, 0, -1)
        elseif MyLevel == 2325 or MyLevel <= 2349 or SelectMonster == "Chocolate Bar Battler" then
            Mon = "Chocolate Bar Battler"
            NameQuest = "ChocQuest1"
            LevelQuest = 2
            NameMon = "Chocolate Bar Battler"
            CFrameQuest = CFrame.new(231.75, 23.9003029, -12200.292, -1, 0, 0, 0, 1, 0, 0, 0, -1)
        elseif MyLevel == 2350 or MyLevel <= 2374 or SelectMonster == "Sweet Thief" then
            Mon = "Sweet Thief"
            NameQuest = "ChocQuest2"
            LevelQuest = 1
            NameMon = "Sweet Thief"
            CFrameQuest = CFrame.new(151.198242, 23.8907146, -12774.6172, 0.422592998, 0, 0.906319618, 0, 1, 0,
                -0.906319618, 0, 0.422592998)
        elseif MyLevel == 2375 or MyLevel <= 2400 or SelectMonster == "Candy Rebel" then
            Mon = "Candy Rebel"
            NameQuest = "ChocQuest2"
            LevelQuest = 2
            NameMon = "Candy Rebel"
            CFrameQuest = CFrame.new(151.198242, 23.8907146, -12774.6172, 0.422592998, 0, 0.906319618, 0, 1, 0,
                -0.906319618, 0, 0.422592998)
        elseif MyLevel == 2400 or MyLevel <= 2424 or SelectMonster == "Candy Pirate" then
            Mon = "Candy Pirate"
            NameQuest = "CandyQuest1"
            LevelQuest = 1
            NameMon = "Candy Pirate"
            CFrameQuest = CFrame.new(-1166, 60, -14492)
        elseif MyLevel == 2425 or MyLevel <= 2449 or SelectMonster == "Snow Demon" then
            Mon = "Snow Demon"
            NameQuest = "CandyQuest1"
            LevelQuest = 2
            NameMon = "Snow Demon"
            CFrameQuest = CFrame.new(-1166, 60, -14492)
        elseif MyLevel == 2450 or MyLevel <= 2474 or SelectMonster == "Isle Outlaw" then
            Mon = "Isle Outlaw"
            NameQuest = "TikiQuest1"
            LevelQuest = 1
            NameMon = "Isle Outlaw"
            CFrameQuest = CFrame.new(-16548.8164, 55.6059914, -172.8125, 0.213092566, -0, -0.977032006, 0, 1, -0,
                0.977032006, 0, 0.213092566)
        elseif MyLevel == 2475 or MyLevel <= 2499 or SelectMonster == "Island Boy" then
            Mon = "Island Boy"
            NameQuest = "TikiQuest1"
            LevelQuest = 2
            NameMon = "Island Boy"
            CFrameQuest = CFrame.new(-16548.8164, 55.6059914, -172.8125, 0.213092566, -0, -0.977032006, 0, 1, -0,
                0.977032006, 0, 0.213092566)
        elseif MyLevel == 2500 or MyLevel <= 2524 or SelectMonster == "Sun-kissed Warrior" then
            Mon = "Sun-kissed Warrior"
            NameQuest = "TikiQuest2"
            LevelQuest = 1
            NameMon = "Sun-"
            CFrameQuest = CFrame.new(-16541.0215, 54.770813, 1051.46118, 0.0410757065, -0, -0.999156058, 0, 1, -0,
                0.999156058, 0, 0.0410757065)
        elseif MyLevel == 2525 or MyLevel <= 2549 or SelectMonster == "Isle Champion" then
            Mon = "Isle Champion"
            NameQuest = "TikiQuest2"
            LevelQuest = 2
            NameMon = "Isle Champion"
            CFrameQuest = CFrame.new(-16541.0215, 54.770813, 1051.46118, 0.0410757065, -0, -0.999156058, 0, 1, -0,
                0.999156058, 0, 0.0410757065)
        elseif MyLevel == 2550 or MyLevel <= 2574 then
            Mon = "Serpent Hunter"
            NameQuest = "TikiQuest3"
            LevelQuest = 1
            NameMon = "Serpent Hunter"
            CFrameQuest = CFrame.new(-16665.1914, 104.596405, 1579.69434, 0.951068401, -0, -0.308980465, 0, 1, -0,
                0.308980465, 0, 0.951068401)
        elseif MyLevel == 2575 or MyLevel <= 2599 then
            Mon = "Skull Slayer"
            NameQuest = "TikiQuest3"
            LevelQuest = 2
            NameMon = "Skull Slayer"
            CFrameQuest = CFrame.new(-16665.1914, 104.596405, 1579.69434, 0.951068401, -0, -0.308980465, 0, 1, -0,
                0.308980465, 0, 0.951068401)
        elseif MyLevel == 2600 or MyLevel <= 2624 then
            Mon = "Reef Bandit"
            NameQuest = "SubmergedQuest1"
            LevelQuest = 1
            NameMon = "Reef Bandit"
            CFrameQuest = CFrame.new(10780.6396, -2088.41406, 9260.4541, -0.953751206, 0, 0.300598353, 0, 1, 0, -0.300598353, 0, -0.953751206)
                if _G['Auto Farm Level'] and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-16271.3271484375, 25.233417510986328, 1370.41943359375))
        elseif MyLevel == 2625 or MyLevel <= 2649 then
            Mon = "Coral Pirate"
            NameQuest = "SubmergedQuest1"
            LevelQuest = 2
            NameMon = "Coral Pirate"
            CFrameQuest = CFrame.new(10780.6396, -2088.41406, 9260.4541, -0.953751206, 0, 0.300598353, 0, 1, 0, -0.300598353, 0, -0.953751206)
                if _G['Auto Farm Level'] and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-16271.3271484375, 25.233417510986328, 1370.41943359375))
        elseif MyLevel == 2650 or MyLevel <= 2674 then
            Mon = "Sea Chanter"
            NameQuest = "SubmergedQuest2"
            LevelQuest = 1
            NameMon = "Sea Chanter"
            CFrameQuest = CFrame.new(10883.5986, -2086.88892, 10034.0195, 0.99651581, 0, 0.0834043249, 0, 1, 0, -0.0834043249, 0, 0.99651581)
                if _G['Auto Farm Level'] and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(10533.2861328125, -2029.0860595703125, 9940.482421875))
        elseif MyLevel >= 2675 then
            Mon = "Ocean Prophet"
            NameQuest = "SubmergedQuest2"
            LevelQuest = 2
            NameMon = "Ocean Prophet"
            CFrameQuest = CFrame.new(10883.5986, -2086.88892, 10034.0195, 0.99651581, 0, 0.0834043249, 0, 1, 0, -0.0834043249, 0, 0.99651581)
                if _G['Auto Farm Level'] and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-16271.3271484375, 25.233417510986328, 1370.41943359375))
            end
        end
    end
end
end
function CheckMon()
    MyLevel = game:GetService("Players").LocalPlayer.Data.Level.Value
    if L_2753915549_ then
        if MyLevel == 1 or MyLevel <= 9 or SelectMonster == "Bandit" then
            CFrameMon1 = CFrame.new(922, 50, 1543)
            CFrameMon2 = CFrame.new(1195, 41, 1600)
            CFrameMon3 = CFrame.new(1317, 39, 1521)
            CFrameMon4 = nil
        elseif MyLevel == 10 or MyLevel <= 14 or SelectMonster == "Monkey" then
            CFrameMon1 = CFrame.new(-1409, 58, 175)
            CFrameMon2 = CFrame.new(-1677, 57, -91)
            CFrameMon3 = CFrame.new(-1795, 57, 104)
            CFrameMon4 = CFrame.new(-1644, 65, 359)
        elseif MyLevel == 15 or MyLevel <= 29 or SelectMonster == "Gorilla" then
            CFrameMon1 = CFrame.new(-1264, 95, -494)
            CFrameMon2 = nil
            CFrameMon3 = nil
            CFrameMon4 = nil
        elseif MyLevel == 30 or MyLevel <= 39 or SelectMonster == "Pirate" then
            CFrameMon1 = CFrame.new(-1205, 53, 3930)
            CFrameMon2 = nil
            CFrameMon3 = nil
            CFrameMon4 = nil
        elseif MyLevel == 40 or MyLevel <= 59 or SelectMonster == "Brute" then
            CFrameMon1 = CFrame.new(-1385, 68, 4234)
            CFrameMon2 = CFrame.new(-1153, 96, 4356)
            CFrameMon3 = CFrame.new(-896, 60, 4282)
            CFrameMon4 = nil
        elseif MyLevel == 60 or MyLevel <= 74 or SelectMonster == "Desert Bandit" then
            CFrameMon1 = CFrame.new(928, 56, 4485)
            CFrameMon2 = nil
            CFrameMon3 = nil
            CFrameMon4 = nil
        elseif MyLevel == 75 or MyLevel <= 89 or SelectMonster == "Desert Officer" then
            CFrameMon1 = CFrame.new(1611, 48, 4376)
            CFrameMon2 = nil
            CFrameMon3 = nil
            CFrameMon4 = nil
        elseif MyLevel == 90 or MyLevel <= 99 or SelectMonster == "Snow Bandit" then
            CFrameMon1 = CFrame.new(1415, 112, -1431)
            CFrameMon2 = CFrame.new(1261, 122, -1358)
            CFrameMon3 = nil
            CFrameMon4 = nil
        elseif MyLevel == 100 or MyLevel <= 119 or SelectMonster == "Snowman" then
            CFrameMon1 = CFrame.new(1056, 143, -1445)
            CFrameMon2 = CFrame.new(1217, 139, -1603)
            CFrameMon3 = CFrame.new(1056, 143, -1445)
            CFrameMon4 = CFrame.new(1217, 139, -1603)
        elseif MyLevel == 120 or MyLevel <= 149 or SelectMonster == "Chief Petty Officer" then
            CFrameMon1 = CFrame.new(-4936, 60, 4006)
            CFrameMon2 = CFrame.new(-4665, 66, 4505)
            CFrameMon3 = CFrame.new(-4936, 60, 4006)
            CFrameMon4 = CFrame.new(-4665, 66, 4505)
        elseif MyLevel == 150 or MyLevel <= 174 or SelectMonster == "Sky Bandit" then
            CFrameMon1 = CFrame.new(-4884, 321, -2793)
            CFrameMon2 = CFrame.new(-5085, 326, -2864)
            CFrameMon3 = nil
            CFrameMon4 = nil
        elseif MyLevel == 175 or MyLevel <= 189 or SelectMonster == "Dark Master" then
            CFrameMon1 = CFrame.new(-5161, 435, -2311)
            CFrameMon2 = CFrame.new(-5303, 433, -2163)
            CFrameMon3 = CFrame.new(-5161, 435, -2311)
            CFrameMon4 = CFrame.new(-5303, 433, -2163)
        elseif MyLevel == 190 or MyLevel <= 209 or SelectMonster == "Prisoner" then
            CFrameMon1 = CFrame.new(4978, 53, 593)
            CFrameMon2 = CFrame.new(5232, 59, 435)
            CFrameMon3 = CFrame.new(4978, 53, 593)
            CFrameMon4 = CFrame.new(5232, 59, 435)
        elseif MyLevel == 210 or MyLevel <= 249 or SelectMonster == "Dangerous Prisoner" then
            CFrameMon1 = CFrame.new(5547, 60, 542)
            CFrameMon2 = CFrame.new(5595, 54, 900)
            CFrameMon3 = CFrame.new(5099, 59, 1034)
            CFrameMon4 = nil
        elseif MyLevel == 250 or MyLevel <= 274 or SelectMonster == "Toga Warrior" then
            CFrameMon1 = CFrame.new(-1774, 53, -2771)
            CFrameMon2 = CFrame.new(-2086, 56, -2813)
            CFrameMon3 = CFrame.new(-1774, 53, -2771)
            CFrameMon4 = CFrame.new(-2086, 56, -2813)
        elseif MyLevel == 275 or MyLevel <= 299 or SelectMonster == "Gladiator" then
            CFrameMon1 = CFrame.new(-1229, 56, -3087)
            CFrameMon2 = CFrame.new(-1149, 52, -3331)
            CFrameMon3 = CFrame.new(-1410, 59, -3482)
            CFrameMon4 = CFrame.new(-1488, 62, -3224)
        elseif MyLevel == 300 or MyLevel <= 324 or SelectMonster == "Military Soldier" then
            CFrameMon1 = CFrame.new(-5470, 48, 8368)
            CFrameMon2 = CFrame.new(-5697, 39, 8426)
            CFrameMon3 = CFrame.new(-5292, 39, 8621)
            CFrameMon4 = nil
        elseif MyLevel == 325 or MyLevel <= 374 or SelectMonster == "Military Spy" then
            CFrameMon1 = CFrame.new(-5856, 108, 8841)
            CFrameMon2 = nil
            CFrameMon3 = nil
            CFrameMon4 = nil
        elseif MyLevel == 375 or MyLevel <= 399 or SelectMonster == "Fishman Warrior" then
            CFrameMon1 = CFrame.new(60956, 61, 1714)
            CFrameMon2 = CFrame.new(60783, 58, 1585)
            CFrameMon3 = CFrame.new(60911, 58, 1292)
            CFrameMon4 = nil
        elseif MyLevel == 400 or MyLevel <= 449 or SelectMonster == "Fishman Commando" then
            CFrameMon1 = CFrame.new(61744, 55, 1562)
            CFrameMon2 = CFrame.new(61784, 72, 1333)
            CFrameMon3 = CFrame.new(62036, 61, 1392)
            CFrameMon4 = CFrame.new(61904, 52, 1667)
        elseif MyLevel == 450 or MyLevel <= 474 or SelectMonster == "God's Guard" then
            CFrameMon1 = CFrame.new(-4839, 892, -1840)
            CFrameMon2 = CFrame.new(-4607, 883, -2002)
            CFrameMon3 = CFrame.new(-4839, 892, -1840)
            CFrameMon4 = CFrame.new(-4607, 883, -2002)
        elseif MyLevel == 475 or MyLevel <= 524 or SelectMonster == "Shanda" then
            CFrameMon1 = CFrame.new(-7753, 5577, -537)
            CFrameMon2 = CFrame.new(-7571, 5592, -627)
            CFrameMon3 = CFrame.new(-7617, 5591, -415)
            CFrameMon4 = nil
        elseif MyLevel == 525 or MyLevel <= 549 or SelectMonster == "Royal Squad" then
            CFrameMon1 = CFrame.new(-7829, 5653, -1367)
            CFrameMon2 = CFrame.new(-7598, 5654, -1490)
            CFrameMon3 = CFrame.new(-7829, 5653, -1367)
            CFrameMon4 = CFrame.new(-7598, 5654, -1490)
        elseif MyLevel == 550 or MyLevel <= 624 or SelectMonster == "Royal Soldier" then
            CFrameMon1 = CFrame.new(-7909, 5660, -1643)
            CFrameMon2 = CFrame.new(-7739, 5656, -1842)
            CFrameMon3 = CFrame.new(-7909, 5660, -1643)
            CFrameMon4 = CFrame.new(-7739, 5656, -1842)
        elseif MyLevel == 625 or MyLevel <= 649 or SelectMonster == "Galley Pirate" then
            CFrameMon1 = CFrame.new(5422, 87, 3977)
            CFrameMon2 = CFrame.new(5714, 81, 3955)
            CFrameMon3 = CFrame.new(5422, 87, 3977)
            CFrameMon4 = CFrame.new(5714, 81, 3955)
        elseif MyLevel >= 650 or MyLevel >= 649 or SelectMonster == "Galley Captain" then
            CFrameMon1 = CFrame.new(5460, 104, 4912)
            CFrameMon2 = CFrame.new(5724, 90, 4938)
            CFrameMon3 = CFrame.new(5919, 86, 4845)
            CFrameMon4 = nil
        end
    end
    if L_4442272183_ then
        if MyLevel == 700 or MyLevel <= 724 or SelectMonster == "Raider" then
            CFrameMon1 = CFrame.new(-723, 113, 2403)
            CFrameMon2 = CFrame.new(-364, 113, 2389)
            CFrameMon3 = CFrame.new(165, 90, 2304)
            CFrameMon4 = CFrame.new(375, 97, 2282)
        elseif MyLevel == 725 or MyLevel <= 774 or SelectMonster == "Mercenary" then
            CFrameMon1 = CFrame.new(-959, 136, 1688)
            CFrameMon2 = CFrame.new(-1004, 119, 1407)
            CFrameMon3 = CFrame.new(-1111, 148, 1089)
            CFrameMon4 = nil
        elseif MyLevel == 775 or MyLevel <= 799 or SelectMonster == "Swan Pirate" then
            CFrameMon1 = CFrame.new(856, 119, 1136)
            CFrameMon2 = CFrame.new(876, 130, 1368)
            CFrameMon3 = CFrame.new(1052, 132, 1172)
            CFrameMon4 = nil
        elseif MyLevel == 800 or MyLevel <= 874 or SelectMonster == "Factory Staff" then
            CFrameMon1 = CFrame.new(848, 132, 120)
            CFrameMon2 = CFrame.new(426, 133, 82)
            CFrameMon3 = CFrame.new(-55, 123, -42)
            CFrameMon4 = CFrame.new(-418, 127, -379)
        elseif MyLevel == 875 or MyLevel <= 899 or SelectMonster == "Marine Lieutenant" then
            CFrameMon1 = CFrame.new(-2694, 128, -3081)
            CFrameMon2 = CFrame.new(-3027, 109, -3043)
            CFrameMon3 = CFrame.new(-3265, 120, -2970)
            CFrameMon4 = nil
        elseif MyLevel == 900 or MyLevel <= 949 or SelectMonster == "Marine Captain" then
            CFrameMon1 = CFrame.new(-2184, 123, -3301)
            CFrameMon2 = CFrame.new(-1911, 121, -3205)
            CFrameMon3 = CFrame.new(-1630, 118, -3332)
            CFrameMon4 = nil
        elseif MyLevel == 950 or MyLevel <= 974 or SelectMonster == "Zombie" then
            CFrameMon1 = CFrame.new(-5598, 104, -924)
            CFrameMon2 = CFrame.new(-5787, 103, -764)
            CFrameMon3 = CFrame.new(-5584, 106, -578)
            CFrameMon4 = nil
        elseif MyLevel == 975 or MyLevel <= 999 or SelectMonster == "Vampire" then
            CFrameMon1 = CFrame.new(-6183, 76, -1178)
            CFrameMon2 = CFrame.new(-5804, 82, -1452)
            CFrameMon3 = CFrame.new(-6183, 76, -1178)
            CFrameMon4 = CFrame.new(-5804, 82, -1452)
        elseif MyLevel == 1000 or MyLevel <= 1049 or SelectMonster == "Snow Trooper" then
            CFrameMon1 = CFrame.new(613, 454, -5503)
            CFrameMon2 = CFrame.new(475, 455, -5315)
            CFrameMon3 = CFrame.new(370, 452, -5091)
            CFrameMon4 = nil
        elseif MyLevel == 1050 or MyLevel <= 1099 or SelectMonster == "Winter Warrior" then
            CFrameMon1 = CFrame.new(1340, 488, -5311)
            CFrameMon2 = CFrame.new(1064, 464, -5043)
            CFrameMon3 = nil
            CFrameMon4 = nil
        elseif MyLevel == 1100 or MyLevel <= 1124 or SelectMonster == "Lab Subordinate" then
            CFrameMon1 = CFrame.new(-5703, 60, -4600)
            CFrameMon2 = CFrame.new(-5946, 54, -4417)
            CFrameMon3 = CFrame.new(-5690, 67, -4328)
            CFrameMon4 = nil
        elseif MyLevel == 1125 or MyLevel <= 1174 or SelectMonster == "Horned Warrior" then
            CFrameMon1 = CFrame.new(-6165, 71, -5923)
            CFrameMon2 = CFrame.new(-6398, 82, -5875)
            CFrameMon3 = CFrame.new(-6506, 74, -5677)
            CFrameMon4 = nil
        elseif MyLevel == 1175 or MyLevel <= 1199 or SelectMonster == "Magma Ninja" then
            CFrameMon1 = CFrame.new(-5686, 95, -5649)
            CFrameMon2 = CFrame.new(-5676, 88, -5897)
            CFrameMon3 = CFrame.new(-5226, 81, -5973)
            CFrameMon4 = CFrame.new(-5232, 91, -6263)
        elseif MyLevel == 1200 or MyLevel <= 1249 or SelectMonster == "Lava Pirate" then
            CFrameMon1 = CFrame.new(-5368, 77, -4868)
            CFrameMon2 = CFrame.new(-5377, 92, -4609)
            CFrameMon3 = CFrame.new(-5102, 68, -4724)
            CFrameMon4 = CFrame.new(-5280, 62, -4384)
        elseif MyLevel == 1250 or MyLevel <= 1274 or SelectMonster == "Ship Deckhand" then
            CFrameMon1 = CFrame.new(1186, 166, 32946)
            CFrameMon2 = CFrame.new(1212, 153, 33182)
            CFrameMon3 = CFrame.new(641, 168, 32966)
            CFrameMon4 = CFrame.new(611, 155, 33134)
        elseif MyLevel == 1275 or MyLevel <= 1299 or SelectMonster == "Ship Engineer" then
            CFrameMon1 = CFrame.new(840, 73, 32714)
            CFrameMon2 = CFrame.new(797, 84, 32968)
            CFrameMon3 = CFrame.new(1036, 82, 33027)
            CFrameMon4 = CFrame.new(1019, 74, 32728)
        elseif MyLevel == 1300 or MyLevel <= 1324 or SelectMonster == "Ship Steward" then
            CFrameMon1 = CFrame.new(817, 153, 33363)
            CFrameMon2 = CFrame.new(810, 156, 33495)
            CFrameMon3 = CFrame.new(1022, 155, 33515)
            CFrameMon4 = CFrame.new(1030, 157, 33370)
        elseif MyLevel == 1325 or MyLevel <= 1349 or SelectMonster == "Ship Officer" then
            CFrameMon1 = CFrame.new(612, 232, 33289)
            CFrameMon2 = CFrame.new(1051, 226, 33349)
            CFrameMon3 = CFrame.new(1292, 228, 33264)
            CFrameMon4 = nil
        elseif MyLevel == 1350 or MyLevel <= 1374 or SelectMonster == "Arctic Warrior" then
            CFrameMon1 = CFrame.new(5831, 74, -6246)
            CFrameMon2 = CFrame.new(6071, 64, -6345)
            CFrameMon3 = CFrame.new(6216, 58, -6144)
            CFrameMon4 = CFrame.new(5990, 81, -6183)
        elseif MyLevel == 1375 or MyLevel <= 1424 or SelectMonster == "Snow Lurker" then
            CFrameMon1 = CFrame.new(5711, 84, -6692)
            CFrameMon2 = CFrame.new(5496, 90, -6678)
            CFrameMon3 = CFrame.new(5500, 80, -6940)
            CFrameMon4 = nil
        elseif MyLevel == 1425 or MyLevel <= 1449 or SelectMonster == "Sea Soldier" then
            CFrameMon1 = CFrame.new(-3016, 112, -9768)
            CFrameMon2 = CFrame.new(-2692, 117, -9823)
            CFrameMon3 = CFrame.new(-3016, 112, -9768)
            CFrameMon4 = CFrame.new(-3317, 102, -9768)
        elseif MyLevel == 1450 or MyLevel >= 1449 or SelectMonster == "Water Fighter" then
            CFrameMon1 = CFrame.new(-3339, 287, -10330)
            CFrameMon2 = CFrame.new(-3359, 295, -10546)
            CFrameMon3 = CFrame.new(-3423, 295, -10734)
            CFrameMon4 = CFrame.new(-3565, 297, -10462)
        end
    end
    if L_7449423635_ then
        if MyLevel == 1500 or MyLevel <= 1524 or SelectMonster == "Pirate Millionaire" then
            CFrameMon1 = CFrame.new(-340, 60, 5544)
            CFrameMon2 = CFrame.new(-123, 108, 5755)
            CFrameMon3 = CFrame.new(-340, 60, 5544)
            CFrameMon4 = CFrame.new(-652, 101, 5619)
        elseif MyLevel == 1525 or MyLevel <= 1574 or SelectMonster == "Pistol Billionaire" then
            CFrameMon1 = CFrame.new(-108, 124, 6058)
            CFrameMon2 = CFrame.new(-251, 125, 6310)
            CFrameMon3 = CFrame.new(-837, 110, 6114)
            CFrameMon4 = CFrame.new(-722, 126, 5845)
        elseif MyLevel == 1575 or MyLevel <= 1599 or SelectMonster == "Dragon Crew Warrior" then
            CFrameMon1 = CFrame.new(7087, 118, -683)
            CFrameMon2 = CFrame.new(6828, 121, -934)
            CFrameMon3 = CFrame.new(6592, 125, -1138)
            CFrameMon4 = CFrame.new(6859, 134, -841)
        elseif MyLevel == 1600 or MyLevel <= 1624 or SelectMonster == "Dragon Crew Archer" then
            CFrameMon1 = CFrame.new(6735, 562, 216)
            CFrameMon2 = CFrame.new(6937, 559, 407)
            CFrameMon3 = CFrame.new(6677, 569, 494)
            CFrameMon4 = CFrame.new(6610, 595, 255)
        elseif MyLevel == 1625 or MyLevel <= 1649 or SelectMonster == "Hydra Enforcer" then
            CFrameMon1 = CFrame.new(4562, 1064, 613)
            CFrameMon2 = CFrame.new(4449, 1044, 460)
            CFrameMon3 = CFrame.new(4543, 1055, 241)
            CFrameMon4 = CFrame.new(4449, 1044, 460)
        elseif MyLevel == 1650 or MyLevel <= 1699 or SelectMonster == "Venomous Assailant" then
            CFrameMon1 = CFrame.new(4709, 1144, 962)
            CFrameMon2 = CFrame.new(4506, 1262, 724)
            CFrameMon3 = CFrame.new(4447, 1272, 389)
            CFrameMon4 = CFrame.new(4506, 1262, 724)
        elseif MyLevel == 1700 or MyLevel <= 1724 or SelectMonster == "Marine Commodore" then
            CFrameMon2 = CFrame.new(2502, 153, -7837)
            CFrameMon3 = CFrame.new(2918, 150, -7965)
            CFrameMon4 = CFrame.new(2502, 153, -7837)
        elseif MyLevel == 1725 or MyLevel <= 1774 or SelectMonster == "Marine Rear Admiral" then
            CFrameMon1 = CFrame.new(3575, 185, -6961)
            CFrameMon2 = CFrame.new(3564, 185, -7258)
            CFrameMon3 = CFrame.new(3828, 203, -7285)
            CFrameMon4 = CFrame.new(3940, 191, -6964)
        elseif MyLevel == 1775 or MyLevel <= 1799 or SelectMonster == "Fishman Raider" then
            CFrameMon1 = CFrame.new(-10492, 399, -8558)
            CFrameMon2 = CFrame.new(-10231, 410, -8460)
            CFrameMon3 = CFrame.new(-10387, 391, -8246)
            CFrameMon4 = CFrame.new(-10811, 391, -8431)
        elseif MyLevel == 1800 or MyLevel <= 1824 or SelectMonster == "Fishman Captain" then
            CFrameMon1 = CFrame.new(-10803, 402, -8941)
            CFrameMon2 = CFrame.new(-11112, 409, -8781)
            CFrameMon3 = CFrame.new(-11111, 382, -9164)
            CFrameMon4 = CFrame.new(-10977, 383, -8848)
        elseif MyLevel == 1825 or MyLevel <= 1849 or SelectMonster == "Forest Pirate" then
            CFrameMon1 = CFrame.new(-13176, 386, -7827)
            CFrameMon2 = CFrame.new(-13456, 375, -8004)
            CFrameMon3 = CFrame.new(-13605, 401, -7766)
            CFrameMon4 = CFrame.new(-13365, 390, -7613)
        elseif MyLevel == 1850 or MyLevel <= 1899 or SelectMonster == "Mythological Pirate" then
            CFrameMon1 = CFrame.new(-13432, 557, -7005)
            CFrameMon2 = CFrame.new(-13256, 570, -6850)
            CFrameMon3 = CFrame.new(-13766, 535, -6899)
            CFrameMon4 = nil
        elseif MyLevel == 1900 or MyLevel <= 1924 or SelectMonster == "Jungle Pirate" then
            CFrameMon1 = CFrame.new(-12213, 395, -10382)
            CFrameMon2 = CFrame.new(-11660, 384, -10504)
            CFrameMon3 = CFrame.new(-11961, 395, -10775)
            CFrameMon4 = CFrame.new(-12334, 386, -10673)
        elseif MyLevel == 1925 or MyLevel <= 1974 or SelectMonster == "Musketeer Pirate" then
            CFrameMon1 = CFrame.new(-13110, 477, -9859)
            CFrameMon2 = CFrame.new(-13388, 473, -9924)
            CFrameMon3 = CFrame.new(-13483, 480, -9731)
            CFrameMon4 = CFrame.new(-13197, 453, -9594)
        elseif MyLevel == 1975 or MyLevel <= 1999 or SelectMonster == "Reborn Skeleton" then
            CFrameMon1 = CFrame.new(-8841, 184, 5930)
            CFrameMon2 = CFrame.new(-8817, 191, 6158)
            CFrameMon3 = CFrame.new(-8649, 190, 6135)
            CFrameMon4 = CFrame.new(-8658, 194, 5860)
        elseif MyLevel == 2000 or MyLevel <= 2024 or SelectMonster == "Living Zombie" then
            CFrameMon1 = CFrame.new(-10020, 207, 5980)
            CFrameMon2 = CFrame.new(-10213, 219, 6090)
            CFrameMon3 = CFrame.new(-10214, 220, 5819)
            CFrameMon4 = nil
        elseif MyLevel == 2025 or MyLevel <= 2049 or SelectMonster == "Demonic Soul" then
            CFrameMon1 = CFrame.new(-9265, 217, 6123)
            CFrameMon2 = CFrame.new(-9743, 220, 6114)
            CFrameMon3 = CFrame.new(-9265, 217, 6123)
            CFrameMon4 = CFrame.new(-9743, 220, 6114)
        elseif MyLevel == 2050 or MyLevel <= 2074 or SelectMonster == "Posessed Mummy" then
            CFrameMon1 = CFrame.new(-9707, 70, 6205)
            CFrameMon2 = CFrame.new(-9597, 64, 6325)
            CFrameMon3 = CFrame.new(-9432, 64, 6205)
            CFrameMon4 = CFrame.new(-9608, 91, 6124)
        elseif MyLevel == 2075 or MyLevel <= 2099 or SelectMonster == "Peanut Scout" then
            CFrameMon1 = CFrame.new(-2059, 88, -10071)
            CFrameMon2 = CFrame.new(-1900, 75, -10132)
            CFrameMon3 = CFrame.new(-2200, 60, -9964)
            CFrameMon4 = CFrame.new(-2318, 88, -10231)
        elseif MyLevel == 2100 or MyLevel <= 2124 or SelectMonster == "Peanut President" then
            CFrameMon1 = CFrame.new(-1977, 97, -10589)
            CFrameMon2 = CFrame.new(-2283, 131, -10503)
            CFrameMon3 = CFrame.new(-1977, 97, -10589)
            CFrameMon4 = CFrame.new(-2283, 131, -10503)
        elseif MyLevel == 2125 or MyLevel <= 2149 or SelectMonster == "Ice Cream Chef" then
            CFrameMon1 = CFrame.new(-1015, 97, -11014)
            CFrameMon2 = CFrame.new(-756, 107, -10829)
            CFrameMon3 = CFrame.new(-541, 115, -10896)
            CFrameMon4 = nil
        elseif MyLevel == 2150 or MyLevel <= 2199 or SelectMonster == "Ice Cream Commander" then
            CFrameMon1 = CFrame.new(-705, 177, -11149)
            CFrameMon2 = CFrame.new(-530, 117, -11332)
            CFrameMon3 = CFrame.new(-385, 129, -11032)
            CFrameMon4 = nil
        elseif MyLevel == 2200 or MyLevel <= 2224 or SelectMonster == "Cookie Crafter" then
            CFrameMon1 = CFrame.new(-2276, 85, -12001)
            CFrameMon2 = CFrame.new(-2461, 86, -12100)
            CFrameMon3 = CFrame.new(-2363, 82, -12222)
            CFrameMon4 = CFrame.new(-2223, 80, -12101)
        elseif MyLevel == 2225 or MyLevel <= 2249 or SelectMonster == "Cake Guard" then
            CFrameMon1 = CFrame.new(-1713, 97, -12252)
            CFrameMon2 = CFrame.new(-1514, 89, -12184)
            CFrameMon3 = CFrame.new(-1479, 80, -12407)
            CFrameMon4 = CFrame.new(-1685, 86, -12431)
        elseif MyLevel == 2250 or MyLevel <= 2274 or SelectMonster == "Baking Staff" then
            CFrameMon1 = CFrame.new(-1945, 92, -13005)
            CFrameMon2 = CFrame.new(-1790, 89, -13108)
            CFrameMon3 = CFrame.new(-1762, 89, -12941)
            CFrameMon4 = CFrame.new(-1815, 91, -12699)
        elseif MyLevel == 2275 or MyLevel <= 2299 or SelectMonster == "Head Baker" then
            CFrameMon1 = CFrame.new(-2149, 108, -12740)
            CFrameMon2 = CFrame.new(-2172, 109, -13015)
            CFrameMon3 = CFrame.new(-2329, 106, -13013)
            CFrameMon4 = CFrame.new(-2319, 118, -12733)
        elseif MyLevel == 2300 or MyLevel <= 2324 or SelectMonster == "Cocoa Warrior" then
            CFrameMon1 = CFrame.new(-40, 93, -12331)
            CFrameMon2 = CFrame.new(-135, 67, -12282)
            CFrameMon3 = CFrame.new(70, 75, -12230)
            CFrameMon4 = CFrame.new(218, 91, -12202)
        elseif MyLevel == 2325 or MyLevel <= 2349 or SelectMonster == "Chocolate Bar Battler" then
            CFrameMon1 = CFrame.new(649, 61, -12405)
            CFrameMon2 = CFrame.new(826, 59, -12647)
            CFrameMon3 = CFrame.new(661, 60, -12688)
            CFrameMon4 = CFrame.new(538, 74, -12464)
        elseif MyLevel == 2350 or MyLevel <= 2374 or SelectMonster == "Sweet Thief" then
            CFrameMon1 = CFrame.new(-89, 63, -12715)
            CFrameMon2 = CFrame.new(-26, 65, -12581)
            CFrameMon3 = CFrame.new(133, 72, -12592)
            CFrameMon4 = nil
        elseif MyLevel == 2375 or MyLevel <= 2400 or SelectMonster == "Candy Rebel" then
            CFrameMon1 = CFrame.new(46, 81, -12857)
            CFrameMon2 = CFrame.new(-33, 70, -12965)
            CFrameMon3 = CFrame.new(116, 67, -13034)
            CFrameMon4 = CFrame.new(198, 65, -12929)
        elseif MyLevel == 2400 or MyLevel <= 2424 or SelectMonster == "Candy Pirate" then
            CFrameMon1 = CFrame.new(-1321, 75, -14438)
            CFrameMon2 = CFrame.new(-1385, 81, -14709)
            CFrameMon3 = CFrame.new(-1321, 75, -14438)
            CFrameMon4 = CFrame.new(-1385, 81, -14709)
        elseif MyLevel == 2425 or MyLevel <= 2449 or SelectMonster == "Snow Demon" then
            CFrameMon1 = CFrame.new(-911, 62, -14626)
            CFrameMon2 = CFrame.new(-849, 72, -14414)
            CFrameMon3 = CFrame.new(-911, 62, -14626)
            CFrameMon4 = CFrame.new(-849, 72, -14414)
        elseif MyLevel == 2450 or MyLevel <= 2474 or SelectMonster == "Isle Outlaw" then
            CFrameMon1 = CFrame.new(-16403, 92, -225)
            CFrameMon2 = CFrame.new(-16241, 69, -108)
            CFrameMon3 = CFrame.new(-16403, 92, -225)
            CFrameMon4 = CFrame.new(-16241, 69, -108)
        elseif MyLevel == 2475 or MyLevel <= 2499 or SelectMonster == "Island Boy" then
            CFrameMon1 = CFrame.new(-16682, 102, -223)
            CFrameMon2 = CFrame.new(-16818, 73, -88)
            CFrameMon3 = CFrame.new(-16937, 62, -161)
            CFrameMon4 = nil
        elseif MyLevel == 2500 or MyLevel <= 2524 or SelectMonster == "Sun-kissed Warrior" then
            CFrameMon1 = CFrame.new(-16400, 98, 1102)
            CFrameMon2 = CFrame.new(-16215, 74, 959)
            CFrameMon3 = CFrame.new(-16215, 74, 959)
            CFrameMon4 = nil
        elseif MyLevel == 2525 or MyLevel <= 2549 or SelectMonster == "Isle Champion" then
            CFrameMon1 = CFrame.new(-16634, 102, 1119)
            CFrameMon2 = CFrame.new(-16825, 60, 968)
            CFrameMon3 = CFrame.new(-16906, 65, 1080)
            CFrameMon4 = nil
        elseif MyLevel == 2550 or MyLevel <= 2574 or SelectMonster == "Serpent Hunter" then
            CFrameMon1 = CFrame.new(-16624, 185, 1307)
            CFrameMon2 = CFrame.new(-16532, 185, 1362)
            CFrameMon3 = CFrame.new(-16541, 150, 1540)
            CFrameMon4 = CFrame.new(-16519, 120, 1716)
        elseif MyLevel == 2575 or MyLevel <= 2599 then
            CFrameMon1 = CFrame.new(-16806, 134, 1534)
            CFrameMon2 = CFrame.new(-16966, 241, 1643)
            CFrameMon3 = CFrame.new(-16818, 219, 1752)
            CFrameMon4 = nil
        elseif MyLevel == 2600 or MyLevel <= 2624 then
            CFrameMon1 = CFrame.new(10920.552734375, -2120.7587890625, 9267.6513671875)
            CFrameMon2 = CFrame.new(11034.779296875, -2128.155517578125, 9118.48046875)
        elseif MyLevel == 2625 or MyLevel <= 2649 then
            CFrameMon1 = CFrame.new(10662.7822265625, -2064.858642578125, 9303.939453125)
            CFrameMon2 = CFrame.new(10835.505859375, -2050.79541015625, 9438.0458984375)
        elseif MyLevel == 2650 or MyLevel <= 2674 then
            CFrameMon1 = CFrame.new(10626.7861328125, -2035.5662841796875, 10000.9775390625)
            CFrameMon2 = CFrame.new(10641.978515625, -2058.716064453125, 10174.470703125)
        elseif MyLevel >= 2675 then
            CFrameMon1 = CFrame.new(11138.119140625, -1975.6793212890625, 10088.7666015625)
            CFrameMon2 = CFrame.new(10892.6611328125, -1973.2645263671875, 10204.5849609375)
        end
    end
end
end
end
function CheckBossQuest()
    if _G['Select Boss'] == "Saber Expert" then
        MsBoss = "Saber Expert"
        NameBoss = "Saber Expert"
        CFrameBoss = CFrame.new(-1458.89502, 29.8870335, -50.633564, 0.858821094, 1.13848939e-08, 0.512275636,
            -4.85649254e-09, 1, -1.40823326e-08, -0.512275636, 9.6063415e-09, 0.858821094)
    elseif _G['Select Boss'] == "The Saw" then
        MsBoss = "The Saw"
        NameBoss = "The Saw"
        CFrameBoss = CFrame.new(-683.519897, 13.8534927, 1610.87854, -0.290192783, 6.88365773e-08, 0.956968188,
            6.98413629e-08, 1, -5.07531119e-08, -0.956968188, 5.21077759e-08, -0.290192783)
    elseif _G['Select Boss'] == "Greybeard" then
        MsBoss = "Greybeard"
        NameBoss = "Greybeard"
        CFrameBoss = CFrame.new(-4955.72949, 80.8163834, 4305.82666, -0.433646321, -1.03394289e-08, 0.901083171,
            -3.0443168e-08, 1, -3.17633075e-09, -0.901083171, -2.88092288e-08, -0.433646321)
    elseif _G['Select Boss'] == "The Gorilla King" then
        MsBoss = "The Gorilla King"
        NameBoss = "The Gorilla King"
        NameQuestBoss = "JungleQuest"
        LevelQuestBoss = 3
        CFrameQuestBoss = CFrame.new(-1604.12012, 36.8521118, 154.23732, 0.0648873374, -4.70858913e-06, -0.997892559,
            1.41431883e-07, 1, -4.70933674e-06, 0.997892559, 1.64442184e-07, 0.0648873374)
        CFrameBoss = CFrame.new(-1223.52808, 6.27936459, -502.292664, 0.310949147, -5.66602516e-08, 0.950426519,
            -3.37275488e-08, 1, 7.06501808e-08, -0.950426519, -5.40241736e-08, 0.310949147)
    elseif _G['Select Boss'] == "Bobby" then
        MsBoss = "Bobby"
        NameBoss = "Bobby"
        NameQuestBoss = "BuggyQuest1"
        LevelQuestBoss = 3
        CFrameQuestBoss = CFrame.new(-1139.59717, 4.75205183, 3825.16211, -0.959730506, -7.5857054e-09, 0.280922383,
            -4.06310328e-08, 1, -1.11807175e-07, -0.280922383, -1.18718916e-07, -0.959730506)
        CFrameBoss = CFrame.new(-1147.65173, 32.5966301, 4156.02588, 0.956680477, -1.77109952e-10, -0.29113996,
            5.16530874e-10, 1, 1.08897802e-09, 0.29113996, -1.19218679e-09, 0.956680477)
    elseif _G['Select Boss'] == "Yeti" then
        MsBoss = "Yeti"
        NameBoss = "Yeti"
        NameQuestBoss = "SnowQuest"
        LevelQuestBoss = 3
        CFrameQuestBoss = CFrame.new(1384.90247, 87.3078308, -1296.6825, 0.280209213, 2.72035177e-08, -0.959938943,
            -6.75690828e-08, 1, 8.6151708e-09, 0.959938943, 6.24481444e-08, 0.280209213)
        CFrameBoss = CFrame.new(1221.7356, 138.046906, -1488.84082, 0.349343032, -9.49245944e-08, 0.936994851,
            6.29478194e-08, 1, 7.7838429e-08, -0.936994851, 3.17894653e-08, 0.349343032)
    elseif _G['Select Boss'] == "Mob Leader" then
        MsBoss = "Mob Leader"
        NameBoss = "Mob Leader"
        CFrameBoss = CFrame.new(-2848.59399, 7.4272871, 5342.44043, -0.928248107, -8.7248246e-08, 0.371961564,
            -7.61816636e-08, 1, 4.44474857e-08, -0.371961564, 1.29216433e-08, -0.92824)
    elseif _G['Select Boss'] == "Vice Admiral" then
        MsBoss = "Vice Admiral"
        NameBoss = "Vice Admiral"
        NameQuestBoss = "MarineQuest2"
        LevelQuestBoss = 2
        CFrameQuestBoss = CFrame.new(-5035.42285, 28.6520386, 4324.50293, -0.0611100644, -8.08395768e-08, 0.998130739,
            -1.57416586e-08, 1, 8.00271849e-08, -0.998130739, -1.08217701e-08, -0.0611100644)
        CFrameBoss = CFrame.new(-5078.45898, 99.6520691, 4402.1665, -0.555574954, -9.88630566e-11, 0.831466436,
            -6.35508286e-08, 1, -4.23449258e-08, -0.831466436, -7.63661632e-08, -0.555574954)
    elseif _G['Select Boss'] == "Warden" then
        MsBoss = "Warden"
        NameBoss = "Warden"
        NameQuestBoss = "ImpelQuest"
        LevelQuestBoss = 1
        CFrameQuestBoss = CFrame.new(4851.35059, 5.68744135, 743.251282, -0.538484037, -6.68303741e-08, -0.842635691,
            1.38001752e-08, 1, -8.81300792e-08, 0.842635691, -5.90851599e-08, -0.538484037)
        CFrameBoss = CFrame.new(5232.5625, 5.26856995, 747.506897, 0.943829298, -4.5439414e-08, 0.330433697,
            3.47818627e-08, 1, 3.81658154e-08, -0.330433697, -2.45289105e-08, 0.943829298)
    elseif _G['Select Boss'] == "Chief Warden" then
        MsBoss = "Chief Warden"
        NameBoss = "Chief Warden"
        NameQuestBoss = "ImpelQuest"
        LevelQuestBoss = 2
        CFrameQuestBoss = CFrame.new(4851.35059, 5.68744135, 743.251282, -0.538484037, -6.68303741e-08, -0.842635691,
            1.38001752e-08, 1, -8.81300792e-08, 0.842635691, -5.90851599e-08, -0.538484037)
        CFrameBoss = CFrame.new(5232.5625, 5.26856995, 747.506897, 0.943829298, -4.5439414e-08, 0.330433697,
            3.47818627e-08, 1, 3.81658154e-08, -0.330433697, -2.45289105e-08, 0.943829298)
    elseif _G['Select Boss'] == "Swan" then
        MsBoss = "Swan"
        NameBoss = "Swan"
        NameQuestBoss = "ImpelQuest"
        LevelQuestBoss = 3
        CFrameQuestBoss = CFrame.new(4851.35059, 5.68744135, 743.251282, -0.538484037, -6.68303741e-08, -0.842635691,
            1.38001752e-08, 1, -8.81300792e-08, 0.842635691, -5.90851599e-08, -0.538484037)
        CFrameBoss = CFrame.new(5232.5625, 5.26856995, 747.506897, 0.943829298, -4.5439414e-08, 0.330433697,
            3.47818627e-08, 1, 3.81658154e-08, -0.330433697, -2.45289105e-08, 0.943829298)
    elseif _G['Select Boss'] == "Magma Admiral" then
        MsBoss = "Magma Admiral"
        NameBoss = "Magma Admiral"
        NameQuestBoss = "MagmaQuest"
        LevelQuestBoss = 3
        CFrameQuestBoss = CFrame.new(-5317.07666, 12.2721891, 8517.41699, 0.51175487, -2.65508806e-08, -0.859131515,
            -3.91131572e-08, 1, -5.42026761e-08, 0.859131515, 6.13418294e-08, 0.51175487)
        CFrameBoss = CFrame.new(-5530.12646, 22.8769703, 8859.91309, 0.857838571, 2.23414389e-08, 0.513919294,
            1.53689133e-08, 1, -6.91265853e-08, -0.513919294, 6.71978384e-08, 0.857838571)
    elseif _G['Select Boss'] == "Fishman Lord" then
        MsBoss = "Fishman Lord"
        NameBoss = "Fishman Lord"
        NameQuestBoss = "FishmanQuest"
        LevelQuestBoss = 3
        CFrameQuestBoss = CFrame.new(61123.0859, 18.5066795, 1570.18018, 0.927145958, 1.0624845e-07, 0.374700129,
            -6.98219367e-08, 1, -1.10790765e-07, -0.374700129, 7.65569368e-08, 0.927145958)
        CFrameBoss = CFrame.new(61351.7773, 31.0306778, 1113.31409, 0.999974668, 0, -0.00714713801, 0, 1.00000012, 0,
            0.00714714266, 0, 0.999974549)
    elseif _G['Select Boss'] == "Wysper" then
        MsBoss = "Wysper"
        NameBoss = "Wysper"
        NameQuestBoss = "SkyExp1Quest"
        LevelQuestBoss = 3
        CFrameQuestBoss = CFrame.new(-7862.94629, 5545.52832, -379.833954, 0.462944925, 1.45838088e-08, -0.886386991,
            1.0534996e-08, 1, 2.19553424e-08, 0.886386991, -1.95022007e-08, 0.462944925)
        CFrameBoss = CFrame.new(-7925.48389, 5550.76074, -636.178345, 0.716468513, -1.22915289e-09, 0.697619379,
            3.37381434e-09, 1, -1.70304748e-09, -0.697619379, 3.57381835e-09, 0.716468513)
    elseif _G['Select Boss'] == "Thunder God" then
        MsBoss = "Thunder God"
        NameBoss = "Thunder God"
        NameQuestBoss = "SkyExp2Quest"
        LevelQuestBoss = 3
        CFrameQuestBoss = CFrame.new(-7902.78613, 5635.99902, -1411.98706, -0.0361216255, -1.16895912e-07,
            0.999347389, 1.44533963e-09, 1, 1.17024491e-07, -0.999347389, 5.6715117e-09, -0.0361216255)
        CFrameBoss = CFrame.new(-7917.53613, 5616.61377, -2277.78564, 0.965189934, 4.80563429e-08, -0.261550069,
            -6.73089886e-08, 1, -6.46515304e-08, 0.261550069, 8.00056768e-08, 0.965189934)
    elseif _G['Select Boss'] == "Cyborg" then
        MsBoss = "Cyborg"
        NameBoss = "Cyborg"
        NameQuestBoss = "FountainQuest"
        LevelQuestBoss = 3
        CFrameQuestBoss = CFrame.new(5253.54834, 38.5361786, 4050.45166, -0.0112687312, -9.93677887e-08, -0.999936521,
            2.55291371e-10, 1, -9.93769547e-08, 0.999936521, -1.37512213e-09, -0.0112687312)
        CFrameBoss = CFrame.new(6041.82813, 52.7112198, 3907.45142, -0.563162148, 1.73805248e-09, -0.826346457,
            -5.94632716e-08, 1, 4.26280238e-08, 0.826346457, 7.31437524e-08, -0.563162148)
    elseif _G['Select Boss'] == "Diamond" then
        MsBoss = "Diamond"
        NameBoss = "Diamond"
        NameQuestBoss = "Area1Quest"
        LevelQuestBoss = 3
        CFrameQuestBoss = CFrame.new(-424.080078, 73.0055847, 1836.91589, 0.253544956, -1.42165932e-08, 0.967323601,
            -6.00147771e-08, 1, 3.04272909e-08, -0.967323601, -6.5768397e-08, 0.253544956)
        CFrameBoss = CFrame.new(-1736.26587, 198.627731, -236.412857, -0.997808516, 0, -0.0661673471, 0, 1, 0,
            0.0661673471, 0, -0.997808516)
    elseif _G['Select Boss'] == "Jeremy" then
        MsBoss = "Jeremy"
        NameBoss = "Jeremy"
        NameQuestBoss = "Area2Quest"
        LevelQuestBoss = 3
        CFrameQuestBoss = CFrame.new(632.698608, 73.1055908, 918.666321, -0.0319722369, 8.96074881e-10, -0.999488771,
            1.36326533e-10, 1, 8.92172336e-10, 0.999488771, -1.07732087e-10, -0.0319722369)
        CFrameBoss = CFrame.new(2203.76953, 448.966034, 752.731079, -0.0217453763, 0, -0.999763548, 0, 1, 0,
            0.999763548, 0, -0.0217453763)
    elseif _G['Select Boss'] == "Fajita" then
        MsBoss = "Fajita"
        NameBoss = "Fajita"
        NameQuestBoss = "MarineQuest3"
        LevelQuestBoss = 3
        CFrameQuestBoss = CFrame.new(-2442.65015, 73.0511475, -3219.11523, -0.873540044, 4.2329841e-08, -0.486752301,
            5.64383384e-08, 1, -1.43220786e-08, 0.486752301, -3.99823996e-08, -0.873540044)
        CFrameBoss = CFrame.new(-2297.40332, 115.449463, -3946.53833, 0.961227536, -1.46645796e-09, -0.275756449,
            -2.3212845e-09, 1, -1.34094433e-08, 0.275756449, 1.35296352e-08, 0.961227536)
    elseif _G['Select Boss'] == "Don Swan" then
        MsBoss = "Don Swan"
        NameBoss = "Don Swan"
        CFrameBoss = CFrame.new(2288.802, 15.1870775, 863.034607, 0.99974072, -8.41247214e-08, -0.0227668174,
            8.4774733e-08, 1, 2.75850098e-08, 0.0227668174, -2.95079072e-08, 0.99974072)
    elseif _G['Select Boss'] == "Smoke Admiral" then
        MsBoss = "Smoke Admiral"
        NameBoss = "Smoke Admiral"
        NameQuestBoss = "IceSideQuest"
        LevelQuestBoss = 3
        CFrameQuestBoss = CFrame.new(-6059.96191, 15.9868021, -4904.7373, -0.444992423, -3.0874483e-09, 0.895534337,
            -3.64098796e-08, 1, -1.4644522e-08, -0.895534337, -3.91229982e-08, -0.444992423)
        CFrameBoss = CFrame.new(-5115.72754, 23.7664986, -5338.2207, 0.251453817, 1.48345061e-08, -0.967869282,
            4.02796978e-08, 1, 2.57916977e-08, 0.967869282, -4.54708946e-08, 0.251453817)
    elseif _G['Select Boss'] == "Cursed Captain" then
        MsBoss = "Cursed Captain"
        NameBoss = "Cursed Captain"
        CFrameBoss = CFrame.new(916.928589, 181.092773, 33422, -0.999505103, 9.26310495e-09, 0.0314563364,
            8.42916226e-09, 1, -2.6643713e-08, -0.0314563364, -2.63653774e-08, -0.999505103)
    elseif _G['Select Boss'] == "Darkbeard" then
        MsBoss = "Darkbeard"
        NameBoss = "Darkbeard"
        CFrameBoss = CFrame.new(3876.00366, 24.6882591, -3820.21777, -0.976951957, 4.97356325e-08, 0.213458836,
            4.57335361e-08, 1, -2.36868622e-08, -0.213458836, -1.33787044e-08, -0.976951957)
    elseif _G['Select Boss'] == "Order" then
        MsBoss = "Order"
        NameBoss = "Order"
        CFrameBoss = CFrame.new(-6221.15039, 16.2351036, -5045.23584, -0.380726993, 7.41463495e-08, 0.924687505,
            5.85604774e-08, 1, -5.60738549e-08, -0.924687505, 3.28013137e-08, -0.380726993)
    elseif _G['Select Boss'] == "Awakened Ice Admiral" then
        MsBoss = "Awakened Ice Admiral"
        NameBoss = "Awakened Ice Admiral"
        NameQuestBoss = "FrostQuest"
        LevelQuestBoss = 3
        CFrameQuestBoss = CFrame.new(5669.33203, 28.2118053, -6481.55908, 0.921275556, -1.25320829e-08, 0.388910472,
            4.72230788e-08, 1, -7.96414241e-08, -0.388910472, 9.17372489e-08, 0.921275556)
        CFrameBoss = CFrame.new(6407.33936, 340.223785, -6892.521, 0.49051559, -5.25310213e-08, -0.871432424,
            -2.76146022e-08, 1, -7.58250565e-08, 0.871432424, 6.12576301e-08, 0.49051559)
    elseif _G['Select Boss'] == "Tide Keeper" then
        MsBoss = "Tide Keeper"
        NameBoss = "Tide Keeper"
        NameQuestBoss = "ForgottenQuest"
        LevelQuestBoss = 3
        CFrameQuestBoss = CFrame.new(-3053.89648, 236.881363, -10148.2324, -0.985987961, -3.58504737e-09, 0.16681771,
            -3.07832915e-09, 1, 3.29612559e-09, -0.16681771, 2.73641976e-09, -0.985987961)
        CFrameBoss = CFrame.new(-3570.18652, 123.328949, -11555.9072, 0.465199202, -1.3857326e-08, 0.885206044,
            4.0332897e-09, 1, 1.35347511e-08, -0.885206044, -2.72606271e-09, 0.465199202)
    elseif _G['Select Boss'] == "Stone" then
        MsBoss = "Stone"
        NameBoss = "Stone"
        NameQuestBoss = "PiratePortQuest"
        LevelQuestBoss = 3
        CFrameQuestBoss = CFrame.new(-290, 44, 5577)
        CFrameBoss = CFrame.new(-1085, 40, 6779)
    elseif _G['Select Boss'] == "Island Empress" then
        MsBoss = "Island Empress"
        NameBoss = "Island Empress"
        NameQuestBoss = "AmazonQuest2"
        LevelQuestBoss = 3
        CFrameQuestBoss = CFrame.new(5443, 602, 752)
        CFrameBoss = CFrame.new(5659, 602, 244)
    elseif _G['Select Boss'] == "Kilo Admiral" then
        MsBoss = "Kilo Admiral"
        NameBoss = "Kilo Admiral"
        NameQuestBoss = "MarineTreeIsland"
        LevelQuestBoss = 3
        CFrameQuestBoss = CFrame.new(2178, 29, -6737)
        CFrameBoss = CFrame.new(2846, 433, -7100)
    elseif _G['Select Boss'] == "Captain Elephant" then
        MsBoss = "Captain Elephant"
        NameBoss = "Captain Elephant"
        NameQuestBoss = "DeepForestIsland"
        LevelQuestBoss = 3
        CFrameQuestBoss = CFrame.new(-13232, 333, -7631)
        CFrameBoss = CFrame.new(-13221, 325, -8405)
    elseif _G['Select Boss'] == "Beautiful Pirate" then
        MsBoss = "Beautiful Pirate"
        NameBoss = "Beautiful Pirate"
        NameQuestBoss = "DeepForestIsland2"
        LevelQuestBoss = 3
        CFrameQuestBoss = CFrame.new(-12686, 391, -9902)
        CFrameBoss = CFrame.new(5182, 23, -20)
    elseif _G['Select Boss'] == "Cake Queen" then
        MsBoss = "Cake Queen"
        NameBoss = "Cake Queen"
        NameQuestBoss = "IceCreamIslandQuest"
        LevelQuestBoss = 3
        CFrameQuestBoss = CFrame.new(-716, 382, -11010)
        CFrameBoss = CFrame.new(-821, 66, -10965)
    elseif _G['Select Boss'] == "rip_indra True Form" then
        MsBoss = "rip_indra True Form"
        NameBoss = "rip_indra True Form"
        CFrameBoss = CFrame.new(-5359, 424, -2735)
    elseif _G['Select Boss'] == "Longma" then
        MsBoss = "Longma"
        NameBoss = "Longma"
        CFrameBoss = CFrame.new(-10248.3936, 353.79129, -9306.34473)
    elseif _G['Select Boss'] == "Soul Reaper" then
        MsBoss = "Soul Reaper"
        NameBoss = "Soul Reaper"
        CFrameBoss = CFrame.new(-9515.62109, 315.925537, 6691.12012)
    end
end
--// Select Monster
Dodge_No_CoolDown = false
function DodgeNoCoolDown()
    if Dodge_No_CoolDown then
        for i, v in next, getgc() do
            if game.Players.LocalPlayer.Character.Dodge then
                if typeof(v) == "function" and getfenv(v).script == game.Players.LocalPlayer.Character.Dodge then
                    for i2, v2 in next, getupvalues(v) do
                        if tostring(v2) == "0.4" then
                            repeat
                                wait(.1)
                                setupvalue(v, i2, 0)
                            until not Dodge_No_CoolDown
                        end
                    end
                end
            end
        end
    end
end
function fly()
    local mouse = game:GetService("Players").LocalPlayer:GetMouse ''
    localplayer = game:GetService("Players").LocalPlayer
    game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart")
    local torso = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
    local speedSET = 25
    local keys = { a = false, d = false, w = false, s = false }
    local e1
    local e2
    local function start()
        local pos = Instance.new("BodyPosition", torso)
        local gyro = Instance.new("BodyGyro", torso)
        pos.Name = "EPIXPOS"
        pos.maxForce = Vector3.new(math.huge, math.huge, math.huge)
        pos.position = torso.Position
        gyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        gyro.CFrame = torso.CFrame
        repeat
            wait()
            localplayer.Character.Humanoid.PlatformStand = true
            local new = gyro.CFrame - gyro.CFrame.p + pos.position
            if not keys.w and not keys.s and not keys.a and not keys.d then
                speed = 1
            end
            if keys.w then
                new = new + workspace.CurrentCamera.CoordinateFrame.lookVector * speed
                speed = speed + speedSET
            end
            if keys.s then
                new = new - workspace.CurrentCamera.CoordinateFrame.lookVector * speed
                speed = speed + speedSET
            end
            if keys.d then
                new = new * CFrame.new(speed, 0, 0)
                speed = speed + speedSET
            end
            if keys.a then
                new = new * CFrame.new(-speed, 0, 0)
                speed = speed + speedSET
            end
            if speed > speedSET then
                speed = speedSET
            end
            pos.position = new.p
            if keys.w then
                gyro.CFrame = workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad(speed * 15), 0, 0)
            elseif keys.s then
                gyro.CFrame = workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(math.rad(speed * 15), 0, 0)
            else
                gyro.CFrame = workspace.CurrentCamera.CoordinateFrame
            end
        until not Fly
        if gyro then
            gyro:Destroy()
        end
        if pos then
            pos:Destroy()
        end
        flying = false
        localplayer.Character.Humanoid.PlatformStand = false
        speed = 0
    end
    e1 = mouse.KeyDown:connect(function(key)
        if not torso or not torso.Parent then
            flying = false
            e1:disconnect()
            e2:disconnect()
            return
        end
        if key == "w" then
            keys.w = true
        elseif key == "s" then
            keys.s = true
        elseif key == "a" then
            keys.a = true
        elseif key == "d" then
            keys.d = true
        end
    end)
    e2 = mouse.KeyUp:connect(function(key)
        if key == "w" then
            keys.w = false
        elseif key == "s" then
            keys.s = false
        elseif key == "a" then
            keys.a = false
        elseif key == "d" then
            keys.d = false
        end
    end)
    start()
end
function Click()
    wait(.1)
    game:GetService 'VirtualUser':CaptureController()
    game:GetService 'VirtualUser':Button1Down(Vector2.new(1280, 672))
end
function AutoHaki()
    if not game:GetService("Players").LocalPlayer.Character:FindFirstChild("HasBuso") then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
    end
end
function UnEquipWeapon(Weapon)
    if game.Players.LocalPlayer.Character:FindFirstChild(Weapon) then
        _G.NotAutoEquip = true
        wait(.5)
        game.Players.LocalPlayer.Character:FindFirstChild(Weapon).Parent = game.Players.LocalPlayer.Backpack
        wait(.1)
        _G.NotAutoEquip = false
    end
end
function EquipWeapon(ToolSe)
    if not _G.NotAutoEquip then
        if game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe) then
            Tool = game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe)
            wait(.1)
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(Tool)
        end
    end
end
function EquipWeaponSword()
    pcall(function()
        for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if v.ToolTip == "Sword" and v:IsA("Tool") then
                local ToolHumanoid = game.Players.LocalPlayer.Backpack:FindFirstChild(v.Name)
                game.Players.LocalPlayer.Character.Humanoid:EquipTool(ToolHumanoid)
            end
        end
    end)
end
function EquipWeaponGun()
    pcall(function()
        for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if v.ToolTip == "Gun" and v:IsA("Tool") then
                local ToolHumanoid = game.Players.LocalPlayer.Backpack:FindFirstChild(v.Name)
                game.Players.LocalPlayer.Character.Humanoid:EquipTool(ToolHumanoid)
            end
        end
    end)
end
function EquipWeaponMelee()
    pcall(function()
        for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if v.ToolTip == "Melee" and v:IsA("Tool") then
                local ToolHumanoid = game.Players.LocalPlayer.Backpack:FindFirstChild(v.Name)
                game.Players.LocalPlayer.Character.Humanoid:EquipTool(ToolHumanoid)
            end
        end
    end)
end
function EquipWeaponFruit()
    pcall(function()
        for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if v.ToolTip == "Blox Fruit" and v:IsA("Tool") then
                local ToolHumanoid = game.Players.LocalPlayer.Backpack:FindFirstChild(v.Name)
                game.Players.LocalPlayer.Character.Humanoid:EquipTool(ToolHumanoid)
            end
        end
    end)
end
function GetDistance(target)
    return math.floor((target.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude)
end
function NoDodgeCool()
    if nododgecool then
        for i,v in next, getgc() do
            if game:GetService("Players").LocalPlayer.Character.Dodge then
                if typeof(v) == "function" and getfenv(v).script == game:GetService("Players").LocalPlayer.Character.Dodge then
                    for i2,v2 in next, getupvalues(v) do
                        if tostring(v2) == "0.4" then
                        repeat task.wait()
                            setupvalue(v,i2,-99999999999999999999999999999999999999)
                        until not nododgecool
                        end
                    end
                end
            end
        end
    end
end
function BTP(P)
    repeat
        wait(1)
        game.Players.LocalPlayer.Character.Humanoid:ChangeState(15)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = P
        task.wait()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = P
    until (P.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 1500
end
function ByPass(Position)
    game.Players.LocalPlayer.Character.Head:Destroy()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Position
    wait(.5)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Position
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
end
function CheckSword(Sword)
    for i, v in pairs(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventory")) do
        if type(v) == "table" then
            if v.Type == "Sword" then
                if v.Name == Sword then
                    return true
                end
            end
        end
    end
    return false
end
function CheckGun(Gun)
    for i, v in pairs(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventory")) do
        if type(v) == "table" then
            if v.Type == "Gun" then
                if v.Name == Gun then
                    return true
                end
            end
        end
    end
    return false
end
function GetMaterial(Material)
    for i, v in pairs(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventory")) do
        if type(v) == "table" and v.Type == "Material" and v.Name == Material then
            return v.Count
        end
    end
    return 0
end
function CheckBelt(BeltName)
    for i, v in pairs(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventory")) do
        if type(v) == "table" then
            if v.Type == "Wear" then
                if v.Name == BeltName then
                    return true
                end
            end
        end
    end
    return false
end
function CheckPirateBoat()
    local checkmmpb = {"FishBoat"}
    for r, v in next, workspace.Enemies:GetChildren() do
        if table.find(checkmmpb, v.Name) and v:FindFirstChild("Health") and v.Health.Value > 0 then
            return v
        end
    end
end
function useSkill(key)
    game:service("VirtualInputManager"):SendKeyEvent(true, key, false, game)
    wait(0.1)
    game:service("VirtualInputManager"):SendKeyEvent(false, key, false, game)
end
function useitem(key)
    game:service("VirtualInputManager"):SendKeyEvent(true, key, false, game)
    game:service("VirtualInputManager"):SendKeyEvent(false, key, false, game)
end
function EEPP()
    for i,v in ipairs({"One"}) do
        useitem(v)
    end
    wait(0.8)
        for i,v2 in ipairs({"Two"}) do
        useitem(v2)
    end
    wait(0.8)
    for i,v3 in ipairs({"Three"})do
        useitem(v3)
    end
    wait(0.8)
    for i,v4 in ipairs({"Four"}) do
        useitem(v4)
    end
end
function EPDDKEJ()
    for i,v in ipairs({"Z","X","C","V","F"}) do
    if _G["Skill " .. v] then
        useSkill(v)
        end
    end
end
function TelePPlayer(P)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = P
end
function _G.TP(Pos)
    Distance = (Pos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    if Distance < 85 then
        Speed = 250
    elseif Distance < 80 then
        Speed = 250
    elseif Distance < 200 then
        Speed = 275
    elseif Distance < 550 then
        Speed = 750
    elseif Distance < 600 then
        Speed = 600
    elseif Distance < 650 then
        Speed = 500
    elseif Distance < 750 then
        Speed = 400
    elseif Distance < 800 then
        Speed = 300
    elseif Distance < 1000 then
        Speed = 275
    elseif Distance < 1000 then
        Speed = 275
    elseif Distance >= 1000 then
        Speed = 275
    end
    game:GetService("TweenService"):Create(
        game.Players.LocalPlayer.Character.HumanoidRootPart,
        TweenInfo.new(Distance / Speed, Enum.EasingStyle.Linear),
        { CFrame = Pos }
    ):Play()
end
function TP1(Pos)
    Distance = (Pos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    if Distance < 375 then
        Speed = 600
    elseif Distance < 375 then
        Speed = 420
    elseif Distance < 420 then
        Speed = 420
    elseif Distance < 420 then
        Speed = 420
    elseif Distance < 420 then
        Speed = 420
    elseif Distance < 750 then
        Speed = 375
    elseif Distance >= 1000 then
        Speed = 375
    end
    game:GetService("TweenService"):Create(
        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart,
        TweenInfo.new(Distance / Speed, Enum.EasingStyle.Linear),
        { CFrame = Pos }
    ):Play()
end
function topos(Pos)
    Distance = (Pos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    if Distance < 250 then
        Speed = 5000
    elseif Distance < 250 then
        Speed = 2000
    elseif Distance < 250 then
        Speed = 800
    elseif Distance < 250 then
        Speed = 600
    elseif Distance < 500 then
        Speed = 400
    elseif Distance < 750 then
        Speed = 300
    elseif Distance >= 1000 then
        Speed = 300
    end
    game:GetService("TweenService"):Create(
        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart,
        TweenInfo.new(Distance / Speed, Enum.EasingStyle.Linear),
        { CFrame = Pos }
    ):Play()
end
function TPB(CFgo)
    local tween_s = game:service "TweenService"
    local info = TweenInfo.new(
        (game:GetService("Workspace").Boats.PirateGrandBrigade.VehicleSeat.CFrame.Position - CFgo.Position)
        .Magnitude /
        300, Enum.EasingStyle.Linear)
    tween = tween_s:Create(game:GetService("Workspace").Boats.PirateGrandBrigade.VehicleSeat, info, { CFrame = CFgo })
    tween:Play()
    local tweenfunc = {}
    function tweenfunc:Stop()
        tween:Cancel()
    end
    return tweenfunc
end
function TPB2(BoatsPos)
    local Distance = (BoatsPos.Position - game:GetService("Workspace").Boats.PirateGrandBrigade.VehicleSeat.Position)
        .Magnitude
    if Distance > 1 then
        Speed = spppp
    end
    game:GetService("TweenService"):Create(game:GetService("Workspace").Boats.PirateGrandBrigade.VehicleSeat,
        TweenInfo.new(Distance / Speed, Enum.EasingStyle.Linear), { CFrame = BoatsPos }):Play()
    if _G.StopTweenBoat then
        game:GetService("TweenService"):Create(game:GetService("Workspace").Boats.PirateGrandBrigade.VehicleSeat,
            TweenInfo.new(Distance / Speed, Enum.EasingStyle.Linear), { CFrame = BoatsPos }):Cancel()
    end
end
function PlayBoatsTween(Target)
    local Distance = (Target.Position - game:GetService("Workspace").Boats:FindFirstChild("PirateGrandBrigade").VehicleSeat.Position)
        .Magnitude
    if Distance > 1 then
        Speed = spppp
    end
    game:GetService("TweenService"):Create(
        game:GetService("Workspace").Boats:FindFirstChild("PirateGrandBrigade").VehicleSeat,
        TweenInfo.new(Distance / Speed, Enum.EasingStyle.Linear), { CFrame = Target }):Play()
    if _G.StopTweenBoat then
        game:GetService("TweenService"):Create(
            game:GetService("Workspace").Boats:FindFirstChild("PirateGrandBrigade").VehicleSeat,
            TweenInfo.new(Distance / Speed, Enum.EasingStyle.Linear), { CFrame = Target }):Cancel()
    end
end
function StopBoats(target)
    if not target then
        _G.StopTweenBoat = true
        wait(.1)
        TPB(game:GetService("Workspace").Boats.PirateGrandBrigade.VehicleSeat.CFrame)
        wait(.1)
        _G.StopTweenBoat = false
    end
end
function StopBoatsTween(target)
    pcall(function()
    if not target then
        _G.StopTweenBoat = true
        wait(.1)
        PlayBoatsTween(game:GetService("Workspace").Boats:FindFirstChild("PirateGrandBrigade").VehicleSeat.CFrame)
        wait(.1)
        _G.StopTweenBoat = false
    end
end)
end
function TPP(CFgo)
    if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health <= 0 or not game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid") then
        tween:Cancel()
        repeat wait() until game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid") and game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid").Health > 0
        wait(7)
        return
    end
    local tween_s = game:service "TweenService"
    local info = TweenInfo.new(
        (game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart.Position - CFgo.Position).Magnitude /
        325,
        Enum.EasingStyle.Linear)
    tween = tween_s:Create(game.Players.LocalPlayer.Character["HumanoidRootPart"], info, { CFrame = CFgo })
    tween:Play()

    local tweenfunc = {}

    function tweenfunc:Stop()
        tween:Cancel()
    end

    return tweenfunc
end
ToTargets = function(p)
    task.spawn(function()
        pcall(function()
            if game:GetService("Players").LocalPlayer:DistanceFromCharacter(p.Position) <= 250 then
                game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = p
            elseif not game.Players.LocalPlayer.Character:FindFirstChild("Root") then
                local K = Instance.new("Part", game.Players.LocalPlayer.Character)
                K.Size = Vector3.new(1, 0.5, 1)
                K.Name = "Root"
                K.Anchored = true
                K.Transparency = 1
                K.CanCollide = false
                K.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0)
            end
            local U = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - p.Position).Magnitude
            local z = game:service("TweenService")
            local B = TweenInfo.new((p.Position - game.Players.LocalPlayer.Character.Root.Position).Magnitude / 300,
                Enum.EasingStyle.Linear)
            local S, g = pcall(function()
                local q = z:Create(game.Players.LocalPlayer.Character.Root, B, { CFrame = p })
                q:Play()
            end)
            if not S then
                return g
            end
            game.Players.LocalPlayer.Character.Root.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart
                .CFrame
            if S and game.Players.LocalPlayer.Character:FindFirstChild("Root") then
                pcall(function()
                    if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - p.Position).Magnitude >= 20 then
                        spawn(function()
                            pcall(function()
                                if (game.Players.LocalPlayer.Character.Root.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 150 then
                                    game.Players.LocalPlayer.Character.Root.CFrame = game.Players.LocalPlayer
                                        .Character.HumanoidRootPart.CFrame
                                else
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players
                                        .LocalPlayer.Character.Root.CFrame
                                end
                            end)
                        end)
                    elseif (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - p.Position).Magnitude >= 10 and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - p.Position).Magnitude < 20 then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = p
                    elseif (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - p.Position).Magnitude < 10 then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = p
                    end
                end)
            end
        end)
    end)
end
function toposition(Pos)
    local player = game:GetService("Players").LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    local tweenService = game:GetService("TweenService")
    local root
    if not character:FindFirstChild("Root") then
        root = Instance.new("Part", character)
        root.Size = Vector3.new(20, 0.5, 20)
        root.Name = "Root"
        root.Anchored = true
        root.Transparency = 1
        root.CanCollide = false
        root.CFrame = humanoidRootPart.CFrame * CFrame.new(0, 0.6, 0)
    else
        root = character:FindFirstChild("Root")
    end
    if character:FindFirstChild("Humanoid") and character.Humanoid.Sit then
        character.Humanoid.Sit = false
    end
    local distance = (Pos.Position - humanoidRootPart.Position).Magnitude
    local tweenInfo = TweenInfo.new(distance / L_3c2, Enum.EasingStyle.Linear)
    local function syncRootToPlayer()
        root.CFrame = humanoidRootPart.CFrame
    end
    local function syncPlayerToRoot()
        humanoidRootPart.CFrame = root.CFrame
    end
    local xTweenPosition = {}
    function xTweenPosition:Stop()
        if self.tween then
            self.tween:Cancel()
            self.tween = nil
        end
    end
    if distance <= 10 then
        root.CFrame = Pos
        return xTweenPosition
    end
    local tween = tweenService:Create(root, tweenInfo, { CFrame = Pos })
    xTweenPosition.tween = tween
    tween:Play()
    local connection
    connection = game:GetService("RunService").Stepped:Connect(function()
        if not root or not character or not character.Parent then
            connection:Disconnect()
            return
        end
        syncPlayerToRoot()
        if (root.Position - humanoidRootPart.Position).Magnitude >= 1 then
            syncRootToPlayer()
        end
    end)
    tween.Completed:Connect(function()
        connection:Disconnect()
        syncPlayerToRoot()
    end)
    return xTweenPosition
end
function topos1(Pos)
    Distance = (Pos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    if game.Players.LocalPlayer.Character.Humanoid.Sit == true then game.Players.LocalPlayer.Character.Humanoid.Sit = false end
    pcall(function()
        tween = game:GetService("TweenService"):Create(
            game.Players.LocalPlayer.Character.HumanoidRootPart,
            TweenInfo.new(Distance / 300, Enum.EasingStyle.Linear),
            { CFrame = Pos })
    end)
    tween:Play()
    if Distance <= 300 then
        tween:Cancel()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Pos
    end
    if _G.StopTween == true then
        tween:Cancel()
        _G.Clip = false
    end
end
function GetDistance(target)
    return math.floor((target.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude)
end
function _G.TP11(Pos)
    Distance = (Pos.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    if Distance < 300 then
        Speed = 600
    elseif Distance >= 1000 then
        Speed = 300
    end
    game:GetService("TweenService"):Create(
        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart,
        TweenInfo.new(Distance / Speed, Enum.EasingStyle.Linear),
        { CFrame = Pos }
    ):Play()
    _G.Clip = true
    wait(Distance / Speed)
    _G.Clip = false
end
function topos2(Pos)
    Distance = (Pos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    if game.Players.LocalPlayer.Character.Humanoid.Sit == true then game.Players.LocalPlayer.Character.Humanoid.Sit = false end
    pcall(function()
        tween = game:GetService("TweenService"):Create(
            game.Players.LocalPlayer.Character.HumanoidRootPart,
            TweenInfo.new(Distance / 400, Enum.EasingStyle.Linear),
            { CFrame = Pos })
    end)
    tween:Play()
    if Distance <= 250 then
        tween:Cancel()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Pos
    end
    if _G.StopTween == true then
        tween:Cancel()
        _G.Clip = false
    end
end
function TP22(Pos)
    repeat
        wait()
        Distance = (Pos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
        if game.Players.LocalPlayer.Character.Humanoid.Sit == true then game.Players.LocalPlayer.Character.Humanoid.Sit = false end
        pcall(function()
            tween = game:GetService("TweenService"):Create(
                game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(Distance / 270,
                    Enum.EasingStyle.Linear), { CFrame = Pos })
        end)
        tween:Play()
        if Distance <= 250 then
            tween:Cancel()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Pos
        end
        if _G.StopTween == true then
            tween:Cancel()
            _G.Clip = false
        end
    until Distance <= 10
end
function TP33(Pos)
    Distance = (Pos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    if game.Players.LocalPlayer.Character.Humanoid.Sit == true then game.Players.LocalPlayer.Character.Humanoid.Sit = false end
    pcall(function()
        tween = game:GetService("TweenService"):Create(
            game.Players.LocalPlayer.Character.HumanoidRootPart,
            TweenInfo.new(Distance / 210, Enum.EasingStyle.Linear),
            { CFrame = Pos })
    end)
    tween:Play()
    if Distance <= 110 then
        tween:Cancel()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Pos
    end
    if _G.StopTween == true then
        tween:Cancel()
        _G.Clip = false
    end
end
function GetDistance(target)
    return math.floor((target.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude)
end
function TP44(Pos)
    Distance = (Pos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    if Distance < 300 then
        Speed = 600
    elseif Distance < 500 then
        Speed = 300
    elseif Distance < 360 then
        Speed = 600
    elseif Distance >= 500 then
        Speed = 300
    end
    game:GetService("TweenService"):Create(
        game.Players.LocalPlayer.Character.HumanoidRootPart,
        TweenInfo.new(Distance / Speed, Enum.EasingStyle.Linear),
        { CFrame = Pos }
    ):Play()
end
function TP55(Pos)
    Distance = (Pos.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    if Distance < 350 then
        Speed = 300
    elseif Distance >= 300 then
        Speed = 350
    end
    game:GetService("TweenService"):Create(
        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart,
        TweenInfo.new(Distance / Speed, Enum.EasingStyle.Linear),
        { CFrame = Pos }
    ):Play()
    _G.Clip = true
    wait(Distance / Speed)
    _G.Clip = false
end
function ATween(Pos)
    Distance = (Pos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    if game.Players.LocalPlayer.Character.Humanoid.Sit == true then game.Players.LocalPlayer.Character.Humanoid.Sit = false end
    pcall(function()
        tween = game:GetService("TweenService"):Create(
            game.Players.LocalPlayer.Character.HumanoidRootPart,
            TweenInfo.new(Distance / 275, Enum.EasingStyle.Linear),
            { CFrame = Pos })
    end)
    tween:Play()
    if Distance <= 0 then
        tween:Cancel()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Pos
    end
    if _G.StopTween == true then
        tween:Cancel()
        _G.Clip = false
    end
end
function Tween(CFrame)
    Distance = (CFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    if Distance < 250 then
        Speed = 600
    elseif Distance < 500 then
        Speed = 500
    elseif Distance < 750 then
        Speed = 400
    elseif Distance >= 1000 then
        Speed = 250
    end
    tween =
        game:GetService("TweenService"):Create(
            game.Players.LocalPlayer.Character.HumanoidRootPart,
            TweenInfo.new(Distance / Speed, Enum.EasingStyle.Linear),
            { CFrame = CFrame }
        ):Play()

    return Distance / Speed
end
function Tween1(K1)
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local humanoid = char:WaitForChild("Humanoid")
    if humanoid.Sit then
        humanoid.Sit = false
    end
    local root = char:WaitForChild("HumanoidRootPart")
    root.CanCollide = false
    local dist = (K1.Position - root.Position).Magnitude
    local spd = 300
    local TweenSvc = game:GetService("TweenService")
    local TweenInf = TweenInfo.new(dist / spd, Enum.EasingStyle.Linear)
    local tween = TweenSvc:Create(root, TweenInf, { CFrame = K1 })
    tween:Play()
    tween.Completed:Connect(function()
        root.CanCollide = true
    end)
    while tween.PlaybackState == Enum.PlaybackState.Playing do
        wait(0.03)
        if _G.StopTween then
            tween:Cancel()
            root.CanCollide = true
            break
        end
    end
end
function TP(Pos)
    local Distance = (Pos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    local Speed
    if Distance <= 200 then
        Speed = 400
    else
        Speed = Config["Tween Speed"]
    end
    local tweenInfo = TweenInfo.new(Distance / Speed, Enum.EasingStyle.Linear)
    local tween = game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart,
        tweenInfo, {
            CFrame = Pos
        })
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.X, Pos.Y,
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Z)
    if Config["Bypass TP"] and Distance >= 1000 then
        game.Players.LocalPlayer.Character.Humanoid:ChangeState(15)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Pos
        task.wait()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Pos
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
    end
    tween:Play()
end
--[[function TP(Pos)
    local Distance = (Pos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    if Distance <= 100 then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Pos
    end
    if Distance < 80 then
        Speed11 = 275
    elseif Distance < 120 then
        Speed11 = 300
    elseif Distance < 150 then
        Speed11 = 800
    elseif Distance < 230 then
        Speed11 = 740
    elseif Distance < 330 then
        Speed11 = 640
    elseif Distance < 440 then
        Speed11 = 520
    elseif Distance < 580 then
        Speed11 = 410
    elseif Distance < 700 then
        Speed11 = 350
    elseif Distance < 800 then
        Speed11 = 300
    elseif Distance < 900 then
        Speed11 = 275
    elseif Distance >= 1000 then
        Speed11 = 275
    end
    local tweenInfo = TweenInfo.new(Distance / L_3c2, Enum.EasingStyle.Linear)
    local tween = game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart,
        tweenInfo, {
            CFrame = Pos
        })
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.X, Pos.Y,
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Z)
    if Config["Bypass TP"] and Distance >= 1500 then
        game.Players.LocalPlayer.Character.Head:Destroy()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Pos
        task.wait()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Pos
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
    end
    tween:Play()
end--]]
function TPTPP(Pos)
    local Distance = (Pos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    if Distance <= 100 then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Pos
    end
    if Distance < 80 then
        Speed11 = 275
    elseif Distance < 120 then
        Speed11 = 300
    elseif Distance < 150 then
        Speed11 = 800
    elseif Distance < 230 then
        Speed11 = 740
    elseif Distance < 330 then
        Speed11 = 640
    elseif Distance < 440 then
        Speed11 = 520
    elseif Distance < 580 then
        Speed11 = 410
    elseif Distance < 700 then
        Speed11 = 350
    elseif Distance < 800 then
        Speed11 = 300
    elseif Distance < 900 then
        Speed11 = 275
    elseif Distance >= 1000 then
        Speed11 = 275
    end
    local tweenInfo = TweenInfo.new(Distance / 325, Enum.EasingStyle.Linear)
    local tween = game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart,
        tweenInfo, {
            CFrame = Pos
        })
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.X, Pos.Y,
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Z)
    if Config["Bypass TP"] and Distance >= 1500 then
        game.Players.LocalPlayer.Character.Head:Destroy()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Pos
        task.wait()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Pos
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
    end
    tween:Play()
end
local function Tween32(Pos)
    local char = player.Character or player.CharacterAdded:Wait()
    local HN = char:WaitForChild("Humanoid")
    if HN.Sit then
        HN.Sit = false
    end
    local root = char:WaitForChild("HumanoidRootPart")
    root.CanCollide = false
    if _G.Tweening then
        return
    end
    local dist = (p.Position - root.Position).Magnitude
    local spd
    if dist >= 1000 then
        spd = 320
    elseif dist >= 500 then
        spd = 500
    elseif dist >= 200 then
        spd = 700
    else
        spd = 300
    end
    local TweenSvc = game:GetService("TweenService")
    local TweenInf = TweenInfo.new(dist / 275, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
    local tween = TweenSvc:Create(root, TweenInf, { CFrame = Pos })
    _G.Tweening = true
    tween:Play()
    tween.Completed:Connect(function()
        root.CanCollide = true
        _G.Tweening = false
    end)
    while tween.PlaybackState == Enum.PlaybackState.Playing do
        wait(0.1)
        if _G.StopTween then
            tween:Cancel()
            root.CanCollide = true
            _G.Tweening = false
            break
        end
    end
end
function teleportToFarm(targetCFrame)
    local character = game.Players.LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local humanoidRootPart = character.HumanoidRootPart
        local distance = (targetCFrame.Position - humanoidRootPart.Position).Magnitude
        local baseSpeed = 275
        local speedMultiplier = 1.2
        if distance < 500 then
            speedMultiplier = 1.5
        elseif distance < 250 then
            speedMultiplier = 1.7
        end
        local tween = game:GetService("TweenService"):Create(
            humanoidRootPart,
            TweenInfo.new((distance / baseSpeed) / speedMultiplier, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
            { CFrame = targetCFrame }
        )
        tween:Play()
    end
end
local function pressKey(key)
    VirtualInputManager:SendKeyEvent(true, key, false, game)
    VirtualInputManager:SendKeyEvent(false, key, false, game)
end
local function useAvailableSkills()
    for _, key in ipairs({"Z", "X", "C", "V", "F"}) do
        if _G["Skill " .. key] then
            useSkill(key)
        end
    end
end
local function performAction(cframe)
    TP(cframe)
    for _, key in ipairs({"One", "Two", "Three", "Four"}) do
        pressKey(key)
        useAvailableSkills()
        wait(0.5)
    end
end
Type = 1
spawn(function()
    while wait(0.1) do
        if Type == 1 then
            Pos = CFrame.new(0, Config["Farm Distance"], 0)
        elseif Type == 2 then
            Pos = CFrame.new(0, Config["Farm Distance"], -25)
        elseif Type == 3 then
            Pos = CFrame.new(25, Config["Farm Distance"], 0)
        elseif Type == 4 then
            Pos = CFrame.new(0, Config["Farm Distance"], 25)
        elseif Type == 5 then
            Pos = CFrame.new(-25, Config["Farm Distance"], 0)
        elseif Type == 6 then
            Pos = CFrame.new(0, Config["Farm Distance"], 0)
        end
    end
end)
spawn(function()
    while wait(0) do
        Type = 1
        wait(0.5)
        Type = 2
        wait(0.5)
        Type = 3
        wait(0.5)
        Type = 4
        wait(0.5)
        Type = 5
        wait(0.5)
    end
end)
TypeKillPlayers = 1
spawn(function()
    while wait() do
        if TypeKillPlayers == 1 then
            PosKillPlayers = CFrame.new(0, 58, 0)
        elseif TypeKillPlayers == 2 then
            PosKillPlayers = CFrame.new(0, 18, -58)
        elseif TypeKillPlayers == 3 then
            PosKillPlayers = CFrame.new(58, 18, 0)
        elseif TypeKillPlayers == 4 then
            PosKillPlayers = CFrame.new(0, 18, 58)
        elseif TypeKillPlayers == 5 then
            PosKillPlayers = CFrame.new(-58, 18, 0)
        elseif TypeKillPlayers == 6 then
            PosKillPlayers = CFrame.new(0, 18, -58)
        elseif TypeKillPlayers == 7 then
            PosKillPlayers = CFrame.new(-58, 18, 0)
        end
    end
end)
spawn(function()
    while wait(-200) do
        TypeKillPlayers = 1
        wait(-200)
        TypeKillPlayers = 2
        wait(-200)
        TypeKillPlayers = 3
        wait(-200)
        TypeKillPlayers = 4
        wait(-200)
        TypeKillPlayers = 5
        wait(-200)
    end
end)
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Config = getgenv().Config
local function isAutoEnabled()
    local keys_G = {
        "Auto Farm Level", "Auto Second Sea", "Auto Third Sea", "Auto Factory",
        "Auto Castle Pirate Raid", "Auto Farm Cake Prince", "Auto Hallow Sycthe",
        "Auto Farm Bone", "Auto Farm Elite Hunter", "Auto Bartilo Quest",
        "Auto Farm Materials", "Auto Farm Fiah Tail", "Auto Farm Magma Ore",
        "Auto Farm [Nearest Mob]", "Auto Saber", "Auto Pole v1", "Auto Bisento V2",
        "Auto Rengoku", "Teleport to Players", "Tween Island", "Auto Next lsland",
        "Auto Farm Angel Wings", "Auto Farm Radioactive Materials", "Auto Farm Demonic Wips",
        "Auto Farm Vampire Fang", "Auto Farm Mini Tusk", "Auto Farm Gunpowder",
        "Auto Farm Sea Events", "Auto Dragon Hunter", "Auto Swan Glasses",
        "Auto Dojo Quest", "Auto Farm Observation Exp", "Auto Dungeon", "Auto Canvander",
        "Auto Yama", "Auto Find Mirage Island", "Teleport to Mirage Island",
        "Auto Farm Boss", "Auto Farm Sea Beasts", "Auto Farm Mastery Fruit",
        "Auto Farm Mastery Gun", "Auto Holy Torch", "Auto Budy Sword","Auto Farm Lightning Bandit",
        "Auto Tushita", "Teleport to Fruit", "Auto Evo Race V2","Auto Farm Ashen",
        "Auto Find Advanced Fruit Dealer", "Auto Find Gear","Auto Farm Agony",
        "Auto Musketeer Hat", "Auto Rainbow Haki", "Teleport to Race Door",
        "Auto Farm Ectoplasm", "Auto Get Cursed Dual Katana", "Auto Farm All Boss",
        "Auto Find Prehistoric Island", "Teleport to Prehistoric Island", "Auto Godhuman Full",
        "Auto Relic Events", "Auto Collect Dinosaur Bones", "Auto Collect Dragon Egg",
        "Auto Find Kitsune Island", "Teleport to Kitsune Island", "Auto Craft Volcanic Magnet", "Auto Quest Yama", "Auto Quest Tushita",
        "Auto Collect Berry", "Auto Godhuman Full", "Auto Electric Claw", "Auto Sharkman Karate", "Auto Twin Hooks",
        "Auto Soul Guitar", "Auto Kill Players", "Auto Complete Trail", "Auto Farm Chest [ Tweem ]", "Auto Farm Chest [ TP ] ( Risk )",
        "Auto Observation V2", "Auto Dough King V2", "Auto Farm Order Boss", "Auto Tyrant of the Skies","Enabled Farm Fast",
        "Auto Farm Oni Soldier","Auto Farm Red Commander","Auto Fishing"
    }
    for _, key in ipairs(keys_G) do
        if Config[key] then return true end
    end
    return false
end
RunService.Heartbeat:Connect(function()
    if isAutoEnabled() then
        if not Workspace:FindFirstChild("LOL") then
            local LOL = Instance.new("Part")
            LOL.Name = "LOL"
            LOL.Parent = Workspace
            LOL.Anchored = true
            LOL.Transparency = 1
            LOL.Size = Vector3.new(0, 0, 0)
        end
    else
        if Workspace:FindFirstChild("LOL") then
            Workspace.LOL:Destroy()
        end
    end
end)
spawn(function()
    while wait() do
        if isAutoEnabled() then
            local hrp = Players.LocalPlayer.Character.HumanoidRootPart
            if not hrp:FindFirstChild("BodyClip") then
                local Noclip = Instance.new("BodyVelocity")
                Noclip.Name = "BodyClip"
                Noclip.Parent = hrp
                Noclip.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                Noclip.Velocity = Vector3.new(0, 0, 0)
            end
        end
    end
end)
RunService.Stepped:Connect(function()
    if isAutoEnabled() then
        for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end
end)
spawn(function()
    while wait() do
        if isAutoEnabled() then
            if not Players.LocalPlayer.Character:FindFirstChild("Highlight") then
                local Highlight = Instance.new("Highlight")
                Highlight.FillColor = Color3.fromRGB(81, 255, 60)
                Highlight.OutlineColor = Color3.fromRGB(81, 255, 60)
                Highlight.Parent = Players.LocalPlayer.Character
            end
        end
    end
end)
--[[]
spawn(function()
    while wait(1) do
        if isAutoEnabled() and game:GetService("Players").LocalPlayer.Character:FindFirstChild("T-Rex-T-Rex") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Yeti-Yeti") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Blade-Blade") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Mammoth-Mammoth") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Gas-Gas") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Leopard-Leopard") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Kitsune-Kitsune") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Dragon-Dragon") and _G['Select Weapon'] == "Fruit" then
            Click()
        end
    end
end)
--]]
spawn(function()
    while wait() do
        if isAutoEnabled() then
            pcall(function()
                ReplicatedStorage.Remotes.CommE:FireServer("Ken", true)
            end)
        end
    end
end)
spawn(function()
    pcall(function()
        game:GetService("RunService").Stepped:Connect(function()
            if Config["Auto Farm Sea Events"] or Config["Auto Find Mirage Island"] or Config["Auto Find Kitsune Island"] or Config["Auto Find Prehistoric Island"] or Config["Auto Dojo Quest"] then
                if game:GetService("Workspace").Boats:FindFirstChild("PirateGrandBrigade") then
                    local BoatsTarget = game:GetService("Workspace").Boats:FindFirstChild("PirateGrandBrigade")
                    for _, v in pairs(BoatsTarget:GetDescendants()) do
                        if v:IsA("BasePart") then
                            v.CanCollide = false
                        end
                    end
                end
            end
        end)
    end)
end)
spawn(function()
    pcall(function()
        game:GetService("RunService").Stepped:Connect(function()
            if not Config["Auto Farm Sea Events"] or Config["Auto Find Mirage Island"] or Config["Auto Find Kitsune Island"] or Config["Auto Find Prehistoric Island"] or Config["Auto Dojo Quest"] then
                if game:GetService("Workspace").Boats:FindFirstChild("PirateGrandBrigade") then
                    local BoatsTarget = game:GetService("Workspace").Boats:FindFirstChild("PirateGrandBrigade")
                    for _, v in pairs(BoatsTarget:GetDescendants()) do
                        if v:IsA("BasePart") then
                            v.CanCollide = true
                        end
                    end
                end
            end
        end)
    end)
end)
-- No _G.
spawn(function()
    game:GetService("RunService").Heartbeat:Connect(function()
        if TeleporttPrehistoricIsland then
            if not game:GetService("Workspace"):FindFirstChild("LOL") then
                local LOL = Instance.new("Part")
                LOL.Name = "LOL"
                LOL.Parent = Workspace
                LOL.Anchored = true
                LOL.Transparency = 1
                LOL.Size = Vector3.new(0,0,0)
            elseif game:GetService("Workspace"):FindFirstChild("LOL") then
                --game.Workspace["LOL"].CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3.6, 0)
            end
        else
            if game:GetService("Workspace"):FindFirstChild("LOL") then
                game:GetService("Workspace"):FindFirstChild("LOL"):Destroy()
            end
        end
    end)
    end)
    spawn(function()
        pcall(function()
            while wait() do
                if TeleporttPrehistoricIsland == true then
                    if not game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
                        local Noclip = Instance.new("BodyVelocity")
                        Noclip.Name = "BodyClip"
                        Noclip.Parent = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
                        Noclip.MaxForce = Vector3.new(100000000000000000000000000000000000000000000000000000000000000000000000000000000000,100000000000000000000000000000000000000000000000000000000000000000000000000000000000,100000000000000000000000000000000000000000000000000000000000000000000000000000000000)
                        Noclip.Velocity = Vector3.new(0,0,0)
                    end
                end
            end
        end)
    end)
    spawn(function()
        pcall(function()
            game:GetService("RunService").Stepped:Connect(function()
                if TeleporttPrehistoricIsland == true then
                    for _, v in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
                        if v:IsA("BasePart") then
                            v.CanCollide = false    
                        end
                    end
                end
            end)
        end)
    end)
    spawn(function()
        pcall(function()
            while wait() do
                if TeleporttPrehistoricIsland == true then
                    if not game.Players.LocalPlayer.Character:FindFirstChild("Highlight") then
                        local Highlight = Instance.new("Highlight")
                        Highlight.FillColor = Color3.fromRGB(81, 255, 60)
                        Highlight.OutlineColor = Color3.fromRGB(81, 255, 60)
                        Highlight.Parent = game.Players.LocalPlayer.Character
                        end
                    end
                end
            end)
        end)
    spawn(function()
        while wait() do
            if TeleporttPrehistoricIsland == true then
                pcall(function()
                    game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("Ken",true)
                end)
            end    
        end
    end)
function InstancePos(pos)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
end
function TP3(pos)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
end
function _St(target)
    if not target then
        _G.StopTween = true
        wait()
        topos(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        wait()
        local humanoidRootPart = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
        if humanoidRootPart:FindFirstChild("BodyClip") then
            humanoidRootPart:FindFirstChild("BodyClip"):Destroy()
        end
        _G.StopTween = false
        _G.Clip = false
        local character = game.Players.LocalPlayer.Character
        if character:FindFirstChild("Highlight") then
            character:FindFirstChild("Highlight"):Destroy()
        end
    end
end
spawn(function()
    pcall(function()
        while wait() do
            for i, v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
                if v:IsA("Tool") then
                    if v:FindFirstChild("RemoteFunctionShoot") then
                        SelectWeaponGun = v.Name
                    end
                end
            end
        end
    end)
end)
local RS = game:GetService("ReplicatedStorage")
local regAtk = RS.Modules.Net:FindFirstChild("RE/RegisterAttack")
local regHit = RS.Modules.Net:FindFirstChild("RE/RegisterHit")
local yZn34 = false
game:GetService("Players").LocalPlayer.Idled:connect(function()
    game:GetService("VirtualUser"):Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    wait(1)
    game:GetService("VirtualUser"):Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)
Speed22 = 300
v2 = false
spawn(function()
    while wait() do
        if Config["Auto Farm Level"] then
            pcall(function()
                local v3 = (game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text)
                if not string.find(v3, NameMon) then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                end
                if (game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible) == false then
                    CheckQuest()
                    if (BypassTP) then
                        if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - CFrameQuest.Position).Magnitude >= (1500) then
                            BTP(CFrameQuest)
                        else
                            TP(CFrameQuest)
                        end
                    else
                        TP(CFrameQuest)
                    end
                    if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - CFrameQuest.Position).Magnitude <= (20) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NameQuest,
                            LevelQuest)
                    end
                elseif (game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible) == true then
                    CheckQuest()
                    v2 = false
                    if (workspace.Enemies:FindFirstChild(Mon)) then
                        for v4, v5 in pairs(workspace.Enemies:GetChildren()) do
                            if (v5:FindFirstChild("HumanoidRootPart") and v5:FindFirstChild("Humanoid") and v5.Humanoid.Health > (0)) then
                                if (v5.Name == Mon) then
                                    if (string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon)) then
                                        repeat
                                            wait()
                                            EquipWeapon(_G['Select Weapon'])
                                            AutoHaki()
                                            v5.Humanoid.WalkSpeed = 0
                                            TP(v5.HumanoidRootPart.CFrame * Pos)
                                            BringMob(v5.HumanoidRootPart.CFrame)
                                        until not Config["Auto Farm Level"] or v5.Humanoid.Health <= 0 or not v5.Parent or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                    else
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(
                                            "AbandonQuest")
                                    end
                                end
                            end
                        end
                    else
                        CheckMon()
                        for _, v6 in ipairs({ CFrameMon1, CFrameMon2, CFrameMon3, CFrameMon4 }) do
                            if (workspace.Enemies:FindFirstChild(Mon)) then
                                break
                            end
                            TP(v6)
                            wait(0.65)
                        if (game:GetService("ReplicatedStorage"):FindFirstChild(Mon)) then
                            TP(game:GetService("ReplicatedStorage"):FindFirstChild(Mon).HumanoidRootPart.CFrame *
                                CFrame.new(15, 10, 2))
                            end
                        end
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while task.wait() do
        if Config["Auto Farm [Nearest Mob]"] then
            pcall(function()
                for v12, v13 in pairs(workspace.Enemies:GetChildren()) do
                    if (v13.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= (2000) and v13.Humanoid.Health > (0) then
                        repeat
                            wait()
                            EquipWeapon(_G['Select Weapon'])
                            TP(v13.HumanoidRootPart.CFrame * CFrame.new(0,PosY,0))
                            BringMob(v13.HumanoidRootPart.CFrame)
                        until not Config["Auto Farm [Nearest Mob]"] or not v13.Parent or v13.Humanoid.Health <= 0
                    end
                end
            end)
        end
    end
end)
local Boss = {}
for i, v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
    if string.find(v.Name, "Boss") then
        if v.Name ~= "Ice Admiral" then
            table.insert(Boss, v.Name)
        end
    end
end
local bossNames = {
    "The Gorilla King", "Bobby", "The Saw", "Yeti", "Mob Leader", "Vice Admiral", "Warden", "Chief Warden",
    "Swan", "Saber Expert", "Magma Admiral", "Fishman Lord", "Wysper", "Thunder God", "Cyborg", "Greybeard",
    "Diamond", "Jeremy", "Fajita", "Don Swan", "Smoke Admiral", "Awakened Ice Admiral", "Tide Keeper", "Order",
    "Darkbeard", "Cursed Captain", "Stone", "Island Empress", "Kilo Admiral", "Captain Elephant",
    "Beautiful Pirate", "Longma", "Cake Queen", "Soul Reaper", "Rip_Indra", "Cake Prince", "Dough King"
}
local function updateBossList()
    local bossCheck = {}
    for _, bossName in pairs(bossNames) do
        if game:GetService("ReplicatedStorage"):FindFirstChild(bossName) then
            table.insert(bossCheck, bossName)
        end
    end
    for _, bossName in pairs(bossNames) do
        if workspace.Enemies:FindFirstChild(bossName) then
            table.insert(bossCheck, bossName)
        end
    end
    for _, name in pairs(Boss) do
        table.insert(bossCheck, name)
    end
    return bossCheck
end
local bossCheck = updateBossList()
spawn(function()
    while wait() do
        if Config["Auto Farm All Boss"] then
            pcall(function()
                for i,v in pairs(game.ReplicatedStorage:GetChildren()) do
                    if string.find(v.Name, bossCheck) then
                        if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 17000 then
                            repeat task.wait()
                                AutoHaki()
                                EquipWeapon(_G['Select Weapon'])
                                v.HumanoidRootPart.CanCollide = false
                                v.Head.CanCollide = false
                                TP(v.HumanoidRootPart.CFrame * CFrame.new(0,PosY,0))
                                sethiddenproperty(game.Players.LocalPlayer,"SimulationRadius",math.huge)
                            until v.Humanoid.Health <= 0 or not  Config["Auto Farm All Boss"] or not v.Parent
                        end
                    else
                        for i, v in pairs(workspace.Enemies:GetChildren()) do
                            if string.find(v.Name, bossCheck) then
                                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    repeat
                                        task.wait()
                                        AutoHaki()
                                        EquipWeapon(_G['Select Weapon'])
                                        TP(v.HumanoidRootPart.CFrame * CFrame.new(0,PosY,0))
                                        sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius",
                                            math.huge)
                                    until not Config["Auto Farm All Boss"] or not v.Parent or v.Humanoid.Health <= 0
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if Config["Auto Farm Boss"] and not Config["Enabled Accept Quest"] then
            pcall(function()
                CheckBossQuest()
                if workspace.Enemies:FindFirstChild(_G['Select Boss']) then
                    for i, v in pairs(workspace.Enemies:GetChildren()) do
                        if v.Name == _G['Select Boss'] then
                            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G['Select Weapon'])
                                    TP(v.HumanoidRootPart.CFrame * CFrame.new(0,PosY,0))
                                    sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius",
                                        math.huge)
                                until not Config["Auto Farm Boss"] or not v.Parent or v.Humanoid.Health <= 0
                            end
                        end
                    end
                else
                CheckBossQuest()
                    if Config["Bypass TP"] then
                        if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - CFrameBoss.Position).Magnitude > 1500 then
                            TP(CFrameBoss)
                        elseif (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - CFrameBoss.Position).Magnitude < 1500 then
                            TP(CFrameBoss)
                        end
                    else
                        TP(CFrameBoss)
                    end
                    if game:GetService("ReplicatedStorage"):FindFirstChild(_G['Select Boss']) then
                        TP(game:GetService("ReplicatedStorage"):FindFirstChild(_G['Select Boss']).HumanoidRootPart
                            .CFrame * CFrame.new(5, 10, 2))
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if Config["Auto Farm Boss"] and Config["Enabled Accept Quest"] then
            pcall(function()
                CheckBossQuest()
                local QuestBoss = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle
                    .Title.Text
                if not string.find(QuestBoss, NameBoss) then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                end
                if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                    if Config["Bypass TP"] then
                        if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - CFrameQuestBoss.Position).Magnitude > 1500 then
                            TP(CFrameQuestBoss)
                        elseif (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - CFrameQuestBoss.Position).Magnitude < 1500 then
                            TP(CFrameQuestBoss)
                        end
                    else
                        TP(CFrameQuestBoss)
                    end
                    if (CFrameQuestBoss.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NameQuestBoss,
                            LevelQuestBoss)
                    end
                elseif game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                    if workspace.Enemies:FindFirstChild(_G['Select Boss']) then
                        for i, v in pairs(workspace.Enemies:GetChildren()) do
                            if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                if v.Name == _G['Select Boss'] then
                                    if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameBoss) then
                                        repeat
                                            task.wait()
                                            EquipWeapon(_G['Select Weapon'])
                                            AutoHaki()
                                            TP(v.HumanoidRootPart.CFrame * CFrame.new(0,PosY,0))
                                        until not Config["Auto Farm Boss"] or v.Humanoid.Health <= 0 or not v.Parent or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                    else
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(
                                            "AbandonQuest")
                                    end
                                end
                            end
                        end
                    else
                        TP(CFrameBoss)
                        if game:GetService("ReplicatedStorage"):FindFirstChild(_G['Select Boss']) then
                            TP(game:GetService("ReplicatedStorage"):FindFirstChild(_G['Select Boss'])
                                .HumanoidRootPart.CFrame * CFrame.new(15, 10, 2))
                        end
                    end
                end
            end)
        end
    end
end)
CheckMonM = false
spawn(function()
    while wait() do
        if Config["Auto Farm Mastery Fruit"] and Config["Select Method"] == "Level" then
            pcall(function()
                local QuestTitle = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle
                    .Title.Text
                if not string.find(QuestTitle, NameMon) then
                    _G['Enabled Aimbot Mastery'] = false
                    _G['UseSkill'] = false
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                end
                if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                    _G['Enabled Aimbot Mastery'] = false
                    _G['UseSkill'] = false
                    CheckQuest()
                    repeat
                        wait()
                        TP(CFrameQuest)
                    until (CFrameQuest.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 or not Config["Auto Farm Mastery Fruit"]
                    if (CFrameQuest.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 5 then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NameQuest,
                            LevelQuest)
                    end
                elseif game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                    CheckQuest()
                    if workspace.Enemies:FindFirstChild(Mon) then
                        for i, v in pairs(workspace.Enemies:GetChildren()) do
                            if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                if v.Name == Mon then
                                    if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) then
                                        HealthMs = v.Humanoid.MaxHealth * Config["Kill At"] / 100
                                        repeat
                                            task.wait()
                                            if v.Humanoid.Health <= HealthMs then
                                                AutoHaki()
                                                EquipWeapon(game:GetService("Players").LocalPlayer.Data.DevilFruit
                                                    .Value)
                                                PosMonMasteryFruit = v.HumanoidRootPart.Position
                                                BringMob(v.HumanoidRootPart.CFrame)
                                                TP(v.HumanoidRootPart.CFrame * CFrame.new(0,PosY,0)) 
                                                _G['Enabled Aimbot Mastery'] = true
                                                _G['UseSkill'] = true
                                            else
                                                _G['Enabled Aimbot Mastery'] = false
                                                _G['UseSkill'] = false
                                                AutoHaki()
                                                EquipWeapon(_G['Select Weapon'])
                                                BringMob(v.HumanoidRootPart.CFrame)
                                                TP(v.HumanoidRootPart.CFrame * CFrame.new(0,PosY,0))
                                                PosMonMasteryFruit = v.HumanoidRootPart.Position
                                            end
                                        until not Config["Auto Farm Mastery Fruit"] or v.Humanoid.Health <= 0 or not v.Parent or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false or Config["Select Method"] ~= "Level"
                                    else
                                        _G['Enabled Aimbot Mastery'] = false
                                        _G['UseSkill'] = false
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(
                                            "AbandonQuest")
                                    end
                                end
                            end
                        end
                    else
                        _G['Enabled Aimbot Mastery'] = false
                        _G['UseSkill'] = false
                        CheckMon()
                        if not CheckMonM then
                            CheckMonM = true
                            for _, cframemon in ipairs({ CFrameMon1, CFrameMon2, CFrameMon3, CFrameMon4 }) do
                                if (workspace.Enemies:FindFirstChild(Mon)) then
                                    CheckMonM = false
                                    break
                                end
                                TP(cframemon)
                                wait(0.65)
                            end
                            CheckMonM = false
                        end
                        if (game:GetService("ReplicatedStorage"):FindFirstChild(Mon)) then
                            TP(game:GetService("ReplicatedStorage"):FindFirstChild(Mon).HumanoidRootPart.CFrame *
                                CFrame.new(15, 10, 2))
                        end
                    end
                end
            end)
        else
        _G['UseSkill'] = false
        wait(0.1)
        _G['Enabled Aimbot Mastery'] = false
        end
    end
end)
CheckMonMG = false
spawn(function()
    while wait() do
        if Config["Auto Farm Mastery Gun"] and Config["Select Method"] == "Level" then
            pcall(function()
                local QuestTitle = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle
                    .Title.Text
                if not string.find(QuestTitle, NameMon) then
                    _G['Enabled Aimbot Mastery Gun'] = false
                    _G['UseSkill'] = false
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                end
                if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                    _G['Enabled Aimbot Mastery Gun'] = false
                    _G['UseSkill'] = false
                    CheckQuest()
                    repeat
                        wait()
                        TP(CFrameQuest)
                    until (CFrameQuest.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 or not Config["Auto Farm Mastery Gun"]
                    if (CFrameQuest.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 5 then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NameQuest,
                            LevelQuest)
                    end
                elseif game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                    CheckQuest()
                    if workspace.Enemies:FindFirstChild(Mon) then
                        for i, v in pairs(workspace.Enemies:GetChildren()) do
                            if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                if v.Name == Mon then
                                    if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) then
                                        HealthMin = v.Humanoid.MaxHealth * Config["Kill At"] / 100
                                        repeat
                                            task.wait()
                                            if v.Humanoid.Health <= HealthMin then
                                                AutoHaki()
                                                EquipWeaponGun()
                                                PosMonMasteryGun = v.HumanoidRootPart.Position
                                                TP(v.HumanoidRootPart.CFrame * CFrame.new(0,PosY,0))
                                                BringMob(v.HumanoidRootPart.CFrame)
                                                _G['Enabled Aimbot Mastery Gun'] = true
                                                _G['UseSkill'] = true
                                                local args = {
                                                    [1] = v.HumanoidRootPart.Position,
                                                    [2] = {}
                                                }
                                                game:GetService("ReplicatedStorage"):WaitForChild("Modules")
                                                    :WaitForChild("Net"):WaitForChild("RE/ShootGunEvent"):FireServer(
                                                    unpack(args))
                                            else
                                                _G['Enabled Aimbot Mastery Gun'] = false
                                                _G['UseSkill'] = false
                                                AutoHaki()
                                                EquipWeapon(_G['Select Weapon'])
                                                TP(v.HumanoidRootPart.CFrame * CFrame.new(0,PosY,0))
                                                PosMonMasteryGun = v.HumanoidRootPart.Position
                                                BringMob(v.HumanoidRootPart.CFrame)  
                                            end
                                        until not Config["Auto Farm Mastery Gun"] or v.Humanoid.Health <= 0 or not v.Parent or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false or Config["Select Method"] ~= "Level"
                                    else
                                        _G['Enabled Aimbot Mastery Gun'] = false
                                        _G['UseSkill'] = false
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(
                                            "AbandonQuest")
                                    end
                                end
                            end
                        end
                    else
                        _G['Enabled Aimbot Mastery Gun'] = false
                        _G['UseSkill'] = false
                        CheckMon()
                        if not CheckMonMG then
                            CheckMonMG = true
                            for _, cframemonG in ipairs({ CFrameMon1, CFrameMon2, CFrameMon3, CFrameMon4 }) do
                                if (workspace.Enemies:FindFirstChild(Mon)) then
                                    CheckMonMG = false
                                    break
                                end
                                TP(cframemonG)
                                wait(0.65)
                            end
                            CheckMonMG = false
                        end
                        if (game:GetService("ReplicatedStorage"):FindFirstChild(Mon)) then
                            TP(game:GetService("ReplicatedStorage"):FindFirstChild(Mon).HumanoidRootPart.CFrame *
                                CFrame.new(15, 10, 2))
                        end
                    end
                end
            end)
        else
            _G['UseSkill'] = false
            wait(0.1)
            _G['Enabled Aimbot Mastery Gun'] = false
        end
    end
end)
spawn(function()
    while wait() do
        if Config["Auto Farm Mastery Fruit"] and Config["Select Method"] == "Bone" and L_7449423635_ then
            pcall(function()
                if (ByPassTP) then
                    BTP(CFrame.new(-9508.5673828125, 142.1398468017578, 5737.3603515625))
                elseif not (ByPassTP) then
                    TP(CFrame.new(-9508.5673828125, 142.1398468017578, 5737.3603515625))
                end
                for v33, v34 in pairs(workspace.Enemies:GetChildren()) do
                    if v34:FindFirstChild("Humanoid") and v34:FindFirstChild("HumanoidRootPart") and v34.Humanoid.Health > (0) then
                        if v34.Name == "Reborn Skeleton" or v34.Name == "Living Zombie" or v34.Name == "Demonic Soul" or v34.Name == "Posessed Mummy" then
                            HealthMin = v34.Humanoid.MaxHealth * Config["Kill At"] / 100
                            repeat
                                task.wait()
                                if v34.Humanoid.Health <= HealthMin then
                                    AutoHaki()
                                    EquipWeaponFruit()
                                    PosMonMasteryFruit = v34.HumanoidRootPart.Position
                                    TP(v34.HumanoidRootPart.CFrame * CFrame.new(0,PosY,0))
                                    BringMob(v34.HumanoidRootPart.CFrame) 
                                    _G['Enabled Aimbot Mastery'] = true
                                    _G['UseSkill'] = true
                                else
                                    _G['Enabled Aimbot Mastery'] = false
                                    _G['UseSkill'] = false
                                    AutoHaki()
                                    EquipWeapon(_G['Select Weapon'])
                                    TP(v34.HumanoidRootPart.CFrame * CFrame.new(0,PosY,0))
                                    PosMonMasteryFruit = v34.HumanoidRootPart.Position
                                    BringMob(v34.HumanoidRootPart.CFrame)
                                end
                            until not Config["Auto Farm Mastery Fruit"] or not v34.Parent or v34.Humanoid.Health <= 0 or not workspace.Enemies:FindFirstChild(v34.Name) or Config["Select Method"] ~= "Bone"
                        end
                    end
                end
                for v33, v34 in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
                    if v34.Name == "Reborn Skeleton" then
                        TP(v34.HumanoidRootPart.CFrame * CFrame.new(0,PosY,0))
                    elseif v34.Name == "Living Zombie" then
                        TP(v34.HumanoidRootPart.CFrame * CFrame.new(0,PosY,0))
                    elseif v34.Name == "Demonic Soul" then
                        TP(v34.HumanoidRootPart.CFrame * CFrame.new(0,PosY,0))
                    elseif v34.Name == "Posessed Mummy" then
                        TP(v34.HumanoidRootPart.CFrame * CFrame.new(0,PosY,0))
                    end
                end
            end)
            else
            _G['UseSkill'] = false
            wait(0.1)
            _G['Enabled Aimbot Mastery'] = false
        end
    end
end)
spawn(function()
    while wait() do
        if Config["Auto Farm Mastery Gun"] and Config["Select Method"] == "Bone" and L_7449423635_ then
            pcall(function()
                if (ByPassTP) then
                    BTP(CFrame.new(-9508.5673828125, 142.1398468017578, 5737.3603515625))
                elseif not (ByPassTP) then
                    TP(CFrame.new(-9508.5673828125, 142.1398468017578, 5737.3603515625))
                end
                for v33, v34 in pairs(workspace.Enemies:GetChildren()) do
                    if v34:FindFirstChild("Humanoid") and v34:FindFirstChild("HumanoidRootPart") and v34.Humanoid.Health > (0) then
                        if v34.Name == "Reborn Skeleton" or v34.Name == "Living Zombie" or v34.Name == "Demonic Soul" or v34.Name == "Posessed Mummy" then
                            HealthMin = v34.Humanoid.MaxHealth * Config["Kill At"] / 100
                            repeat
                                task.wait()
                                if v34.Humanoid.Health <= HealthMin then
                                    AutoHaki()
                                    EquipWeaponGun()
                                    PosMonMasteryGun = v34.HumanoidRootPart.Position
                                    TP(v34.HumanoidRootPart.CFrame * CFrame.new(0,PosY,0))
                                    BringMob(v34.HumanoidRootPart.CFrame) 
                                    _G['Enabled Aimbot Mastery Gun'] = true
                                    _G['UseSkill'] = true
                                else
                                    _G['Enabled Aimbot Mastery Gun'] = false
                                    _G['UseSkill'] = false
                                    AutoHaki()
                                    EquipWeapon(_G['Select Weapon'])
                                    TP(v34.HumanoidRootPart.CFrame * CFrame.new(0,PosY,0))
                                    PosMonMasteryGun = v34.HumanoidRootPart.Position
                                    BringMob(v34.HumanoidRootPart.CFrame)
                                end
                            until not Config["Auto Farm Mastery Gun"] or not v34.Parent or v34.Humanoid.Health <= 0 or not workspace.Enemies:FindFirstChild(v34.Name) or Config["Select Method"] ~= "Bone"
                        end
                    end
                end
                for v33, v34 in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
                    if v34.Name == "Reborn Skeleton" then
                        TP(v34.HumanoidRootPart.CFrame * CFrame.new(0,PosY,0))
                    elseif v34.Name == "Living Zombie" then
                        TP(v34.HumanoidRootPart.CFrame * CFrame.new(0,PosY,0))
                    elseif v34.Name == "Demonic Soul" then
                        TP(v34.HumanoidRootPart.CFrame * CFrame.new(0,PosY,0))
                    elseif v34.Name == "Posessed Mummy" then
                        TP(v34.HumanoidRootPart.CFrame * CFrame.new(0,PosY,0))
                    end
                end
            end)
            else
            _G['UseSkill'] = false
            wait(0.1)
            _G['Enabled Aimbot Mastery Gun'] = false
        end
    end
end)
spawn(function()
    while wait() do
        if Config["Auto Farm Mastery Fruit"] and Config["Select Method"] == "Cake Prince" and L_7449423635_ then
            pcall(function()
                if (game.ReplicatedStorage:FindFirstChild("Cake Prince") or workspace.Enemies:FindFirstChild("Cake Prince")) then
                    if (workspace.Enemies:FindFirstChild("Cake Prince")) then
                        for v28, v29 in pairs(workspace.Enemies:GetChildren()) do
                            if (Config["Auto Fram Cake Prince"] and v29.Name == "Cake Prince" and v29:FindFirstChild("HumanoidRootPart") and v29:FindFirstChild("Humanoid") and v29.Humanoid.Health) > (0) then
                                HealthMin = v29.Humanoid.MaxHealth * Config["Kill At"] / 100
                                repeat
                                    game:GetService("RunService").Heartbeat:wait()
                                    if v29.Humanoid.Health <= HealthMin then
                                        AutoHaki()
                                        EquipWeaponFruit()
                                        PosMonMasteryFruit = v29.HumanoidRootPart.Position
                                        TP(v29.HumanoidRootPart.CFrame * CFrame.new(0,PosY,0))
                                        BringMob(v34.HumanoidRootPart.CFrame)
                                        _G['Enabled Aimbot Mastery'] = true
                                        _G['UseSkill'] = true
                                    else
                                        _G['Enabled Aimbot Mastery'] = false
                                        _G['UseSkill'] = false
                                        AutoHaki()
                                        EquipWeapon(_G['Select Weapon'])
                                        TP(v29.HumanoidRootPart.CFrame * CFrame.new(0,PosY,0))
                                        PosMonMasteryFruit = v29.HumanoidRootPart.Position
                                        BringMob(v29.HumanoidRootPart.CFrame)  
                                    end
                                until not Config["Auto Farm Mastery Fruit"] or not v29.Parent or v29.Humanoid.Health <= 0 or Config["Select Method"] ~= "Cake Prince"
                            end
                        end
                    else
                        if (game:GetService("Workspace").Map.CakeLoaf.BigMirror.Other.Transparency == (0) and (CFrame.new(-1990.672607421875, 4532.99951171875, -14973.6748046875).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position)).Magnitude >= (1000) then
                            TP(CFrame.new(-2151.82153, 149.315704, -12404.9053))
                        end
                    end
                else
                    if (workspace.Enemies:FindFirstChild("Cookie Crafter") or workspace.Enemies:FindFirstChild("Cake Guard") or workspace.Enemies:FindFirstChild("Baking Staff") or workspace.Enemies:FindFirstChild("Head Baker")) then
                        for v30, v31 in pairs(workspace.Enemies:GetChildren()) do
                            if (v31:FindFirstChild("Humanoid") and v31:FindFirstChild("HumanoidRootPart") and v31.Humanoid.Health) > (0) then
                                if (v31.Name == "Cookie Crafter" or v31.Name == "Cake Guard" or v31.Name == "Baking Staff" or v31.Name == "Head Baker") and v31:FindFirstChild("HumanoidRootPart") and v31:FindFirstChild("Humanoid") and v31.Humanoid.Health > (0) then
                                HealthMin = v31.Humanoid.MaxHealth * Config["Kill At"] / 100
                                    repeat
                                        wait()
                                        if v31.Humanoid.Health <= HealthMin then
                                            AutoHaki()
                                            EquipWeaponFruit()
                                            PosMonMasteryFruit = v31.HumanoidRootPart.Position
                                            TP(v31.HumanoidRootPart.CFrame * CFrame.new(0,PosY,0))
                                            BringMob(v34.HumanoidRootPart.CFrame)
                                            _G['Enabled Aimbot Mastery'] = true
                                            _G['UseSkill'] = true
                                        else
                                            _G['Enabled Aimbot Mastery'] = false
                                            _G['UseSkill'] = false
                                            AutoHaki()
                                            EquipWeapon(_G['Select Weapon'])
                                            TP(v31.HumanoidRootPart.CFrame * CFrame.new(0,PosY,0))
                                            PosMonMasteryFruit = v31.HumanoidRootPart.Position
                                            BringMob(v34.HumanoidRootPart.CFrame)
                                        end
                                    until not Config["Auto Farm Mastery Fruit"] or not v31.Parent or v31.Humanoid.Health <= 0 or Config["Select Method"] ~= "Cake Prince"
                                end
                            end
                        end
                    else
                        if (ByPassTP) then
                            BTP(CFrame.new(-2077, 252, -12373))
                        else
                            TP(CFrame.new(-2077, 252, -12373))
                        end
                    end
                end
            end)
            else
            _G['UseSkill'] = false
            wait(0.1)
            _G['Enabled Aimbot Mastery'] = false
        end
    end
end)
spawn(function()
    while wait() do
        if Config["Auto Farm Mastery Gun"] and Config["Select Method"] == "Cake Prince" and L_7449423635_ then
            pcall(function()
                if (game.ReplicatedStorage:FindFirstChild("Cake Prince") or workspace.Enemies:FindFirstChild("Cake Prince")) then
                    if (workspace.Enemies:FindFirstChild("Cake Prince")) then
                        for v28, v29 in pairs(workspace.Enemies:GetChildren()) do
                            if (Config["Auto Fram Cake Prince"] and v29.Name == "Cake Prince" and v29:FindFirstChild("HumanoidRootPart") and v29:FindFirstChild("Humanoid") and v29.Humanoid.Health) > (0) then
                                HealthMin = v29.Humanoid.MaxHealth * Config["Kill At"] / 100
                                repeat
                                    game:GetService("RunService").Heartbeat:wait()
                                    if v29.Humanoid.Health <= HealthMin then
                                        AutoHaki()
                                        EquipWeaponGun()
                                        PosMonMasteryGun = v29.HumanoidRootPart.Position
                                        TP(v29.HumanoidRootPart.CFrame * CFrame.new(0,PosY,0))
                                        BringMob(v29.HumanoidRootPart.CFrame) 
                                        _G['Enabled Aimbot Mastery Gun'] = true
                                        _G['UseSkill'] = true
                                    else
                                        _G['Enabled Aimbot Mastery Gun'] = false
                                        _G['UseSkill'] = false
                                        AutoHaki()
                                        EquipWeapon(_G['Select Weapon'])
                                        TP(v29.HumanoidRootPart.CFrame * CFrame.new(0,PosY,0))
                                        PosMonMasteryGun = v29.HumanoidRootPart.Position
                                        BringMob(v29.HumanoidRootPart.CFrame) 
                                    end
                                until not Config["Auto Farm Mastery Gun"] or not v29.Parent or v29.Humanoid.Health <= 0 or Config["Select Method"] ~= "Cake Prince"
                            end
                        end
                    else
                        if (game:GetService("Workspace").Map.CakeLoaf.BigMirror.Other.Transparency == (0) and (CFrame.new(-1990.672607421875, 4532.99951171875, -14973.6748046875).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position)).Magnitude >= (1000) then
                            TP(CFrame.new(-2151.82153, 149.315704, -12404.9053))
                        end
                    end
                else
                    if (workspace.Enemies:FindFirstChild("Cookie Crafter") or workspace.Enemies:FindFirstChild("Cake Guard") or workspace.Enemies:FindFirstChild("Baking Staff") or workspace.Enemies:FindFirstChild("Head Baker")) then
                        for v30, v31 in pairs(workspace.Enemies:GetChildren()) do
                            if (v31:FindFirstChild("Humanoid") and v31:FindFirstChild("HumanoidRootPart") and v31.Humanoid.Health) > (0) then
                                if (v31.Name == "Cookie Crafter" or v31.Name == "Cake Guard" or v31.Name == "Baking Staff" or v31.Name == "Head Baker") and v31:FindFirstChild("HumanoidRootPart") and v31:FindFirstChild("Humanoid") and v31.Humanoid.Health > (0) then
                                HealthMin = v31.Humanoid.MaxHealth * Config["Kill At"] / 100
                                    repeat
                                        wait()
                                        if v31.Humanoid.Health <= HealthMin then
                                            AutoHaki()
                                            EquipWeaponGun()
                                            PosMonMasteryGun = v31.HumanoidRootPart.Position
                                            TP(v31.HumanoidRootPart.CFrame * CFrame.new(0,PosY,0))
                                            --BringMob(v34.HumanoidRootPart.CFrame)
                                            BringMob(v31.HumanoidRootPart.CFrame) 
                                            _G['Enabled Aimbot Mastery Gun'] = true
                                            _G['UseSkill'] = true
                                        else
                                            _G['Enabled Aimbot Mastery Gun'] = false
                                            _G['UseSkill'] = false
                                            AutoHaki()
                                            EquipWeapon(_G['Select Weapon'])
                                            TP(v31.HumanoidRootPart.CFrame * CFrame.new(0,PosY,0))
                                            PosMonMasteryGun = v31.HumanoidRootPart.Position
                                            --BringMob(v34.HumanoidRootPart.CFrame)
                                            BringMob(v31.HumanoidRootPart.CFrame) 
                                        end
                                    until not Config["Auto Farm Mastery Gun"] or not v31.Parent or v31.Humanoid.Health <= 0 or Config["Select Method"] ~= "Cake Prince"
                                end
                            end
                        end
                    else
                        if (ByPassTP) then
                            BTP(CFrame.new(-2077, 252, -12373))
                        else
                            TP(CFrame.new(-2077, 252, -12373))
                        end
                    end
                end
            end)
            else
            _G['UseSkill'] = false
            wait(0.1)
            _G['Enabled Aimbot Mastery'] = false
        end
    end
end)
local gg = getrawmetatable(game)
local old = gg.__namecall
setreadonly(gg, false)
gg.__namecall = newcclosure(function(...)
    local method = getnamecallmethod()
    local args = { ... }
    if tostring(method) == "FireServer" then
        if tostring(args[1]) == "RemoteEvent" then
            if tostring(args[2]) ~= "true" and tostring(args[2]) ~= "false" then
                if _G['Enabled Aimbot Mastery'] then
                    args[2] = PosMonMasteryFruit
                    return old(unpack(args))
                end
            end
        end
    end
    return old(...)
end)
gg.__namecall = newcclosure(function(...)
    local method = getnamecallmethod()
    local args = { ... }
    if tostring(method) == "FireServer" then
        if tostring(args[1]) == "RemoteEvent" then
            if tostring(args[2]) ~= "true" and tostring(args[2]) ~= "false" then
                if _G['Enabled Aimbot Mastery Gun'] then
                    args[2] = PosMonMasteryGun
                    return old(unpack(args))
                end
            end
        end
    end
    return old(...)
end)
spawn(function()
    while wait() do
        if Config["Auto Farm Chest [ Tweem ]"] then
            pcall(function()
                for i, v in pairs(workspace.Map:GetDescendants()) do
                    if v.Name == "Chest1" or v.Name == "Chest2" or v.Name == "Chest3" then
                        repeat wait()
                            TP(v.CFrame)
                        until not Config["Auto Farm Chest [ Tweem ]"] or not v.Parent or (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude == 0
                        wait(0.2)
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if Config["Auto Farm Chest [ TP ] ( Risk )"] then
            pcall(function()
                for i, v in pairs(workspace.Map:GetDescendants()) do
                    if v.Name == "Chest1" or v.Name == "Chest2" or v.Name == "Chest3" then
                        repeat wait()
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",v.Position)
                        until not Config["Auto Farm Chest [ TP ] ( Risk )"] or not v.Parent or (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude == 0
                        wait(0.25)
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if Config["Auto Farm Cake Prince"] and L_7449423635_ then
            pcall(function()
                if (game.ReplicatedStorage:FindFirstChild("Cake Prince") or workspace.Enemies:FindFirstChild("Cake Prince")) then
                    if (workspace.workspace.Enemies:FindFirstChild("Cake Prince")) then
                        for v28, v29 in pairs(Workspace.Enemies:GetChildren()) do
                            if (Config["Auto Fram Cake Prince"] and v29.Name == "Cake Prince" and v29:FindFirstChild("HumanoidRootPart") and v29:FindFirstChild("Humanoid") and v29.Humanoid.Health) > (0) then
                                repeat
                                    game:GetService("RunService").Heartbeat:wait()
                                    EquipWeapon(_G['Select Weapon'])
                                    TP(v29.HumanoidRootPart.CFrame * Pos)
                                until not Config["Auto Farm Cake Prince"] or not v29.Parent or v29.Humanoid.Health <= 0
                            end
                        end
                    else
                        if (game:GetService("Workspace").Map.CakeLoaf.BigMirror.Other.Transparency == (0) and (CFrame.new(-1990.672607421875, 4532.99951171875, -14973.6748046875).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position)).Magnitude >= (1000) then
                            TP(CFrame.new(-2151.82153, 149.315704, -12404.9053))
                        end
                    end
                else
                    if (workspace.Enemies:FindFirstChild("Cookie Crafter") or workspace.Enemies:FindFirstChild("Cake Guard") or workspace.Enemies:FindFirstChild("Baking Staff") or workspace.Enemies:FindFirstChild("Head Baker")) then
                        for v30, v31 in pairs(Workspace.Enemies:GetChildren()) do
                            if (v31:FindFirstChild("Humanoid") and v31:FindFirstChild("HumanoidRootPart") and v31.Humanoid.Health) > (0) then
                                if (v31.Name == "Cookie Crafter" or v31.Name == "Cake Guard" or v31.Name == "Baking Staff" or v31.Name == "Head Baker") and v31:FindFirstChild("HumanoidRootPart") and v31:FindFirstChild("Humanoid") and v31.Humanoid.Health > (0) then
                                    repeat
                                        wait()
                                        --BringMob(v31.HumanoidRootPart.CFrame)
                                        EquipWeapon(_G['Select Weapon'])
                                        TP(v31.HumanoidRootPart.CFrame * Pos)
                                        BringMob(v31.HumanoidRootPart.CFrame) 
                                    until not Config["Auto Farm Cake Prince"] or not v31.Parent or v31.Humanoid.Health <= 0
                                end
                            end
                        end
                    else
                        if (ByPassTP) then
                            BTP(CFrame.new(-2077, 252, -12373))
                        else
                            TP(CFrame.new(-2077, 252, -12373))
                        end
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if Config["Enabled Spwm Cake Prince"] and L_7449423635_ then
            pcall(function()
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CakePrinceSpawner")
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if Config["Auto Farm Bone"] and L_7449423635_ then
            pcall(function()
                if (ByPassTP) then
                    BTP(CFrame.new(-9508.5673828125, 142.1398468017578, 5737.3603515625))
                elseif not (ByPassTP) then
                    TP(CFrame.new(-9508.5673828125, 142.1398468017578, 5737.3603515625))
                end
                for v33, v34 in pairs(game.Workspace.Enemies:GetChildren()) do
                    if v34:FindFirstChild("Humanoid") and v34:FindFirstChild("HumanoidRootPart") and v34.Humanoid.Health > (0) then
                        if v34.Name == "Reborn Skeleton" or v34.Name == "Living Zombie" or v34.Name == "Demonic Soul" or v34.Name == "Posessed Mummy" then
                            repeat
                                wait()
                                AutoHaki()
                                EquipWeapon(_G['Select Weapon'])
                                TP(v34.HumanoidRootPart.CFrame * Pos) 
                                --BringMob(v34.HumanoidRootPart.CFrame)
                                BringMob(v34.HumanoidRootPart.CFrame) 
                            until not Config["Auto Farm Bone"] or not v34.Parent or v34.Humanoid.Health <= 0 or not game.Workspace.Enemies:FindFirstChild(v34.Name)
                        end
                    end
                end
                for v33, v34 in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
                    if v34.Name == "Reborn Skeleton" then
                        TP(v34.HumanoidRootPart.CFrame * Pos)
                    elseif v34.Name == "Living Zombie" then
                        TP(v34.HumanoidRootPart.CFrame * Pos)
                    elseif v34.Name == "Demonic Soul" then
                        TP(v34.HumanoidRootPart.CFrame * Pos)
                    elseif v34.Name == "Posessed Mummy" then
                        TP(v34.HumanoidRootPart.CFrame * Pos)
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while task.wait() do
        if Config["Enabled Random Bone Surprise"] then
            args = {
                [1] = "Bones",
                [2] = "Buy",
                [3] = 1,
                [4] = 1
            }
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
        end
    end
end)
spawn(function()
    while wait() do
        if Config["Auto Farm Elite Hunter"] then
            pcall(function()
                if (game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible) == true then
                    if (string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Diablo") or string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Deandre") or string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Urban")) then
                        if (workspace.Enemies:FindFirstChild("Diablo") or workspace.Enemies:FindFirstChild("Deandre") or workspace.Enemies:FindFirstChild("Urban")) then
                            for v37, v38 in pairs(workspace.Enemies:GetChildren()) do
                                if (v38:FindFirstChild("Humanoid") and v38:FindFirstChild("HumanoidRootPart") and v38.Humanoid.Health) > (0) then
                                    if (v38.Name == "Diablo" or v38.Name == "Deandre" or v38.Name == "Urban") then
                                        repeat
                                            game:GetService("RunService").Heartbeat:wait()
                                            EquipWeapon(_G['Select Weapon'])
                                            TP(v38.HumanoidRootPart.CFrame * Pos)
                                        until (Config["Auto Farm Elite Hunter"] == false or v38.Humanoid.Health <= (0) or not v.Parent)
                                    end
                                end
                            end
                        else
                            if (game:GetService("ReplicatedStorage"):FindFirstChild("Diablo")) then
                                if (ByPassTP) then
                                    BTP(game:GetService("ReplicatedStorage"):FindFirstChild("Diablo")
                                        .HumanoidRootPart.CFrame)
                                else
                                    TP(game:GetService("ReplicatedStorage"):FindFirstChild("Diablo")
                                        .HumanoidRootPart.CFrame)
                                end
                            elseif (game:GetService("ReplicatedStorage"):FindFirstChild("Deandre")) then
                                if (ByPassTP) then
                                    BTP(game:GetService("ReplicatedStorage"):FindFirstChild("Deandre")
                                        .HumanoidRootPart.CFrame)
                                else
                                    TP(game:GetService("ReplicatedStorage"):FindFirstChild("Deandre")
                                        .HumanoidRootPart.CFrame)
                                end
                            elseif (game:GetService("ReplicatedStorage"):FindFirstChild("Urban")) then
                                if (ByPassTP) then
                                    BTP(game:GetService("ReplicatedStorage"):FindFirstChild("Urban")
                                        .HumanoidRootPart.CFrame)
                                else
                                    TP(game:GetService("ReplicatedStorage"):FindFirstChild("Urban").HumanoidRootPart
                                        .CFrame)
                                end
                            end
                        end
                    end
                else
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter")
                end
            end)
        end
    end
end)
local VIM = game:service("VirtualInputManager")
function useAllSkills()
    for _, key in ipairs({"Z"}) do
        if _G["Skill " .. key] then
            useSkill(key)
        end
    end
    wait(0.1)
    for _, key in ipairs({"X",}) do
        if _G["Skill " .. key] then
            useSkill(key)
        end
    end
    wait(0.1)
    for _, key in ipairs({"C",}) do
        if _G["Skill " .. key] then
            useSkill(key)
        end
    end
    wait(0.1)
    for _, key in ipairs({"V"}) do
        if _G["Skill " .. key] then
            useSkill(key)
        end
    end
    wait(0.1)
    for _, key in ipairs({"F"}) do
        if _G["Skill " .. key] then
            useSkill(key)
        end
    end
end
function pressAllWeapons()
    useAllSkills()
end
local positions = {
    CFrame.new(-16212.0068, 155.212143, 1470.34521, -0.66659236, -1.15e-08, -0.745422423, -6.46e-08, 1, 4.23e-08, 0.745422423, 7.63e-08, -0.66659236),
    CFrame.new(-16251.0049, 155.212173, 1467.11316, -0.999910951, -6.5e-08, 0.0133428834, -6.43e-08, 1, 5.1e-08, -0.0133428834, 5.02e-08, -0.999910951),
    CFrame.new(-16288.084, 155.212158, 1470.14441, -0.925380409, 6.5e-08, 0.379039675, 4.5e-08, 1, -6.22e-08, -0.379039675, -4.05e-08, -0.925380409),
    CFrame.new(-16334.6846, 155.212143, 1455.61646, -0.659618318, 3.86e-09, 0.751600742, -3.66e-09, 1, -8.36e-09, -0.751600742, -8.27e-09, -0.659618318),
    CFrame.new(-16334.0273, 155.212158, 1322.12671, 0.992453635, 7.38745376e-09, -0.12262053, -5.55953861e-09, 1, 1.52492365e-08, 0.12262053, -1.44524464e-08, 0.992453635),
    CFrame.new(-16292.7031, 155.212173, 1321.85107, 0.976865053, -5.6229027e-10, -0.213856563, 1.35211553e-09, 1, 3.54697627e-09, 0.213856563, -3.75407616e-09, 0.976865053),
    CFrame.new(-16252.6611, 155.212158, 1316.16296, -0.106582999, 1.53650319e-08, -0.994303823, 5.11667553e-09, 1, 1.49045807e-08, 0.994303823, -3.49895535e-09, -0.106582999),
    CFrame.new(-16215.2607, 155.212158, 1319.12964, 0.663878798, -5.98061831e-08, -0.747840166, 3.21805445e-08, 1, -5.1404303e-08, 0.747840166, 1.00603241e-08, 0.663878798)
}
spawn(function()
    while task.wait() do
        pcall(function()
            if Config["Auto Tyrant of the Skies"] then
                local pos = CFrame.new(-16209.4434, 155.212173, 1394.25403, 0.0604604445, 3.11304014e-08, 0.998170614, -1.85925462e-08, 1, -3.00612832e-08, -0.998170614, -1.67410139e-08, 0.0604604445)
                if (pos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
                    TP(pos)
                else
                    if workspace.Map.TikiOutpost.IslandModel.Eye1.Transparency == 1 or workspace.Map.TikiOutpost.IslandModel.Eye2.Transparency == 1 or workspace.Map.TikiOutpost.IslandModel.Eye3.Transparency == 1 or workspace.Map.TikiOutpost.IslandModel.Eye4.Transparency == 1 then
                        for i,v in pairs(workspace.Enemies:GetChildren()) do
                            if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 1500 then
                                _G['UseSkill'] = false
                                repeat
                                    wait()
                                    EquipWeapon(_G['Select Weapon'])
                                    TP(v.HumanoidRootPart.CFrame * Pos)
                                    BringMob(v.HumanoidRootPart.CFrame)  
                                until not Config["Auto Tyrant of the Skies"] or v.Humanoid.Health <= 0 or workspace.Map.TikiOutpost.IslandModel.Eye1.Transparency == 0 and workspace.Map.TikiOutpost.IslandModel.Eye2.Transparency == 0 and workspace.Map.TikiOutpost.IslandModel.Eye3.Transparency == 0 and workspace.Map.TikiOutpost.IslandModel.Eye4.Transparency == 0
                            end
                        end
                    elseif workspace.Map.TikiOutpost.IslandModel.Eye1.Transparency == 0 and workspace.Map.TikiOutpost.IslandModel.Eye2.Transparency == 0 and workspace.Map.TikiOutpost.IslandModel.Eye3.Transparency == 0 and workspace.Map.TikiOutpost.IslandModel.Eye4.Transparency == 0 then
                        if not workspace.Enemies:FindFirstChild("Tyrant of the Skies") then
                            for i, v in ipairs(positions) do
                                repeat
                                    task.wait()
                                    TP(v)
                                until not Config["Auto Tyrant of the Skies"] or workspace.Enemies:FindFirstChild("Tyrant of the Skies") or (v.Position - game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootaPart").Position).Magnitude <= 20
                            end
                            for i,v in pairs(workspace.Enemies:GetChildren()) do
                                if v.Name == "Tyrant of the Skies" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") then
                                    _G['UseSkill'] = false
                                    repeat
                                        wait()
                                        EquipWeapon(_G['Select Weapon'])
                                        TP(v.HumanoidRootPart.CFrame * Pos)
                                        BringMob(v.HumanoidRootPart.CFrame)   
                                    until not Config["Auto Tyrant of the Skies"] or v.Humanoid.Health <= 0
                                end
                            end
                        elseif workspace.Enemies:FindFirstChild("Tyrant of the Skies") then
                            for i,v in pairs(workspace.Enemies:GetChildren()) do
                                if v.Name == "Tyrant of the Skies" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") then
                                    _G['UseSkill'] = false
                                    repeat
                                        wait()
                                        EquipWeapon(_G['Select Weapon'])
                                        TP(v.HumanoidRootPart.CFrame * Pos)
                                        BringMob(v.HumanoidRootPart.CFrame) 
                                    until not Config["Auto Tyrant of the Skies"] or v.Humanoid.Health <= 0
                                end
                            end
                        end
                    end
                end
            end
        end)
    end
end)
spawn(function()
    while task.wait() do
        if Config["Auto Tyrant of the Skies"] then
            pcall(function()
                if workspace.Map.TikiOutpost.IslandModel.Eye1.Transparency == 0 and workspace.Map.TikiOutpost.IslandModel.Eye2.Transparency == 0 and workspace.Map.TikiOutpost.IslandModel.Eye3.Transparency == 0 and workspace.Map.TikiOutpost.IslandModel.Eye4.Transparency == 0 then
                    if not workspace.Enemies:FindFirstChild("Tyrant of the Skies") then
                        for i, v in ipairs(positions) do
                            repeat wait(0.1)
                            _G['UseSkill'] = true
                            until not Config["Auto Tyrant of the Skies"] or workspace.Enemies:FindFirstChild("Tyrant of the Skies") or (v.Position - game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootaPart").Position).Magnitude <= 20
                        end
                    end
                end
            end)
        else
            _G['UseSkill'] = false
        end
    end
end)
spawn(function()
    while task.wait() do
        pcall(function()
            if Config["Auto Farm Observation Esp"] then
                repeat
                    task.wait()
                    if not game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
                        game:GetService('VirtualUser'):CaptureController()
                        game:GetService('VirtualUser'):SetKeyDown('0x65')
                        wait(2)
                        game:GetService('VirtualUser'):SetKeyUp('0x65')
                    end
                until game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") or not _G['Auto Farm Observation Esp']
            end
        end)
    end
end)
spawn(function()
        while wait() do
            if Config["Auto Farm Observation Esp"] and L_2753915549_ then
                pcall(function()
                local screenGui = game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui
                local imageLabel = screenGui:FindFirstChild("ImageLabel")
                if imageLabel then
                    for i, v in pairs(game.workspace.Enemies:GetChildren()) do
                        if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") then
                            if v.Name == "Galley Captain" then
                                repeat
                                    wait()
                                    TP(v.HumanoidRootPart.CFrame)
                                until not Config["Auto Farm Observation Esp"] or not v.Parent or not screenGui:FindFirstChild("ImageLabel")
                            end
                        end
                    end
                else
                    local posfosep = CFrame.new(5849.021, 86.7085648, 4832.98877, -0.307219446, -7.56955885e-08, 0.951638699, -4.26994085e-08, 1, 6.57576251e-08, -0.951638699, -2.04323882e-08, -0.307219446)
                    TP(posfosep)
                end
            end)
        end
    end
end)
spawn(function()
        while wait() do
            if Config["Auto Farm Observation Esp"] and L_4442272183_ then
                pcall(function()
                local screenGui = game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui
                local imageLabel = screenGui:FindFirstChild("ImageLabel")
                if imageLabel then
                    for i, v in pairs(game.workspace.Enemies:GetChildren()) do
                        if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") then
                            if v.Name == "Snow Lurker" then
                                repeat
                                    wait()
                                    TP(v.HumanoidRootPart.CFrame)
                                until not Config["Auto Farm Observation Esp"] or not v.Parent or not screenGui:FindFirstChild("ImageLabel")
                            end
                        end
                    end
                else
                    TP(CFrame.new(5459.74316, 85.4110641, -6833.91943, -0.116157748, -6.96834457e-09, -0.99323076,
                        1.17716212e-07, 1, -2.07826769e-08, 0.99323076, -1.19333436e-07, -0.116157748))
                end
            end)
        end
    end
end)
spawn(function()
        while wait() do
            if Config["Auto Farm Observation Esp"] and L_7449423635_ then
                pcall(function()
                local screenGui = game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui
                local imageLabel = screenGui:FindFirstChild("ImageLabel")
                if imageLabel then
                    for i, v in pairs(game.workspace.Enemies:GetChildren()) do
                        if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") then
                            if v.Name == "Venomous Assailant" then
                                repeat
                                    wait()
                                    TP(v.HumanoidRootPart.CFrame)
                                until not Config["Auto Farm Observation Esp"] or not v.Parent or not screenGui:FindFirstChild("ImageLabel")
                            end
                        end
                    end
                else
                    local posfosep = CFrame.new(4735.41846, 1163.58459, 967.498535, -0.821547985, 7.04315113e-08, -0.570139408, 1.4866762e-08, 1, 1.02111443e-07, 0.570139408, 7.54133183e-08, -0.821547985)
                    if (posfosep.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 1500 then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",
                        Vector3.new(5661.52979, 1013.07385, -334.962189))
                    wait()
                        TP(posfosep)
                    else
                        TP(posfosep)
                    end
                end
            end)
        end
    end
end)
spawn(function()
    pcall(function()
        while wait() do
            if _G['Auto Farm Observation Esp'] and Config["Auto Farm Observation Exp Hop"] then
                local screenGui = game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui
                local imageLabel = screenGui:FindFirstChild("ImageLabel")
                wait(5)
                if not imageLabel then
                    Hop()
                end
            end
        end
    end)
end)
spawn(function()
    while wait() do
        if Config["Auto Observation V2"] and L_7449423635_ then
        pcall(function()
                if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress","Citizen") == 3 then
                    if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Banana") and 
                       game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Apple") and 
                       game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Pineapple") then
                        repeat 
                            Tween(CFrame.new(-12444.78515625, 332.40396118164, -7673.1806640625)) 
                            task.wait() 
                        until not Config["Auto Observation V2"] or 
                              (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - 
                               Vector3.new(-12444.78515625, 332.40396118164, -7673.1806640625)).Magnitude <= 10
                        task.wait(0.5)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress","Citizen")
                    elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Fruit Bowl") or 
                           game:GetService("Players").LocalPlayer.Character:FindFirstChild("Fruit Bowl") then
                        repeat 
                            Tween(CFrame.new(-10920.125, 624.20275878906, -10266.995117188)) 
                            task.wait() 
                        until not Config["Auto Observation V2"] or 
                              (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - 
                               Vector3.new(-10920.125, 624.20275878906, -10266.995117188)).Magnitude <= 10
                            task.wait(0.5)
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("KenTalk2","Start")
                            task.wait(1)
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("KenTalk2","Buy")
                        else
                    for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
                        if v.Name == "Apple" or v.Name == "Banana" or v.Name == "Pineapple" then
                            v.Handle.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,1,10)
                            task.wait()
                            firetouchinterest(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, v.Handle, 0)    
                            task.wait()
                        end
                        end   
                    end
                end
            end)
        end
    end
end)
spawn(function()
    pcall(function()
        while wait() do
            if Config["Auto Farm Ectoplasm"] then
                if workspace.Enemies:FindFirstChild("Ship Deckhand") or workspace.Enemies:FindFirstChild("Ship Engineer") or workspace.Enemies:FindFirstChild("Ship Steward") or workspace.Enemies:FindFirstChild("Ship Officer") then
                    for i, v in pairs(workspace.Enemies:GetChildren()) do
                        if v.Name == "Ship Deckhand" or v.Name == "Ship Engineer" or v.Name == "Ship Steward" or v.Name == "Ship Officer" then
                            TP(v.HumanoidRootPart.CFrame * Pos)
                            repeat
                                wait()
                                EquipWeapon(_G['Select Weapon'])
                                AutoHaki()
                                if string.find(v.Name, "Ship") then
                                    v.HumanoidRootPart.CanCollide = false
                                    --BringMob(v.HumanoidRootPart.CFrame)
                                    BringMob(v.HumanoidRootPart.CFrame) 
                                else
                                    TP(CFrame.new(911.35827636719, 125.95812988281, 33159.5390625))
                                end
                            until Config["Auto Farm Ectoplasm"] == false or not v.Parent or v.Humanoid.Health <= 0
                        end
                    end
                else
                    TP(v.HumanoidRootPart.CFrame * Pos)
                    local Distance = (Vector3.new(911.35827636719, 125.95812988281, 33159.5390625) - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position)
                        .Magnitude
                    if Distance >= 1000 then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",
                            Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
                    end
                    TP(CFrame.new(911.35827636719, 125.95812988281, 33159.5390625))
                end
            end
        end
    end)
end)
spawn(function()
    while wait() do
        pcall(function()
            if Config["Auto Farm Sea Beasts"] and L_7449423635_ then
                if not game:GetService("Workspace").SeaBeasts:FindFirstChild("SeaBeast1") or game:GetService("Workspace").SeaBeasts:FindFirstChild("SeaBeast2") or game:GetService("Workspace").SeaBeasts:FindFirstChild("SeaBeast3") then
                    if not game:GetService("Workspace").Boats:FindFirstChild("PirateGrandBrigade") then
                        buyb = TP(CFrame.new(-16192.2539, 12.3828964, 1738.85999, -0.997757435, 4.43451498e-08,
                            -0.0669331998, 5.01932291e-08, 1, -8.56902034e-08, 0.0669331998, -8.88576324e-08,
                            -0.997757435))
                        if (CFrame.new(-16192.2539, 12.3828964, 1738.85999, -0.997757435, 4.43451498e-08, -0.0669331998, 5.01932291e-08, 1, -8.56902034e-08, 0.0669331998, -8.88576324e-08, -0.997757435).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 10 then
                            if buyb then buyb:Stop() end
                            local args = {
                                [1] = "BuyBoat",
                                [2] = "PirateGrandBrigade"
                            }
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                        end
                    elseif game:GetService("Workspace").Boats:FindFirstChild("PirateGrandBrigade") then
                        if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit == false then
                            TPP(game:GetService("Workspace").Boats.PirateGrandBrigade.VehicleSeat.CFrame *
                                CFrame.new(0, 1, 0))
                        else
                            for i, v in pairs(game:GetService("Workspace").Boats:GetChildren()) do
                                if v.Name == "PirateGrandBrigade" then
                                    repeat
                                        wait()
                                        PlayBoatsTween(CFrame.new(-99999999, 10.964323997497559, -324.4842224121094))
                                    until game:GetService("Workspace").SeaBeasts:FindFirstChild("SeaBeast1") or game:GetService("Workspace").SeaBeasts:FindFirstChild("SeaBeast2") or game:GetService("Workspace").SeaBeasts:FindFirstChild("SeaBeast3") or not Config["Auto Farm Sea Beasts"] or _G.StopTweenBoat == false
                                end
                            end
                        end
                    end
                end
            end
        end)
    end
end)
spawn(function()
    pcall(function()
        while wait() do
            if Config["Auto Farm Sea Beasts"] then
                if game:GetService("Workspace").SeaBeasts:FindFirstChild("SeaBeast1") or game:GetService("Workspace").SeaBeasts:FindFirstChild("SeaBeast2") or game:GetService("Workspace").SeaBeasts:FindFirstChild("SeaBeast3") then
                    game.Players.LocalPlayer.Character.Humanoid.Sit = false
                    StopBoatsTween()
                else
                    _G.StopTweenBoat = false
                end
            end
        end
    end)
end)
spawn(function()
    while wait() do
        if Config["Auto Farm Sea Beasts"] and L_7449423635_ then
            pcall(function()
                local enemies = game:GetService("Workspace").SeaBeasts
                local player = game.Players.LocalPlayer
                local character = player.Character
                local humanoid = character and character:FindFirstChild("Humanoid")
                for _, v in pairs(enemies:GetChildren()) do
                    if v.Name == "SeaBeast1" or v.Name == "SeaBeast2" or v.Name == "SeaBeast3" and v:FindFirstChild("HumanoidRootPart") then
                        repeat
                            task.wait()
                            AutoHaki()
                            TP(v.HumanoidRootPart.CFrame * CFrame.new(0, 480, 0))
                            sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                        until not _G['Auto Farm Sea Beasts'] or not v.Parent
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if Config["Auto Farm Sea Beasts"] and L_7449423635_ then
            pcall(function()
                local enemies = game:GetService("Workspace").SeaBeasts
                local player = game.Players.LocalPlayer
                local character = player.Character
                local humanoid = character and character:FindFirstChild("Humanoid")
                for _, v in pairs(enemies:GetChildren()) do
                    if v.Name == "SeaBeast1" or v.Name == "SeaBeast2" or v.Name == "SeaBeast3" and v:FindFirstChild("HumanoidRootPart") then
                    if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumnaoidRootPart.Position).Magnitude <= 575 then
                        game:service("VirtualInputManager"):SendKeyEvent(true, "One", false, game)
                        game:service("VirtualInputManager"):SendKeyEvent(false, "One", false, game)
                        if _G['Skill Z'] then useSkill("Z") end
                        if _G['Skill X'] then useSkill("X") end
                        if _G['Skill C'] then useSkill("C") end
                        if _G['Skill V'] then useSkill("V") end
                        if _G['Skill F'] then useSkill("F") end
                        game:service("VirtualInputManager"):SendKeyEvent(true, "Two", false, game)
                        game:service("VirtualInputManager"):SendKeyEvent(false, "Two", false, game)
                        if _G['Skill Z'] then useSkill("Z") end
                        if _G['Skill X'] then useSkill("X") end
                        if _G['Skill C'] then useSkill("C") end
                        if _G['Skill V'] then useSkill("V") end
                        if _G['Skill F'] then useSkill("F") end
                        game:service("VirtualInputManager"):SendKeyEvent(true, "Three", false, game)
                        game:service("VirtualInputManager"):SendKeyEvent(false, "Three", false, game)
                        if _G['Skill Z'] then useSkill("Z") end
                        if _G['Skill X'] then useSkill("X") end
                        if _G['Skill C'] then useSkill("C") end
                        if _G['Skill V'] then useSkill("V") end
                        if _G['Skill F'] then useSkill("F") end
                        game:service("VirtualInputManager"):SendKeyEvent(true, "Four", false, game)
                        game:service("VirtualInputManager"):SendKeyEvent(false, "Four", false, game)
                        if _G['Skill Z'] then useSkill("Z") end
                        if _G['Skill X'] then useSkill("X") end
                        if _G['Skill C'] then useSkill("C") end
                        if _G['Skill V'] then useSkill("V") end
                        if _G['Skill F'] then useSkill("F") end
                    end
                end
            end
            end)
        end
    end
end)
spawn(function()
    pcall(function()
        while task.wait() do
            if Config["Auto Evo Race V2"] and L_4442272183_ then
                local player = game:GetService("Players").LocalPlayer
                local raceData = player.Data.Race
                local replicatedStorage = game:GetService("ReplicatedStorage")
                local commF = replicatedStorage.Remotes.CommF_
                if not raceData:FindFirstChild("Evolved") then
                    local alchemistResponse = commF:InvokeServer("Alchemist", "1")
                    if alchemistResponse == 0 then
                        local targetPosition = CFrame.nfew(-2779.83521, 72.9661407, -3574.02002)
                        TP(targetPosition)
                        if (targetPosition.Position - player.Character.HumanoidRootPart.Position).Magnitude <= 4 then
                            wait(0.1)
                            commF:InvokeServer("Alchemist", "2")
                        end
                    elseif alchemistResponse == 1 then
                        pcall(function()
                            local backpack = player.Backpack
                            local character = player.Character
                            local workspace = game:GetService("Workspace")
                            if not backpack:FindFirstChild("Flower 1") and not character:FindFirstChild("Flower 1") then
                                TP(game.workspace.Flower1.CFrame)
                            elseif not backpack:FindFirstChild("Flower 2") and not character:FindFirstChild("Flower 2") then
                                TP(game.workspace.Flower2.CFrame)
                            elseif not backpack:FindFirstChild("Flower 3") and not character:FindFirstChild("Flower 3") then
                                local enemies = game.workspace.Enemies
                                if enemies:FindFirstChild("Zombie") then
                                    for _, v in pairs(enemies:GetChildren()) do
                                        if v.Name == "Zombie" then
                                            TP(v.HumanoidRootPart.CFrame * Pos)
                                            repeat
                                                task.wait()
                                                AutoHaki()
                                                EquipWeapon(_G['Select Weapon'])
                                                BringMob(v.HumanoidRootPart.CFrame) 
                                                v.HumanoidRootPart.CanCollide = false
                                            until
                                                backpack:FindFirstChild("Flower 3") or
                                                not v.Parent or
                                                v.Humanoid.Health <= 0 or
                                                not Config["Auto Evo Race V2"]
                                        end
                                    end
                                else
                                    TP(CFrame.new(-5685.923, 48.4801, -853.237))
                                end
                            end
                        end)
                    elseif alchemistResponse == 2 then
                        commF:InvokeServer("Alchemist", "3")
                    end
                end
            end
        end
    end)
end)
spawn(function()
    while wait() do
        if Config["Auto Farm Order Boss"] then
            pcall(function()
                if workspace.Enemies:FindFirstChild("Order") then
                    for i,v in pairs(workspace.Enemies:GetChildren()) do
                        if v.Name == "Order" then
                            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                repeat task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G['Select Weapon'])
                                    TP(v.HumanoidRootPart.CFrame * Pos)
                                until not Config["Auto Farm Order Boss"] or not v.Parent or v.Humanoid.Health <= 0
                            end
                        end
                    end
                else
                    if game:GetService("ReplicatedStorage"):FindFirstChild("Order [Lv. 1250] [Raid Boss]") then
                        TP(game:GetService("ReplicatedStorage"):FindFirstChild("Order [Lv. 1250] [Raid Boss]").HumanoidRootPart.CFrame * CFrame.new(2,20,2))
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if Config["Enabled Buy Raid Chip"] then
            pcall(function()
                local args = {
                    [1] = "BlackbeardReward",
                    [2] = "Microchip",
                    [3] = "2"
                 }
                 game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if Config["Enabled Start Raid"] then
            pcall(function()
                fireclickdetector(game:GetService("Workspace").Map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if Config["Auto Superhuman"] then
            pcall(function()
                if game.Players.LocalPlayer.Backpack:FindFirstChild("Combat") or game.Players.LocalPlayer.Character:FindFirstChild("Combat") and game:GetService("Players")["LocalPlayer"].Data.Beli.Value >= 150000 then
                    UnEquipWeapon("Combat")
                    wait(.1)
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBlackLeg")
                end   
                if game.Players.LocalPlayer.Character:FindFirstChild("Superhuman") or game.Players.LocalPlayer.Backpack:FindFirstChild("Superhuman") then
                    EquipWeapon("Superhuman")
                end  
                if game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg") or game.Players.LocalPlayer.Character:FindFirstChild("Black Leg") or game.Players.LocalPlayer.Backpack:FindFirstChild("Electro") or game.Players.LocalPlayer.Character:FindFirstChild("Electro") or game.Players.LocalPlayer.Backpack:FindFirstChild("Fishman Karate") or game.Players.LocalPlayer.Character:FindFirstChild("Fishman Karate") or game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Claw") or game.Players.LocalPlayer.Character:FindFirstChild("Dragon Claw") then
                    if game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg").Level.Value <= 299 then
                        EquipWeapon("Black Leg")
                    end
                    if game.Players.LocalPlayer.Backpack:FindFirstChild("Electro") and game.Players.LocalPlayer.Backpack:FindFirstChild("Electro").Level.Value <= 299 then
                        EquipWeapon("Electro")
                    end
                    if game.Players.LocalPlayer.Backpack:FindFirstChild("Fishman Karate") and game.Players.LocalPlayer.Backpack:FindFirstChild("Fishman Karate").Level.Value <= 299 then
                        EquipWeapon("Fishman Karate")
                    end
                    if game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Claw") and game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Claw").Level.Value <= 299 then
                        EquipWeapon("Dragon Claw")
                    end
                    if game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg").Level.Value >= 300 and game:GetService("Players")["LocalPlayer"].Data.Beli.Value >= 300000 then
                        UnEquipWeapon("Black Leg")
                        wait(.1)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectro")
                    end
                    if game.Players.LocalPlayer.Character:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Character:FindFirstChild("Black Leg").Level.Value >= 300 and game:GetService("Players")["LocalPlayer"].Data.Beli.Value >= 300000 then
                        UnEquipWeapon("Black Leg")
                        wait(.1)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectro")
                    end
                    if game.Players.LocalPlayer.Backpack:FindFirstChild("Electro") and game.Players.LocalPlayer.Backpack:FindFirstChild("Electro").Level.Value >= 300 and game:GetService("Players")["LocalPlayer"].Data.Beli.Value >= 750000 then
                        UnEquipWeapon("Electro")
                        wait(.1)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyFishmanKarate")
                    end
                    if game.Players.LocalPlayer.Character:FindFirstChild("Electro") and game.Players.LocalPlayer.Character:FindFirstChild("Electro").Level.Value >= 300 and game:GetService("Players")["LocalPlayer"].Data.Beli.Value >= 750000 then
                        UnEquipWeapon("Electro")
                        wait(.1)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyFishmanKarate")
                    end
                    if game.Players.LocalPlayer.Backpack:FindFirstChild("Fishman Karate") and game.Players.LocalPlayer.Backpack:FindFirstChild("Fishman Karate").Level.Value >= 300 and game:GetService("Players")["Localplayer"].Data.Fragments.Value >= 1500 then
                        UnEquipWeapon("Fishman Karate")
                        wait(.1)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","1")
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","2") 
                    end
                    if game.Players.LocalPlayer.Character:FindFirstChild("Fishman Karate") and game.Players.LocalPlayer.Character:FindFirstChild("Fishman Karate").Level.Value >= 300 and game:GetService("Players")["Localplayer"].Data.Fragments.Value >= 1500 then
                        UnEquipWeapon("Fishman Karate")
                        wait(.1)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","1")
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","2") 
                    end
                    if game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Claw") and game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Claw").Level.Value >= 300 and game:GetService("Players")["LocalPlayer"].Data.Beli.Value >= 3000000 then
                        UnEquipWeapon("Dragon Claw")
                        wait(.1)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySuperhuman")
                    end
                    if game.Players.LocalPlayer.Character:FindFirstChild("Dragon Claw") and game.Players.LocalPlayer.Character:FindFirstChild("Dragon Claw").Level.Value >= 300 and game:GetService("Players")["LocalPlayer"].Data.Beli.Value >= 3000000 then
                        UnEquipWeapon("Dragon Claw")
                        wait(.1)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySuperhuman")
                    end 
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if Config["Auto Death Step"] then
            pcall(function()
                if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Black Leg") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Black Leg") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Death Step") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Death Step") then
                    if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Black Leg") and game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Black Leg").Level.Value >= 450 then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDeathStep")
                        EquipWeapon("Death Step")
                    end  
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Black Leg") and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Black Leg").Level.Value >= 450 then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDeathStep")
                        EquipWeapon("Death Step")
                    end  
                    if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Black Leg") and game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Black Leg").Level.Value <= 449 then
                        EquipWeapon("Black Leg")
                    end 
                else 
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBlackLeg")
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if Config["Auto Sharkman Karate"] then
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyFishmanKarate")
                if string.find(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate"), "keys") then  
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Water Key") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Water Key") then
                        TP(CFrame.new(-2604.6958, 239.432526, -10315.1982, 0.0425701365, 0, -0.999093413, 0, 1, 0, 0.999093413, 0, 0.0425701365))
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate")
                    elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("Fishman Karate") and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Fishman Karate").Level.Value >= 400 then
                    else
                        if workspace.Enemies:FindFirstChild("Tide Keeper") then   
                            for i,v in pairs(workspace.Enemies:GetChildren()) do
                                if v.Name == "Tide Keeper" then
                                    repeat task.wait()
                                        AutoHaki()
                                        EquipWeapon(_G['Select Weapon'])
                                        v.Head.CanCollide = false
                                        v.HumanoidRootPart.CanCollide = false
                                        TP(v.HumanoidRootPart.CFram * Pos)
                                        sethiddenproperty(game:GetService("Players").LocalPlayer,"SimulationRadius",math.huge)
                                    until not v.Parent or v.Humanoid.Health <= 0 or not Config["Auto Sharkman Karate"] or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Water Key") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Water Key")
                                end
                            end
                        else
                            TP(CFrame.new(-3570.18652, 123.328949, -11555.9072, 0.465199202, -1.3857326e-08, 0.885206044, 4.0332897e-09, 1, 1.35347511e-08, -0.885206044, -2.72606271e-09, 0.465199202))
                            wait(3)
                        end
                    end
                else 
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate")
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if Config["Auto Electric Claw"] then
            pcall(function()
                if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Electro") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Electro") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Electric Claw") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Electric Claw") then
                    if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Electro") and game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Electro").Level.Value >= 400 then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw")
                        EquipWeapon("Electric Claw")
                    end  
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Electro") and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Electro").Level.Value >= 400 then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw")
                        EquipWeapon("Electric Claw")
                    end  
                    if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Electro") and game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Electro").Level.Value <= 399 then
                        EquipWeapon("Electro")
                    end 
                else
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectro")
                end
            if Config["Auto Electric Claw"] then
                if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Electro") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Electro") then
                    if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Electro") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Electro") and game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Electro").Level.Value >= 400 or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Electro").Level.Value >= 400 then
                            repeat task.wait()
                                TP(CFrame.new(-10371.4717, 330.764496, -10131.4199))
                            until not Config["Auto Electric Claw"] or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - CFrame.new(-10371.4717, 330.764496, -10131.4199).Position).Magnitude <= 10
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw","Start")
                            wait(2)
                            repeat task.wait()
                                TP(CFrame.new(-12550.532226563, 336.22631835938, -7510.4233398438))
                            until not Config["Auto Electric Claw"] or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - CFrame.new(-12550.532226563, 336.22631835938, -7510.4233398438).Position).Magnitude <= 10
                            wait(1)
                            repeat task.wait()
                                TP(CFrame.new(-10371.4717, 330.764496, -10131.4199))
                            until not Config["Auto Electric Claw"] or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - CFrame.new(-10371.4717, 330.764496, -10131.4199).Position).Magnitude <= 10
                            wait(1)
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw")
                            repeat task.wait()
                                TP(CFrame.new(-10371.4717, 330.764496, -10131.4199))
                            until not Config["Auto Electric Claw"] or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - CFrame.new(-10371.4717, 330.764496, -10131.4199).Position).Magnitude <= 10
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw","Start")
                            wait(2)
                            repeat task.wait()
                                TP(CFrame.new(-12550.532226563, 336.22631835938, -7510.4233398438))
                            until not Config["Auto Electric Claw"] or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - CFrame.new(-12550.532226563, 336.22631835938, -7510.4233398438).Position).Magnitude <= 10
                            wait(1)
                            repeat task.wait()
                                TP(CFrame.new(-10371.4717, 330.764496, -10131.4199))
                            until not Config["Auto Electric Claw"] or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - CFrame.new(-10371.4717, 330.764496, -10131.4199).Position).Magnitude <= 10
                            wait(1)
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw")
                            EquipWeapon("Electric Claw")
                            wait(.1)
                        end
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if Config["Auto Dragon Talon"] then
            pcall(function()
                if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dragon Claw") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Dragon Claw") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dragon Talon") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Dragon Talon") then
                    if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dragon Claw") and game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dragon Claw").Level.Value >= 400 then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon")
                        EquipWeapon("Dragon Talon")
                    end  
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Dragon Claw") and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Dragon Claw").Level.Value >= 400 then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon")
                        EquipWeapon("Dragon Talon")
                    end  
                    if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dragon Claw") and game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dragon Claw").Level.Value <= 399 then
                        EquipWeapon("Dragon Claw")
                    end 
                else 
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","2")
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if Config["Auto Godhuman"] then
            pcall(function()
				if game.Players.LocalPlayer.Character:FindFirstChild("Superhuman") or game.Players.LocalPlayer.Backpack:FindFirstChild("Superhuman") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Black Leg") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Black Leg") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Death Step") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Death Step") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Fishman Karate") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Fishman Karate") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Sharkman Karate") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Sharkman Karate") or game.Players.LocalPlayer.Backpack:FindFirstChild("Electro") or game.Players.LocalPlayer.Character:FindFirstChild("Electro") or game.Players.LocalPlayer.Backpack:FindFirstChild("Electric Claw") or game.Players.LocalPlayer.Character:FindFirstChild("Electric Claw") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dragon Claw") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Dragon Claw") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dragon Talon") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Dragon Talon") or game.Players.LocalPlayer.Character:FindFirstChild("Godhuman") or game.Players.LocalPlayer.Backpack:FindFirstChild("Godhuman") then
					if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySuperhuman",true) == 1 then
						if game.Players.LocalPlayer.Backpack:FindFirstChild("Superhuman") and game.Players.LocalPlayer.Backpack:FindFirstChild("Superhuman").Level.Value >= 400 or game.Players.LocalPlayer.Character:FindFirstChild("Superhuman") and game.Players.LocalPlayer.Character:FindFirstChild("Superhuman").Level.Value >= 400 then
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDeathStep")
						end
					else
					end
					if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDeathStep",true) == 1 then
						if game.Players.LocalPlayer.Backpack:FindFirstChild("Death Step") and game.Players.LocalPlayer.Backpack:FindFirstChild("Death Step").Level.Value >= 400 or game.Players.LocalPlayer.Character:FindFirstChild("Death Step") and game.Players.LocalPlayer.Character:FindFirstChild("Death Step").Level.Value >= 400 then
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate")
						end
					else
					end
					if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate",true) == 1 then
						if game.Players.LocalPlayer.Backpack:FindFirstChild("Sharkman Karate") and game.Players.LocalPlayer.Backpack:FindFirstChild("Sharkman Karate").Level.Value >= 400 or game.Players.LocalPlayer.Character:FindFirstChild("Sharkman Karate") and game.Players.LocalPlayer.Character:FindFirstChild("Sharkman Karate").Level.Value >= 400 then
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw")
						end
					else
					end
					if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw",true) == 1 then
						if game.Players.LocalPlayer.Backpack:FindFirstChild("Electric Claw") and game.Players.LocalPlayer.Backpack:FindFirstChild("Electric Claw").Level.Value >= 400 or game.Players.LocalPlayer.Character:FindFirstChild("Electric Claw") and game.Players.LocalPlayer.Character:FindFirstChild("Electric Claw").Level.Value >= 400 then
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon")
						end
					else
					end
					if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon",true) == 1 then
						if game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Talon") and game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Talon").Level.Value >= 400 or game.Players.LocalPlayer.Character:FindFirstChild("Dragon Talon") and game.Players.LocalPlayer.Character:FindFirstChild("Dragon Talon").Level.Value >= 400 then
							if string.find(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyGodhuman",true), "Bring") then
							else
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyGodhuman")
							end
						end
					else
					end
				else
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySuperhuman")
				end
            end)
        end
    end
end)
spawn(function()
	while wait() do
		if Config["Auto Godhuman Full"] then
			pcall(function()
			if game.Players.LocalPlayer.Character:FindFirstChild("Godhuman") or game.Players.LocalPlayer.Backpack:FindFirstChild("Godhuman") then
				EquipWeapon("Godhuman")
				else
					if game.Players.LocalPlayer.Backpack:FindFirstChild("Death Step") and game.Players.LocalPlayer.Backpack:FindFirstChild("Death Step").Level.Value <= 399 and game.Players.LocalPlayer.Backpack:FindFirstChild("Electric Claw") and game.Players.LocalPlayer.Backpack:FindFirstChild("Electric Claw").Level.Value <= 399 and  game.Players.LocalPlayer.Backpack:FindFirstChild("Sharkman Karate") and game.Players.LocalPlayer.Backpack:FindFirstChild("Sharkman Karate").Level.Value <= 399 and game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Talon") and game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Talon").Level.Value <= 399 then
					if not L_7449423635_ then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
					elseif L_7449423635_ then
					if GetMaterial("Fish Tail") <= 20 and L_7449423635_ then
						for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                            if v.Name == "Fishman Raider" or v.Name == "Fishman Captain" then
                        		if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    repeat task.wait()
                               	 	EquipWeapon(_G['Select Weapon'])
                              		v.HumanoidRootPart.CanCollide = false
                                	v.Head.CanCollide = false
                                    BringMob(v.HumanoidRootPart.CFrame) 
                                	TP(v.HumanoidRootPart.CFrame * Pos)
                            		until not Config["Auto Godhuman Full"] or not v.Parent or v.Humanoid.Health <= 0
                        		end
                  				else
                                TP(CFrame.new( -10993,332, -8940))
                   	 		end
              		  	end
						elseif GetMaterial("Dragon Scale") <= 10 and L_7449423635_ then
						for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                            if v.Name == "Fishman Raider" or v.Name == "Fishman Captain" then
                        		if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    repeat task.wait()
                                    EquipWeapon(_G['Select Weapon'])
                                    v.HumanoidRootPart.CanCollide = false
                                    v.Head.CanCollide = false
                                    BringMob(v.HumanoidRootPart.CFrame) 
                                    TP(v.HumanoidRootPart.CFrame * Pos)
                            		until not Config["Auto Godhuman Full"] or not v.Parent or v.Humanoid.Health <= 0
                        		end
								else
									TP(CFram.new(6594,383,139))
                                end
							end
							if GetMaterial("Dragon Scale") >= 10 and GetMaterial("Fish Tail") >= 20 then
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
							end
						end
						elseif not L_4442272183_ then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
						elseif L_4442272183_ then
						if GetMaterial("Magma Ore") <= 20 and L_4442272183_ then
							for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                            if v.Name == "Magma Ninja" then
                        		if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    repeat task.wait()
                                    EquipWeapon(_G['Select Weapon'])
                                    v.HumanoidRootPart.CanCollide = false
                                    v.Head.CanCollide = false
                                    BringMob(v.HumanoidRootPart.CFrame) 
                                    TP(v.HumanoidRootPart.CFrame * Pos)
                            		until not Config["Auto Godhuman Full"] or not v.Parent or v.Humanoid.Health <= 0
                        		end
									else
									TP(CFrame.new( -5428,78, -5959))
              		  			end
							end
						elseif GetMaterial("Mystic Droplet") <= 10 and L_4442272183_ then
							for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                                if v.Name == "Water Fighter" then
                        		if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    repeat task.wait()
                                    EquipWeapon(_G['Select Weapon'])
                                    v.HumanoidRootPart.CanCollide = false
                                    v.Head.CanCollide = false
                                    BringMob(v.HumanoidRootPart.CFrame) 
                                    TP(v.HumanoidRootPart.CFrame * Pos)
                            		until not Config["Auto Godhuman Full"] or not v.Parent or v.Humanoid.Health <= 0
                        		end
									else
									TP(CFrame.new( -3385,239, -10542))
              		  			end
								end
								if not L_7449423635_ then
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
								elseif L_7449423635_ then
									if GetMaterial("Mystic Droplet") >= 10 and GetMaterial("Magma Ore") >= 20 and GetMaterial("Dragon Scale") >= 10 and GetMaterial("Fish Tail") >= 20 then
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyGodhuman")
									wait(.3)
									end
								end
							end
						end
						else 
						if game.Players.LocalPlayer.Backpack:FindFirstChild("Death Step") and game.Players.LocalPlayer.Backpack:FindFirstChild("Death Step").Level.Value >= 400 or game.Players.LocalPlayer.Character:FindFirstChild("Death Step") and game.Players.LocalPlayer.Character:FindFirstChild("Death Step").Level.Value >= 400 then
                       	 game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw")
                   	 end
                    	if game.Players.LocalPlayer.Backpack:FindFirstChild("Electric Claw") and game.Players.LocalPlayer.Backpack:FindFirstChild("Electric Claw").Level.Value >= 400 or game.Players.LocalPlayer.Character:FindFirstChild("Electric Claw") and game.Players.LocalPlayer.Character:FindFirstChild("Electric Claw").Level.Value >= 400 then
                        	game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate")
                    	end
                    	if game.Players.LocalPlayer.Backpack:FindFirstChild("Sharkman Karate") and game.Players.LocalPlayer.Backpack:FindFirstChild("Sharkman Karate").Level.Value >= 400 or game.Players.LocalPlayer.Character:FindFirstChild("Sharkman Karate") and game.Players.LocalPlayer.Character:FindFirstChild("Sharkman Karate").Level.Value >= 400 then
                        	game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon")
                  	  end 
        			end
				end
			end)
		end
 	end
end)
spawn(function()
    while wait() do
        if Config["Auto Hallow Sycthe"] then
            pcall(function()
                if (workspace.Enemies:FindFirstChild("Soul Reaper")) then
                    for v38, v39 in pairs(workspace.Enemies:GetChildren()) do
                        if (string.find(v39.Name, "Soul Reaper")) then
                            repeat
                                wait()
                                AutoHaki()
                                EquipWeapon(_G['Select Weapon'])
                                TP(v39.HumanoidRootPart.CFrame * Pos)
                                v39.HumanoidRootPart.Transparency = 1
                                sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                            until (v39.Humanoid.Health <= (0) or not Config["Auto Hallow Sycthe"])
                        end
                    end
                elseif (game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Hallow Essence") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Hallow Essence")) then
                    repeat
                        TP(CFrame.new(-8932.322265625, 146.83154296875, 6062.55078125))
                        wait()
                    until (CFrame.new(-8932.322265625, 146.83154296875, 6062.55078125).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= (20)
                    wait(0.5)
                    EquipWeapon("Hallow Essence")
                elseif not game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Hallow Essence") and not game:GetService("Players").LocalPlayer.Character:FindFirstChild("Hallow Essence") then
                    local args = {
                        [1] = "Bones",
                        [2] = "Buy",
                        [3] = 1,
                        [4] = 1
                    }
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                else
                    if (game:GetService("ReplicatedStorage"):FindFirstChild("Soul Reaper")) then
                        TP(game:GetService("ReplicatedStorage"):FindFirstChild("Soul Reaper").HumanoidRootPart
                            .CFrame * Pos)
                    else
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while task.wait() do
        if Config["Auto Saber"] and game.Players.LocalPlayer.Data.Level.Value >= 200 then
            pcall(function()
                if (game:GetService("Workspace").Map.Jungle.Final.Part.Transparency) == (0) then
                    if (game:GetService("Workspace").Map.Jungle.QuestPlates.Door.Transparency) == (0) then
                        if (CFrame.new(-1612.55884, 36.9774132, 148.719543, 0.37091279, 3.0717151e-09, -0.928667724, 3.97099491e-08, 1, 1.91679348e-08, 0.928667724, -4.39869794e-08, 0.37091279).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= (100) then
                            local v40 = 0
                            if (v40 == (0)) then
                                wait(0.1)
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService(
                                    "Workspace").Map.Jungle.QuestPlates.Plate1.Button.CFrame
                                v40 = 1
                            end
                            if (v40 == (1)) then
                                wait(0.1)
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService(
                                    "Workspace").Map.Jungle.QuestPlates.Plate2.Button.CFrame
                                v40 = 2
                            end
                            if (v40 == (2)) then
                                wait(0.1)
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService(
                                    "Workspace").Map.Jungle.QuestPlates.Plate3.Button.CFrame
                                v40 = 3
                            end
                            if (v40 == (3)) then
                                wait(0.1)
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService(
                                    "Workspace").Map.Jungle.QuestPlates.Plate4.Button.CFrame
                                v40 = 4
                            end
                            if (v40 == (4)) then
                                wait(0.1)
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService(
                                    "Workspace").Map.Jungle.QuestPlates.Plate5.Button.CFrame
                            end
                        else
                            TP(CFrame.new(-1612.55884, 36.9774132, 148.719543, 0.37091279, 3.0717151e-09,
                                -0.928667724, 3.97099491e-08, 1, 1.91679348e-08, 0.928667724, -4.39869794e-08,
                                0.37091279))
                        end
                    else
                        if (game:GetService("Workspace").Map.Desert.Burn.Part.Transparency) == (0) then
                            if (game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Torch") or game.Players.LocalPlayer.Character:FindFirstChild("Torch")) then
                                EquipWeapon("Torch")
                                TP(CFrame.new(1114.61475, 5.04679728, 4350.22803, -0.648466587, -1.28799094e-09,
                                    0.761243105, -5.70652914e-10, 1, 1.20584542e-09, -0.761243105, 3.47544882e-10,
                                    -0.648466587))
                            else
                                TP(CFrame.new(-1610.00757, 11.5049858, 164.001587, 0.984807551, -0.167722285,
                                    -0.0449818149, 0.17364943, 0.951244235, 0.254912198, 3.42372805e-05, -0.258850515,
                                    0.965917408))
                            end
                        else
                            if (game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "SickMan")) ~= (0) then
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress",
                                    "GetCup")
                                wait(0.5)
                                EquipWeapon("Cup")
                                wait(0.5)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress",
                                    "FillCup", game:GetService("Players").LocalPlayer.Character.Cup)
                                wait(0)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress",
                                    "SickMan")
                            else
                                if (game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon")) == nil then
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(
                                        "ProQuestProgress", "RichSon")
                                elseif (game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon")) == 0 then
                                    if (workspace.Enemies:FindFirstChild("Mob Leader") or game:GetService("ReplicatedStorage"):FindFirstChild("Mob Leader")) then
                                        TP(CFrame.new(-2874.97021484375, 20.01312828063965, 5415.25244140625))
                                        for v41, v42 in pairs(workspace.Enemies:GetChildren()) do
                                            if v42.Name == "Mob Leader" then
                                                if (workspace.Enemies:FindFirstChild("Mob Leader")) then
                                                    if (v42:FindFirstChild("Humanoid") and v42:FindFirstChild("HumanoidRootPart") and v42.Humanoid.Health) > (0) then
                                                        repeat
                                                            task.wait()
                                                            AutoHaki()
                                                            EquipWeapon(_G['Select Weapon'])
                                                            v42.HumanoidRootPart.CanCollide = false
                                                            v42.Humanoid.WalkSpeed = 0
                                                            TP(v42.HumanoidRootPart.CFrame * Pos)
                                                            sethiddenproperty(game:GetService("Players").LocalPlayer,
                                                                "SimulationRadius", math.huge)
                                                        until v42.Humanoid.Health <= (0) or not Config["Auto Saber"]
                                                    end
                                                end
                                                if game:GetService("ReplicatedStorage"):FindFirstChild("Mob Leader") then
                                                end
                                            end
                                        end
                                    end
                                    TP(game:GetService("ReplicatedStorage"):FindFirstChild("Mob Leader")
                                        .HumanoidRootPart.CFrame * Pos)
                                elseif (game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon")) == (1) then
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(
                                        "ProQuestProgress", "RichSon")
                                    wait(0.5)
                                    EquipWeapon("Relic")
                                    wait(0.5)
                                    TP(CFrame.new(-1404.91504, 29.9773273, 3.80598116, 0.876514494, 5.66906877e-09,
                                        0.481375456, 2.53851997e-08, 1, -5.79995607e-08, -0.481375456, 6.30572643e-08,
                                        0.876514494))
                                end
                            end
                        end
                    end
                else
                    if (workspace.Enemies:FindFirstChild("Saber Expert") or game:GetService("ReplicatedStorage"):FindFirstChild("Saber Expert")) then
                        for v43, v44 in pairs(workspace.Enemies:GetChildren()) do
                            if (v44:FindFirstChild("Humanoid") and v44:FindFirstChild("HumanoidRootPart") and v44.Humanoid.Health) > (0) then
                                if (v44.Name == "Saber Expert") then
                                    repeat
                                        task.wait()
                                        EquipWeapon(_G['Select Weapon'])
                                        TP(v44.HumanoidRootPart.CFrame * Pos)
                                    until (v44.Humanoid.Health <= (0) or not Config["Auto Saber"])
                                    if (v44.Humanoid.Health <= (0)) then
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(
                                            "ProQuestProgress", "PlaceRelic")
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if Config["Auto Pole v1"] and L_2753915549_ then
            pcall(function()
                local enemies = workspace.Enemies
                if enemies:FindFirstChild("Thunder God") then
                    for _, v in pairs(enemies:GetChildren()) do
                        if v.Name == "Thunder God" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                            humanoid = v.Humanoid
                            rootPart = v.HumanoidRootPart
                            if humanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G['Select Weapon'])
                                    rootPart.CanCollide = false
                                    humanoid.WalkSpeed = 0
                                    TP(rootPart.CFrame * Pos)
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                until not Config["Auto Pole v1"] or not v.Parent or humanoid.Health <= 0
                            end
                        end
                    end
                else
               local _paps = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                    if (_paps - CFrame.new(-7748.0185546875, 5606.80615234375, -2305.898681640625).Position).Magnitude > 1500 then
                    else
                        TP(CFrame.new(-7748.0185546875, 5606.80615234375, -2305.898681640625))
                    end
                    TP(CFrame.new(-7748.0185546875, 5606.80615234375, -2305.898681640625))
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if Config["Auto Pole v1"] and Config["Auto Pole v1 Hop"] and L_2753915549_ then
            pcall(function()
                local enemies = workspace.Enemies
                if enemies:FindFirstChild("Thunder God") then
                    for _, v in pairs(enemies:GetChildren()) do
                        if v.Name == "Thunder God" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                            humanoid = v.Humanoid
                            rootPart = v.HumanoidRootPart
                            if humanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G['Select Weapon'])
                                    rootPart.CanCollide = false
                                    humanoid.WalkSpeed = 0
                                    TP(rootPart.CFrame * Pos)
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                until not Config["Auto Pole v1"] or not v.Parent or humanoid.Health <= 0
                            end
                        end
                    end
                else
                    Hop()
                end
            end)
        end
    end
end)
sgssss = CFrame.new(2285.93921, 15.382349, 767.798035, 0.9999789, -2.15635154e-09, 0.00649796473, 2.78876344e-09, 1, -9.73155281e-08, -0.00649796473, 9.73315935e-08, 0.9999789)
spawn(function()
    while wait() do
        if Config["Auto Swan Glasses"] and L_4442272183_ then
            pcall(function()
                local enemies = workspace.Enemies
                if enemies:FindFirstChild("Greybeard") then
                    for _, v in pairs(enemies:GetChildren()) do
                        if v.Name == "Greybeard" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                            humanoid = v.Humanoid
                            rootPart = v.HumanoidRootPart
                            if humanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G['Select Weapon'])
                                    rootPart.CanCollide = false
                                    humanoid.WalkSpeed = 0
                                    TP(rootPart.CFrame * Pos)
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                until not Config["Auto Swan Glasses"] or not v.Parent or humanoid.Health <= 0
                            end
                        end
                    end
                else
                playerPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                    if (playerPos - sgssss.Position).Magnitude > 1500 then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",
                        Vector3.new(2284.912109375, 15.152034759521484, 905.48291015625))
                    else
                        TP(sgssss)
                    end
                    TP(sgssss)
                end
            end)
        end
    end
end)
b2p = CFrame.new(-4917.68457, 20.6870441, 4253.10596, -0.500057101, -1.7856765e-08, -0.865992427, 6.94795546e-08, 1,
    -6.07401489e-08, 0.865992427, -9.0542315e-08, -0.500057101)
spawn(function()
    while wait() do
        if Config["Auto Bisento v2"] and L_2753915549_ then
            pcall(function()
                local enemies = workspace.Enemies
                if enemies:FindFirstChild("Greybeard") then
                    for _, v in pairs(enemies:GetChildren()) do
                        if v.Name == "Greybeard" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                            humanoid = v.Humanoid
                            rootPart = v.HumanoidRootPart
                            if humanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G['Select Weapon'])
                                    rootPart.CanCollide = false
                                    humanoid.WalkSpeed = 0
                                    TP(rootPart.CFrame * Pos)
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                until not Config["Auto Bisento v2"] or not v.Parent or humanoid.Health <= 0
                            end
                        end
                    end
                else
                    playerPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                    if BypassTP then
                        if (playerPos - b2p.Position).Magnitude > 1500 then
                            TP(b2p)
                        else
                            TP(b2p)
                        end
                    else
                        TP(b2p)
                    end
                    TP(b2p)
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Bisento v2"] and getgenv().Config["Auto Bisento v2 Hop"] and L_2753915549_ then
            pcall(function()
                local enemies = workspace.Enemies
                if enemies:FindFirstChild("Greybeard") then
                    for _, v in pairs(enemies:GetChildren()) do
                        if v.Name == "Greybeard" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                            humanoid = v.Humanoid
                            rootPart = v.HumanoidRootPart
                            if humanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G['Select Weapon'])
                                    rootPart.CanCollide = false
                                    humanoid.WalkSpeed = 0
                                    TP(rootPart.CFrame * Pos)
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                until not getgenv().Config["Auto Bisento v2"] or not v.Parent or humanoid.Health <= 0
                            end
                        end
                    end
                else
                    Hop()
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Buy Lengedary Sword"] then
            pcall(function()
                local args = {
                    [1] = "LegendarySwordDealer",
                    [2] = "1"
                }
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                local args = {
                    [1] = "LegendarySwordDealer",
                    [2] = "2"
                }
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                local args = {
                    [1] = "LegendarySwordDealer",
                    [2] = "3"
                }
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                if getgenv().Config["Auto Buy Lengedary Sword Hop"] and getgenv().Config["Auto Buy Lengedary Sword"] then
                    wait(5)
                    Hop()
                end
            end)
        end 
    end
end)
spawn(function()
    pcall(function()
        while wait() do
            if getgenv().Config["Auto Rengoku"] and L_4442272183_ then
                player = game:GetService("Players").LocalPlayer
                backpack = player.Backpack
                character = player.Character
                x9 = CFrame.new(6373, 297, -6841)
                TP(CFrame.new(6119, 28, -6237))
                if backpack:FindFirstChild("Hidden Key") or character:FindFirstChild("Hidden Key") then
                    EquipWeapon("Hidden Key")
                    TP(x9)
                else
                    enemies = workspace.Enemies:GetChildren()
                    target = nil
                    for _, v in pairs(enemies) do
                        if (v.Name == "Snow Lurker" or v.Name == "Arctic Warrior") and v.Humanoid and v.Humanoid.Health > 0 then
                            target = v
                            break
                        end
                    end
                    if target then
                        repeat
                            task.wait()
                            EquipWeapon(_G['Select Weapon'])
                            AutoHaki()
                            target.HumanoidRootPart.CanCollide = false
                            BringMob(target.HumanoidRootPart.CFrame) 
                            TP(target.HumanoidRootPart.CFrame * Pos)
                        until backpack:FindFirstChild("Hidden Key") or not getgenv().Config["Auto Rengoku"] or not target.Parent or target.Humanoid.Health <= 0
                    else
                        replicatedStorage = game:GetService("ReplicatedStorage")
                        snowLurker = replicatedStorage:FindFirstChild("Snow Lurker")
                        arcticWarrior = replicatedStorage:FindFirstChild("Arctic Warrior")
                        if snowLurker and snowLurker:FindFirstChild("HumanoidRootPart") then
                            TP(snowLurker.HumanoidRootPart.CFrame * Pos)
                        elseif arcticWarrior and arcticWarrior:FindFirstChild("HumanoidRootPart") then
                            TP(arcticWarrior.HumanoidRootPart.CFrame * Pos)
                        end
                    end
                end
            end
        end
    end)
end)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Rengoku"] then
            pcall(function()
                if not game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Hidden Key") then
                    checkHiddenKey = false
                    for i, v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
                         if v.Name == "Hidden Key" then
                            checkHiddenKey = true
                            break
                         end
                         if not checkHiddenKey then
                            for i, v in pairs(workspace.Enemies:GetChildren()) do
                                if (v.Name == "Snow Lurker" or v.Name == "Arctic Warrior") and v.Humanoid and v.Humanoid.Health > 0 then
                                    repeat
                                        task.wait()
                                        EquipWeapon(_G['Select Weapon'])
                                        AutoHaki()
                                        v.HumanoidRootPart.CanCollide = false
                                        BringMob(v.HumanoidRootPart.CFrame) 
                                        TP(v.HumanoidRootPart.CFrame * Pos)
                                    until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Hidden Key") or not getgenv().Config["Auto Rengoku"] or not v.Parent or v.Humanoid.Health <= 0
                                end
                                Posawdaw = CFrame.new()
                            if checkHiddenKey then
                                TP(Posawdaw)
                                    if (Posawdaw.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 20 then
                                        TP(CFrame.new())
                                    end
                                end
                            end
                         end
                    end
                end
            end)
        end
    end
end)
local BigMomPos = CFrame.new(-731.2034301757812, 381.5658874511719, -11198.4951171875)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Budy Sword"] and L_7449423635_ then
            pcall(function()
                local enemies = workspace.Enemies
                if enemies:FindFirstChild("Cake Queen") then
                    for _, v in pairs(enemies:GetChildren()) do
                        if v.Name == "Cake Queen" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                            local humanoid = v.Humanoid
                            local rootPart = v.HumanoidRootPart
                            if humanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G['Select Weapon'])
                                    rootPart.CanCollide = false
                                    humanoid.WalkSpeed = 0
                                    TP(rootPart.CFrame * Pos)
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                until not getgenv().Config["Auto Budy Sword"] or not v.Parent or humanoid.Health <= 0
                            end
                        end
                    end
                else
                    local playerPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                    if BypassTP then
                        if (playerPos - BigMomPos.Position).Magnitude > 1500 then
                            BTP(BigMomPos)
                        else
                            TP(BigMomPos)
                        end
                    else
                        TP(BigMomPos)
                    end
                    TP(BigMomPos)
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Budy Sword"] and getgenv().Config["Auto Budy Sword Hop"] and L_7449423635_ then
            pcall(function()
                local enemies = workspace.Enemies
                if enemies:FindFirstChild("Cake Queen") then
                    for _, v in pairs(enemies:GetChildren()) do
                        if v.Name == "Cake Queen" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                            local humanoid = v.Humanoid
                            local rootPart = v.HumanoidRootPart
                            if humanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G['Select Weapon'])
                                    rootPart.CanCollide = false
                                    humanoid.WalkSpeed = 0
                                    TP(rootPart.CFrame * Pos)
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                until not getgenv().Config["Auto Budy Sword"] or not v.Parent or humanoid.Health <= 0
                            end
                        end
                    end
                else
                    
                end
            end)
        end
    end
end)
cccccc = CFrame.new(5366, 22, -305)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Canvander"] and L_7449423635_ then
            pcall(function()
                local enemies = workspace.Enemies
                if enemies:FindFirstChild("Beautiful Pirate") then
                    for _, v in pairs(enemies:GetChildren()) do
                        if v.Name == "Beautiful Pirate" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                            humanoid = v.Humanoid
                            rootPart = v.HumanoidRootPart
                            if humanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G['Select Weapon'])
                                    rootPart.CanCollide = false
                                    humanoid.WalkSpeed = 0
                                    TP(rootPart.CFrame * Pos)
                                until not getgenv().Config["Auto Canvander"] or not v.Parent or humanoid.Health <= 0
                            end
                        end
                    end
                else
                    playerPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                    if BypassTP then
                        if (playerPos - cccccc.Position).Magnitude > 1500 then
                            TP(cccccc)
                        else
                            TP(cccccc)
                        end
                    else
                        TP(cccccc)
                    end
                    TP(cccccc)
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Canvander"] and getgenv().Config["Auto Canvander Hop"] and L_7449423635_ then
            pcall(function()
                local enemies = workspace.Enemies
                if enemies:FindFirstChild("Beautiful Pirate") then
                    for _, v in pairs(enemies:GetChildren()) do
                        if v.Name == "Beautiful Pirate" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                            humanoid = v.Humanoid
                            rootPart = v.HumanoidRootPart
                            if humanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G['Select Weapon'])
                                    rootPart.CanCollide = false
                                    humanoid.WalkSpeed = 0
                                    TP(rootPart.CFrame * Pos)
                                until not getgenv().Config["Auto Canvander"] or not v.Parent or humanoid.Health <= 0
                            end
                        end
                    end
                else
                    Hop()
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Yama"] then
            if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter", "Progress") >= 30 then
                repeat
                    wait()
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",
                        Vector3.new(5661.52979, 1013.07385, -334.962189))
                    fireclickdetector(game.workspace.Map.Waterfall.SealedKatana.Hitbox.ClickDetector)
                until game.Players.LocalPlayer.Backpack:FindFirstChild("Yama") or not getgenv().Config["Auto Yama"]
            else
                if (game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible) == true then
                    if (string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Diablo") or string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Deandre") or string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Urban")) then
                        if (workspace.Enemies:FindFirstChild("Diablo") or workspace.Enemies:FindFirstChild("Deandre") or workspace.Enemies:FindFirstChild("Urban")) then
                            for v37, v38 in pairs(workspace.Enemies:GetChildren()) do
                                if (v38:FindFirstChild("Humanoid") and v38:FindFirstChild("HumanoidRootPart") and v38.Humanoid.Health) > (0) then
                                    if (v38.Name == "Diablo" or v38.Name == "Deandre" or v38.Name == "Urban") then
                                        repeat
                                            game:GetService("RunService").Heartbeat:wait()
                                            EquipWeapon(_G['Select Weapon'])
                                            TP(v38.HumanoidRootPart.CFrame * Pos)
                                        until (getgenv().Config["Auto Yama"] == false or v38.Humanoid.Health <= (0) or not v.Parent)
                                    end
                                end
                            end
                        else
                            if (game:GetService("ReplicatedStorage"):FindFirstChild("Diablo")) then
                                if (ByPassTP) then
                                    BTP(game:GetService("ReplicatedStorage"):FindFirstChild("Diablo")
                                        .HumanoidRootPart.CFrame)
                                else
                                    TP(game:GetService("ReplicatedStorage"):FindFirstChild("Diablo")
                                        .HumanoidRootPart.CFrame)
                                end
                            elseif (game:GetService("ReplicatedStorage"):FindFirstChild("Deandre")) then
                                if (ByPassTP) then
                                    BTP(game:GetService("ReplicatedStorage"):FindFirstChild("Deandre")
                                        .HumanoidRootPart.CFrame)
                                else
                                    TP(game:GetService("ReplicatedStorage"):FindFirstChild("Deandre")
                                        .HumanoidRootPart.CFrame)
                                end
                            elseif (game:GetService("ReplicatedStorage"):FindFirstChild("Urban")) then
                                if (ByPassTP) then
                                    BTP(game:GetService("ReplicatedStorage"):FindFirstChild("Urban")
                                        .HumanoidRootPart.CFrame)
                                else
                                    TP(game:GetService("ReplicatedStorage"):FindFirstChild("Urban").HumanoidRootPart
                                        .CFrame)
                                end
                            end
                        end
                    end
                else
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter")
                end
            end
        end
    end
end)
local twinpos = CFrame.new(-13346.2705, 405.925385, -8575.56641, -0.998146832, -1.27272148e-08, 0.0608517416,
    -1.80948838e-08, 1, -8.76578881e-08, -0.0608517416, -8.85965505e-08, -0.998146832)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Twin Hooks"] and L_7449423635_ then
            pcall(function()
                local enemies = workspace.Enemies
                if enemies:FindFirstChild("Captain Elephant") then
                    for _, v in pairs(enemies:GetChildren()) do
                        if v.Name == "Captain Elephant" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                            local humanoid = v.Humanoid
                            local rootPart = v.HumanoidRootPart
                            if humanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G.SelectWeapon)
                                    rootPart.CanCollide = false
                                    humanoid.WalkSpeed = 0
                                    toposition(rootPart.CFrame * Pos)
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                until not getgenv().Config["Auto Twin Hooks"] or not v.Parent or humanoid.Health <= 0
                            end
                        end
                    end
                else
                    local playerPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                    if BypassTP then
                        if (playerPos - twinpos.Position).Magnitude > 1500 then
                            BTP(twinpos)
                        else
                            TP(twinpos)
                        end
                    else
                        TP(twinpos)
                    end
                    TP(twinpos)
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Twin Hooks"] and getgenv().Config["Auto Twin Hooks Hop"] and L_7449423635_ then
            pcall(function()
                local enemies = workspace.Enemies
                if enemies:FindFirstChild("Captain Elephant") then
                    for _, v in pairs(enemies:GetChildren()) do
                        if v.Name == "Captain Elephant" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                            local humanoid = v.Humanoid
                            local rootPart = v.HumanoidRootPart
                            if humanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G.SelectWeapon)
                                    rootPart.CanCollide = false
                                    humanoid.WalkSpeed = 0
                                    toposition(rootPart.CFrame * Pos)
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                until not getgenv().Config["Auto Twin Hooks"] or not v.Parent or humanoid.Health <= 0
                            end
                        end
                    end
                else
                    Hop()
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        pcall(function()
            if getgenv().Config["Auto Soul Guitar"] then
                if CheckGun("Skull Guitar") == false then
                    if (CFrame.new(-9681.458984375, 6.139880657196045, 6341.3720703125).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 5000 then
                        if game:GetService("Workspace").NPCs:FindFirstChild("Skeleton Machine") then
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("soulGuitarBuy",true)
                        else
                            if game:GetService("Workspace").Map["Haunted Castle"].Candle1.Transparency == 0 then
                                if game:GetService("Workspace").Map["Haunted Castle"].Placard1.Left.Part.Transparency == 0 then
                                    Quest2 = true
                                    repeat wait() TP(CFrame.new(-8762.69140625, 176.84783935546875, 6171.3076171875)) until (CFrame.new(-8762.69140625, 176.84783935546875, 6171.3076171875).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 or not getgenv().Config["Auto Soul Guitar"]
                                    wait(1)
                                    fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Placard7.Left.ClickDetector)
                                    wait(1)
                                    fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Placard6.Left.ClickDetector)
                                    wait(1)
                                    fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Placard5.Left.ClickDetector)
                                    wait(1)
                                    fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Placard4.Right.ClickDetector)
                                    wait(1)
                                    fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Placard3.Left.ClickDetector)
                                    wait(1)
                                    fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Placard2.Right.ClickDetector)
                                    wait(1)
                                    fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Placard1.Right.ClickDetector)
                                    wait(1)
                                elseif game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment1:FindFirstChild("ClickDetector") then
                                    if game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part1:FindFirstChild("ClickDetector") then
                                        Quest4 = true
                                        repeat wait() TP(CFrame.new(-9553.5986328125, 65.62338256835938, 6041.58837890625)) until (CFrame.new(-9553.5986328125, 65.62338256835938, 6041.58837890625).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 or not getgenv().Config["Auto Soul Guitar"]
                                        wait(1)
                                        TP(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part3.CFrame)
                                        wait(1)
                                        fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part3.ClickDetector)
                                        wait(1)
                                        TP(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part4.CFrame)
                                        wait(1)
                                        fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part4.ClickDetector)
                                        wait(1)
                                        fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part4.ClickDetector)
                                        wait(1)
                                        fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part4.ClickDetector)
                                        wait(1)
                                        TP(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part6.CFrame)
                                        wait(1)
                                        fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part6.ClickDetector)
                                        wait(1)
                                        fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part6.ClickDetector)
                                        wait(1)
                                        TP(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part8.CFrame)
                                        wait(1)
                                        fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part8.ClickDetector)
                                        wait(1)
                                        TP(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part10.CFrame)
                                        wait(1)
                                        fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part10.ClickDetector)
                                        wait(1)
                                        fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part10.ClickDetector)
                                        wait(1)
                                        fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part10.ClickDetector)
                                    else
                                        Quest3 = true
                                    end
                                else
                                    if game:GetService("Workspace").NPCs:FindFirstChild("Ghost") then
                                        local args = {
                                            [1] = "GuitarPuzzleProgress",
                                            [2] = "Ghost"
                                        }

                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                                    end
                                    if game.Workspace.Enemies:FindFirstChild("Living Zombie") then
                                        for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                                            if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                                if v.Name == "Living Zombie" then
                                                    EquipWeapon(_G['Select Weapon'])
                                                    v.HumanoidRootPart.Transparency = 1
                                                    v.Humanoid.JumpPower = 0
                                                    v.Humanoid.WalkSpeed = 0
                                                    v.HumanoidRootPart.CanCollide = false
                                                    v.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,-PosY,0)
                                                    TP(CFrame.new(-10160.787109375, 138.6616973876953, 5955.03076171875))
                                                end
                                            end
                                        end
                                    else
                                        TP(CFrame.new(-10160.787109375, 138.6616973876953, 5955.03076171875))
                                    end
                                end
                            else    
                                if string.find(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("gravestoneEvent",2), "Error") then
                                    TP(CFrame.new(-8653.2060546875, 140.98487854003906, 6160.033203125))
                                elseif string.find(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("gravestoneEvent",2), "Nothing") then
                                else
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("gravestoneEvent",2,true)
                                end
                            end
                        end
                    else
                        TP(CFrame.new(-9681.458984375, 6.139880657196045, 6341.3720703125))
                    end
                else
                    if _G.soulGuitarhop then
                        Hop()
                    end
                end
            end
        end)
    end
end)
local tushitapos = CFrame.new(-10324.416, 332.800507, -9445.86621, -0.0438114405, -3.84933436e-08, -0.999039829,
    -2.5365658e-08, 1, -3.74179656e-08, 0.999039829, 2.37019684e-08, -0.0438114405)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Tushita"] and L_7449423635_ then
            pcall(function()
                local enemies = workspace.Enemies
                if enemies:FindFirstChild("Longma") then
                    for _, v in pairs(enemies:GetChildren()) do
                        if v.Name == "Longma" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                            local humanoid = v.Humanoid
                            local rootPart = v.HumanoidRootPart
                            if humanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G['Select Weapon'])
                                    rootPart.CanCollide = false
                                    humanoid.WalkSpeed = 0
                                    TP(rootPart.CFrame * Pos)
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                until not getgenv().Config["Auto Tushita"] or not v.Parent or humanoid.Health <= 0
                            end
                        end
                    end
                else
                    local playerPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                    if BypassTP then
                        if (playerPos - tushitapos.Position).Magnitude > 1500 then
                            BTP(tushitapos)
                        else
                            TP(tushitapos)
                        end
                    else
                        TP(tushitapos)
                    end
                    TP(tushitapos)
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Holy Torch"] then
            pcall(function()
                EquipWeapon("Holy Torch")
                repeat
                    TP(CFrame.new(-10753.3174, 412.433777, -9365.34375, 0.970033109, -6.00706827e-08, 0.242972791,
                        7.93705368e-08, 1, -6.96430433e-08, -0.242972791, 8.68409415e-08, 0.970033109))
                    wait()
                until not getgenv().Config["Auto Holy Torch"] or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(-10753.3174, 412.433777, -9365.34375, 0.970033109, -6.00706827e-08, 0.242972791, 7.93705368e-08, 1, -6.96430433e-08, -0.242972791, 8.68409415e-08, 0.970033109)).Magnitude <= 10
                wait(1)
                repeat
                    TP(CFrame.new(-11673.7344, 331.953827, -9474.70117, 0.283551037, 4.05383149e-09, -0.958957136,
                        2.1445361e-09, 1, 4.86144414e-09, 0.958957136, -3.43498585e-09, 0.283551037))
                    wait()
                until not getgenv().Config["Auto Holy Torch"] or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(-11673.7344, 331.953827, -9474.70117, 0.283551037, 4.05383149e-09, -0.958957136, 2.1445361e-09, 1, 4.86144414e-09, 0.958957136, -3.43498585e-09, 0.283551037)).Magnitude <= 10
                wait(1)
                repeat
                    TP(CFrame.new(-12133.5586, 519.679443, -10654.5859, 0.648711026, 1.72827441e-08, -0.761034846,
                        4.58535396e-08, 1, 6.1795383e-08, 0.761034846, -7.49834896e-08, 0.648711026))
                    wait()
                until not getgenv().Config["Auto Holy Torch"] or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(-12133.5586, 519.679443, -10654.5859, 0.648711026, 1.72827441e-08, -0.761034846, 4.58535396e-08, 1, 6.1795383e-08, 0.761034846, -7.49834896e-08, 0.648711026)).Magnitude <= 10
                wait(1)
                repeat
                    TP(CFrame.new(-13336.917, 485.744751, -6983.9502, 0.889054537, -8.44348449e-08, -0.457801312,
                        6.7040304e-08, 1, -5.42426477e-08, 0.457801312, 1.7533532e-08, 0.889054537))
                    wait()
                until not getgenv().Config["Auto Holy Torch"] or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(-13336.917, 485.744751, -6983.9502, 0.889054537, -8.44348449e-08, -0.457801312, 6.7040304e-08, 1, -5.42426477e-08, 0.457801312, 1.7533532e-08, 0.889054537)).Magnitude <= 10
                wait(1)
                repeat
                    TP(CFrame.new(-13486.9111, 332.608368, -7924.9502, -0.974770486, 5.87527749e-10, 0.22320962,
                        6.13812445e-10, 1, 4.83782805e-11, -0.22320962, 1.84166557e-10, -0.974770486))
                    wait()
                until not getgenv().Config["Auto Holy Torch"] or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(-13486.9111, 332.608368, -7924.9502, -0.974770486, 5.87527749e-10, 0.22320962, 6.13812445e-10, 1, 4.83782805e-11, -0.22320962, 1.84166557e-10, -0.974770486)).Magnitude <= 10
                wait(1)
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Quest Yama"] then
            pcall(function()
                if GetMaterial("Alucard Fragment") == 0 then
                    Auto_Quest_Yama_1 = true;
                    Auto_Quest_Yama_2 = false;
                    Auto_Quest_Yama_3 = false;
                    Auto_Quest_Tushita_1 = false;
                    Auto_Quest_Tushita_2 = false;
                    Auto_Quest_Tushita_3 = false;
                    (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Evil");
                    (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial",
                        "Evil");
                elseif GetMaterial("Alucard Fragment") == 1 then
                    Auto_Quest_Yama_1 = false;
                    Auto_Quest_Yama_2 = true;
                    Auto_Quest_Yama_3 = false;
                    Auto_Quest_Tushita_1 = false;
                    Auto_Quest_Tushita_2 = false;
                    Auto_Quest_Tushita_3 = false;
                    (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Evil");
                    (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial",
                        "Evil");
                elseif GetMaterial("Alucard Fragment") == 2 then
                    Auto_Quest_Yama_1 = false;
                    Auto_Quest_Yama_2 = false;
                    Auto_Quest_Yama_3 = true;
                    Auto_Quest_Tushita_1 = false;
                    Auto_Quest_Tushita_2 = false;
                    Auto_Quest_Tushita_3 = false;
                    (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Evil");
                    (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial",
                        "Evil");
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if Auto_Quest_Yama_1 then
            pcall(function()
                if (game:GetService("Workspace")).Enemies:FindFirstChild("Mythological Pirate") then
                    for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
                        if v.Name == "Mythological Pirate" then
                            repeat
                                wait()
                                TP(v.HumanoidRootPart.CFrame * CFrame.new(0, 0, (-2)))
                            until not getgenv().Config["Auto Quest Yama"] or not Auto_Quest_Yama_1;
                            (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CDKQuest",
                                "StartTrial", "Evil");
                        end;
                    end;
                else
                    TP(CFrame.new(-13451.46484375, 543.712890625, -6961.0029296875))
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        pcall(function()
            if Auto_Quest_Yama_2 then
                for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
                    if v:FindFirstChild("HazeESP") then
                        v.HazeESP.Size = UDim2.new(50, 50, 50, 50)
                        v.HazeESP.MaxDistance = "inf"
                    end
                end
                for i, v in pairs((game:GetService("ReplicatedStorage")):GetChildren()) do
                    if v:FindFirstChild("HazeESP") then
                        v.HazeESP.Size = UDim2.new(50, 50, 50, 50)
                        v.HazeESP.MaxDistance = "inf"
                    end
                end
            end
        end)
    end
end)
spawn(function()
    while wait() do
        pcall(function()
            for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
                if Auto_Quest_Yama_2 and v:FindFirstChild("HazeESP") and (v.HumanoidRootPart.Position - PosMonsEsp.Position).magnitude <= 300 then
                    v.HumanoidRootPart.CanCollide = false
                    v.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
                    if not v.HumanoidRootPart:FindFirstChild("BodyVelocity") then
                        local vc = Instance.new("BodyVelocity", v.HumanoidRootPart)
                        vc.MaxForce = Vector3.new(1, 1, 1) * math.huge
                        vc.Velocity = Vector3.new(0, 0, 0)
                    end
                end
            end
        end)
    end
end)
spawn(function()
    while wait() do
        if Auto_Quest_Yama_2 then
            pcall(function()
                for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
                    if v:FindFirstChild("HazeESP") then
                        repeat
                            wait()
                            if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 2000 then
                                TP(v.HumanoidRootPart.CFrame * Pos)
                            else
                                EquipWeaponSword()
                                TP(v.HumanoidRootPart.CFrame * Pos)
                                v.HumanoidRootPart.CanCollide = false
                                BringMob(v.HumanoidRootPart.CFrame) 
                            end
                        until not getgenv().Config["Auto Quest Yama"] or not Auto_Quest_Yama_2 or (not v.Parent) or v.Humanoid.Health <= 0 or (not v:FindFirstChild("HazeESP"))
                    else
                        for x, y in pairs((game:GetService("ReplicatedStorage")):GetChildren()) do
                            if y:FindFirstChild("HazeESP") then
                                if (y.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 2000 then
                                    TP(y.HumanoidRootPart.CFrameMon * Pos)
                                else
                                    TP(y.HumanoidRootPart.CFrame * Pos)
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if Auto_Quest_Yama_3 then
            pcall(function()
                if game.Players.LocalPlayer.Backpack:FindFirstChild("Hallow Essence") then
                    TP((game:GetService("Workspace")).Map["Haunted Castle"].Summoner.Detection.CFrame)
                elseif (game:GetService("Workspace")).Map:FindFirstChild("HellDimension") then
                    repeat
                        wait()
                        if (game:GetService("Workspace")).Enemies:FindFirstChild("Cursed Skeleton [Lv. 2200]") or (game:GetService("Workspace")).Enemies:FindFirstChild("Cursed Skeleton [Lv. 2200] [Boss]") or (game:GetService("Workspace")).Enemies:FindFirstChild("Hell's Messenger [Lv. 2200] [Boss]") then
                            for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
                                if v.Name == "Cursed Skeleton" or v.Name == "Cursed Skeleton" or v.Name == "Hell's Messenger" then
                                    if v.Humanoid.Health > 0 then
                                        repeat
                                            wait()
                                            EquipWeaponSword()
                                            TP(v.HumanoidRootPart.CFrame * Pos)
                                            BringMob(v.HumanoidRootPart.CFrame) 
                                            v.HumanoidRootPart.CanCollide = false
                                        until v.Humanoid.Health <= 0 or (not v.Parent) or not Auto_Quest_Yama_3
                                    end
                                end
                            end
                        else
                            wait(5)
                            TP((game:GetService("Workspace")).Map.HellDimension.Torch1.CFrame);
                            wait(1.5);
                            (game:GetService("VirtualInputManager")):SendKeyEvent(true, "E", false, game);
                            wait(1.5);
                            TP((game:GetService("Workspace")).Map.HellDimension.Torch2.CFrame);
                            wait(1.5);
                            (game:GetService("VirtualInputManager")):SendKeyEvent(true, "E", false, game);
                            wait(1.5);
                            TP((game:GetService("Workspace")).Map.HellDimension.Torch3.CFrame);
                            wait(1.5);
                            (game:GetService("VirtualInputManager")):SendKeyEvent(true, "E", false, game);
                            wait(1.5);
                            TP((game:GetService("Workspace")).Map.HellDimension.Exit.CFrame);
                        end
                    until Auto_Quest_Yama_3 == false or GetMaterial("Alucard Fragment") == 3
                elseif (game:GetService("Workspace")).Enemies:FindFirstChild("Soul Reaper") or game.ReplicatedStorage:FindFirstChild("Soul Reaper [Lv. 2100] [Raid Boss]") then
                    if (game:GetService("Workspace")).Enemies:FindFirstChild("Soul Reaper") then
                        for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
                            if v.Name == "Soul Reaper" then
                                if v.Humanoid.Health > 0 then
                                    repeat
                                        wait()
                                        TP(v.HumanoidRootPart.CFrame * Pos)
                                    until not getgenv().Config["Auto Quest Yama"] or not Auto_Quest_Yama_3 or (game:GetService("Workspace")).Map:FindFirstChild("HellDimension")
                                end
                            end
                        end
                    else
                        TP(CFrame.new(-9570.033203125, 315.9346923828125, 6726.89306640625))
                    end
                else
                    (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("Bones", "Buy", 1, 1)
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Quest Tushita"] then
            pcall(function()
                if GetMaterial("Alucard Fragment") == 3 then
                    Auto_Quest_Yama_1 = false;
                    Auto_Quest_Yama_2 = false;
                    Auto_Quest_Yama_3 = false;
                    Auto_Quest_Tushita_1 = true;
                    Auto_Quest_Tushita_2 = false;
                    Auto_Quest_Tushita_3 = false;
                    (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Good");
                    (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial",
                        "Good");
                elseif GetMaterial("Alucard Fragment") == 4 then
                    Auto_Quest_Yama_1 = false;
                    Auto_Quest_Yama_2 = false;
                    Auto_Quest_Yama_3 = false;
                    Auto_Quest_Tushita_1 = false;
                    Auto_Quest_Tushita_2 = true;
                    Auto_Quest_Tushita_3 = false;
                    (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Good");
                    (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial",
                        "Good");
                elseif GetMaterial("Alucard Fragment") == 5 then
                    Auto_Quest_Yama_1 = false;
                    Auto_Quest_Yama_2 = false;
                    Auto_Quest_Yama_3 = false;
                    Auto_Quest_Tushita_1 = false;
                    Auto_Quest_Tushita_2 = false;
                    Auto_Quest_Tushita_3 = true;
                    (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Good");
                    (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial",
                        "Good");
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if Auto_Quest_Tushita_1 then
            TP(CFrame.new(-9546.990234375, 21.139892578125, 4686.1142578125))
            wait(5)
            TP(CFrame.new(-6120.0576171875, 16.455780029296875, -2250.697265625))
            wait(5)
            TP(CFrame.new(-9533.2392578125, 7.254445552825928, -8372.69921875))
        end
    end
end)
spawn(function()
    while wait() do
        if Auto_Quest_Tushita_2 then
            pcall(function()
                if ((CFrame.new((-5539.3115234375), 313.800537109375, (-2972.372314453125))).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 500 then
                    for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
                        if Auto_Quest_Tushita_2 and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                            if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 2000 then
                                repeat
                                    wait()
                                    EquipWeaponSword()
                                    TP(v.HumanoidRootPart.CFrame * Pos)
                                    v.HumanoidRootPart.CanCollide = false
                                    BringMob(v.HumanoidRootPart.CFrame) 
                                until v.Humanoid.Health <= 0 or (not v.Parent) or not Auto_Quest_Tushita_2
                            end
                        end
                    end
                else
                    TP(CFrame.new(-5545.1240234375, 313.800537109375, -2976.616455078125))
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if Auto_Quest_Tushita_3 then
            pcall(function()
                if (game:GetService("Workspace")).Enemies:FindFirstChild("Cake Queen") or game.ReplicatedStorage:FindFirstChild("Cake Queen [Lv. 2175] [Boss]") then
                    if (game:GetService("Workspace")).Enemies:FindFirstChild("Cake Queen") then
                        for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
                            if v.Name == "Cake Queen" then
                                if v.Humanoid.Health > 0 then
                                    repeat
                                        wait()
                                        EquipWeaponSword()
                                        TP(v.HumanoidRootPart.CFrame * Pos)
                                        v.HumanoidRootPart.CanCollide = false
                                        BringMob(v.HumanoidRootPart.CFrame) 
                                    until not getgenv().Config["Auto Quest Tushita"] or not Auto_Quest_Tushita_3 or (game:GetService("Workspace")).Map:FindFirstChild("HeavenlyDimension")
                                end
                            end
                        end
                    else
                        TP(CFrame.new(-709.3132934570312, 381.6005859375, -11011.396484375))
                    end
                elseif (game:GetService("Workspace")).Map:FindFirstChild("HeavenlyDimension") then
                    repeat
                        wait()
                        if (game:GetService("Workspace")).Enemies:FindFirstChild("Cursed Skeleton [Lv. 2200]") or (game:GetService("Workspace")).Enemies:FindFirstChild("Cursed Skeleton [Lv. 2200] [Boss]") or (game:GetService("Workspace")).Enemies:FindFirstChild("Heaven's Guardian [Lv. 2200] [Boss]") then
                            for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
                                if v.Name == "Cursed Skeleton" or v.Name == "Cursed Skeleton" or v.Name == "Heaven's Guardian" then
                                    if v.Humanoid.Health > 0 then
                                        repeat
                                            wait()
                                            EquipWeaponSword()
                                            TP(v.HumanoidRootPart.CFrame * Pos)
                                            v.HumanoidRootPart.CanCollide = false
                                            BringMob(v.HumanoidRootPart.CFrame) 
                                        until v.Humanoid.Health <= 0 or (not v.Parent) or not Auto_Quest_Tushita_3
                                    end
                                end
                            end
                        else
                            wait(5)
                            TP((game:GetService("Workspace")).Map.HeavenlyDimension.Torch1.CFrame);
                            wait(1.5);
                            (game:GetService("VirtualInputManager")):SendKeyEvent(true, "E", false, game);
                            wait(1.5);
                            TP((game:GetService("Workspace")).Map.HeavenlyDimension.Torch2.CFrame);
                            wait(1.5);
                            (game:GetService("VirtualInputManager")):SendKeyEvent(true, "E", false, game);
                            wait(1.5);
                            TP((game:GetService("Workspace")).Map.HeavenlyDimension.Torch3.CFrame);
                            wait(1.5);
                            (game:GetService("VirtualInputManager")):SendKeyEvent(true, "E", false, game);
                            wait(1.5);
                            TP((game:GetService("Workspace")).Map.HeavenlyDimension.Exit.CFrame);
                        end
                    until not getgenv().Config["Auto Quest Tushita"] or (not Auto_Quest_Tushita_3) or GetMaterial("Alucard Fragment") == 6
                end
            end)
        end
    end
end)
local getcdk = CFrame.new(-12359.79, 603.354004, -6552.86719, -0.00293002231, -3.04624841e-08, -0.999995708, 4.2381803e-08, 1, -3.05867971e-08, 0.999995708, -4.2471239e-08, -0.00293002231)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Get Cursed Dual Katana"] and L_7449423635_ then
            pcall(function()
                enemies = workspace.Enemies
                if enemies:FindFirstChild("Cursed Dual Katana") then
                    for _, v in pairs(enemies:GetChildren()) do
                        if v.Name == "Cursed Dual Katana" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                            humanoid = v.Humanoid
                            rootPart = v.HumanoidRootPart
                            if humanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G['Select Weapon'])
                                    rootPart.CanCollide = false
                                    humanoid.WalkSpeed = 0
                                    TP(rootPart.CFrame * Pos)
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                until not getgenv().Config["Auto Get Cursed Dual Katana"] or not v.Parent or humanoid.Health <= 0
                            end
                        end
                    end
                else
                    playerPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                    if BypassTP then
                        if (playerPos - getcdk.Position).Magnitude > 1500 then
                            BTP(getcdk)
                        else
                            TP(getcdk)
                        end
                    else
                        TP(getcdk)
                    end
                    TP(getcdk)
                end
            end)
        end
    end
end)
spawn(function()
    pcall(function()
        while task.wait() do
            if not getgenv().Config["Auto Bartilo Quest"] then break end
            local player = game:GetService("Players").LocalPlayer
            local replicatedStorage = game:GetService("ReplicatedStorage")
            local commF = replicatedStorage.Remotes.CommF_
            local questProgress = commF:InvokeServer("BartiloQuestProgress", "Bartilo")
            if player.Data.Level.Value >= 800 then
                if questProgress == 0 then
                    local questGui = player.PlayerGui.Main.Quest
                    local questTitle = questGui.Container.QuestTitle.Title.Text
                    if questGui.Visible and questTitle:find("Swan Pirates") and questTitle:find("50") then
                        local enemies = workspace.Enemies
                        if enemies:FindFirstChild("Swan Pirate") then
                            for _, v in pairs(enemies:GetChildren()) do
                                if v.Name == "Swan Pirate" then
                                    repeat
                                        task.wait()
                                        sethiddenproperty(player, "SimulationRadius", math.huge)
                                        EquipWeapon(_G['Select Weapon'])
                                        AutoHaki()
                                        v.HumanoidRootPart.Transparency = 1
                                        v.HumanoidRootPart.CanCollide = false
                                        TP(v.HumanoidRootPart.CFrame * Pos)
                                    until not v.Parent or v.Humanoid.Health <= 0 or not getgenv().Config["Auto Bartilo Quest"] or not questGui.Visible
                                end
                            end
                        else
                            repeat
                                TP(CFrame.new(932.624, 156.106, 1180.274))
                                task.wait()
                            until not getgenv().Config["Auto Bartilo Quest"] or (player.Character.HumanoidRootPart.Position - Vector3.new(932.624, 156.106, 1180.274)).Magnitude <= 10
                        end
                    else
                        repeat
                            TP(CFrame.new(-456.289, 73.020, 299.895))
                            task.wait()
                        until not getgenv().Config["Auto Bartilo Quest"] or (player.Character.HumanoidRootPart.Position - Vector3.new(-456.289, 73.020, 299.895)).Magnitude <= 10
                        task.wait(1.1)
                        commF:InvokeServer("StartQuest", "BartiloQuest", 1)
                    end
                elseif questProgress == 1 then
                    TP(CFrame.new(2068, 449, 782))
                    local enemies = workspace.Enemies
                    if enemies:FindFirstChild("Jeremy") then
                        for _, v in pairs(enemies:GetChildren()) do
                            if v.Name == "Jeremy" then
                                repeat
                                    task.wait()
                                    EquipWeapon(_G['Select Weapon'])
                                    AutoHaki()
                                    TP(v.HumanoidRootPart.CFrame * Pos)
                                    sethiddenproperty(player, "SimulationRadius", math.huge)
                                until not v.Parent or v.Humanoid.Health <= 0 or not getgenv().Config["Auto Bartilo Quest"]
                            end
                        end
                    end
                elseif questProgress == 2 then
                    local positions = {
                        Vector3.new(-1850.493, 13.178, 1750.896),
                        Vector3.new(-1858.873, 19.377, 1712.018),
                        Vector3.new(-1803.943, 16.578, 1750.896),
                        Vector3.new(-1858.558, 16.860, 1724.795),
                        Vector3.new(-1869.542, 15.987, 1681.006),
                        Vector3.new(-1800.097, 16.497, 1684.523),
                        Vector3.new(-1819.263, 14.795, 1717.906),
                        Vector3.new(-1813.518, 14.860, 1724.795)
                    }
                    for _, pos in ipairs(positions) do
                        repeat
                            TP(CFrame.new(pos))
                            task.wait()
                        until not getgenv().Config["Auto Bartilo Quest"] or (player.Character.HumanoidRootPart.Position - pos).Magnitude <= 10
                        task.wait(1)
                    end
                end
            end
        end
    end)
end)
spawn(function()
    pcall(function()
        while wait() do
            if getgenv().Config["Auto Musketeer Hat"] then
                if game:GetService("Players").LocalPlayer.Data.Level.Value >= 1800 and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress").KilledBandits == false then
                    if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Forest Pirate") and string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "50") and game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                        if workspace.Enemies:FindFirstChild("Forest Pirate") then
                            for i, v in pairs(workspace.Enemies:GetChildren()) do
                                if v.Name == "Forest Pirate" then
                                    repeat
                                        task.wait()
                                        pcall(function()
                                            EquipWeapon(_G['Select Weapon'])
                                            AutoHaki()
                                            TP(v.HumanoidRootPart.CFrame * Pos)
                                            BringMob(v.HumanoidRootPart.CFrame) 
                                            v.HumanoidRootPart.CanCollide = false
                                        end)
                                    until getgenv().Config["Auto Musketeer Hat"] == false or not v.Parent or v.Humanoid.Health <= 0 or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                end
                            end
                        else
                            TP(CFrame.new(-13206.452148438, 425.89199829102, -7964.5537109375))
                        end
                    else
                        TP(CFrame.new(-12443.8671875, 332.40396118164, -7675.4892578125))
                        if (Vector3.new(-12443.8671875, 332.40396118164, -7675.4892578125) - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 30 then
                            wait(1.5)
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest",
                                "CitizenQuest", 1)
                        end
                    end
                elseif game:GetService("Players").LocalPlayer.Data.Level.Value >= 1800 and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress").KilledBoss == false then
                    if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible and string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Captain Elephant") and game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                        if workspace.Enemies:FindFirstChild("Captain Elephant") then
                            for i, v in pairs(workspace.workspace.Enemies:GetChildren()) do
                                if v.Name == "Captain Elephant" then
                                    repeat
                                        task.wait()
                                        pcall(function()
                                            EquipWeapon(_G['Select Weapon'])
                                            AutoHaki()
                                            TP(v.HumanoidRootPart.CFrame * Pos)
                                            BringMob(v.HumanoidRootPart.CFrame) 
                                            v.HumanoidRootPart.CanCollide = false
                                            sethiddenproperty(game:GetService("Players").LocalPlayer,
                                                "SimulationRadius", math.huge)
                                        end)
                                    until getgenv().Config["Auto Musketeer Hat"] == false or v.Humanoid.Health <= 0 or not v.Parent or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                end
                            end
                        else
                            TP(CFrame.new(-13374.889648438, 421.27752685547, -8225.208984375))
                        end
                    else
                        TP(CFrame.new(-12443.8671875, 332.40396118164, -7675.4892578125))
                        if (CFrame.new(-12443.8671875, 332.40396118164, -7675.4892578125).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 4 then
                            wait(1.5)
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress",
                                "Citizen")
                        end
                    end
                elseif game:GetService("Players").LocalPlayer.Data.Level.Value >= 1800 and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen") == 2 then
                    TP(CFrame.new(-12512.138671875, 340.39279174805, -9872.8203125))
                end
            end
        end
    end)
end)
spawn(function()
    pcall(function()
        while wait() do
            if getgenv().Config["Auto Rainbow Haki"] then
                if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                    TP(CFrame.new(-11892.0703125, 930.57672119141, -8760.1591796875))
                    if (Vector3.new(-11892.0703125, 930.57672119141, -8760.1591796875) - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 30 then
                        wait(1.5)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("HornedMan", "Bet")
                    end
                elseif game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true and string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Stone") then
                    if workspace.Enemies:FindFirstChild("Stone") then
                        for i, v in pairs(workspace.Enemies:GetChildren()) do
                            if v.Name == "Stone" then
                                repeat
                                    task.wait()
                                    EquipWeapon(_G['Select Weapon'])
                                    TP(v.HumanoidRootPart.CFrame * Pos)
                                    v.HumanoidRootPart.CanCollide = false
                                    BringMob(v.HumanoidRootPart.CFrame) 
                                    sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius",
                                        math.huge)
                                until getgenv().Config["Auto Rainbow Haki"] == false or v.Humanoid.Health <= 0 or not v.Parent or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
                            end
                        end
                    else
                        TP(CFrame.new(-1086.11621, 38.8425903, 6768.71436, 0.0231462717, -0.592676699, 0.805107772,
                            2.03251839e-05, 0.805323839, 0.592835128, -0.999732077, -0.0137055516, 0.0186523199))
                    end
                elseif game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true and string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Island Empress") then
                    if workspace.Enemies:FindFirstChild("Island Empress") then
                        for i, v in pairs(workspace.Enemies:GetChildren()) do
                            if v.Name == "Island Empress" then
                                repeat
                                    task.wait()
                                    EquipWeapon(_G['Select Weapon'])
                                    TP(v.HumanoidRootPart.CFrame * Pos)
                                    v.HumanoidRootPart.CanCollide = false
                                    BringMob(v.HumanoidRootPart.CFrame) 
                                    sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius",
                                        math.huge)
                                until getgenv().Config["Auto Rainbow Haki"] == false or v.Humanoid.Health <= 0 or not v.Parent or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
                            end
                        end
                    else
                        TP(CFrame.new(5713.98877, 601.922974, 202.751251, -0.101080291, -0, -0.994878292, -0, 1, -0,
                            0.994878292, 0, -0.101080291))
                    end
                elseif string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Kilo Admiral") then
                    if workspace.Enemies:FindFirstChild("Kilo Admiral") then
                        for i, v in pairs(workspace.Enemies:GetChildren()) do
                            if v.Name == "Kilo Admiral" then
                                repeat
                                    task.wait()
                                    EquipWeapon(_G['Select Weapon'])
                                    TP(v.HumanoidRootPart.CFrame * Pos)
                                    v.HumanoidRootPart.CanCollide = false
                                    BringMob(v.HumanoidRootPart.CFrame) 
                                    sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius",
                                        math.huge)
                                until getgenv().Config["Auto Rainbow Haki"] == false or v.Humanoid.Health <= 0 or not v.Parent or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
                            end
                        end
                    else
                        TP(CFrame.new(2877.61743, 423.558685, -7207.31006, -0.989591599, -0, -0.143904909, -0,
                            1.00000012, -0, 0.143904924, 0, -0.989591479))
                    end
                elseif string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Captain Elephant") then
                    if workspace.Enemies:FindFirstChild("Captain Elephant") then
                        for i, v in pairs(workspace.Enemies:GetChildren()) do
                            if v.Name == "Captain Elephant" then
                                repeat
                                    task.wait()
                                    EquipWeapon(_G['Select Weapon'])
                                    TP(v.HumanoidRootPart.CFrame * Pos)
                                    v.HumanoidRootPart.CanCollide = false
                                    BringMob(v.HumanoidRootPart.CFrame) 
                                    sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius",
                                        math.huge)
                                until getgenv().Config["Auto Rainbow Haki"] == false or v.Humanoid.Health <= 0 or not v.Parent or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
                            end
                        end
                    else
                        TP(CFrame.new(-13485.0283, 331.709259, -8012.4873, 0.714521289, 7.98849911e-08, 0.69961375,
                            -1.02065748e-07, 1, -9.94383065e-09, -0.69961375, -6.43015241e-08, 0.714521289))
                    end
                elseif string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Beautiful Pirate") then
                    if workspace.Enemies:FindFirstChild("Beautiful Pirate") then
                        for i, v in pairs(workspace.Enemies:GetChildren()) do
                            if v.Name == "Beautiful Pirate" then
                                repeat
                                    task.wait()
                                    EquipWeapon(_G['Select Weapon'])
                                    TP(v.HumanoidRootPart.CFrame * Pos)
                                    v.HumanoidRootPart.CanCollide = false
                                    BringMob(v.HumanoidRootPart.CFrame) 
                                    sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius",
                                        math.huge)
                                until getgenv().Config["Auto Rainbow Haki"] == false or v.Humanoid.Health <= 0 or not v.Parent or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
                            end
                        end
                    else
                        TP(CFrame.new(5312.3598632813, 20.141201019287, -10.158538818359))
                    end
                else
                    TP(CFrame.new(-11892.0703125, 930.57672119141, -8760.1591796875))
                    if (Vector3.new(-11892.0703125, 930.57672119141, -8760.1591796875) - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 30 then
                        wait(1.5)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("HornedMan", "Bet")
                    end
                end
            end
        end
    end)
end)
function SaveCFrame(cf)
    return {X = cf.X, Y = cf.Y, Z = cf.Z}
end
function LoadCFrame(t)
    if typeof(t) == "table" and t.X and t.Y and t.Z then
        return CFrame.new(t.X, t.Y, t.Z)
    end
    return nil
end
spawn(function()
    while wait() do
        if Config["Auto Fishing"] then
            pcall(function()
                local pos = LoadCFrame(Config["Position Fishing"])
                if pos then
                    TP(pos)
                end
                local args = {
                    "StartCasting"
                }
                game:GetService("ReplicatedStorage"):WaitForChild("FishReplicated"):WaitForChild("FishingRequest"):InvokeServer(unpack(args))
                local args = {
                    "CastLineAtLocation",
                    game.Players.LocalPlayer.Character.HumanoidRootPart.Position,
                    100,
                    true
                }
                game:GetService("ReplicatedStorage"):WaitForChild("FishReplicated"):WaitForChild("FishingRequest"):InvokeServer(unpack(args))
                local args = {
                    "Catching",
                    true,
                    {
                        fastBite = true
                    }
                }
                game:GetService("ReplicatedStorage"):WaitForChild("FishReplicated"):WaitForChild("FishingRequest"):InvokeServer(unpack(args))
                local args = {
                    "Catch",
                    1,
                    0,
                    1
                }
                game:GetService("ReplicatedStorage"):WaitForChild("FishReplicated"):WaitForChild("FishingRequest"):InvokeServer(unpack(args))
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Factory"] and L_4442272183_ then
            pcall(function()
                TP(CFrame.new(432, 211, -431) * CFrame.new(0, -20, 0))
                EquipWeapon(_G['Select Weapon'])
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Castle Pirate Raid"] and L_7449423635_ then
            pcall(function()
                TP(CFrame.new(-5496.17432, 313.768921, -2841.53027, 0.924894512, 7.37058015e-09, 0.380223751,
                    3.5881019e-08, 1, -1.06665446e-07, -0.380223751, 1.12297109e-07, 0.924894512))
                if (CFrame.new(-5539.3115234375, 313.800537109375, -2972.372314453125).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= (500) then
                    for v25, v26 in pairs(workspace.Enemies:GetChildren()) do
                        if getgenv().Config["Auto Castle Pirate Raid"] and v26:FindFirstChild("HumanoidRootPart") and v26:FindFirstChild("Humanoid") and v26.Humanoid.Health > (0) then
                            if (v26.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 2000 then
                                repeat
                                    wait()
                                    AutoHaki()
                                    EquipWeapon(_G['Select Weapon'])
                                    TP(v26.HumanoidRootPart.CFrame * Pos)
                                    BringMob(v26.HumanoidRootPart.CFrame) 
                                until v26.Humanoid.Health <= 0 or not v26.Parent or not getgenv().Config["Auto Castle Pirate Raid"]
                            end
                        end
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        pcall(function()
            if getgenv().Config["Auto Farm Sea Events"] then
                if not workspace.Enemies:FindFirstChild("Shark") or not workspace.Enemies:FindFirstChild("Terrorshark") or not workspace.Enemies:FindFirstChild("Piranha") or not workspace.Enemies:FindFirstChild("Fish Crew Member") or not CheckPirateBoat() then
                    if not game:GetService("Workspace").Boats:FindFirstChild("PirateGrandBrigade") then
                        buyb = TP(CFrame.new(-16192.2539, 12.3828964, 1738.85999, -0.997757435, 4.43451498e-08,
                            -0.0669331998, 5.01932291e-08, 1, -8.56902034e-08, 0.0669331998, -8.88576324e-08,
                            -0.997757435))
                        if (CFrame.new(-16192.2539, 12.3828964, 1738.85999, -0.997757435, 4.43451498e-08, -0.0669331998, 5.01932291e-08, 1, -8.56902034e-08, 0.0669331998, -8.88576324e-08, -0.997757435).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 10 then
                            if buyb then buyb:Stop() end
                            local args = {
                                [1] = "BuyBoat",
                                [2] = "PirateGrandBrigade"
                            }
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                        end
                    elseif game:GetService("Workspace").Boats:FindFirstChild("PirateGrandBrigade") then
                        if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit == false then
                            TPP(game:GetService("Workspace").Boats.PirateGrandBrigade.VehicleSeat.CFrame *
                                CFrame.new(0, 1, 0))
                        else
                            for i, v in pairs(game:GetService("Workspace").Boats:GetChildren()) do
                                if v.Name == "PirateGrandBrigade" then
                                    repeat
                                        wait()
                                        if _G['Select Zone'] == "Sea 1 [Low]" then
                                            PlayBoatsTween(CFrame.new(-11887.5166, 30.0003834, 16193.2559,
                                                -0.96912086, -0.00206306507, -0.246577561, -0.00212879549,
                                                0.999997735, -6.44699627e-10, 0.24657701, 0.000524912612,
                                                -0.969123065))
                                        elseif _G['Select Zone'] == "Sea 2 [Medium]" then
                                            PlayBoatsTween(CFrame.new(-11000.5625, -0.306667894, 21056.0312,
                                                -0.796931446, -6.017189E-8, -0.604069769, -7.449085E-8, 1,
                                                -1.3372562E-9, 0.604069769, 4.3931966E-8, -0.796931446))
                                        elseif _G['Select Zone'] == "Sea 3 [High]" then
                                            PlayBoatsTween(CFrame.new(-9995.36719, -0.306667894, 24740.7656,
                                                -0.970631301, 1.5574746E-9, -0.240571901, 3.9648890000000003E-9, 1,
                                                -9.523019E-9, 0.2405719010000098, -1.0197181E-8, -0.970631301))
                                        elseif _G['Select Zone'] == "Sea 4 [Extreme]" then
                                            PlayBoatsTween(CFrame.new(-8656.56934, -0.3066678939999292, 29984.1152,
                                                -0.737478554, -7.8071736E-8, -0.675370574, -4.139847E-8, 1,
                                                -7.0392844000000006E-8, 0.675370574, -2.3953902E-8,
                                                -0.7374785539999493))
                                        elseif _G['Select Zone'] == "Sea 5 [Crazy]" then
                                            PlayBoatsTween(CFrame.new(-8627.31934, -0.306667835, 34267.3516,
                                                -0.9371762279999984, -4.476127E-12, -0.34885627,
                                                -2.155638867407106E-8, 1, 5.7896813e-8, 0.34885627, 6.17796e-8,
                                                -0.937176228))
                                        elseif _G['Select Zone'] == "Sea 6 [???]" then
                                            PlayBoatsTween(CFrame.new(-2551.66382, -0.306667715, 75050.80469999998,
                                                -0.909505963, -3.7095425E-8, -0.415690839, 4.8213584e-9, 1,
                                                -9.978685E-8, 0.41569083900003534, -9.276093E-8, -0.9095059629999014))
                                        elseif _G['Select Zone'] == "Beyond the Sea" then
                                            PlayBoatsTween(CFrame.new(-99999999, 10.964323997497559,
                                                -324.4842224121094))
                                        end
                                    until workspace.Enemies:FindFirstChild("Shark") or workspace.Enemies:FindFirstChild("Terrorshark") or workspace.Enemies:FindFirstChild("Piranha") or workspace.Enemies:FindFirstChild("Fish Crew Member") or CheckPirateBoat() or getgenv().Config["Auto Farm Sea Events"] == false or _G.StopTweenBoat == false
                                end
                            end
                        end
                    end
                end
            end
        end)
    end
end)
spawn(function()
    pcall(function()
        while wait() do
            if getgenv().Config["Auto Farm Sea Events"] and getgenv().Config["Auto Kill Piranha"] then
                if workspace.Enemies:FindFirstChild("Piranha") then
                    game.Players.LocalPlayer.Character.Humanoid.Sit = false
                    StopBoatsTween()
                else
                    _G.StopTweenBoat = false
                end
            end
        end
    end)
end)
spawn(function()
    pcall(function()
        while wait() do
            if getgenv().Config["Auto Farm Sea Events"] and getgenv().Config["Auto Kill Shark"] then
                if workspace.Enemies:FindFirstChild("Shark") then
                    game.Players.LocalPlayer.Character.Humanoid.Sit = false
                    StopBoatsTween()
                else
                    _G.StopTweenBoat = false
                end
            end
        end
    end)
end)
spawn(function()
    pcall(function()
        while wait() do
            if getgenv().Config["Auto Farm Sea Events"] and getgenv().Config["Auto Kill Terrorshark"] then
                if workspace.Enemies:FindFirstChild("Terrorshark") then
                    game.Players.LocalPlayer.Character.Humanoid.Sit = false
                    StopBoatsTween()
                else
                    _G.StopTweenBoat = false
                end
            end
        end
    end)
end)
spawn(function()
    pcall(function()
        while wait() do
            if getgenv().Config["Auto Farm Sea Events"] and getgenv().Config["Auto Kill Fish Crew Member"] then
                if workspace.Enemies:FindFirstChild("Fish Crew Member") then
                    game.Players.LocalPlayer.Character.Humanoid.Sit = false
                    StopBoatsTween()
                else
                    _G.StopTweenBoat = false
                end
            end
        end
    end)
end)
spawn(function()
    pcall(function()
        while wait() do
            if getgenv().Config["Auto Farm Sea Events"] and getgenv().Config["Auto Kill Sea Beasts"] then
                if game:GetService("Workspace").SeaBeasts:FindFirstChild("SeaBeast1") or game:GetService("Workspace").SeaBeasts:FindFirstChild("SeaBeast2") or game:GetService("Workspace").SeaBeasts:FindFirstChild("SeaBeast3") then
                    game.Players.LocalPlayer.Character.Humanoid.Sit = false
                    StopBoatsTween()
                else
                    _G.StopTweenBoat = false
                end
            end
        end
    end)
end)
spawn(function()
    pcall(function()
        while wait() do
            if getgenv().Config["Auto Farm Sea Events"] and getgenv().Config["Auto Kill Raid Ship"] then
                if CheckPirateBoat() then
                    game.Players.LocalPlayer.Character.Humanoid.Sit = false
                    StopBoatsTween()
                else
                    _G.StopTweenBoat = false
                end
            end
        end
    end)
end)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Farm Sea Events"] and getgenv().Config["Auto Kill Piranha"] and L_7449423635_ then
            pcall(function()
                local enemies = workspace.Enemies
                if enemies:FindFirstChild("Piranha") then
                    for _, v in pairs(enemies:GetChildren()) do
                        if v.Name == "Piranha" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                            local humanoid = v.Humanoid
                            local rootPart = v.HumanoidRootPart
                            if humanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G['Select Weapon'])
                                    rootPart.CanCollide = false
                                    humanoid.WalkSpeed = 0
                                    BringMob(rootPart.CFrame) 
                                    TP(rootPart.CFrame * Pos)
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                until not getgenv().Config["Auto Farm Sea Events"] or not v.Parent or humanoid.Health <= 0
                            end
                        end
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Farm Sea Events"] and getgenv().Config["Auto Kill Shark"] and L_7449423635_ then
            pcall(function()
                local enemies = workspace.Enemies
                for _, v in pairs(enemies:GetChildren()) do
                    if v.Name == "Shark" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                        local humanoid = v.Humanoid
                        local rootPart = v.HumanoidRootPart
                        if humanoid.Health > 0 then
                            repeat
                                task.wait()
                                AutoHaki()
                                EquipWeapon(_G['Select Weapon'])
                                rootPart.CanCollide = false
                                humanoid.WalkSpeed = 0
                                BringMob(rootPart.CFrame) 
                                TP(rootPart.CFrame * Pos)
                                sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                            until not getgenv().Config["Auto Farm Sea Events"] or not v.Parent or humanoid.Health <= 0
                        end
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Farm Sea Events"] and getgenv().Config["Auto Kill Terrorshark"] and L_7449423635_ then
            pcall(function()
                local enemies = workspace.Enemies
                local player = game.Players.LocalPlayer
                local character = player.Character
                local humanoid = character and character:FindFirstChild("Humanoid")
                if humanoid and humanoid.Health >= 8500 then
                    for _, v in pairs(enemies:GetChildren()) do
                        if v.Name == "Terrorshark" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                            local enemyHumanoid = v.Humanoid
                            local rootPart = v.HumanoidRootPart
                            if enemyHumanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G['Select Weapon'])
                                    rootPart.CanCollide = false
                                    enemyHumanoid.WalkSpeed = 0
                                    if humanoid.Health <= 4000 then
                                        BringMob(rootPart.CFrame) 
                                        TP(rootPart.CFrame * CFrame.new(0, 180, 0))
                                    elseif humanoid.Health >= 8000 then
                                        BringMob(rootPart.CFrame) 
                                        TP(rootPart.CFrame * Pos)
                                    end
                                    sethiddenproperty(player, "SimulationRadius", math.huge)
                                until not getgenv().Config["Auto Farm Sea Events"] or not v.Parent or enemyHumanoid.Health <= 0
                            end
                        end
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Farm Sea Events"] and getgenv().Config["Auto Kill Fish Crew Member"] and L_7449423635_ then
            pcall(function()
                local enemies = workspace.Enemies
                for _, v in pairs(enemies:GetChildren()) do
                    if v.Name == "Fish Crew Member" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                        local humanoid = v.Humanoid
                        local rootPart = v.HumanoidRootPart
                        if humanoid.Health > 0 then
                            repeat
                                task.wait()
                                AutoHaki()
                                EquipWeapon(_G['Select Weapon'])
                                rootPart.CanCollide = false
                                humanoid.WalkSpeed = 0
                                BringMob(rootPart.CFrame) 
                                TP(rootPart.CFrame * Pos)
                                sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                            until not getgenv().Config["Auto Farm Sea Events"] or not v.Parent or humanoid.Health <= 0
                        end
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Farm Sea Events"] and getgenv().Config["Auto Kill Sea Beasts"] and L_7449423635_ then
            pcall(function()
                local enemies = game:GetService("Workspace").SeaBeasts
                local player = game.Players.LocalPlayer
                local character = player.Character
                local humanoid = character and character:FindFirstChild("Humanoid")
                for _, v in pairs(enemies:GetChildren()) do
                    if v.Name == "SeaBeast1" or v.Name == "SeaBeast2" or v.Name == "SeaBeast3" and v:FindFirstChild("HumanoidRootPart") then
                        repeat
                            task.wait()
                            AutoHaki()
                            TP(v.HumanoidRootPart.CFrame * CFrame.new(0, 480, 0))
                            sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                        until not getgenv().Config["Auto Farm Sea Events"] or not v.Parent
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Farm Sea Events"] and getgenv().Config["Auto Kill Sea Beasts"] and L_7449423635_ then
            pcall(function()
                local enemies = game:GetService("Workspace").SeaBeasts
                local player = game.Players.LocalPlayer
                local character = player.Character
                local humanoid = character and character:FindFirstChild("Humanoid")
                for _, v in pairs(enemies:GetChildren()) do
                    if v.Name == "SeaBeast1" or v.Name == "SeaBeast2" or v.Name == "SeaBeast3" and v:FindFirstChild("HumanoidRootPart") then
                    if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumnaoidRootPart.Position).Magnitude <= 575 then
                        game:service("VirtualInputManager"):SendKeyEvent(true, "One", false, game)
                        game:service("VirtualInputManager"):SendKeyEvent(false, "One", false, game)
                        if _G['Skill Z'] then useSkill("Z") end
                        if _G['Skill X'] then useSkill("X") end
                        if _G['Skill C'] then useSkill("C") end
                        if _G['Skill V'] then useSkill("V") end
                        if _G['Skill F'] then useSkill("F") end
                        game:service("VirtualInputManager"):SendKeyEvent(true, "Two", false, game)
                        game:service("VirtualInputManager"):SendKeyEvent(false, "Two", false, game)
                        if _G['Skill Z'] then useSkill("Z") end
                        if _G['Skill X'] then useSkill("X") end
                        if _G['Skill C'] then useSkill("C") end
                        if _G['Skill V'] then useSkill("V") end
                        if _G['Skill F'] then useSkill("F") end
                        game:service("VirtualInputManager"):SendKeyEvent(true, "Three", false, game)
                        game:service("VirtualInputManager"):SendKeyEvent(false, "Three", false, game)
                        if _G['Skill Z'] then useSkill("Z") end
                        if _G['Skill X'] then useSkill("X") end
                        if _G['Skill C'] then useSkill("C") end
                        if _G['Skill V'] then useSkill("V") end
                        if _G['Skill F'] then useSkill("F") end
                        game:service("VirtualInputManager"):SendKeyEvent(true, "Four", false, game)
                        game:service("VirtualInputManager"):SendKeyEvent(false, "Four", false, game)
                        if _G['Skill Z'] then useSkill("Z") end
                        if _G['Skill X'] then useSkill("X") end
                        if _G['Skill C'] then useSkill("C") end
                        if _G['Skill V'] then useSkill("V") end
                        if _G['Skill F'] then useSkill("F") end
                    end
                end
            end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Farm Sea Events"] and getgenv().Config["Auto Kill Raid Ship"] and L_7449423635_ then
            pcall(function()
                if CheckPirateBoat() then
                    local v = CheckPirateBoat()
                    repeat
                        wait()
                        spawn(TP(v.Engine.CFrame * CFrame.new(0, -20, 0)), 1)
                        AimBotSkillPositionBoat = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, -5, 0)
                            EquipWeaponMelee()
                        if _G['Skill Z'] then useSkill("Z") end
                        if _G['Skill X'] then useSkill("X") end
                        if _G['Skill C'] then useSkill("C") end
                        if _G['Skill V'] then useSkill("V") end
                        if _G['Skill F'] then useSkill("F") end
                            EquipWeaponSword()
                        if _G['Skill Z'] then useSkill("Z") end
                        if _G['Skill X'] then useSkill("X") end
                        if _G['Skill C'] then useSkill("C") end
                        if _G['Skill V'] then useSkill("V") end
                        if _G['Skill F'] then useSkill("F") end
                            EquipWeaponGun()
                        if _G['Skill Z'] then useSkill("Z") end
                        if _G['Skill X'] then useSkill("X") end
                        if _G['Skill C'] then useSkill("C") end
                        if _G['Skill V'] then useSkill("V") end
                        if _G['Skill F'] then useSkill("F") end
                            EquipWeaponFruit()
                        if _G['Skill Z'] then useSkill("Z") end
                        if _G['Skill X'] then useSkill("X") end
                        if _G['Skill C'] then useSkill("C") end
                        if _G['Skill V'] then useSkill("V") end
                        if _G['Skill F'] then useSkill("F") end
                    until not v or not v.Parent or v.Health.Value <= 0 or not CheckPirateBoat()
                end
            end)
        end
    end
end)
local gg = getrawmetatable(game)
local old = gg.__namecall
setreadonly(gg, false)
gg.__namecall = newcclosure(function(...)
    local method = getnamecallmethod()
    local args = { ... }
    if tostring(method) == "FireServer" then
        if tostring(args[1]) == "RemoteEvent" then
            if tostring(args[2]) ~= "true" and tostring(args[2]) ~= "false" then
                if getgenv().Config["Auto Farm Kill Raid Ship"] then
                    args[2] = AimBotSkillPositionBoat
                    return old(unpack(args))
                end
            end
        end
    end
    return old(...)
end)
spawn(function()
    while wait() do
        pcall(function()
            if getgenv().Config["Auto Find Kitsune Island"] and L_7449423635_ then
                    if not game:GetService("Workspace").Boats:FindFirstChild("PirateGrandBrigade") then
                        buyb = TP(CFrame.new(-16192.2539, 12.3828964, 1738.85999, -0.997757435, 4.43451498e-08,
                            -0.0669331998, 5.01932291e-08, 1, -8.56902034e-08, 0.0669331998, -8.88576324e-08,
                            -0.997757435))
                        if (CFrame.new(-16192.2539, 12.3828964, 1738.85999, -0.997757435, 4.43451498e-08, -0.0669331998, 5.01932291e-08, 1, -8.56902034e-08, 0.0669331998, -8.88576324e-08, -0.997757435).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 10 then
                            if buyb then buyb:Stop() end
                            local args = {
                                [1] = "BuyBoat",
                                [2] = "PirateGrandBrigade"
                            }
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                        end
                    elseif game:GetService("Workspace").Boats:FindFirstChild("PirateGrandBrigade") then
                        if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit == false then
                            TPP(game:GetService("Workspace").Boats.PirateGrandBrigade.VehicleSeat.CFrame *
                                CFrame.new(0, 1, 0))
                        else
                            for i, v in pairs(game:GetService("Workspace").Boats:GetChildren()) do
                                if v.Name == "PirateGrandBrigade" then
                                    repeat
                                        wait()
                                        PlayBoatsTween(CFrame.new(-99999999, 10.964323997497559, -324.4842224121094))
                                    until game:GetService("Workspace").SeaBeasts:FindFirstChild("d") or game:GetService("Workspace").SeaBeasts:FindFirstChild("dz") or game:GetService("Workspace").SeaBeasts:FindFirstChild("ddd") or not getgenv().Config["Auto Find Kitsune Island"] or _G.StopTweenBoat == false
                            end
                        end
                    end
                end
            end
        end)
    end
end)
spawn(function()
    while task.wait() do
        if getgenv().Config["Teleport to Kitsune Island"] then
            if game:GetService("Workspace").Map:FindFirstChild("KitsuneIsland") or game.Workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island") then
                game.Players.LocalPlayer.Character.Humanoid.Sit = false
                TP(game.Workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island").CFrame * CFrame.new(23,-25.5,19))
            end
        end
    end
end)
spawn(function()
    while task.wait() do
        if getgenv().Config["Auto Collect Azure Ember"] then
            pcall(function()
                local CFrameMe = game.Players.LocalPlayer.Character.HumanoidRootPart
                for i, v in pairs(game:GetService("Workspace").EmberTemplate:GetChildren()) do
                    v.CFrame = CFrameMe.CFrame
                    task.wait()
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Trade Azure Ember"] then
            pcall(function()
                local test = workspace.Map.KitsuneIsland.ShrineDialogPart
                local test1 = Darkbeard
                if GetMaterial("Azure Ember") >= cheeckAzure then
                    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/KitsuneStatuePray"):InvokeServer()
                end
            end)
        end
    end
end)
function RemoveRocks(Rocks)
    local Rocks = workspace:FindFirstChild(Rocks)
    if Rocks then
        Rocks:Destroy()
    else
    end
end
local doingQuest = false
spawn(function()
    while wait() do
        if getgenv().Config["Auto Dragon Hunter"] and not doingQuest then
            doingQuest = true
            pcall(function()
                TP(CFrame.new(5864.96729, 1209.49329, 810.422363))
                task.wait()
                local questData = game:GetService("ReplicatedStorage").Modules.Net["RF/DragonHunter"]:InvokeServer({
                    ["Context"] = "Check" })
                if questData then
                    local activeQuest = false
                    for _, value in pairs(questData) do
                        local questLocations = {
                            ["Defeat 3 Venomous Assailants on Hydra Island."] = { CFrame.new(4460, 1218, 663), "Venomous Assailant", 3 },
                            ["Defeated 1/3 Venomous Assailants on Hydra Island."] = { CFrame.new(4460, 1218, 663), "Venomous Assailant", 2 },
                            ["Defeated 2/3 Venomous Assailants on Hydra Island."] = { CFrame.new(4460, 1218, 663), "Venomous Assailant", 1 },
                            ["Defeat 3 Hydra Enforcers on Hydra Island."] = { CFrame.new(4555, 1002, 478), "Hydra Enforcer", 3 },
                            ["Defeated 1/3 Hydra Enforcers on Hydra Island."] = { CFrame.new(4555, 1002, 478), "Hydra Enforcer", 2 },
                            ["Defeated 2/3 Hydra Enforcers on Hydra Island."] = { CFrame.new(4555, 1002, 478), "Hydra Enforcer", 1 },
                            ["Destroy 10 trees on Hydra Island."] = { CFrame.new(5287.32959, 1005.39813, 398.474274, 0.51608938, 6.28953956e-08, -0.856534719, -5.03406667e-08, 1, 4.30982112e-08, 0.856534719, 2.08759996e-08, 0.51608938), "Tree", 1 },
                            ["Destroyed 1/10 trees on Hydra Island."] = { CFrame.new(5347.45361, 1004.19812, 358.860504, -0.55470717, 1.76127504e-08, 0.832045674, 7.96258561e-08, 1, 3.19168585e-08, -0.832045674, 8.39568557e-08, -0.55470717), "Tree", 1 },
                            ["Destroyed 2/10 trees on Hydra Island."] = { CFrame.new(5234.77588, 1004.19812, 431.294434, 0.546005368, -2.78318524e-08, -0.837781668, -2.16353033e-08, 1, -4.73212118e-08, 0.837781668, 4.3963297e-08, 0.546005368), "Tree", 1 },
                            ["Destroyed 3/10 trees on Hydra Island."] = { CFrame.new(5262.0957, 1004.19812, 351.249573, -0.842448711, 9.36148794e-08, -0.538776517, 8.04484728e-08, 1, 4.79626792e-08, 0.538776517, -2.93765212e-09, -0.842448711), "Tree", 1 },
                            ["Destroyed 4/10 trees on Hydra Island."] = { CFrame.new(5322.82715, 1004.19812, 440.443268, 0.842484713, 4.23488711e-09, 0.53872025, 1.17971739e-08, 1, -2.63101789e-08, -0.53872025, 2.85212991e-08, 0.842484713), "Tree", 1 },
                            ["Destroyed 5/10 trees on Hydra Island."] = { CFrame.new(5347.45361, 1004.19812, 358.860504, -0.55470717, 1.76127504e-08, 0.832045674, 7.96258561e-08, 1, 3.19168585e-08, -0.832045674, 8.39568557e-08, -0.55470717), "Tree", 1 },
                            ["Destroyed 6/10 trees on Hydra Island."] = { CFrame.new(5322.82715, 1004.19812, 440.443268, 0.842484713, 4.23488711e-09, 0.53872025, 1.17971739e-08, 1, -2.63101789e-08, -0.53872025, 2.85212991e-08, 0.842484713), "Tree", 1 },
                            ["Destroyed 7/10 trees on Hydra Island."] = { CFrame.new(5287.32959, 1005.39813, 398.474274, 0.51608938, 6.28953956e-08, -0.856534719, -5.03406667e-08, 1, 4.30982112e-08, 0.856534719, 2.08759996e-08, 0.51608938), "Tree", 1 },
                            ["Destroyed 8/10 trees on Hydra Island."] = { CFrame.new(5262.0957, 1004.19812, 351.249573, -0.842448711, 9.36148794e-08, -0.538776517, 8.04484728e-08, 1, 4.79626792e-08, 0.538776517, -2.93765212e-09, -0.842448711), "Tree", 1 },
                            ["Destroyed 9/10 trees on Hydra Island."] = { CFrame.new(5347.45361, 1004.19812, 358.860504, -0.55470717, 1.76127504e-08, 0.832045674, 7.96258561e-08, 1, 3.19168585e-08, -0.832045674, 8.39568557e-08, -0.55470717), "Tree", 1 },
                        }
                        if questLocations[value] then
                            local questInfo = questLocations[value]
                            local questCFrame, targetName, targetCount = unpack(questInfo)
                            TP(questCFrame)
                            task.wait(3.7)
                            local killCount = 0
                            while killCount < targetCount and getgenv().Config["Auto Dragon Hunter"] do
                                local objects = workspace.Enemies:GetChildren()
                                if value:find("Destroy 10 trees on Hydra Island.") or value:find("Destroyed 1/10 trees on Hydra Island.") or value:find("Destroyed 2/10 trees on Hydra Island.") or value:find("Destroyed 3/10 trees on Hydra Island.") or value:find("Destroyed 4/10 trees on Hydra Island.") or value:find("Destroyed 5/10 trees on Hydra Island.") or value:find("Destroyed 6/10 trees on Hydra Island.") or value:find("Destroyed 7/10 trees on Hydra Island.") or value:find("Destroyed 8/10 trees on Hydra Island.") or value:find("Destroyed 9/10 trees on Hydra Island.") then
                                    objects = game:GetService("Workspace").Map.Waterfall:FindFirstChild(
                                        "IslandModel"):GetChildren()
                                end
                                for _, obj in pairs(objects) do
                                    if obj.Name == targetName and obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChild("Tree") then
                                        if value:find("Destroy 10 trees on Hydra Island.") or value:find("Destroyed 1/10 trees on Hydra Island.") or value:find("Destroyed 2/10 trees on Hydra Island.") or value:find("Destroyed 3/10 trees on Hydra Island.") or value:find("Destroyed 4/10 trees on Hydra Island.") or value:find("Destroyed 5/10 trees on Hydra Island.") or value:find("Destroyed 6/10 trees on Hydra Island.") or value:find("Destroyed 7/10 trees on Hydra Island.") or value:find("Destroyed 8/10 trees on Hydra Island.") or value:find("Destroyed 9/10 trees on Hydra Island.") then
                                            task.wait(1)
                                        else
                                            local humanoid = obj:FindFirstChild("Humanoid")
                                            if humanoid and humanoid.Health > 0 then
                                                repeat
                                                    task.wait()
                                                    AutoHaki()
                                                    EquipWeapon(_G['Select Weapon'])
                                                    obj.HumanoidRootPart.CanCollide = false
                                                    humanoid.WalkSpeed = 0
                                                    TP(obj.HumanoidRootPart.CFrame * Pos)
                                                    BringMob(v.HumanoidRootPart.CFrame) 
                                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius",
                                                        math.huge)
                                                until not getgenv().Config["Auto Dragon Hunter"] or not obj.Parent or humanoid.Health <= 0
                                            end
                                        end
                                        killCount = killCount + 1
                                        if killCount >= targetCount then
                                            break
                                        end
                                    end
                                end
                                task.wait()
                            end
                            activeQuest = true
                            break
                        end
                    end
                    if not activeQuest then
                        game:GetService("ReplicatedStorage").Modules.Net["RF/DragonHunter"]:InvokeServer({
                            ["Context"] = "RequestQuest" })
                        task.wait()
                    end
                end
            end)
            doingQuest = false
        end
        task.wait()
    end
end)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Dragon Hunter"] and doingQuest then
            pcall(function()
                local objects = game:GetService("Workspace").Map.Waterfall:FindFirstChild("IslandModel"):GetChildren()
                for _, v in pairs(objects) do
                    if v:FindFirstChild("Tree") then
                        local tree = v:FindFirstChild("Tree")
                        local Poswolrd = tree:GetPivot()
                        local Pos = Poswolrd.Position
                        if (Pos - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 125 then
                            game:service("VirtualInputManager"):SendKeyEvent(true, "One", false, game)
                            game:service("VirtualInputManager"):SendKeyEvent(false, "One", false, game)
                            if _G['Skill Z'] then useSkill("Z") end
                            if _G['Skill X'] then useSkill("X") end
                            if _G['Skill C'] then useSkill("C") end
                            if _G['Skill V'] then useSkill("V") end
                            if _G['Skill F'] then useSkill("F") end
                            game:service("VirtualInputManager"):SendKeyEvent(true, "Two", false, game)
                            game:service("VirtualInputManager"):SendKeyEvent(false, "Two", false, game)
                            if _G['Skill Z'] then useSkill("Z") end
                            if _G['Skill X'] then useSkill("X") end
                            if _G['Skill C'] then useSkill("C") end
                            if _G['Skill V'] then useSkill("V") end
                            if _G['Skill F'] then useSkill("F") end
                            game:service("VirtualInputManager"):SendKeyEvent(true, "Three", false, game)
                            game:service("VirtualInputManager"):SendKeyEvent(false, "Three", false, game)
                            if _G['Skill Z'] then useSkill("Z") end
                            if _G['Skill X'] then useSkill("X") end
                            if _G['Skill C'] then useSkill("C") end
                            if _G['Skill V'] then useSkill("V") end
                            if _G['Skill F'] then useSkill("F") end
                            game:service("VirtualInputManager"):SendKeyEvent(true, "Four", false, game)
                            game:service("VirtualInputManager"):SendKeyEvent(false, "Four", false, game)
                            if _G['Skill Z'] then useSkill("Z") end
                            if _G['Skill X'] then useSkill("X") end
                            if _G['Skill C'] then useSkill("C") end
                            if _G['Skill V'] then useSkill("V") end
                            if _G['Skill F'] then useSkill("F") end
                        end
                    end
                end
            end)
        end
    end
end)
local isSealingLava2 = false
local isAttackingGolem2 = false
local function attackLavaGolem2()
    if isSealingLava2 then return end 
    local golems = {}
    for _, enemy in pairs(workspace.Enemies:GetChildren()) do
        if enemy.Name == "Lava Golem" and enemy:FindFirstChild("HumanoidRootPart") and enemy.Humanoid.Health > 0 then
            table.insert(golems, enemy)
        end
    end
    if #golems > 0 then
        isAttackingGolem2 = true
        for _, golem in pairs(golems) do
            repeat
                if golem and golem:FindFirstChild("HumanoidRootPart") and golem.Humanoid.Health > 0 then
                    EquipWeapon(_G['Select Weapon'])
                    TP(golem.HumanoidRootPart.CFrame * Pos)
                end
                wait(0.5)
            until golem == nil or golem.Humanoid.Health <= 0 or not getgenv().Config["Auto Dojo Quest"]
        end
        isAttackingGolem2 = false
    end
end
local function sealLava2()
    if isAttackingGolem2 then return end
    for _, v in pairs(game.workspace.Map.PrehistoricIsland.Core.VolcanoRocks:GetChildren()) do
        local checkcolor = v:FindFirstChild("volcanorock")
        local checkcolorVFXLayer = v:FindFirstChild("VFXLayer")
        if checkcolor and checkcolorVFXLayer and checkcolor:IsA("BasePart") and checkcolor.BrickColor.Name == "Bright red" or checkcolorVFXLayer.BrickColor.Name == "Bright red" then
            isSealingLava2 = true
            repeat wait()
                TP(checkcolor.CFrame + Vector3.new(0, 5, 0))
                Posvolcanorock = checkcolor.Position
                game:service("VirtualInputManager"):SendKeyEvent(true, "One", false, game)
                game:service("VirtualInputManager"):SendKeyEvent(false, "One", false, game)
                if _G['Skill Z'] then useSkill("Z") end
                if _G['Skill X'] then useSkill("X") end
                if _G['Skill C'] then useSkill("C") end
                if _G['Skill V'] then useSkill("V") end
                if _G['Skill F'] then useSkill("F") end
                game:service("VirtualInputManager"):SendKeyEvent(true, "Two", false, game)
                game:service("VirtualInputManager"):SendKeyEvent(false, "Two", false, game)
                if _G['Skill Z'] then useSkill("Z") end
                if _G['Skill X'] then useSkill("X") end
                if _G['Skill C'] then useSkill("C") end
                if _G['Skill V'] then useSkill("V") end
                if _G['Skill F'] then useSkill("F") end
                game:service("VirtualInputManager"):SendKeyEvent(true, "Three", false, game)
                game:service("VirtualInputManager"):SendKeyEvent(false, "Three", false, game)
                if _G['Skill Z'] then useSkill("Z") end
                if _G['Skill X'] then useSkill("X") end
                if _G['Skill C'] then useSkill("C") end
                if _G['Skill V'] then useSkill("V") end
                if _G['Skill F'] then useSkill("F") end
                game:service("VirtualInputManager"):SendKeyEvent(true, "Four", false, game)
                game:service("VirtualInputManager"):SendKeyEvent(false, "Four", false, game)
                if _G['Skill Z'] then useSkill("Z") end
                if _G['Skill X'] then useSkill("X") end
                if _G['Skill C'] then useSkill("C") end
                if _G['Skill V'] then useSkill("V") end
                if _G['Skill F'] then useSkill("F") end
            until checkcolor.BrickColor.Name ~= "Bright red" or checkcolorVFXLayer.BrickColor.Name ~= "Bright red" or not getgenv().Config["Auto Dojo Quest"]
            if checkcolor.BrickColor.Name ~= "Bright red" and checkcolorVFXLayer.BrickColor.Name ~= "Bright red" then
                isSealingLava2 = false 
                attackLavaGolem2()
            end
            break
        end
    end
end
spawn(function()
    while wait() do
        if getgenv().Config["Auto Dojo Quest"] then
            pcall(function()
                local posquest = CFrame.new(5864, 1208, 873)
                local cfmonster = CFrame.new(-16966, 241, 1643)
                local posquestckeck = CFrame.new(-16665.1914, 104.596405, 1579.69434, 0.951068401, -0, -0.308980465, 0, 1, -0, 0.308980465, 0, 0.951068401)
                if CheckBelt("Dojo Belt (White)") == false and CheckBelt("Dojo Belt (Yellow)") == false and CheckBelt("Dojo Belt (Orange)") == false and CheckBelt("Dojo Belt (Green)") == false and CheckBelt("Dojo Belt (Blue)") == false and CheckBelt("Dojo Belt (Purple)") == false and CheckBelt("Dojo Belt (Red)") == false and CheckBelt("Dojo Belt (Black)") == false then
                if (posquest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(5661.52979, 1013.07385, -334.962189))
                end
                repeat
                    wait(0.1)
                    TP(posquest)
                until not getgenv().Config["Auto Dojo Quest"] or CheckBelt("Dojo Belt (White)") == true and CheckBelt("Dojo Belt (Yellow)") == false and CheckBelt("Dojo Belt (Orange)") == false and CheckBelt("Dojo Belt (Green)") == false and CheckBelt("Dojo Belt (Blue)") == false and CheckBelt("Dojo Belt (Purple)") == false and CheckBelt("Dojo Belt (Red)") == false and CheckBelt("Dojo Belt (Black)") == false or (posquest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 20
                wait(0.1)
                local args = {
                    [1] = {
                        ["NPC"] = "Dojo Trainer",
                        ["Command"] = "RequestQuest"
                    }
                }
                game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/InteractDragonQuest"):InvokeServer(unpack(args))   
                wait(0.1)
                repeat
                    wait(0.1)
                    TP(cfmonster)
                until not getgenv().Config["Auto Dojo Quest"] or CheckBelt("Dojo Belt (White)") == true and CheckBelt("Dojo Belt (Yellow)") == false and CheckBelt("Dojo Belt (Orange)") == false and CheckBelt("Dojo Belt (Green)") == false and CheckBelt("Dojo Belt (Blue)") == false and CheckBelt("Dojo Belt (Purple)") == false and CheckBelt("Dojo Belt (Red)") == false and CheckBelt("Dojo Belt (Black)") == false or (cfmonster.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 20
                local killCount2 = 0
                    while killCount2 < 30 do wait()
                        for _, v in pairs(workspace.Enemies:GetChildren()) do
                            if v.Name == "Skull Slayer" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                                repeat
                                    task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G['Select Weapon'])
                                    v.HumanoidRootPart.CanCollide = false
                                    BringMob(v.HumanoidRootPart.CFrame) 
                                    v.Humanoid.WalkSpeed = 0
                                    TP(v.HumanoidRootPart.CFrame * Pos)
                                until v.Humanoid.Health <= 0 or not _G['Auto Dojo Quest'] or killCount2 >= 30
                                if v.Humanoid.Health <= 0 then
                                    repeat task.wait() until not v.Parent
                                    killCount2 = killCount2 + 1
                                end
                            end
                            if killCount2 >= 30 then break end
                        end
                    end
                    wait(0.1)
                    if (posquest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(5661.52979, 1013.07385, -334.962189))
                        end
                    repeat
                        wait(0.1)
                        TP(posquest)
                    until not getgenv().Config["Auto Dojo Quest"] or CheckBelt("Dojo Belt (White)") == true and CheckBelt("Dojo Belt (Yellow)") == false and CheckBelt("Dojo Belt (Orange)") == false and CheckBelt("Dojo Belt (Green)") == false and CheckBelt("Dojo Belt (Blue)") == false and CheckBelt("Dojo Belt (Purple)") == false and CheckBelt("Dojo Belt (Red)") == false and CheckBelt("Dojo Belt (Black)") == false or (posquest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 20
                    wait(0.1)
                    local args = {
                        [1] = {
                            ["NPC"] = "Dojo Trainer",
                            ["Command"] = "ClaimQuest"
                        }
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/InteractDragonQuest"):InvokeServer(unpack(args))
                    wait(0.1)
                    local args = {
                        [1] = {
                            ["NPC"] = "Dojo Trainer",
                            ["Command"] = "RequestQuest"
                        }
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/InteractDragonQuest"):InvokeServer(unpack(args))
                elseif CheckBelt("Dojo Belt (White)") == true and CheckBelt("Dojo Belt (Yellow)") == false and CheckBelt("Dojo Belt (Orange)") == false and CheckBelt("Dojo Belt (Green)") == false and CheckBelt("Dojo Belt (Blue)") == false and CheckBelt("Dojo Belt (Purple)") == false and CheckBelt("Dojo Belt (Red)") == false and CheckBelt("Dojo Belt (Black)") == false then
                    wait(0.1)
                    if (posquest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(5661.52979, 1013.07385, -334.962189))
                    end
                    repeat
                        wait(0.1)
                        TP(posquest)
                    until not getgenv().Config["Auto Dojo Quest"] or CheckBelt("Dojo Belt (White)") == true and CheckBelt("Dojo Belt (Yellow)") == true and CheckBelt("Dojo Belt (Orange)") == false and CheckBelt("Dojo Belt (Green)") == false and CheckBelt("Dojo Belt (Blue)") == false and CheckBelt("Dojo Belt (Purple)") == false and CheckBelt("Dojo Belt (Red)") == false and CheckBelt("Dojo Belt (Black)") == false or (posquest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 20
                    wait(0.1)
                    local args = {
                        [1] = {
                            ["NPC"] = "Dojo Trainer",
                            ["Command"] = "ClaimQuest"
                        }
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/InteractDragonQuest"):InvokeServer(unpack(args))
                    wait(0.1)
                    local args = {
                        [1] = {
                            ["NPC"] = "Dojo Trainer",
                            ["Command"] = "RequestQuest"
                        }
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/InteractDragonQuest"):InvokeServer(unpack(args))
                    wait(0.1)
                    local killCountTerrorshark = 0
                    while killCountTerrorshark < 1 do wait()
                        if not workspace.Enemies:FindFirstChild("Terrorshark") then
                            if not game:GetService("Workspace").Boats:FindFirstChild("PirateGrandBrigade") then
                                buyb = TP(CFrame.new(-16192.2539, 12.3828964, 1738.85999, -0.997757435, 4.43451498e-08,
                                    -0.0669331998, 5.01932291e-08, 1, -8.56902034e-08, 0.0669331998, -8.88576324e-08,
                                    -0.997757435))
                                if (CFrame.new(-16192.2539, 12.3828964, 1738.85999, -0.997757435, 4.43451498e-08, -0.0669331998, 5.01932291e-08, 1, -8.56902034e-08, 0.0669331998, -8.88576324e-08, -0.997757435).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 10 then
                                    if buyb then buyb:Stop() end
                                    local args = {
                                        [1] = "BuyBoat",
                                        [2] = "PirateGrandBrigade"
                                    }
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                                end
                            elseif game:GetService("Workspace").Boats:FindFirstChild("PirateGrandBrigade") then
                                if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit == false then
                                    TPTPP(game:GetService("Workspace").Boats.PirateGrandBrigade.VehicleSeat.CFrame * CFrame.new(0, 1, 0))
                                else
                                    for i, v in pairs(game:GetService("Workspace").Boats:GetChildren()) do
                                        if v.Name == "PirateGrandBrigade" then
                                            repeat
                                                wait()
                                                PlayBoatsTween(CFrame.new(-99999999, 10.964323997497559, -324.4842224121094))
                                            until not getgenv().Config["Auto Dojo Quest"] or _G.StopTweenBoat == false or killCountTerrorshark >= 1 or workspace.Enemies:FindFirstChild("Terrorshark")
                                            game.Players.LocalPlayer.Character.Humanoid.Sit = false
                                        end
                                    end
                                end
                            end
                        elseif workspace.Enemies:FindFirstChild("Terrorshark") then
                        local enemies = workspace.Enemies
                        local player = game.Players.LocalPlayer
                        local character = player.Character
                        local humanoid = character and character:FindFirstChild("Humanoid")
                            if humanoid and humanoid.Health >= 8500 then
                                for _, v in pairs(enemies:GetChildren()) do
                                    if v.Name == "Terrorshark" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                                        local enemyHumanoid = v.Humanoid
                                        local rootPart = v.HumanoidRootPart
                                        if enemyHumanoid.Health > 0 then
                                            repeat
                                                task.wait()
                                                AutoHaki()
                                                EquipWeapon(_G['Select Weapon'])
                                                rootPart.CanCollide = false
                                                enemyHumanoid.WalkSpeed = 0
                                                if humanoid.Health <= 4000 then
                                                    BringMob(rootPart.CFrame) 
                                                    TP(rootPart.CFrame * CFrame.new(0, 180, 0))
                                                elseif humanoid.Health >= 8000 then
                                                    BringMob(rootPart.CFrame) 
                                                    TP(rootPart.CFrame * Pos)
                                                end
                                                sethiddenproperty(player, "SimulationRadius", math.huge)
                                            until not getgenv().Config["Auto Farm Sea Events"] or not v.Parent or enemyHumanoid.Health <= 0
                                            if enemyHumanoid.Health <= 0 then
                                                repeat task.wait() until not v.Parent
                                                killCountTerrorshark = killCountTerrorshark + 1
                                            end
                                            if killCountTerrorshark >= 1 then break end
                                        end
                                    end
                                end
                            end
                        end
                    end
                    wait(0.1)
                    if (posquest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(5661.52979, 1013.07385, -334.962189))
                    end
                    repeat
                        wait(0.1)
                        TP(posquest)
                    until not getgenv().Config["Auto Dojo Quest"] or CheckBelt("Dojo Belt (White)") == true and CheckBelt("Dojo Belt (Yellow)") == true and CheckBelt("Dojo Belt (Orange)") == false and CheckBelt("Dojo Belt (Green)") == false and CheckBelt("Dojo Belt (Blue)") == false and CheckBelt("Dojo Belt (Purple)") == false and CheckBelt("Dojo Belt (Red)") == false and CheckBelt("Dojo Belt (Black)") == false or (posquest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 20
                    wait(0.1)
                    local args = {
                        [1] = {
                            ["NPC"] = "Dojo Trainer",
                            ["Command"] = "ClaimQuest"
                        }
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/InteractDragonQuest"):InvokeServer(unpack(args))
                    wait(0.1)
                    local args = {
                        [1] = {
                            ["NPC"] = "Dojo Trainer",
                            ["Command"] = "RequestQuest"
                        }
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/InteractDragonQuest"):InvokeServer(unpack(args))
                    wait(0.1)
                elseif CheckBelt("Dojo Belt (White)") == true and CheckBelt("Dojo Belt (Yellow)") == true and CheckBelt("Dojo Belt (Orange)") == false and CheckBelt("Dojo Belt (Green)") == false and CheckBelt("Dojo Belt (Blue)") == false and CheckBelt("Dojo Belt (Purple)") == false and CheckBelt("Dojo Belt (Red)") == false and CheckBelt("Dojo Belt (Black)") == false then
                    wait(0.1)
                    if (posquest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(5661.52979, 1013.07385, -334.962189))
                    end
                    repeat
                        wait(0.1)
                        TP(posquest)
                    until not getgenv().Config["Auto Dojo Quest"] or CheckBelt("Dojo Belt (White)") == true and CheckBelt("Dojo Belt (Yellow)") == true and CheckBelt("Dojo Belt (Orange)") == true and CheckBelt("Dojo Belt (Green)") == false and CheckBelt("Dojo Belt (Blue)") == false and CheckBelt("Dojo Belt (Purple)") == false and CheckBelt("Dojo Belt (Red)") == false and CheckBelt("Dojo Belt (Black)") == false or (posquest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 20
                    wait(0.1)
                    local args = {
                        [1] = {
                            ["NPC"] = "Dojo Trainer",
                            ["Command"] = "ClaimQuest"
                        }
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/InteractDragonQuest"):InvokeServer(unpack(args))
                    wait(0.1)
                    local args = {
                        [1] = {
                            ["NPC"] = "Dojo Trainer",
                            ["Command"] = "RequestQuest"
                        }
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/InteractDragonQuest"):InvokeServer(unpack(args))
                    wait(0.1)
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-12468.5380859375, 375.0094299316406, -7554.62548828125))
                    wait(0.1)
                    local finalPosition = CFrame.new(-12591.0586, 337.540649, -7556.75684)
                    TP(finalPosition)
                elseif CheckBelt("Dojo Belt (White)") == true and CheckBelt("Dojo Belt (Yellow)") == true and CheckBelt("Dojo Belt (Orange)") == true and CheckBelt("Dojo Belt (Green)") == false and CheckBelt("Dojo Belt (Blue)") == false and CheckBelt("Dojo Belt (Purple)") == false and CheckBelt("Dojo Belt (Red)") == false and CheckBelt("Dojo Belt (Black)") == false then
                    wait(0.1)
                    if (posquest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(5661.52979, 1013.07385, -334.962189))
                    end
                    repeat
                        wait(0.1)
                        TP(posquest)
                    until not getgenv().Config["Auto Dojo Quest"] or CheckBelt("Dojo Belt (White)") == true and CheckBelt("Dojo Belt (Yellow)") == true and CheckBelt("Dojo Belt (Orange)") == true and CheckBelt("Dojo Belt (Green)") == true and CheckBelt("Dojo Belt (Blue)") == false and CheckBelt("Dojo Belt (Purple)") == false and CheckBelt("Dojo Belt (Red)") == false and CheckBelt("Dojo Belt (Black)") == false or (posquest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 20
                    wait(0.1)
                    local args = {
                        [1] = {
                            ["NPC"] = "Dojo Trainer",
                            ["Command"] = "ClaimQuest"
                        }
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/InteractDragonQuest"):InvokeServer(unpack(args))
                    wait(0.1)
                    local args = {
                        [1] = {
                            ["NPC"] = "Dojo Trainer",
                            ["Command"] = "RequestQuest"
                        }
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/InteractDragonQuest"):InvokeServer(unpack(args))
                    wait(0.1)
                    if not game:GetService("Workspace").Boats:FindFirstChild("PirateGrandBrigade") then
                        buyb = TP(CFrame.new(-16192.2539, 12.3828964, 1738.85999, -0.997757435, 4.43451498e-08,
                            -0.0669331998, 5.01932291e-08, 1, -8.56902034e-08, 0.0669331998, -8.88576324e-08,
                            -0.997757435))
                        if (CFrame.new(-16192.2539, 12.3828964, 1738.85999, -0.997757435, 4.43451498e-08, -0.0669331998, 5.01932291e-08, 1, -8.56902034e-08, 0.0669331998, -8.88576324e-08, -0.997757435).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 10 then
                            if buyb then buyb:Stop() end
                            local args = {
                                [1] = "BuyBoat",
                                [2] = "PirateGrandBrigade"
                            }
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                        end
                    elseif game:GetService("Workspace").Boats:FindFirstChild("PirateGrandBrigade") then
                        if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit == false then
                            TPTPP(game:GetService("Workspace").Boats.PirateGrandBrigade.VehicleSeat.CFrame * CFrame.new(0, 1, 0))
                        else
                            for i, v in pairs(game:GetService("Workspace").Boats:GetChildren()) do
                                if v.Name == "PirateGrandBrigade" then
                                    repeat
                                        wait()
                                        PlayBoatsTween(CFrame.new(-99999999, 10.964323997497559, -324.4842224121094))
                                    until CheckBelt("Dojo Belt (White)") == true and CheckBelt("Dojo Belt (Yellow)") == true and CheckBelt("Dojo Belt (Orange)") == true and CheckBelt("Dojo Belt (Green)") == true and CheckBelt("Dojo Belt (Blue)") == false and CheckBelt("Dojo Belt (Purple)") == false and CheckBelt("Dojo Belt (Red)") == false and CheckBelt("Dojo Belt (Black)") == false or not getgenv().Config["Auto Dojo Quest"] or _G.StopTweenBoat == false or (posquestckeck.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 6000
                                end
                            end
                        end
                    end
                    wait(0.1)
                    if (posquest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(5661.52979, 1013.07385, -334.962189))
                    end
                    repeat
                        wait(0.1)
                        TP(posquest)
                    until not getgenv().Config["Auto Dojo Quest"] or CheckBelt("Dojo Belt (White)") == true and CheckBelt("Dojo Belt (Yellow)") == true and CheckBelt("Dojo Belt (Orange)") == true and CheckBelt("Dojo Belt (Green)") == true and CheckBelt("Dojo Belt (Blue)") == false and CheckBelt("Dojo Belt (Purple)") == false and CheckBelt("Dojo Belt (Red)") == false and CheckBelt("Dojo Belt (Black)") == false or (posquest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 20
                    wait(0.1)
                    local args = {
                        [1] = {
                            ["NPC"] = "Dojo Trainer",
                            ["Command"] = "ClaimQuest"
                        }
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/InteractDragonQuest"):InvokeServer(unpack(args))
                    wait(0.1)
                    local args = {
                        [1] = {
                            ["NPC"] = "Dojo Trainer",
                            ["Command"] = "RequestQuest"
                        }
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/InteractDragonQuest"):InvokeServer(unpack(args))
                    wait(0.1)
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-12468.5380859375, 375.0094299316406, -7554.62548828125))
                elseif CheckBelt("Dojo Belt (White)") == true and CheckBelt("Dojo Belt (Yellow)") == true and CheckBelt("Dojo Belt (Orange)") == true and CheckBelt("Dojo Belt (Green)") == true and CheckBelt("Dojo Belt (Blue)") == true and CheckBelt("Dojo Belt (Purple)") == false and CheckBelt("Dojo Belt (Red)") == false and CheckBelt("Dojo Belt (Black)") == false then
                    wait(0.1)
                    if (posquest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(5661.52979, 1013.07385, -334.962189))
                    end
                    repeat
                        wait(0.1)
                        TP(posquest)
                    until not getgenv().Config["Auto Dojo Quest"] or CheckBelt("Dojo Belt (White)") == true and CheckBelt("Dojo Belt (Yellow)") == true and CheckBelt("Dojo Belt (Orange)") == true and CheckBelt("Dojo Belt (Green)") == true and CheckBelt("Dojo Belt (Blue)") == true and CheckBelt("Dojo Belt (Purple)") == true and CheckBelt("Dojo Belt (Red)") == false and CheckBelt("Dojo Belt (Black)") == false or (posquest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 20
                    wait(0.1)
                    local args = {
                        [1] = {
                            ["NPC"] = "Dojo Trainer",
                            ["Command"] = "ClaimQuest"
                        }
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/InteractDragonQuest"):InvokeServer(unpack(args))
                    wait(0.1)
                    local args = {
                        [1] = {
                            ["NPC"] = "Dojo Trainer",
                            ["Command"] = "RequestQuest"
                        }
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/InteractDragonQuest"):InvokeServer(unpack(args))
                    wait(0.1)
                    if (game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible) == true then
                        if (string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Diablo") or string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Deandre") or string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Urban")) then
                            if (workspace.Enemies:FindFirstChild("Diablo") or workspace.Enemies:FindFirstChild("Deandre") or workspace.Enemies:FindFirstChild("Urban")) then
                                for v37, v38 in pairs(workspace.Enemies:GetChildren()) do
                                    if (v38:FindFirstChild("Humanoid") and v38:FindFirstChild("HumanoidRootPart") and v38.Humanoid.Health) > (0) then
                                        if (v38.Name == "Diablo" or v38.Name == "Deandre" or v38.Name == "Urban") then
                                            repeat
                                                game:GetService("RunService").Heartbeat:wait()
                                                EquipWeapon(_G['Select Weapon'])
                                                TP(v38.HumanoidRootPart.CFrame * Pos)
                                            until (getgenv().Config["Auto Dojo Quest"] == false or v38.Humanoid.Health <= (0) or not v.Parent)
                                        end
                                    end
                                end
                            else
                                if (game:GetService("ReplicatedStorage"):FindFirstChild("Diablo")) then
                                    if (ByPassTP) then
                                        BTP(game:GetService("ReplicatedStorage"):FindFirstChild("Diablo")
                                            .HumanoidRootPart.CFrame)
                                    else
                                        TP(game:GetService("ReplicatedStorage"):FindFirstChild("Diablo")
                                            .HumanoidRootPart.CFrame)
                                    end
                                elseif (game:GetService("ReplicatedStorage"):FindFirstChild("Deandre")) then
                                    if (ByPassTP) then
                                        BTP(game:GetService("ReplicatedStorage"):FindFirstChild("Deandre")
                                            .HumanoidRootPart.CFrame)
                                    else
                                        TP(game:GetService("ReplicatedStorage"):FindFirstChild("Deandre")
                                            .HumanoidRootPart.CFrame)
                                    end
                                elseif (game:GetService("ReplicatedStorage"):FindFirstChild("Urban")) then
                                    if (ByPassTP) then
                                        BTP(game:GetService("ReplicatedStorage"):FindFirstChild("Urban")
                                            .HumanoidRootPart.CFrame)
                                    else
                                        TP(game:GetService("ReplicatedStorage"):FindFirstChild("Urban").HumanoidRootPart
                                            .CFrame)
                                    end
                                else
                                    Hop()
                                end
                            end
                        end
                    else
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter")
                    end
                elseif CheckBelt("Dojo Belt (White)") == true and CheckBelt("Dojo Belt (Yellow)") == true and CheckBelt("Dojo Belt (Orange)") == true and CheckBelt("Dojo Belt (Green)") == true and CheckBelt("Dojo Belt (Blue)") == true and CheckBelt("Dojo Belt (Purple)") == true and CheckBelt("Dojo Belt (Red)") == false and CheckBelt("Dojo Belt (Black)") == false then
                    wait(0.1)
                    if (posquest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(5661.52979, 1013.07385, -334.962189))
                    end
                    repeat
                        wait(0.1)
                        TP(posquest)
                    until not getgenv().Config["Auto Dojo Quest"] or CheckBelt("Dojo Belt (White)") == true and CheckBelt("Dojo Belt (Yellow)") == true and CheckBelt("Dojo Belt (Orange)") == true and CheckBelt("Dojo Belt (Green)") == true and CheckBelt("Dojo Belt (Blue)") == true and CheckBelt("Dojo Belt (Purple)") == true and CheckBelt("Dojo Belt (Red)") == true and CheckBelt("Dojo Belt (Black)") == false or (posquest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 20
                    wait(0.1)
                    local args = {
                        [1] = {
                            ["NPC"] = "Dojo Trainer",
                            ["Command"] = "ClaimQuest"
                        }
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/InteractDragonQuest"):InvokeServer(unpack(args))
                    wait(0.1)
                    local args = {
                        [1] = {
                            ["NPC"] = "Dojo Trainer",
                            ["Command"] = "RequestQuest"
                        }
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/InteractDragonQuest"):InvokeServer(unpack(args))
                    wait(0.1)
                    local killCountTerrorshark2 = 0
                    while killCountTerrorshark2 < 1 do wait()
                        if not workspace.Enemies:FindFirstChild("Terrorshark") then
                            if not game:GetService("Workspace").Boats:FindFirstChild("PirateGrandBrigade") then
                                buyb = TP(CFrame.new(-16192.2539, 12.3828964, 1738.85999, -0.997757435, 4.43451498e-08,
                                    -0.0669331998, 5.01932291e-08, 1, -8.56902034e-08, 0.0669331998, -8.88576324e-08,
                                    -0.997757435))
                                if (CFrame.new(-16192.2539, 12.3828964, 1738.85999, -0.997757435, 4.43451498e-08, -0.0669331998, 5.01932291e-08, 1, -8.56902034e-08, 0.0669331998, -8.88576324e-08, -0.997757435).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 10 then
                                    if buyb then buyb:Stop() end
                                    local args = {
                                        [1] = "BuyBoat",
                                        [2] = "PirateGrandBrigade"
                                    }
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                                end
                            elseif game:GetService("Workspace").Boats:FindFirstChild("PirateGrandBrigade") then
                                if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit == false then
                                    TPTPP(game:GetService("Workspace").Boats.PirateGrandBrigade.VehicleSeat.CFrame * CFrame.new(0, 1, 0))
                                else
                                    for i, v in pairs(game:GetService("Workspace").Boats:GetChildren()) do
                                        if v.Name == "PirateGrandBrigade" then
                                            repeat
                                                wait()
                                                PlayBoatsTween(CFrame.new(-99999999, 10.964323997497559, -324.4842224121094))
                                            until CheckBelt("Dojo Belt (White)") == true and CheckBelt("Dojo Belt (Yellow)") == true and CheckBelt("Dojo Belt (Orange)") == false and CheckBelt("Dojo Belt (Green)") == false and CheckBelt("Dojo Belt (Blue)") == false and CheckBelt("Dojo Belt (Purple)") == false and CheckBelt("Dojo Belt (Red)") == false and CheckBelt("Dojo Belt (Black)") == false or not getgenv().Config["Auto Dojo Quest"] or _G.StopTweenBoat == false or killCountTerrorshark2 >= 1 or workspace.Enemies:FindFirstChild("Terrorshark")
                                        end
                                    end
                                end
                            end
                        elseif workspace.Enemies:FindFirstChild("Terrorshark") then
                            local enemies = workspace.Enemies
                            local player = game.Players.LocalPlayer
                            local character = player.Character
                            local humanoid = character and character:FindFirstChild("Humanoid")
                            if humanoid and humanoid.Health >= 8500 then
                                for _, v in pairs(enemies:GetChildren()) do
                                    if v.Name == "Terrorshark" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                                        local enemyHumanoid = v.Humanoid
                                        local rootPart = v.HumanoidRootPart
                                        if enemyHumanoid.Health > 0 then
                                            repeat
                                                task.wait()
                                                AutoHaki()
                                                EquipWeapon(_G['Select Weapon'])
                                                rootPart.CanCollide = false
                                                enemyHumanoid.WalkSpeed = 0
                                                if humanoid.Health <= 4000 then
                                                    BringMob(rootPart.CFrame) 
                                                    TP(rootPart.CFrame * CFrame.new(0, 180, 0))
                                                elseif humanoid.Health >= 8000 then
                                                    BringMob(rootPart.CFrame) 
                                                    TP(rootPart.CFrame * Pos)
                                                end
                                                sethiddenproperty(player, "SimulationRadius", math.huge)
                                            until not getgenv().Config["Auto Farm Sea Events"] or not v.Parent or enemyHumanoid.Health <= 0
                                            if enemyHumanoid.Health <= 0 then
                                                repeat task.wait() until not v.Parent
                                                killCountTerrorshark2 = killCountTerrorshark2 + 1
                                            end
                                            if killCountTerrorshark2 >= 1 then break end
                                        end
                                    end
                                end
                            end
                        end
                    end
                    wait(0.1)
                    if (posquest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(5661.52979, 1013.07385, -334.962189))
                    end
                    repeat
                        wait(0.1)
                        TP(posquest)
                    until not getgenv().Config["Auto Dojo Quest"] or CheckBelt("Dojo Belt (White)") == true and CheckBelt("Dojo Belt (Yellow)") == true and CheckBelt("Dojo Belt (Orange)") == true and CheckBelt("Dojo Belt (Green)") == true and CheckBelt("Dojo Belt (Blue)") == true and CheckBelt("Dojo Belt (Purple)") == true and CheckBelt("Dojo Belt (Red)") == true and CheckBelt("Dojo Belt (Black)") == false or (posquest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 20
                    wait(0.1)
                    local args = {
                        [1] = {
                            ["NPC"] = "Dojo Trainer",
                            ["Command"] = "ClaimQuest"
                        }
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/InteractDragonQuest"):InvokeServer(unpack(args))
                    wait(0.1)
                    local args = {
                        [1] = {
                            ["NPC"] = "Dojo Trainer",
                            ["Command"] = "RequestQuest"
                        }
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/InteractDragonQuest"):InvokeServer(unpack(args))
                    wait(0.1)
                elseif CheckBelt("Dojo Belt (White)") == true and CheckBelt("Dojo Belt (Yellow)") == true and CheckBelt("Dojo Belt (Orange)") == true and CheckBelt("Dojo Belt (Green)") == true and CheckBelt("Dojo Belt (Blue)") == true and CheckBelt("Dojo Belt (Purple)") == true and CheckBelt("Dojo Belt (Red)") == true and CheckBelt("Dojo Belt (Black)") == false then
                    wait(0.1)
                    if (posquest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(5661.52979, 1013.07385, -334.962189))
                    end
                    repeat
                        wait(0.1)
                        TP(posquest)
                    until not getgenv().Config["Auto Dojo Quest"] or CheckBelt("Dojo Belt (White)") == true and CheckBelt("Dojo Belt (Yellow)") == true and CheckBelt("Dojo Belt (Orange)") == true and CheckBelt("Dojo Belt (Green)") == true and CheckBelt("Dojo Belt (Blue)") == true and CheckBelt("Dojo Belt (Purple)") == true and CheckBelt("Dojo Belt (Red)") == true and CheckBelt("Dojo Belt (Black)") == true or (posquest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 20
                    wait(0.1)
                    local args = {
                        [1] = {
                            ["NPC"] = "Dojo Trainer",
                            ["Command"] = "ClaimQuest"
                        }
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/InteractDragonQuest"):InvokeServer(unpack(args))
                    wait(0.1)
                    local args = {
                        [1] = {
                            ["NPC"] = "Dojo Trainer",
                            ["Command"] = "RequestQuest"
                        }
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/InteractDragonQuest"):InvokeServer(unpack(args))
                    wait(0.1)
                    if not game:GetService("Workspace").Map:FindFirstChild("PrehistoricRelic") or not game.Workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") then
                        if not game:GetService("Workspace").Boats:FindFirstChild("PirateGrandBrigade") then
                            buyb = TP(CFrame.new(-16192.2539, 12.3828964, 1738.85999, -0.997757435, 4.43451498e-08,
                                -0.0669331998, 5.01932291e-08, 1, -8.56902034e-08, 0.0669331998, -8.88576324e-08,
                                -0.997757435))
                            if (CFrame.new(-16192.2539, 12.3828964, 1738.85999, -0.997757435, 4.43451498e-08, -0.0669331998, 5.01932291e-08, 1, -8.56902034e-08, 0.0669331998, -8.88576324e-08, -0.997757435).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 10 then
                                if buyb then buyb:Stop() end
                                local args = {
                                    [1] = "BuyBoat",
                                    [2] = "PirateGrandBrigade"
                                }
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                            end
                        elseif game:GetService("Workspace").Boats:FindFirstChild("PirateGrandBrigade") then
                            if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit == false then
                                TPTPP(game:GetService("Workspace").Boats.PirateGrandBrigade.VehicleSeat.CFrame *
                                    CFrame.new(0, 1, 0))
                            else
                                for i, v in pairs(game:GetService("Workspace").Boats:GetChildren()) do
                                    if v.Name == "PirateGrandBrigade" then
                                        repeat
                                            wait()
                                            PlayBoatsTween(CFrame.new(-99999999, 10.964323997497559, -324.4842224121094))
                                        until game:GetService("Workspace").Map:FindFirstChild("PrehistoricRelic") or game.Workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") or not getgenv().Config["Auto Dojo Quest"] or _G.StopTweenBoat == false
                                    end
                                end
                            end
                        end
                    elseif game:GetService("Workspace").Map:FindFirstChild("PrehistoricRelic") or game.Workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") then
                        game.Players.LocalPlayer.Character.Humanoid.Sit = false
                        TP(game.Workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island").CFrame * CFrame.new(0,20,0))
                        wait(2.5)
                        if game.workspace.Map:FindFirstChild("PrehistoricIsland") then
                            game.Players.LocalPlayer.Character.Humanoid.Sit = false
                        end
                        if not isSealingLava2 then
                            attackLavaGolem2()
                        end
                        if not isAttackingGolem2 then
                            sealLava2()
                        end
                        if not isAttackingGolem2 and not isSealingLava2 then
                            TP(game.workspace.Map.PrehistoricIsland.Core.ActivationPrompt.CFrame)
                        end
                    end
                    wait(0.1)
                    local args = {
                        [1] = {
                            ["NPC"] = "Dojo Trainer",
                            ["Command"] = "ClaimQuest"
                        }
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/InteractDragonQuest"):InvokeServer(unpack(args))
                    wait(0.1)
                    local args = {
                        [1] = {
                            ["NPC"] = "Dojo Trainer",
                            ["Command"] = "RequestQuest"
                        }
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/InteractDragonQuest"):InvokeServer(unpack(args))
                    wait(0.1)
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Dojo Quest"] then
            pcall(function()
                if game.workspace.Map:FindFirstChild("PrehistoricIsland") then
                    game.Players.LocalPlayer.Character.Humanoid.Sit = false
                end
                if not isAttackingGolem and not isSealingLava then
                    for i, v in  pairs(game.workspace.Map.PrehistoricIsland.Core:GetDescendants()) do
                        if v.Name == "ProximityPrompt" then
                        fireproximityprompt(v, 40)
                        end
                    end
                end
            end)
        end
    end
end)
local gg = getrawmetatable(game)
local old = gg.__namecall
setreadonly(gg, false)
gg.__namecall = newcclosure(function(...)
    local method = getnamecallmethod()
    local args = { ... }
    if tostring(method) == "FireServer" then
        if tostring(args[1]) == "RemoteEvent" then
            if tostring(args[2]) ~= "true" and tostring(args[2]) ~= "false" then
                if getgenv().Config["Auto Dojo Quest"] then
                    args[2] = Posvolcanorock
                    return old(unpack(args))
                end
            end
        end
    end
    return old(...)
end)
AutoFarmLeatherVolcanic = CFrame.new(-13354.001, 379.738068, -7752.01367, 0.792679489, -2.59651269e-08, -0.609638572,
-1.42174805e-08, 1, -6.10772233e-08, 0.609638572, 5.70821896e-08, 0.792679489)
spawn(function()
    while task.wait() do
        if getgenv().Config["Auto Craft Volcanic Magnet"] then
            pcall(function()
                if GetMaterial("Volcanic Magnet") <= 10 then
                    if GetMaterial("Blaze Ember") < 15 and GetMaterial("Scrap Metal") <= 10 then
                        getgenv().Config["Auto Dragon HunterMagnet"] = true
                    elseif GetMaterial("Scrap Metal") < 10 and GetMaterial("Blaze Ember") >= 15 then
                        local enemies = workspace.Enemies
                        if enemies:FindFirstChild("Forest Pirate") then
                            for _, v in pairs(enemies:GetChildren()) do
                                if v.Name == "Forest Pirate" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                                    humanoid = v.Humanoid
                                    rootPart = v.HumanoidRootPart
                                    if humanoid.Health > 0 then
                                        repeat
                                            task.wait()
                                            AutoHaki()
                                            EquipWeapon(_G['Select Weapon'])
                                            rootPart.CanCollide = false
                                            humanoid.WalkSpeed = 0
                                            BringMob(rootPart.CFrame) 
                                            TP(rootPart.CFrame * Pos)
                                            sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                        until not getgenv().Config["Auto Craft Volcanic Magnet"] or not v.Parent or humanoid.Health <= 0
                                    end
                                end
                            end
                        else
                            local playerPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                            if BypassTP then
                                if (playerPos - AutoFarmLeatherVolcanic.Position).Magnitude > 1500 then
                                    TP(AutoFarmLeatherVolcanic)
                                else
                                    TP(AutoFarmLeatherVolcanic)
                                end
                            else
                                TP(AutoFarmLeatherVolcanic)
                            end
                            TP(AutoFarmLeatherVolcanic)
                        end
                    else
                        local args = {
                            [1] = "CraftItem",
                            [2] = "Craft",
                            [3] = "Volcanic Magnet"
                        }
                        
                        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))                        
                    end
                end
            end)
        else
            getgenv().Config["Auto Dragon HunterMagnet"] = false
        end
    end
end)
local doingQuestMagnet = false
spawn(function()
    while wait() do
        if getgenv().Config["Auto Dragon HunterMagnet"] and not doingQuestMagnet then
            doingQuestMagnet = true
            pcall(function()
                TP(CFrame.new(5864.96729, 1209.49329, 810.422363))
                task.wait()
                local questData = game:GetService("ReplicatedStorage").Modules.Net["RF/DragonHunter"]:InvokeServer({
                    ["Context"] = "Check" })
                if questData then
                    local activeQuest = false
                    for _, value in pairs(questData) do
                        local questLocations = {
                            ["Defeat 3 Venomous Assailants on Hydra Island."] = { CFrame.new(4460, 1218, 663), "Venomous Assailant", 3 },
                            ["Defeated 1/3 Venomous Assailants on Hydra Island."] = { CFrame.new(4460, 1218, 663), "Venomous Assailant", 2 },
                            ["Defeated 2/3 Venomous Assailants on Hydra Island."] = { CFrame.new(4460, 1218, 663), "Venomous Assailant", 1 },
                            ["Defeat 3 Hydra Enforcers on Hydra Island."] = { CFrame.new(4555, 1002, 478), "Hydra Enforcer", 3 },
                            ["Defeated 1/3 Hydra Enforcers on Hydra Island."] = { CFrame.new(4555, 1002, 478), "Hydra Enforcer", 2 },
                            ["Defeated 2/3 Hydra Enforcers on Hydra Island."] = { CFrame.new(4555, 1002, 478), "Hydra Enforcer", 1 },
                            ["Destroy 10 trees on Hydra Island."] = { CFrame.new(5287.32959, 1005.39813, 398.474274, 0.51608938, 6.28953956e-08, -0.856534719, -5.03406667e-08, 1, 4.30982112e-08, 0.856534719, 2.08759996e-08, 0.51608938), "Tree", 1 },
                            ["Destroyed 1/10 trees on Hydra Island."] = { CFrame.new(5347.45361, 1004.19812, 358.860504, -0.55470717, 1.76127504e-08, 0.832045674, 7.96258561e-08, 1, 3.19168585e-08, -0.832045674, 8.39568557e-08, -0.55470717), "Tree", 1 },
                            ["Destroyed 2/10 trees on Hydra Island."] = { CFrame.new(5234.77588, 1004.19812, 431.294434, 0.546005368, -2.78318524e-08, -0.837781668, -2.16353033e-08, 1, -4.73212118e-08, 0.837781668, 4.3963297e-08, 0.546005368), "Tree", 1 },
                            ["Destroyed 3/10 trees on Hydra Island."] = { CFrame.new(5262.0957, 1004.19812, 351.249573, -0.842448711, 9.36148794e-08, -0.538776517, 8.04484728e-08, 1, 4.79626792e-08, 0.538776517, -2.93765212e-09, -0.842448711), "Tree", 1 },
                            ["Destroyed 4/10 trees on Hydra Island."] = { CFrame.new(5322.82715, 1004.19812, 440.443268, 0.842484713, 4.23488711e-09, 0.53872025, 1.17971739e-08, 1, -2.63101789e-08, -0.53872025, 2.85212991e-08, 0.842484713), "Tree", 1 },
                            ["Destroyed 5/10 trees on Hydra Island."] = { CFrame.new(5347.45361, 1004.19812, 358.860504, -0.55470717, 1.76127504e-08, 0.832045674, 7.96258561e-08, 1, 3.19168585e-08, -0.832045674, 8.39568557e-08, -0.55470717), "Tree", 1 },
                            ["Destroyed 6/10 trees on Hydra Island."] = { CFrame.new(5322.82715, 1004.19812, 440.443268, 0.842484713, 4.23488711e-09, 0.53872025, 1.17971739e-08, 1, -2.63101789e-08, -0.53872025, 2.85212991e-08, 0.842484713), "Tree", 1 },
                            ["Destroyed 7/10 trees on Hydra Island."] = { CFrame.new(5287.32959, 1005.39813, 398.474274, 0.51608938, 6.28953956e-08, -0.856534719, -5.03406667e-08, 1, 4.30982112e-08, 0.856534719, 2.08759996e-08, 0.51608938), "Tree", 1 },
                            ["Destroyed 8/10 trees on Hydra Island."] = { CFrame.new(5262.0957, 1004.19812, 351.249573, -0.842448711, 9.36148794e-08, -0.538776517, 8.04484728e-08, 1, 4.79626792e-08, 0.538776517, -2.93765212e-09, -0.842448711), "Tree", 1 },
                            ["Destroyed 9/10 trees on Hydra Island."] = { CFrame.new(5347.45361, 1004.19812, 358.860504, -0.55470717, 1.76127504e-08, 0.832045674, 7.96258561e-08, 1, 3.19168585e-08, -0.832045674, 8.39568557e-08, -0.55470717), "Tree", 1 },
                        }
                        if questLocations[value] then
                            local questInfo = questLocations[value]
                            local questCFrame, targetName, targetCount = unpack(questInfo)
                            TP(questCFrame)
                            task.wait(3.7)
                            local killCount = 0
                            while killCount < targetCount and getgenv().Config["Auto Dragon HunterMagnet"] do
                                local objects = workspace.Enemies:GetChildren()
                                if value:find("Destroy 10 trees on Hydra Island.") or value:find("Destroyed 1/10 trees on Hydra Island.") or value:find("Destroyed 2/10 trees on Hydra Island.") or value:find("Destroyed 3/10 trees on Hydra Island.") or value:find("Destroyed 4/10 trees on Hydra Island.") or value:find("Destroyed 5/10 trees on Hydra Island.") or value:find("Destroyed 6/10 trees on Hydra Island.") or value:find("Destroyed 7/10 trees on Hydra Island.") or value:find("Destroyed 8/10 trees on Hydra Island.") or value:find("Destroyed 9/10 trees on Hydra Island.") then
                                    objects = game:GetService("Workspace").Map.Waterfall:FindFirstChild(
                                        "IslandModel"):GetChildren()
                                end
                                for _, obj in pairs(objects) do
                                    if obj.Name == targetName and obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChild("Tree") then
                                        if value:find("Destroy 10 trees on Hydra Island.") or value:find("Destroyed 1/10 trees on Hydra Island.") or value:find("Destroyed 2/10 trees on Hydra Island.") or value:find("Destroyed 3/10 trees on Hydra Island.") or value:find("Destroyed 4/10 trees on Hydra Island.") or value:find("Destroyed 5/10 trees on Hydra Island.") or value:find("Destroyed 6/10 trees on Hydra Island.") or value:find("Destroyed 7/10 trees on Hydra Island.") or value:find("Destroyed 8/10 trees on Hydra Island.") or value:find("Destroyed 9/10 trees on Hydra Island.") then
                                            task.wait(1)
                                        else
                                            local humanoid = obj:FindFirstChild("Humanoid")
                                            if humanoid and humanoid.Health > 0 then
                                                repeat
                                                    task.wait()
                                                    AutoHaki()
                                                    EquipWeapon(_G['Select Weapon'])
                                                    obj.HumanoidRootPart.CanCollide = false
                                                    humanoid.WalkSpeed = 0
                                                    TP(obj.HumanoidRootPart.CFrame * Pos)
                                                    BringMob(obj.HumanoidRootPart.CFrame) 
                                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius",
                                                        math.huge)
                                                until not getgenv().Config["Auto Dragon HunterMagnet"] or not obj.Parent or humanoid.Health <= 0
                                            end
                                        end
                                        killCount = killCount + 1
                                        if killCount >= targetCount then
                                            break
                                        end
                                    end
                                end
                                task.wait()
                            end
                            activeQuest = true
                            break
                        end
                    end
                    if not activeQuest then
                        game:GetService("ReplicatedStorage").Modules.Net["RF/DragonHunter"]:InvokeServer({
                            ["Context"] = "RequestQuest" })
                        task.wait()
                    end
                end
            end)
            doingQuestMagnet = false
        end
        task.wait()
    end
end)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Dragon HunterMagnet"] and doingQuestMagnet then
            pcall(function()
                local objects = game:GetService("Workspace").Map.Waterfall:FindFirstChild("IslandModel"):GetChildren()
                for _, v in pairs(objects) do
                    if v:FindFirstChild("Tree") then
                        local tree = v:FindFirstChild("Tree")
                        local Poswolrd = tree:GetPivot()
                        local Pos = Poswolrd.Position
                        if (Pos - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 125 then
                            game:service("VirtualInputManager"):SendKeyEvent(true, "One", false, game)
                            game:service("VirtualInputManager"):SendKeyEvent(false, "One", false, game)
                            if _G['Skill Z'] then useSkill("Z") end
                            if _G['Skill X'] then useSkill("X") end
                            if _G['Skill C'] then useSkill("C") end
                            if _G['Skill V'] then useSkill("V") end
                            if _G['Skill F'] then useSkill("F") end
                            game:service("VirtualInputManager"):SendKeyEvent(true, "Two", false, game)
                            game:service("VirtualInputManager"):SendKeyEvent(false, "Two", false, game)
                            if _G['Skill Z'] then useSkill("Z") end
                            if _G['Skill X'] then useSkill("X") end
                            if _G['Skill C'] then useSkill("C") end
                            if _G['Skill V'] then useSkill("V") end
                            if _G['Skill F'] then useSkill("F") end
                            game:service("VirtualInputManager"):SendKeyEvent(true, "Three", false, game)
                            game:service("VirtualInputManager"):SendKeyEvent(false, "Three", false, game)
                            if _G['Skill Z'] then useSkill("Z") end
                            if _G['Skill X'] then useSkill("X") end
                            if _G['Skill C'] then useSkill("C") end
                            if _G['Skill V'] then useSkill("V") end
                            if _G['Skill F'] then useSkill("F") end
                            game:service("VirtualInputManager"):SendKeyEvent(true, "Four", false, game)
                            game:service("VirtualInputManager"):SendKeyEvent(false, "Four", false, game)
                            if _G['Skill Z'] then useSkill("Z") end
                            if _G['Skill X'] then useSkill("X") end
                            if _G['Skill C'] then useSkill("C") end
                            if _G['Skill V'] then useSkill("V") end
                            if _G['Skill F'] then useSkill("F") end
                        end
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while task.wait() do
        if getgenv().Config["Auto Collect Blaze Ember"] then
            pcall(function()
                local CFrameMe = game.Players.LocalPlayer.Character.HumanoidRootPart
                for i, v in pairs(game:GetService("Workspace").EmberTemplate:GetChildren()) do
                    v.CFrame = CFrameMe.CFrame
                    task.wait()
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        pcall(function()
            if getgenv().Config["Auto Find Prehistoric Island"] and L_7449423635_ then
                    if not game:GetService("Workspace").Boats:FindFirstChild("PirateGrandBrigade") then
                        buyb = TP(CFrame.new(-16192.2539, 12.3828964, 1738.85999, -0.997757435, 4.43451498e-08,
                            -0.0669331998, 5.01932291e-08, 1, -8.56902034e-08, 0.0669331998, -8.88576324e-08,
                            -0.997757435))
                        if (CFrame.new(-16192.2539, 12.3828964, 1738.85999, -0.997757435, 4.43451498e-08, -0.0669331998, 5.01932291e-08, 1, -8.56902034e-08, 0.0669331998, -8.88576324e-08, -0.997757435).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 10 then
                            if buyb then buyb:Stop() end
                            local args = {
                                [1] = "BuyBoat",
                                [2] = "PirateGrandBrigade"
                            }
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                        end
                    elseif game:GetService("Workspace").Boats:FindFirstChild("PirateGrandBrigade") then
                        if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit == false then
                            TPP(game:GetService("Workspace").Boats.PirateGrandBrigade.VehicleSeat.CFrame *
                                CFrame.new(0, 1, 0))
                        else
                            for i, v in pairs(game:GetService("Workspace").Boats:GetChildren()) do
                                if v.Name == "PirateGrandBrigade" then
                                    repeat
                                        wait()
                                        PlayBoatsTween(CFrame.new(-99999999, 10.964323997497559, -324.4842224121094))
                                    until game:GetService("Workspace").SeaBeasts:FindFirstChild("d") or game:GetService("Workspace").SeaBeasts:FindFirstChild("dz") or game:GetService("Workspace").SeaBeasts:FindFirstChild("ddd") or not getgenv().Config["Auto Find Prehistoric Island"] or _G.StopTweenBoat == false
                            end
                        end
                    end
                end
            end
        end)
    end
end)
spawn(function()
    while task.wait() do
        if getgenv().Config["Teleport to Prehistoric Island"] then
            if game:GetService("Workspace").Map:FindFirstChild("PrehistoricRelic") or game.Workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") then
                game.Players.LocalPlayer.Character.Humanoid.Sit = false
                TP(game.Workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island").CFrame * CFrame.new(0,20,0))
            end
        end
    end
end)
local isSealingLava = false
local isAttackingGolem = false
local function attackLavaGolem()
    if isSealingLava then return end 
    local golems = {}
    for _, enemy in pairs(game.workspace.Enemies:GetChildren()) do
        if enemy.Name == "Lava Golem" and enemy:FindFirstChild("HumanoidRootPart") and enemy.Humanoid.Health > 0 then
            table.insert(golems, enemy)
        end
    end
    if #golems > 0 then
        isAttackingGolem = true
        for _, golem in pairs(golems) do
            repeat
                if golem and golem:FindFirstChild("HumanoidRootPart") and golem.Humanoid.Health > 0 then
                    EquipWeapon(_G['Select Weapon'])
                    TP(golem.HumanoidRootPart.CFrame * Pos)
                end
                wait(0.5)
            until golem == nil or golem.Humanoid.Health <= 0 or not getgenv().Config["Auto Relic Events"]
        end
        isAttackingGolem = false
    end
end
local function sealLava()
    if isAttackingGolem then return end
    for _, v in pairs(game.workspace.Map.PrehistoricIsland.Core.VolcanoRocks:GetChildren()) do
        local checkcolor = v:FindFirstChild("volcanorock")
        local checkcolorVFXLayer = v:FindFirstChild("VFXLayer")
        if checkcolor and checkcolorVFXLayer and checkcolor:IsA("BasePart") and checkcolor.BrickColor.Name == "Bright red" or checkcolorVFXLayer.BrickColor.Name == "Bright red" then
            isSealingLava = true
            repeat wait()
                TP(checkcolor.CFrame + Vector3.new(0, 5, 0))
                Posvolcanorock = checkcolor.Position
                game:service("VirtualInputManager"):SendKeyEvent(true, "One", false, game)
                game:service("VirtualInputManager"):SendKeyEvent(false, "One", false, game)
                if _G['Skill Z'] then useSkill("Z") end
                if _G['Skill X'] then useSkill("X") end
                if _G['Skill C'] then useSkill("C") end
                if _G['Skill V'] then useSkill("V") end
                if _G['Skill F'] then useSkill("F") end
                game:service("VirtualInputManager"):SendKeyEvent(true, "Two", false, game)
                game:service("VirtualInputManager"):SendKeyEvent(false, "Two", false, game)
                if _G['Skill Z'] then useSkill("Z") end
                if _G['Skill X'] then useSkill("X") end
                if _G['Skill C'] then useSkill("C") end
                if _G['Skill V'] then useSkill("V") end
                if _G['Skill F'] then useSkill("F") end
                game:service("VirtualInputManager"):SendKeyEvent(true, "Three", false, game)
                game:service("VirtualInputManager"):SendKeyEvent(false, "Three", false, game)
                if _G['Skill Z'] then useSkill("Z") end
                if _G['Skill X'] then useSkill("X") end
                if _G['Skill C'] then useSkill("C") end
                if _G['Skill V'] then useSkill("V") end
                if _G['Skill F'] then useSkill("F") end
                game:service("VirtualInputManager"):SendKeyEvent(true, "Four", false, game)
                game:service("VirtualInputManager"):SendKeyEvent(false, "Four", false, game)
                if _G['Skill Z'] then useSkill("Z") end
                if _G['Skill X'] then useSkill("X") end
                if _G['Skill C'] then useSkill("C") end
                if _G['Skill V'] then useSkill("V") end
                if _G['Skill F'] then useSkill("F") end
            until checkcolor.BrickColor.Name ~= "Bright red" or checkcolorVFXLayer.BrickColor.Name ~= "Bright red" or not getgenv().Config["Auto Relic Events"]
            if checkcolor.BrickColor.Name ~= "Bright red" and checkcolorVFXLayer.BrickColor.Name ~= "Bright red" then
                isSealingLava = false 
                attackLavaGolem()
            end
            break
        end
    end
end
spawn(function()
    while wait() do
        if getgenv().Config["Auto Relic Events"] then
            pcall(function()
                if game.workspace.Map:FindFirstChild("PrehistoricIsland") then
                    game.Players.LocalPlayer.Character.Humanoid.Sit = false
                end
                if not isSealingLava then
                    attackLavaGolem()
                end
                if not isAttackingGolem then
                    sealLava()
                end
                if not isAttackingGolem and not isSealingLava then
                    TP(game.workspace.Map.PrehistoricIsland.Core.ActivationPrompt.CFrame)
                end
            end)
        end
    end
end)
local gg = getrawmetatable(game)
local old = gg.__namecall
setreadonly(gg, false)
gg.__namecall = newcclosure(function(...)
    local method = getnamecallmethod()
    local args = { ... }
    if tostring(method) == "FireServer" then
        if tostring(args[1]) == "RemoteEvent" then
            if tostring(args[2]) ~= "true" and tostring(args[2]) ~= "false" then
                if getgenv().Config["Auto Relic Events"] then
                    args[2] = Posvolcanorock
                    return old(unpack(args))
                end
            end
        end
    end
    return old(...)
end)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Relic Events"] then
            pcall(function()
                if game.workspace.Map:FindFirstChild("PrehistoricIsland") then
                    game.Players.LocalPlayer.Character.Humanoid.Sit = false
                end
                if not isAttackingGolem and not isSealingLava then
                    for i, v in  pairs(game.workspace.Map.PrehistoricIsland.Core:GetDescendants()) do
                        if v.Name == "ProximityPrompt" then
                        fireproximityprompt(v, 40)
                        end
                    end
                end
            end)
        end
    end
end)
_G.DestroycheckTouchInterest = true
spawn(function()
    while wait() do
        if _G.DestroycheckTouchInterest then
            pcall(function()
                if game.workspace.Map:FindFirstChild("PrehistoricIsland") then
                for i, v in pairs(game.workspace.Map.PrehistoricIsland:GetDescendants()) do
                    local checkTouchInterest = v:FindFirstChild("TouchInterest")
                        if checkTouchInterest then
                            checkTouchInterest:Destroy()
                        end
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Collect Dinosaur Bones"] then
            pcall(function()
                for i,v in  pairs(game.workspace:GetChildren()) do
                    if v.Name == "DinoBone" then
                    TP(v.CFrame)
                    else
                        break
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Collect Dragon Egg"] then
            pcall(function()
                for i, v in pairs(game.workspace.Map.PrehistoricIsland.Core.SpawnedDragonEggs:GetDescendants()) do
                    if v.Name == "DragonEgg" then
                    repeat wait()
                    TP(v.Molten.CFrame)
                    until not getgenv().Config["Auto Collect Dragon Egg"] or v.Name ~= "DragonEgg"
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Collect Dragon Egg"] then
            pcall(function()
                for i, v in pairs(game.workspace.Map.PrehistoricIsland.Core.SpawnedDragonEggs:GetDescendants()) do
                    if v.Name == "ProximityPrompt" then
                    repeat wait()
                    fireproximityprompt(v, 40)
                    until not getgenv().Config["Auto Collect Dragon Egg"] or v.Name ~= "ProximityPrompt"
                    end
                end
            end)
        end
    end
end)
AutoFarmLeather = CFrame.new(-1223, 14, 4060)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Farm Materials"] and L_2753915549_ and Config["Select Materials"] == "Leather" then
            pcall(function()
                local enemies = workspace.Enemies
                if enemies:FindFirstChild("Pirate") and enemies:FindFirstChild("Brute") then
                    for _, v in pairs(enemies:GetChildren()) do
                        if v.Name == "Pirate" or v.Name == "Brute" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                            humanoid = v.Humanoid
                            rootPart = v.HumanoidRootPart
                            if humanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G['Select Weapon'])
                                    rootPart.CanCollide = false
                                    humanoid.WalkSpeed = 0
                                    BringMob(rootPart.CFrame) 
                                    TP(rootPart.CFrame * Pos)
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                until not getgenv().Config["Auto Farm Materials"] or not v.Parent or humanoid.Health <= 0 or Config["Select Materials"] ~= "Leather"
                            end
                        end
                    end
                else
                    local playerPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                    if BypassTP then
                        if (playerPos - AutoFarmLeather.Position).Magnitude > 1500 then
                            TP(AutoFarmLeather)
                        else
                            TP(AutoFarmLeather)
                        end
                    else
                        TP(AutoFarmLeather)
                    end
                    TP(AutoFarmLeather)
                end
            end)
        end
    end
end)
local AutoFarmLeather2 = CFrame.new(-988.00415, 172.441269, 1438.27039, -0.00364514231, 3.70347131e-09, 0.999993384,
    1.41154317e-07, 1, -3.18896487e-09, -0.999993384, 1.41141754e-07, -0.00364514231)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Farm Materials"] and L_4442272183_ and Config["Select Materials"] == "Leather" then
            pcall(function()
                local enemies = workspace.Enemies
                if enemies:FindFirstChild("Mercenary") then
                    for _, v in pairs(enemies:GetChildren()) do
                        if v.Name == "Mercenary" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                            local humanoid = v.Humanoid
                            local rootPart = v.HumanoidRootPart
                            if humanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G['Select Weapon'])
                                    rootPart.CanCollide = false
                                    humanoid.WalkSpeed = 0
                                    BringMob(rootPart.CFrame) 
                                    TP(rootPart.CFrame * Pos)
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                until not getgenv().Config["Auto Farm Materials"] or not v.Parent or humanoid.Health <= 0 or Config["Select Materials"] ~= "Leather"
                            end
                        end
                    end
                else
                    local playerPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                    if BypassTP then
                        if (playerPos - AutoFarmLeather2.Position).Magnitude > 1500 then
                            TP(AutoFarmLeather2)
                        else
                            TP(AutoFarmLeather2)
                        end
                    else
                        TP(AutoFarmLeather2)
                    end
                    TP(AutoFarmLeather2)
                end
            end)
        end
    end
end)
local check = false
local AutoFarmLeather3 = CFrame.new(-13354.001, 379.738068, -7752.01367, 0.792679489, -2.59651269e-08, -0.609638572,
    -1.42174805e-08, 1, -6.10772233e-08, 0.609638572, 5.70821896e-08, 0.792679489)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Farm Materials"] and L_7449423635_ and Config["Select Materials"] == "Leather" then
            pcall(function()
                local enemies = workspace.Enemies
                if enemies:FindFirstChild("Forest Pirate") then
                    for _, v in pairs(enemies:GetChildren()) do
                        if v.Name == "Forest Pirate" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                            local humanoid = v.Humanoid
                            local rootPart = v.HumanoidRootPart
                            if humanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G['Select Weapon'])
                                    rootPart.CanCollide = false
                                    humanoid.WalkSpeed = 0
                                    BringMob(rootPart.CFrame) 
                                    TP(rootPart.CFrame * Pos)
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                until not getgenv().Config["Auto Farm Materials"] or not v.Parent or humanoid.Health <= 0 or Config["Select Materials"] ~= "Leather"
                            end
                        end
                    end
                else
                    local playerPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                    if BypassTP then
                        if (playerPos - AutoFarmLeather3.Position).Magnitude > 1500 then
                            TP(AutoFarmLeather3)
                        else
                            TP(AutoFarmLeather3)
                        end
                    else
                        TP(AutoFarmLeather3)
                    end
                    TP(AutoFarmLeather3)
                end
            end)
        end
    end
end)
AutoFarmLeather = CFrame.new(-1223, 14, 4060)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Farm Materials"] and L_2753915549_ and Config["Select Materials"] == "Scrap Meta" then
            pcall(function()
                local enemies = workspace.Enemies
                if enemies:FindFirstChild("Pirate") and enemies:FindFirstChild("Brute") then
                    for _, v in pairs(enemies:GetChildren()) do
                        if v.Name == "Pirate" or v.Name == "Brute" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                            humanoid = v.Humanoid
                            rootPart = v.HumanoidRootPart
                            if humanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G['Select Weapon'])
                                    rootPart.CanCollide = false
                                    humanoid.WalkSpeed = 0
                                    BringMob(rootPart.CFrame) 
                                    TP(rootPart.CFrame * Pos)
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                until not getgenv().Config["Auto Farm Materials"] or not v.Parent or humanoid.Health <= 0 or Config["Select Materials"] ~= "Scrap Meta"
                            end
                        end
                    end
                else
                    local playerPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                    if BypassTP then
                        if (playerPos - AutoFarmLeather.Position).Magnitude > 1500 then
                            TP(AutoFarmLeather)
                        else
                            TP(AutoFarmLeather)
                        end
                    else
                        TP(AutoFarmLeather)
                    end
                    TP(AutoFarmLeather)
                end
            end)
        end
    end
end)
local AutoFarmLeather2 = CFrame.new(-988.00415, 172.441269, 1438.27039, -0.00364514231, 3.70347131e-09, 0.999993384,
    1.41154317e-07, 1, -3.18896487e-09, -0.999993384, 1.41141754e-07, -0.00364514231)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Farm Materials"] and L_4442272183_ and Config["Select Materials"] == "Scrap Meta" then
            pcall(function()
                local enemies = workspace.Enemies
                if enemies:FindFirstChild("Mercenary") then
                    for _, v in pairs(enemies:GetChildren()) do
                        if v.Name == "Mercenary" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                            local humanoid = v.Humanoid
                            local rootPart = v.HumanoidRootPart
                            if humanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G['Select Weapon'])
                                    rootPart.CanCollide = false
                                    humanoid.WalkSpeed = 0
                                    BringMob(rootPart.CFrame) 
                                    TP(rootPart.CFrame * Pos)
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                until not getgenv().Config["Auto Farm Materials"] or not v.Parent or humanoid.Health <= 0 or Config["Select Materials"] ~= "Scrap Meta"
                            end
                        end
                    end
                else
                    local playerPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                    if BypassTP then
                        if (playerPos - AutoFarmLeather2.Position).Magnitude > 1500 then
                            TP(AutoFarmLeather2)
                        else
                            TP(AutoFarmLeather2)
                        end
                    else
                        TP(AutoFarmLeather2)
                    end
                    TP(AutoFarmLeather2)
                end
            end)
        end
    end
end)
local check = false
local AutoFarmLeather3 = CFrame.new(-13354.001, 379.738068, -7752.01367, 0.792679489, -2.59651269e-08, -0.609638572,
    -1.42174805e-08, 1, -6.10772233e-08, 0.609638572, 5.70821896e-08, 0.792679489)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Farm Materials"] and L_7449423635_ and Config["Select Materials"] == "Scrap Meta" then
            pcall(function()
                local enemies = workspace.Enemies
                if enemies:FindFirstChild("Forest Pirate") then
                    for _, v in pairs(enemies:GetChildren()) do
                        if v.Name == "Forest Pirate" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                            local humanoid = v.Humanoid
                            local rootPart = v.HumanoidRootPart
                            if humanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G['Select Weapon'])
                                    rootPart.CanCollide = false
                                    humanoid.WalkSpeed = 0
                                    BringMob(rootPart.CFrame) 
                                    TP(rootPart.CFrame * Pos)
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                until not getgenv().Config["Auto Farm Materials"] or not v.Parent or humanoid.Health <= 0 or Config["Select Materials"] ~= "Scrap Meta"
                            end
                        end
                    end
                else
                    local playerPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                    if BypassTP then
                        if (playerPos - AutoFarmLeather3.Position).Magnitude > 1500 then
                            TP(AutoFarmLeather3)
                        else
                            TP(AutoFarmLeather3)
                        end
                    else
                        TP(AutoFarmLeather3)
                    end
                    TP(AutoFarmLeather3)
                end
            end)
        end
    end
end)
local AutoFarmFiahTail = CFrame.new(60887, 96, 1546)
local requestEntranceDone = false
spawn(function()
    while task.wait() do
        if getgenv().Config["Auto Farm Materials"] and L_2753915549_ and Config["Select Materials"] == "Fiah Tail" then
            pcall(function()
                if not requestEntranceDone then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",
                        Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
                    requestEntranceDone = true
                end
                local enemies = workspace.Enemies
                if enemies:FindFirstChild("Fishman Warrior") then
                    for _, v in pairs(enemies:GetChildren()) do
                        if v.Name == "Fishman Warrior" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                            local humanoid = v.Humanoid
                            local rootPart = v.HumanoidRootPart
                            if humanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G['Select Weapon'])
                                    rootPart.CanCollide = false
                                    humanoid.WalkSpeed = 0
                                    BringMob(rootPart.CFrame) 
                                    TP(rootPart.CFrame * Pos)
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                until not getgenv().Config["Auto Farm Materials"] or not v.Parent or humanoid.Health <= 0 or Config["Select Materials"] ~= "Fiah Tail"
                            end
                        end
                    end
                else
                    local playerPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                    if BypassTP then
                        if (playerPos - AutoFarmFiahTail.Position).Magnitude > 1500 then
                            TP(AutoFarmFiahTail)
                        else
                            TP(AutoFarmFiahTail)
                        end
                    else
                        TP(AutoFarmFiahTail)
                    end
                    TP(AutoFarmFiahTail)
                end
            end)
        else
            requestEntranceDone = false
        end
    end
end)
local AutoFarmFiahTail3 = CFrame.new(-10491.3994, 367.740082, -8434.71387, -0.663893342, -2.15274039e-08,
    -0.747827291, -3.12983373e-09, 1, -2.6008049e-08, 0.747827291, -1.49259947e-08, -0.663893342)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Farm Materials"] and L_7449423635_ and Config["Select Materials"] == "Fiah Tail" then
            pcall(function()
                local enemies = workspace.Enemies
                if enemies:FindFirstChild("Fishman Raider") then
                    for _, v in pairs(enemies:GetChildren()) do
                        if v.Name == "Fishman Raider" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                            local humanoid = v.Humanoid
                            local rootPart = v.HumanoidRootPart
                            if humanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G['Select Weapon'])
                                    rootPart.CanCollide = false
                                    humanoid.WalkSpeed = 0
                                    BringMob(rootPart.CFrame) 
                                    TP(rootPart.CFrame * Pos)
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                until not getgenv().Config["Auto Farm Materials"] or not v.Parent or humanoid.Health <= 0 or Config["Select Materials"] ~= "Fiah Tail"
                            end
                        end
                    end
                else
                    local playerPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                    if BypassTP then
                        if (playerPos - AutoFarmFiahTail3.Position).Magnitude > 1500 then
                            TP(AutoFarmFiahTail3)
                        else
                            TP(AutoFarmFiahTail3)
                        end
                    else
                        TP(AutoFarmFiahTail3)
                    end
                    TP(AutoFarmFiahTail3)
                end
            end)
        end
    end
end)
local AutoFarmMagmaOre = CFrame.new(-5408, 11, 8455)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Farm Materials"] and L_2753915549_ and Config["Select Materials"] == "Magma Ore" then
            pcall(function()
                local enemies = workspace.Enemies
                if enemies:FindFirstChild("Military Soldier") then
                    for _, v in pairs(enemies:GetChildren()) do
                        if v.Name == "Military Soldier" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                            local humanoid = v.Humanoid
                            local rootPart = v.HumanoidRootPart
                            if humanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G['Select Weapon'])
                                    rootPart.CanCollide = false
                                    humanoid.WalkSpeed = 0
                                    BringMob(rootPart.CFrame) 
                                    TP(rootPart.CFrame * Pos)
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                until not getgenv().Config["Auto Farm Materials"] or not v.Parent or humanoid.Health <= 0 or Config["Select Materials"] ~= "Magma Ore"
                            end
                        end
                    end
                else
                    local playerPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                    if BypassTP then
                        if (playerPos - AutoFarmMagmaOre.Position).Magnitude > 1500 then
                            TP(AutoFarmMagmaOre)
                        else
                            TP(AutoFarmMagmaOre)
                        end
                    else
                        TP(AutoFarmMagmaOre)
                    end
                    TP(AutoFarmMagmaOre)
                end
            end)
        end
    end
end)
local AutoFarmMagmaOre2 = CFrame.new(-5230.55029, 33.2870216, -4664.38574, 0.927146196, -5.82520059e-08, -0.374699801,
    4.83817786e-08, 1, -3.57486805e-08, 0.374699801, 1.50156101e-08, 0.927146196)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Farm Materials"] and L_4442272183_ and Config["Select Materials"] == "Magma Ore" then
            pcall(function()
                local enemies = workspace.Enemies
                if enemies:FindFirstChild("Lava Pirate") then
                    for _, v in pairs(enemies:GetChildren()) do
                        if v.Name == "Lava Pirate" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                            local humanoid = v.Humanoid
                            local rootPart = v.HumanoidRootPart
                            if humanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G['Select Weapon'])
                                    rootPart.CanCollide = false
                                    humanoid.WalkSpeed = 0
                                    BringMob(rootPart.CFrame) 
                                    TP(rootPart.CFrame * Pos)
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                until not getgenv().Config["Auto Farm Materials"] or not v.Parent or humanoid.Health <= 0 or Config["Select Materials"] ~= "Magma Ore"
                            end
                        end
                    end
                else
                    local playerPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                    if BypassTP then
                        if (playerPos - AutoFarmMagmaOre2.Position).Magnitude > 1500 then
                            TP(AutoFarmMagmaOre2)
                        else
                            TP(AutoFarmMagmaOre2)
                        end
                    else
                        TP(AutoFarmMagmaOre2)
                    end
                    TP(AutoFarmMagmaOre2)
                end
            end)
        end
    end
end)
local AutoFarmAngelWings = CFrame.new(-7833.17236, 5664.76709, -1738.12341, 0.984430254, -2.88010131e-08, 0.175775602,
    6.88215662e-09, 1, 1.25307551e-07, -0.175775602, -1.2214683e-07, 0.984430254)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Farm Materials"] and L_2753915549_ and Config["Select Materials"] == "Angel Wings" then
            pcall(function()
                local enemies = workspace.Enemies
                if enemies:FindFirstChild("Royal Soldier") then
                    for _, v in pairs(enemies:GetChildren()) do
                        if v.Name == "Royal Soldier" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                            local humanoid = v.Humanoid
                            local rootPart = v.HumanoidRootPart
                            if humanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G['Select Weapon'])
                                    rootPart.CanCollide = false
                                    BringMob(rootPart.CFrame)
                                    humanoid.WalkSpeed = 0
                                    BringMob(rootPart.CFrame) 
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                until not getgenv().Config["Auto Farm Materials"] or not v.Parent or humanoid.Health <= 0 or Config["Select Materials"] ~= "Angel Wings"
                            end
                        end
                    end
                else
                    local playerPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                    if BypassTP then
                        if (playerPos - AutoFarmAngelWings.Position).Magnitude > 1500 then
                            TP(AutoFarmAngelWings)
                        else
                            TP(AutoFarmAngelWings)
                        end
                    else
                        TP(AutoFarmAngelWings)
                    end
                    TP(AutoFarmAngelWings)
                end
            end)
        end
    end
end)
local AutoFarmRadioactiveMaterials = CFrame.new(426, 133, 82)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Farm Materials"] and L_4442272183_ and Config["Select Materials"] == "Radioactive Materials" then
            pcall(function()
                local enemies = workspace.Enemies
                if enemies:FindFirstChild("Factory Staff") then
                    for _, v in pairs(enemies:GetChildren()) do
                        if v.Name == "Factory Staff" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                            local humanoid = v.Humanoid
                            local rootPart = v.HumanoidRootPart
                            if humanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G['Select Weapon'])
                                    rootPart.CanCollide = false
                                    BringMob(rootPart.CFrame) 
                                    humanoid.WalkSpeed = 0
                                    TP(rootPart.CFrame * Pos)
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                until not getgenv().Config["Auto Farm Materials"] or not v.Parent or humanoid.Health <= 0 or Config["Select Materials"] ~= "Radioactive Materials"
                            end
                        end
                    end
                else
                    local playerPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                    if BypassTP then
                        if (playerPos - AutoFarmRadioactiveMaterials.Position).Magnitude > 1500 then
                            TP(AutoFarmRadioactiveMaterials)
                        else
                            TP(AutoFarmRadioactiveMaterials)
                        end
                    else
                        TP(AutoFarmRadioactiveMaterials)
                    end
                    TP(AutoFarmRadioactiveMaterials)
                end
            end)
        end
    end
end)
local AutoFarmDemonicWips = CFrame.new(-9265, 217, 6123)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Farm Materials"] and L_7449423635_ and Config["Select Materials"] == "Demonic Wips" then
            pcall(function()
                local enemies = workspace.Enemies
                if enemies:FindFirstChild("Demonic Soul") then
                    for _, v in pairs(enemies:GetChildren()) do
                        if v.Name == "Demonic Soul" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                            local humanoid = v.Humanoid
                            local rootPart = v.HumanoidRootPart
                            if humanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G['Select Weapon'])
                                    rootPart.CanCollide = false
                                    BringMob(rootPart.CFrame) 
                                    humanoid.WalkSpeed = 0
                                    TP(rootPart.CFrame * Pos)
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                until not getgenv().Config["Auto Farm Materials"] or not v.Parent or humanoid.Health <= 0 or Config["Select Materials"] ~= "Demonic Wips"
                            end
                        end
                    end
                else
                    local playerPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                    if BypassTP then
                        if (playerPos - AutoFarmDemonicWips.Position).Magnitude > 1500 then
                            TP(AutoFarmDemonicWips)
                        else
                            TP(AutoFarmDemonicWips)
                        end
                    else
                        TP(AutoFarmDemonicWips)
                    end
                    TP(AutoFarmDemonicWips)
                end
            end)
        end
    end
end)
local AutoFarmVampireFang = CFrame.new(-6183, 76, -1178)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Farm Materials"] and L_4442272183_ and Config["Select Materials"] == "Vampire Fang" then
            pcall(function()
                local enemies = workspace.Enemies
                if enemies:FindFirstChild("Vampire") then
                    for _, v in pairs(enemies:GetChildren()) do
                        if v.Name == "Vampire" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                            local humanoid = v.Humanoid
                            local rootPart = v.HumanoidRootPart
                            if humanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G['Select Weapon'])
                                    rootPart.CanCollide = false
                                    BringMob(rootPart.CFrame) 
                                    humanoid.WalkSpeed = 0
                                    TP(rootPart.CFrame * Pos)
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                until not getgenv().Config["Auto Farm Materials"] or not v.Parent or humanoid.Health <= 0 or Config["Select Materials"] ~= "Vampire Fang"
                            end
                        end
                    end
                else
                    local playerPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                    if BypassTP then
                        if (playerPos - AutoFarmVampireFang.Position).Magnitude > 1500 then
                            TP(AutoFarmVampireFang)
                        else
                            TP(AutoFarmVampireFang)
                        end
                    else
                        TP(AutoFarmVampireFang)
                    end
                    TP(AutoFarmVampireFang)
                end
            end)
        end
    end
end)
local AutoFarmMiniTusk = CFrame.new(-13431.2148, 544.050171, -6849.32324, -0.579150081, 3.4096983e-09, 0.815220952,
    -4.87719305e-08, 1, -3.88311499e-08, -0.815220952, -6.2248958e-08, -0.579150081)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Farm Materials"] and L_7449423635_ and Config["Select Materials"] == "Mini Tusk" then
            pcall(function()
                local enemies = workspace.Enemies
                if enemies:FindFirstChild("Mythological Pirate") then
                    for _, v in pairs(enemies:GetChildren()) do
                        if v.Name == "Mythological Pirate" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                            local humanoid = v.Humanoid
                            local rootPart = v.HumanoidRootPart
                            if humanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G['Select Weapon'])
                                    rootPart.CanCollide = false
                                    BringMob(rootPart.CFrame) 
                                    humanoid.WalkSpeed = 0
                                    TP(rootPart.CFrame * Pos)
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                until not getgenv().Config["Auto Farm Materials"] or not v.Parent or humanoid.Health <= 0 or Config["Select Materials"] ~= "Mini Tusk"
                            end
                        end
                    end
                else
                    local playerPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                    if BypassTP then
                        if (playerPos - AutoFarmMiniTusk.Position).Magnitude > 1500 then
                            TP(AutoFarmMiniTusk)
                        else
                            TP(AutoFarmMiniTusk)
                        end
                    else
                        TP(AutoFarmMiniTusk)
                    end
                    TP(AutoFarmMiniTusk)
                end
            end)
        end
    end
end)
local AutoFarmGunpowder = CFrame.new(-367.398956, 77.0727768, 5931.71826, -0.933972836, -3.85812307e-08, -0.357344002,
    7.24117877e-09, 1, -1.26892559e-07, 0.357344002, -1.21101792e-07, -0.933972836)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Farm Gunpowder"] and L_7449423635_ and Config["Select Materials"] == "Gunpowder" then
            pcall(function()
                local enemies = workspace.Enemies
                if enemies:FindFirstChild("Pistol Billionaire") then
                    for _, v in pairs(enemies:GetChildren()) do
                        if v.Name == "Pistol Billionaire" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                            local humanoid = v.Humanoid
                            local rootPart = v.HumanoidRootPart
                            if humanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G['Select Weapon'])
                                    rootPart.CanCollide = false
                                    BringMob(rootPart.CFrame) 
                                    humanoid.WalkSpeed = 0
                                    TP(rootPart.CFrame * Pos)
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                until not getgenv().Config["Auto Farm Gunpowder"] or not v.Parent or humanoid.Health <= 0 or Config["Select Materials"] ~= "Gunpowder"
                            end
                        end
                    end
                else
                    local playerPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                    if BypassTP then
                        if (playerPos - AutoFarmGunpowder.Position).Magnitude > 1500 then
                            TP(AutoFarmGunpowder)
                        else
                            TP(AutoFarmGunpowder)
                        end
                    else
                        TP(AutoFarmGunpowder)
                    end
                    TP(AutoFarmGunpowder)
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        pcall(function()
            if getgenv().Config["Auto Find Mirage Island"] then
                if not game:GetService("Workspace").Boats:FindFirstChild("PirateGrandBrigade") then
                    buyb = TP(CFrame.new(-16192.2539, 12.3828964, 1738.85999, -0.997757435, 4.43451498e-08,
                        -0.0669331998, 5.01932291e-08, 1, -8.56902034e-08, 0.0669331998, -8.88576324e-08,
                        -0.997757435))
                    if (CFrame.new(-16192.2539, 12.3828964, 1738.85999, -0.997757435, 4.43451498e-08, -0.0669331998, 5.01932291e-08, 1, -8.56902034e-08, 0.0669331998, -8.88576324e-08, -0.997757435).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 10 then
                        if buyb then buyb:Stop() end
                        local args = {
                            [1] = "BuyBoat",
                            [2] = "PirateGrandBrigade"
                        }
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                    end
                elseif game:GetService("Workspace").Boats:FindFirstChild("PirateGrandBrigade") then
                    if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit == false then
                        TPP(game:GetService("Workspace").Boats.PirateGrandBrigade.VehicleSeat.CFrame *
                            CFrame.new(0, 1, 0))
                    else
                        for i, v in pairs(game:GetService("Workspace").Boats:GetChildren()) do
                            if v.Name == "PirateGrandBrigade" then
                                repeat
                                    wait()
                                    PlayBoatsTween(CFrame.new(-99999999, 10.964323997497559, -324.4842224121094))
                                until workspace.Enemies:FindFirstChild("dd") or workspace.Enemies:FindFirstChild("D") or workspace.Enemies:FindFirstChild("d") or workspace.Enemies:FindFirstChild("Fish Crew d") or getgenv().Config["Auto Find Mirage Island"] == false or _G.StopTweenBoat == false
                            end
                        end
                    end
                end
            end
        end)
    end
end)
spawn(function()
    while wait() do
        if getgenv().Config["Teleport to Mirage Island"] then
            pcall(function()
                if (game.workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island")) or game:GetService("Workspace").Map:FindFirstChild("MysticIsland") then
                    TP(game.workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island").CFrame *
                    CFrame.new(0, 250, 0))
                end
            end)
        end
    end
end)
spawn(function()
    pcall(function()
        while wait() do
            if getgenv().Config["Auto Find Advanced Fruit Dealer"] then
                if game:GetService("Workspace").NPCs:FindFirstChild("Advanced Fruit Dealer") then
                    TP(game:GetService("Workspace").NPCs["Advanced Fruit Dealer"].HumanoidRootPart.CFrame)
                end
            end
        end
    end)
end)
spawn(function()
    pcall(function()
        while wait() do
            if getgenv().Config["Auto Find Gear"] then
                if game:GetService("Workspace").Map:FindFirstChild("MysticIsland") then
                    for i, v in pairs(game:GetService("Workspace").Map.MysticIsland:GetChildren()) do
                        if v:IsA("MeshPart") then
                            if v.Material == Enum.Material.Neon then
                                TP(v.CFrame)
                            end
                        end
                    end
                end
            end
        end
    end)
end)
spawn(function()
    while task.wait() do
        pcall(function()
            if getgenv().Config["Auto Lock Camera to Moon"] then
                wait()
                local moonDir = game.Lighting:GetMoonDirection()
                local lookAtPos = game.Workspace.CurrentCamera.CFrame.p + moonDir * 100
                game.Workspace.CurrentCamera.CFrame = CFrame.lookAt(game.Workspace.CurrentCamera.CFrame.p, lookAtPos)
                task.wait()
            end
        end)
    end
end)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Complete Trail"] then
            pcall(function()
                if game:GetService("Players").LocalPlayer.Data.Race.Value == "Human" then
                    for i, v in pairs(game.workspace.Enemies:GetChildren()) do
                        if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") then
                        if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRooPart.Position).Magnitude <= 200 then
                            repeat
                                wait()
                                TP(v.HumanoidRootPart.CFrame * Pos)
                                EquipWeapon(_G['Select Weapon'])
                            until not getgenv().Config["Auto Complete Trail"] or not v.Parent or v.Humanoid.Health <= 0
                            end
                        end
                    end
                elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Mink" then
                elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Fishman" then
                    local enemies = game:GetService("Workspace").SeaBeasts
                    local player = game.Players.LocalPlayer
                    local character = player.Character
                    local humanoid = character and character:FindFirstChild("Humanoid")
                    for _, v in pairs(enemies:GetChildren()) do
                        if v.Name == "SeaBeast1" or v.Name == "SeaBeast2" or v.Name == "SeaBeast3" and v:FindFirstChild("HumanoidRootPart") then
                            repeat
                                task.wait()
                                AutoHaki()
                                TP(v.HumanoidRootPart.CFrame * CFrame.new(0, 480, 0))
                                game:service("VirtualInputManager"):SendKeyEvent(true, "One", false, game)
                                game:service("VirtualInputManager"):SendKeyEvent(false, "One", false, game)
                                if _G['Skill Z'] then useSkill("Z") end
                                if _G['Skill X'] then useSkill("X") end
                                if _G['Skill C'] then useSkill("C") end
                                if _G['Skill V'] then useSkill("V") end
                                if _G['Skill F'] then useSkill("F") end
                                game:service("VirtualInputManager"):SendKeyEvent(true, "Two", false, game)
                                game:service("VirtualInputManager"):SendKeyEvent(false, "Two", false, game)
                                if _G['Skill Z'] then useSkill("Z") end
                                if _G['Skill X'] then useSkill("X") end
                                if _G['Skill C'] then useSkill("C") end
                                if _G['Skill V'] then useSkill("V") end
                                if _G['Skill F'] then useSkill("F") end
                                game:service("VirtualInputManager"):SendKeyEvent(true, "Three", false, game)
                                game:service("VirtualInputManager"):SendKeyEvent(false, "Three", false, game)
                                if _G['Skill Z'] then useSkill("Z") end
                                if _G['Skill X'] then useSkill("X") end
                                if _G['Skill C'] then useSkill("C") end
                                if _G['Skill V'] then useSkill("V") end
                                if _G['Skill F'] then useSkill("F") end
                                game:service("VirtualInputManager"):SendKeyEvent(true, "Four", false, game)
                                game:service("VirtualInputManager"):SendKeyEvent(false, "Four", false, game)
                                if _G['Skill Z'] then useSkill("Z") end
                                if _G['Skill X'] then useSkill("X") end
                                if _G['Skill C'] then useSkill("C") end
                                if _G['Skill V'] then useSkill("V") end
                                if _G['Skill F'] then useSkill("F") end
                                sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                            until not _G['Auto Farm Sea Beasts'] or not v.Parent
                        end
                    end
                elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Cyborg" then
                elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Skypiea" then
                elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Ghoul" then
                    for i, v in pairs(game.workspace.Enemies:GetChildren()) do
                        if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") then
                        if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRooPart.Position).Magnitude <= 200 then
                            repeat
                                wait()
                                TP(v.HumanoidRootPart.CFrame * Pos)
                                EquipWeapon(_G['Select Weapon'])
                            until not getgenv().Config["Auto Complete Trail"] or not v.Parent or v.Humanoid.Health <= 0
                            end
                        end
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if getgenv().Config["Teleport to Race Door"] then
            pcall(function()
                if game:GetService("Players").LocalPlayer.Data.Race.Value == "Human" then
                    TP(game.workspace.Map["Temple of Time"].HumanCorridor.Door.Entrance.CFrame * CFrame.new(0,0,2))
                elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Mink" then
                    TP(game.workspace.Map["Temple of Time"].MinkCorridor.Door.Entrance.CFrame * CFrame.new(0,0,2))
                elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Fishman" then
                    TP(game.workspace.Map["Temple of Time"].FishmanCorridor.Door.Entrance.CFrame * CFrame.new(0,0,2))
                elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Cyborg" then
                    TP(game.workspace.Map["Temple of Time"].CyborgCorridor.Door.Entrance.CFrame * CFrame.new(0,0,2))
                elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Skypiea" then
                    TP(game.workspace.Map["Temple of Time"].SkypieaCorridor.Door.Entrance.CFrame * CFrame.new(0,0,2))
                elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Ghoul" then
                    TP(game.workspace.Map["Temple of Time"].GhoulCorridor.Door.Entrance.CFrame * CFrame.new(0,0,2))
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if Config["Auto Buy Bait"] then
            pcall(function()
                local args = {"Craft",Config["Select Bait"],{}}game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/Craft"):InvokeServer(unpack(args))
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if getgenv().Config["Spectate to Players"] then
            pcall(function()
                if game.Players:FindFirstChild(_G['Select Player']) then
                    game.Workspace.Camera.CameraSubject = game.Players:FindFirstChild(_G['Select Player']).Character
                        .Humanoid
                end
            end)
        else
            game.Workspace.Camera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
        end
    end
end)
local function TeleportToPlayerAbove()
    if not getgenv().Config["Teleport to Players"] or not _G['Select Player'] then return end
    local targetPlayer = game:GetService("Players"):FindFirstChild(_G['Select Player'])
    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        if game.Players.LocalPlayer.Character.Humanoid.Health > 4000 then
            TP(targetPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, Config["Height"], 0))
        end
    else
    end
end
local function TeleportToPlayerBeside()
    if not getgenv().Config["Teleport to Players"] or not _G['Select Player'] then return end
    local targetPlayer = game:GetService("Players"):FindFirstChild(_G['Select Player'])
    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        if game.Players.LocalPlayer.Character.Humanoid.Health > 4000 then
            TP(targetPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, Config["Position Z [ Beside ]"]))
        end
    else
    end
end
local function TeleportToPlayerLower()
    if not getgenv().Config["Teleport to Players"] or not _G['Select Player'] then return end
    local targetPlayer = game:GetService("Players"):FindFirstChild(_G['Select Player'])
    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        if game.Players.LocalPlayer.Character.Humanoid.Health > 4000 then
            TP(targetPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, -Config["Lowness"], 0))
        end
    else
    end
end
spawn(function()
    while wait() do
        if getgenv().Config["Teleport to Players"] and _G['Select Player'] and _G['Position'] == "Above" then
            pcall(TeleportToPlayerAbove)
        end
    end
end)
spawn(function()
    while wait() do
        if getgenv().Config["Teleport to Players"] and _G['Select Player'] and _G['Position'] == "Beside" then
            pcall(TeleportToPlayerBeside)
        end
    end
end)
spawn(function()
    while wait() do
        if getgenv().Config["Teleport to Players"] and _G['Select Player'] and _G['Position'] == "Lower" then
            pcall(TeleportToPlayerLower)
        end
    end
end)
spawn(function()
    while task.wait() do
        if _G['Enabled Aimbot'] then
            if game.Players:FindFirstChild(_G['Select Player']) and game.Players:FindFirstChild(_G['Select Player']).Character:FindFirstChild("HumanoidRootPart") and game.Players:FindFirstChild(_G['Select Player']).Character:FindFirstChild("Humanoid") and game.Players:FindFirstChild(_G['Select Player']).Character.Humanoid.Health > 0 then
                AimBotSkillPosition = game.Players:FindFirstChild(_G['Select Player']).Character:FindFirstChild(
                    "HumanoidRootPart").Position
            end
        end
    end
end)
spawn(function()
    while task.wait() do
        if getgenv().Config["Auto Kill Players"] and _G['Select Player'] then
            pcall(function()
                local targetPlayer = game:GetService("Players"):FindFirstChild(_G['Select Player'])
                if targetPlayer then
                   for i, v in pairs(game.workspace.Characters:GetChildren()) do
                    if v.Name == _G['Select Player'] then
                        repeat 
                            task.wait()
                            if game.Players.LocalPlayer.Character.Humanoid.Health > 5000 then
                            TP(v.HumanoidRootPart.CFrame * PosKillPlayers)
                            elseif game.Players.LocalPlayer.Character.Humanoid.Health <= 4000 then
                            TP(v.HumanoidRootPart.CFrame * CFrame.new(0,125,0))
                            end
                        until not getgenv().Config["Auto Kill Players"] or not v.Parent or v.Humanoid.Health <= 0
                    end
                   end
                end
            end)
        end
    end
end)
spawn(function()
    while task.wait() do
        if getgenv().Config["Auto Kill Players"] and _G['Select Player'] then
            pcall(function()
                local targetPlayer = game:GetService("Players"):FindFirstChild(_G['Select Player'])
                if targetPlayer then
                   for i, v in pairs(game.workspace.Characters:GetChildren()) do
                    if v.Name == _G['Select Player'] then
                        repeat 
                            task.wait()
                            if game.Players.LocalPlayer.Character.Humanoid.Health > 5000 then
                            game:service("VirtualInputManager"):SendKeyEvent(true, "One", false, game)
                            game:service("VirtualInputManager"):SendKeyEvent(false, "One", false, game)
                            if _G['Skill Z'] then useSkill("Z") end
                            if _G['Skill X'] then useSkill("X") end
                            if _G['Skill C'] then useSkill("C") end
                            if _G['Skill V'] then useSkill("V") end
                            if _G['Skill F'] then useSkill("F") end
                            game:service("VirtualInputManager"):SendKeyEvent(true, "Two", false, game)
                            game:service("VirtualInputManager"):SendKeyEvent(false, "Two", false, game)
                            if _G['Skill Z'] then useSkill("Z") end
                            if _G['Skill X'] then useSkill("X") end
                            if _G['Skill C'] then useSkill("C") end
                            if _G['Skill V'] then useSkill("V") end
                            if _G['Skill F'] then useSkill("F") end
                            game:service("VirtualInputManager"):SendKeyEvent(true, "Three", false, game)
                            game:service("VirtualInputManager"):SendKeyEvent(false, "Three", false, game)
                            if _G['Skill Z'] then useSkill("Z") end
                            if _G['Skill X'] then useSkill("X") end
                            if _G['Skill C'] then useSkill("C") end
                            if _G['Skill V'] then useSkill("V") end
                            if _G['Skill F'] then useSkill("F") end
                            game:service("VirtualInputManager"):SendKeyEvent(true, "Four", false, game)
                            game:service("VirtualInputManager"):SendKeyEvent(false, "Four", false, game)
                            if _G['Skill Z'] then useSkill("Z") end
                            if _G['Skill X'] then useSkill("X") end
                            if _G['Skill C'] then useSkill("C") end
                            if _G['Skill V'] then useSkill("V") end
                            if _G['Skill F'] then useSkill("F") end
                            end
                        until not getgenv().Config["Auto Kill Players"] or not v.Parent or v.Humanoid.Health <= 0
                    end
                   end
                end
            end)
        end
    end
end)
local gg = getrawmetatable(game)
local old = gg.__namecall
setreadonly(gg, false)
gg.__namecall = newcclosure(function(...)
    local method = getnamecallmethod()
    local args = { ... }
    if tostring(method) == "FireServer" then
        if tostring(args[1]) == "RemoteEvent" then
            if tostring(args[2]) ~= "true" and tostring(args[2]) ~= "false" then
                if _G['Enabled Aimbot'] then
                    args[2] = AimBotSkillPosition
                    return old(unpack(args))
                end
            end
        end
    end
    return old(...)
end)
spawn(function()
    while wait() do
        if getgenv().Config["Enabled PvP"] then
            pcall(function()
                local args = {
                    [1] = "EnablePvp"
                }
                
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Activate Ability"] then
            pcall(function()
                local args = {
                    [1] = "ActivateAbility"
                }
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommE"):FireServer(unpack(
                    args))
            end)
        end
    end
end)
spawn(function()
    while task.wait() do
        if getgenv().Config["Safe Mode"] and game.Players.LocalPlayer.Character.Humanoid.Health < 4000 then
            pcall(function()
                TP(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 200, 0))
                if game.Players.LocalPlayer.Character.Humanoid.Health > 4000 then
                    TP(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 0))
                end
            end)
        end
    end
end)
spawn(function()
    while task.wait() do
        if getgenv().Config["Auto Stats Melee"] then
            local args = {
                [1] = "AddPoint",
                [2] = "Melee",
                [3] = _G['Point Stats']
            }
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
        end
    end
end)
spawn(function()
    while task.wait() do
        if getgenv().Config["Auto Stats Defense"] then
            local args = {
                [1] = "AddPoint",
                [2] = "Defense",
                [3] = _G['Point Stats']
            }
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
        end
    end
end)
spawn(function()
    while task.wait() do
        if getgenv().Config["Auto Stats Sword"] then
            local args = {
                [1] = "AddPoint",
                [2] = "Sword",
                [3] = _G['Point Stats']
            }
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
        end
    end
end)
spawn(function()
    while task.wait() do
        if getgenv().Config["Auto Stats Gun"] then
            local args = {
                [1] = "AddPoint",
                [2] = "Gun",
                [3] = _G['Point Stats']
            }
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
        end
    end
end)
spawn(function()
    while task.wait() do
        if getgenv().Config["Auto Stats Demon Fruit"] then
            local args = {
                [1] = "AddPoint",
                [2] = "Demon Fruit",
                [3] = _G['Point Stats']
            }
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
        end
    end
end)
spawn(function()
    while wait() do
        if getgenv().Config["Tween Island"] then
            pcall(function()
                if _G.SelectIsland == "WindMill" then
                    TP(CFrame.new(979.79895019531, 16.516613006592, 1429.0466308594))
                elseif _G.SelectIsland == "Marine" then
                    TP(CFrame.new(-2566.4296875, 6.8556680679321, 2045.2561035156))
                elseif _G.SelectIsland == "Middle Town" then
                    TP(CFrame.new(-690.33081054688, 15.09425163269, 1582.2380371094))
                elseif _G.SelectIsland == "Jungle" then
                    TP(CFrame.new(-1612.7957763672, 36.852081298828, 149.12843322754))
                elseif _G.SelectIsland == "Pirate Village" then
                    TP(CFrame.new(-1181.3093261719, 4.7514905929565, 3803.5456542969))
                elseif _G.SelectIsland == "Desert" then
                    TP(CFrame.new(944.15789794922, 20.919729232788, 4373.3002929688))
                elseif _G.SelectIsland == "Snow Island" then
                    TP(CFrame.new(1347.8067626953, 104.66806030273, -1319.7370605469))
                elseif _G.SelectIsland == "MarineFord" then
                    TP(CFrame.new(-4914.8212890625, 50.963626861572, 4281.0278320313))
                elseif _G.SelectIsland == "Colosseum" then
                    TP(CFrame.new(-1427.6203613281, 7.2881078720093, -2792.7722167969))
                elseif _G.SelectIsland == "Sky Island 1" then
                    TP(CFrame.new(-4869.1025390625, 733.46051025391, -2667.0180664063))
                elseif _G.SelectIsland == "Sky Island 2" then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",
                        Vector3.new(-4607.82275, 872.54248, -1667.55688))
                elseif _G.SelectIsland == "Sky Island 3" then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",
                        Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047))
                elseif _G.SelectIsland == "Prison" then
                    TP(CFrame.new(4875.330078125, 5.6519818305969, 734.85021972656))
                elseif _G.SelectIsland == "Magma Village" then
                    TP(CFrame.new(-5247.7163085938, 12.883934020996, 8504.96875))
                elseif _G.SelectIsland == "Under Water Island" then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",
                        Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
                elseif _G.SelectIsland == "Fountain City" then
                    TP(CFrame.new(5127.1284179688, 59.501365661621, 4105.4458007813))
                elseif _G.SelectIsland == "Shank Room" then
                    TP(CFrame.new(-1442.16553, 29.8788261, -28.3547478))
                elseif _G.SelectIsland == "Mob Island" then
                    TP(CFrame.new(-2850.20068, 7.39224768, 5354.99268))
                elseif _G.SelectIsland == "The Cafe" then
                    TP(CFrame.new(-380.47927856445, 77.220390319824, 255.82550048828))
                elseif _G.SelectIsland == "Frist Spot" then
                    TP(CFrame.new(-11.311455726624, 29.276733398438, 2771.5224609375))
                elseif _G.SelectIsland == "Dark Area" then
                    TP(CFrame.new(3780.0302734375, 22.652164459229, -3498.5859375))
                elseif _G.SelectIsland == "Flamingo Mansion" then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",
                        Vector3.new(-281.93707275390625, 306.130615234375, 609.280029296875))
                elseif _G.SelectIsland == "Flamingo Room" then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",
                        Vector3.new(2284.912109375, 15.152034759521484, 905.48291015625))
                elseif _G.SelectIsland == "Green Zone" then
                    TP(CFrame.new(-2448.5300292969, 73.016105651855, -3210.6306152344))
                elseif _G.SelectIsland == "Factory" then
                    TP(CFrame.new(424.12698364258, 211.16171264648, -427.54049682617))
                elseif _G.SelectIsland == "Colossuim" then
                    TP(CFrame.new(-1503.6224365234, 219.7956237793, 1369.3101806641))
                elseif _G.SelectIsland == "Zombie Island" then
                    TP(CFrame.new(-5622.033203125, 492.19604492188, -781.78552246094))
                elseif _G.SelectIsland == "Two Snow Mountain" then
                    TP(CFrame.new(753.14288330078, 408.23559570313, -5274.6147460938))
                elseif _G.SelectIsland == "Punk Hazard" then
                    TP(CFrame.new(-6127.654296875, 15.951762199402, -5040.2861328125))
                elseif _G.SelectIsland == "Cursed Ship" then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",
                        Vector3.new(923.40197753906, 125.05712890625, 32885.875))
                elseif _G.SelectIsland == "Ice Castle" then
                    TP(CFrame.new(6148.4116210938, 294.38687133789, -6741.1166992188))
                elseif _G.SelectIsland == "Forgotten Island" then
                    TP(CFrame.new(-3032.7641601563, 317.89672851563, -10075.373046875))
                elseif _G.SelectIsland == "Ussop Island" then
                    TP(CFrame.new(4816.8618164063, 8.4599885940552, 2863.8195800781))
                elseif _G.SelectIsland == "Mini Sky Island" then
                    TP(CFrame.new(-288.74060058594, 49326.31640625, -35248.59375))
                elseif _G.SelectIsland == "Great Tree" then
                    TP(CFrame.new(2681.2736816406, 1682.8092041016, -7190.9853515625))
                elseif _G.SelectIsland == "Castle On The Sea" then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",
                        Vector3.new(-5075.50927734375, 314.5155029296875, -3150.0224609375))
                elseif _G.SelectIsland == "MiniSky" then
                    TP(CFrame.new(-260.65557861328, 49325.8046875, -35253.5703125))
                elseif _G.SelectIsland == "Port Town" then
                    TP(CFrame.new(-290.7376708984375, 6.729952812194824, 5343.5537109375))
                elseif _G.SelectIsland == "Hydra Island" then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",
                        Vector3.new(5661.52979, 1013.07385, -334.962189))
                elseif _G.SelectIsland == "Floating Turtle" then
                    TP(CFrame.new(-13274.528320313, 531.82073974609, -7579.22265625))
                elseif _G.SelectIsland == "Mansion" then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",
                        Vector3.new(-12468.5380859375, 375.0094299316406, -7554.62548828125))
                elseif _G.SelectIsland == "Haunted Castle" then
                    TP(CFrame.new(-9515.3720703125, 164.00624084473, 5786.0610351562))
                elseif _G.SelectIsland == "Ice Cream Island" then
                    TP(CFrame.new(-902.56817626953, 79.93204498291, -10988.84765625))
                elseif _G.SelectIsland == "Peanut Island" then
                    TP(CFrame.new(-2062.7475585938, 50.473892211914, -10232.568359375))
                elseif _G.SelectIsland == "Cake Island" then
                    TP(CFrame.new(-1884.7747802734375, 19.327526092529297, -11666.8974609375))
                elseif _G.SelectIsland == "Cocoa Island" then
                    TP(CFrame.new(87.94276428222656, 73.55451202392578, -12319.46484375))
                elseif _G.SelectIsland == "Candy Island" then
                    TP(CFrame.new(-1014.4241943359375, 149.11068725585938, -14555.962890625))
                elseif _G.SelectIsland == "Tiki Outpost" then
                    TP(CFrame.new(-16542.447265625, 55.68632888793945, 1044.41650390625))
                end
            end)
        end
    end
end)
spawn(function()
    pcall(function()
        while task.wait() do
            if IslandESP then
                UpdateIslandESP()
            end
        end
    end)
end)
spawn(function()
    pcall(function()
        while task.wait() do
            if ESPPlayer then
                UpdatePlayerChams()
            end
        end
    end)
end)
spawn(function()
    pcall(function()
        while task.wait() do
            if ChestESP then
                UpdateChestChams()
            end
        end
    end)
end)
spawn(function()
    pcall(function()
        while task.wait() do
            if DevilFruitESP then
                UpdateDevilChams()
            end
        end
    end)
end)
spawn(function()
    pcall(function()
        while task.wait() do
            if RealFruitESP then
                UpdateRealFruitChams()
            end
        end
    end)
end)
spawn(function()
    pcall(function()
        while task.wait() do
            if FlowerESP then
                UpdateFlowerChams()
            end
        end
    end)
end)
spawn(function()
    pcall(function()
        while task.wait() do
            if MirageIslandESP then
                UpdateIslandMirageESP()
            end
        end
    end)
end)
spawn(function()
    pcall(function()
        while task.wait() do
            if AfdESP then
                UpdateAfdESP()
            end
        end
    end)
end)
spawn(function()
    pcall(function()
        while task.wait() do
            if PrehistoricESP then
                UpdateIslandPrehistoricESP()
            end
        end
    end)
end)
spawn(function()
    pcall(function()
        while task.wait() do
            if KitsuneIslandEsp then
                UpdateIslandKisuneESP()
            end
        end
    end)
end)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Buy Chip"] then
            pcall(function()
                local args = {
                    [1] = "RaidsNpc",
                    [2] = "Select",
                    [3] = getgenv().Config["Select Chip Raid"]
                }
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Start Raid"] then
            pcall(function()
                if L_4442272183_ then
                    fireclickdetector(game:GetService("Workspace").Map.CircleIsland.RaidSummon2.Button.Main
                        .ClickDetector)
                elseif L_7449423635_ then
                    fireclickdetector(game:GetService("Workspace").Map["Boat Castle"].RaidSummon2.Button.Main
                        .ClickDetector)
                end
            end)
        end
    end
end)
spawn(function()
    while wait(.1) do
        if getgenv().Config["Auto Awaken"] then
            pcall(function()
                local args = {
                    [1] = "Awakener",
                    [2] = "Check"
                }
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                local args = {
                    [1] = "Awakener",
                    [2] = "Awaken"
                }
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if getgenv().Config["Kill Aura"] then
            pcall(function()
                for i, v in pairs(game.workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") then
                        v.HumanoidRootPart.Size = Vector3.new(100,100,100)
                        v.HumanoidRootPart.CanCollide = false
                        v.Humanoid.Health = v.Humanoid.Health - math.random(5000, 10000)
                    end
                end
            end)
        end
    end
end)
local InCombat = false
spawn(function()
    while wait() do
        if getgenv().Config["Auto Dungeon"] then
            pcall(function()
                local foundEnemy = false
                local player = game.Players.LocalPlayer
                local health = player.Character and player.Character:FindFirstChild("Humanoid") and
                    player.Character.Humanoid.Health or 0
                if health > 0 and health < 4000 then
                    InCombat = false
                    TP(player.Character.HumanoidRootPart.CFrame * CFrame.new(0, 150, 0))
                    return
                end
                if health >= 6500 then
                    for _, v in pairs(workspace.Enemies:GetChildren()) do
                        if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") then
                            if (v.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).magnitude <= 1000 and v.Humanoid.Health > 0 then
                                foundEnemy = true
                                InCombat = true
                                repeat
                                    wait()
                                    EquipWeapon(_G['Select Weapon'])
                                    BringMob(v.HumanoidRootPart.CFrame) 
                                    v.HumanoidRootPart.CanCollide = false
                                    TP(v.HumanoidRootPart.CFrame * Pos)
                                until not getgenv().Config["Auto Dungeon"] or not v.Parent or v.Humanoid.Health <= 0

                                InCombat = false
                            end
                        end
                    end
                end
                if not foundEnemy then
                    InCombat = false
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Dungeon"] and not InCombat then
            pcall(function()
                local locations = game:GetService("Workspace")["_WorldOrigin"].Locations
                for i = 5, 1, -1 do
                    local island = locations:FindFirstChild("Island " .. i)
                    if island then
                        TP(island.CFrame * CFrame.new(0, 55, 0))
                        break
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while wait(0.1) do
        if getgenv().Config["Auto Random Fruit"] then
            local args = {
                [1] = "Cousin",
                [2] = "Buy"
            }
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
        end
    end
end)
function StoredFruited(name_1, name_2)
    local Character = game:GetService("Players").LocalPlayer.Character
    local Backpack = game:GetService("Players").LocalPlayer.Backpack
    local CommF_ = game:GetService("ReplicatedStorage").Remotes.CommF_
    if Character:FindFirstChild(name_2) or Backpack:FindFirstChild(name_2) then
        local args = {
            [1] = "StoreFruit",
            [2] = name_1,
            [3] = Character:FindFirstChild(name_2) or Backpack:FindFirstChild(name_2) 
        }
        CommF_:InvokeServer(unpack(args))
    end
end
spawn(function()
    while task.wait() do
        if Config["Auto Store Fruit"] then
            pcall(function()
                StoredFruited("Rocket-Rocket", "Rocket Fruit")
                StoredFruited("Spin-Spin", "Spin Fruit")
                StoredFruited("Blade-Blade", "Blade Fruit")
                StoredFruited("Spring-Spring", "Spring Fruit")
                StoredFruited("Bomb-Bomb", "Bomb Fruit")
                StoredFruited("Smoke-Smoke", "Smoke Fruit")
                StoredFruited("Spike-Spike", "Spike Fruit")
                StoredFruited("Flame-Flame", "Flame Fruit")
                StoredFruited("Falcon-Falcon", "Falcon Fruit")
                StoredFruited("Ice-Ice", "Ice Fruit")
                StoredFruited("Sand-Sand", "Sand Fruit")
                StoredFruited("Dark-Dark", "Dark Fruit")
                StoredFruited("Diamond-Diamond", "Diamond Fruit")
                StoredFruited("Light-Light", "Light Fruit")
                StoredFruited("Rubber-Rubber", "Rubber Fruit")
                StoredFruited("Barrier-Barrier", "Barrier Fruit")
                StoredFruited("Ghost-Ghost", "Ghost Fruit")
                StoredFruited("Magma-Magma", "Magma Fruit")
                StoredFruited("Quake-Quake", "Quake Fruit")
                StoredFruited("Buddha-Buddha", "Buddha Fruit")
                StoredFruited("Love-Love", "Love Fruit")
                StoredFruited("Spider-Spider", "Spider Fruit")
                StoredFruited("Sound-Sound", "Sound Fruit")
                StoredFruited("Phoenix-Phoenix", "Phoenix Fruit")
                StoredFruited("Portal-Portal", "Portal Fruit")
                StoredFruited("Rumble-Rumble", "Rumble Fruit")
                StoredFruited("Pain-Pain", "Pain Fruit")
                StoredFruited("Blizzard-Blizzard", "Blizzard Fruit")
                StoredFruited("Gravity-Gravity", "Gravity Fruit")
                StoredFruited("Mammoth-Mammoth", "Mammoth Fruit")
                StoredFruited("T-Rex-T-Rex", "T-Rex Fruit")
                StoredFruited("Yeti-Yeti", "Yeti Fruit")
                StoredFruited("Dough-Dough", "Dough Fruit")
                StoredFruited("Shadow-Shadow", "Shadow Fruit")
                StoredFruited("Venom-Venom", "Venom Fruit")
                StoredFruited("Control-Control", "Control Fruit")
                StoredFruited("Gas-Gas", "Gas Fruit")
                StoredFruited("Spirit-Spirit", "Spirit Fruit")
                StoredFruited("Dragon-Dragon", "Dragon Fruit")
                StoredFruited("Leopard-Leopard", "Leopard Fruit")
                StoredFruited("Kitsune-Kitsune", "Kitsune Fruit")
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if getgenv().Config["Teleport to Fruit"] then
            pcall(function()
                for i, v in pairs(workspace:GetChildren()) do
                    if v:IsA("Tool") then
                        TP(v.Handle.CFrame)
                    end
                end
            end)
        end
    end
end)
local pos_farm_event_new = CFrame.new(42.1511803, 4643.81396, -365.322998, 0.202033624, 6.54368737e-09, -0.979378581, 5.38032774e-09, 1, 7.79136311e-09, 0.979378581, -6.8434951e-09, 0.202033624)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Farm Agony"] then
            pcall(function()
                local enemies = workspace.Enemies
                if enemies:FindFirstChild("Agony") then
                    for _, v in pairs(enemies:GetChildren()) do
                        if v.Name == "Agony" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                            local humanoid = v.Humanoid
                            local rootPart = v.HumanoidRootPart
                            if humanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G.SelectWeapon)
                                    rootPart.CanCollide = false
                                    humanoid.WalkSpeed = 0
                                    toposition(rootPart.CFrame * Pos)
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                until not getgenv().Config["Auto Farm Agony"] or not v.Parent or humanoid.Health <= 0
                            end
                        end
                    end
                else
                    TP(pos_farm_event_new)
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Farm Ashen"] then
            pcall(function()
                local enemies = workspace.Enemies
                if enemies:FindFirstChild("Ashen") then
                    for _, v in pairs(enemies:GetChildren()) do
                        if v.Name == "Ashen" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                            local humanoid = v.Humanoid
                            local rootPart = v.HumanoidRootPart
                            if humanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G.SelectWeapon)
                                    rootPart.CanCollide = false
                                    humanoid.WalkSpeed = 0
                                    toposition(rootPart.CFrame * Pos)
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                until not getgenv().Config["Auto Farm Ashen"] or not v.Parent or humanoid.Health <= 0
                            end
                        end
                    end
                else
                    TP(pos_farm_event_new)
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if getgenv().Config["Auto Farm Lightning Bandit"] then
            pcall(function()
                local enemies = workspace.Enemies
                if enemies:FindFirstChild("Lightning Bandit") then
                    for _, v in pairs(enemies:GetChildren()) do
                        if v.Name == "Lightning Bandit" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                            local humanoid = v.Humanoid
                            local rootPart = v.HumanoidRootPart
                            if humanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G.SelectWeapon)
                                    rootPart.CanCollide = false
                                    humanoid.WalkSpeed = 0
                                    toposition(rootPart.CFrame * Pos)
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                until not getgenv().Config["Auto Farm Lightning Bandit"] or not v.Parent or humanoid.Health <= 0
                            end
                        end
                    end
                else
                    TP(pos_farm_event_new)
                end
            end)
        end
    end
end)
local args = {
	"SetTeam",
	"Rip Family"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
local DynamicNotify = function(Text_i,Duration_i)
    game.StarterGui:SetCore("SendNotification", {
        Title = "Dynamic Hub",
        Text = Text_i,
        Duration = Duration_i,
        Icon = "rbxassetid://105608302686093"
    })
end
DynamicNotify("discord.gg/BFuEmqUgPq",5)
if game:GetService("Players").LocalPlayer.Team then end
wait(1.5)
local cascade = loadstring(game:HttpGet("https://raw.githubusercontent.com/tun9811/wddaaadd3wfefeewgwee/refs/heads/main/AutoFarmtest.luau"))()
local userInputService = cloneref and cloneref(game:GetService("UserInputService")) or
game:GetService("UserInputService")
local minimizeKeybind = Enum.KeyCode.LeftAlt
local function titledRow(parent, title, subtitle) -- You can use this to automate the process of creating similar rows.
    local row = parent:Row({
        SearchIndex = title,
    })
    row:Left():TitleStack({
        Title = title,
        Subtitle = subtitle,
    })
    return row
end
local app = cascade.New({
    WindowPill = true,
    Theme = cascade.Themes.Dark,
})
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()
_G.Logo = 83452741766028
if game.CoreGui:FindFirstChild("ImageButton") then
    game.CoreGui:FindFirstChild("ImageButton"):Destroy()
end
local ScreenGui = Instance.new("ScreenGui")
local ImageButton = Instance.new("ImageButton")
local UICorner = Instance.new("UICorner")
local ClickSound = Instance.new("Sound")
local FlashFrame = Instance.new("Frame")
local UICorner2 = Instance.new("UICorner")
ScreenGui.Name = "ImageButton"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ImageButton.Parent = ScreenGui
ImageButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ImageButton.BorderSizePixel = 0
ImageButton.Position = UDim2.new(0.120833337, 0, 0.0952890813, 0)
ImageButton.Size = UDim2.new(0, 55, 0, 53)
ImageButton.Draggable = true
ImageButton.Image = "http://www.roblox.com/asset/?id=" .. (_G.Logo)
UICorner.Parent = ImageButton
FlashFrame.Size = UDim2.new(0, 20, 0, 20)
FlashFrame.Position = UDim2.new(0, 0, 0, 0)
FlashFrame.AnchorPoint = Vector2.new(0.5, 0.5)
FlashFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
FlashFrame.BackgroundTransparency = 1
FlashFrame.ZIndex = 2
FlashFrame.Parent = ImageButton
UICorner2.Parent = FlashFrame
UICorner2.CornerRadius = UDim.new(1, 10)
local function playClickFlash()
    local mousePos = Mouse.X, Mouse.Y
    local relX = (Mouse.X - ImageButton.AbsolutePosition.X) / ImageButton.AbsoluteSize.X
    local relY = (Mouse.Y - ImageButton.AbsolutePosition.Y) / ImageButton.AbsoluteSize.Y
    FlashFrame.Position = UDim2.new(relX, 0, relY, 0)
    FlashFrame.Size = UDim2.new(0, 20, 0, 20)
    FlashFrame.BackgroundTransparency = 0.3
    local TweenFlash = TweenService:Create(
        FlashFrame,
        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundTransparency = 1, Size = UDim2.new(1.8, 0, 1.8, 0)}
    )
    TweenFlash:Play()
end
ImageButton.MouseButton1Click:Connect(function()
    ClickSound:Play()
    playClickFlash()
    game:GetService("VirtualInputManager"):SendKeyEvent(true, "LeftAlt", false, game)
    game:GetService("VirtualInputManager"):SendKeyEvent(false, "LeftAlt", false, game)
end)
code = {}
function code.sleep(t)
    task.wait(t)
end
local window = app:Window({
    Title = "Dynamic Hub [ Blox Fruit ]",
    Subtitle = "Make By thanakrit0067 & khaay4997",
    Size = userInputService.TouchEnabled and UDim2.fromOffset(550, 325) or UDim2.fromOffset(850, 530),
})
userInputService.InputEnded:Connect(function(input, gameProcessedEvent)
    if input.KeyCode == minimizeKeybind and not gameProcessedEvent then
        window.Minimized = not window.Minimized
    end
end)
window.Destroying:Connect(function()
    pcall(function()
    local ok, hui = pcall(function() return gethui() end)
        if not ok or not hui then return end
        local imageButton = hui:FindFirstChild("ImageButton")
        if imageButton then
            imageButton:Destroy()
        else
            game:GetService("CoreGui"):FindFirstChild("ImageButton"):Destroy()
        end
        for i,v in pairs(gethui():GetChildren()) do
            print(i,v)
            v:Destroy()
        end
    end)
end)
window.Destroying:Connect(function()
    for i, v in pairs(Config) do
        if v == true or v == false and i ~= "Save_Member" then
            Config[i] = false
            _G[i] = false
        end
    end
end)
local downpress = math.random(1, 2)
local Tabs = { 
    FarmSettings = window:Tab({Title = "Farm Settings", Icon = cascade.Symbols.sliderHorizontal2Square }),
    Main = window:Tab({Selected = true, Title = "Main", Icon = cascade.Symbols.house }),
    Sub_Farming = window:Tab({Title = "Sub Farming", Icon = cascade.Symbols.square3Layers3d }),
    Misc_Farming = window:Tab({Title = "Misc Farming", Icon = cascade.Symbols.hammer }),
    MirageandRace = window:Tab({Title = "Race & Mirage", Icon = cascade.Symbols.airplayaudioBadgeExclamationmark }),
    Events = window:Tab({Title = "Events", Icon = cascade.Symbols.partyPopper }),
    VolcanoEvents = window:Tab({Title = "Volcano Events", Icon = cascade.Symbols.gear }),
    PvP = window:Tab({Title = "PvP", Icon = cascade.Symbols.sliderHorizontal2Square }),
    Stats = window:Tab({Title = "Stats", Icon = cascade.Symbols.chartBarXaxis }),
    Location = window:Tab({Title = "Location", Icon = cascade.Symbols.locationCircle }),
    Esp = window:Tab({Title = "Esp", Icon = cascade.Symbols.eyeSquare }),
    Dungeons = window:Tab({Title = "Dungeons", Icon = cascade.Symbols.fireplace }),
    DevilFruit = window:Tab({Title = "Devil Fruit", Icon = cascade.Symbols.cupAndSaucer }),
    Shop = window:Tab({Title = "Shop", Icon = cascade.Symbols.cart }),
    Miscellaneous = window:Tab({Title = "Miscellaneouss", Icon = cascade.Symbols.appleTerminal }),
    Window = window:Tab({Title = "Window", Icon = cascade.Symbols.sidebarLeft }),
}
form = Tabs.FarmSettings:Form()
row = titledRow(form, "Select Weapon","Choose the weapon you want to use")
if math.random(1, 2) == downpress then
local popUpButton = row:Right():PopUpButton({
    Options = { "Melee", "Sword", "Gun", "Fruit" },
    Value =  (function()
        for i, v in ipairs({ "Melee", "Sword", "Gun", "Fruit" }) do
            if v == Config["Select Weapon"] then
                return i
            end
        end
        return 1
    end)(),
    ValueChanged = function(self, value)
        _G['Select Weapon'] = self.Options[value]
        Config["Select Weapon"] = self.Options[value]
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end,
})
else
row:Right():PullDownButton({
    Options = { "Melee", "Sword", "Gun", "Fruit" },
    Label = "N/A",
    Multi = false,
    Selected = "Select Weapon",
    ValueLabel = 2,
    Value = (function()
        for i, v in ipairs({ "Melee", "Sword", "Gun", "Fruit" }) do
            if v == Config["Select Weapon"] then
                return i
            end
        end
        return 1
    end)(),
    ValueChanged = function(self, value)
        local names = self.Selected
        if self.Multi then
            if self.ValueLabel == 1 then
                _G["selected" .. names] = {}
                for _, i in ipairs(value) do
                    table.insert(_G["selected" .. names], self.Options[i])
                end
                if #_G["selected" .. names] == 0 then
                    self.Label = "N/A"
                elseif #_G["selected" .. names] == 1 then
                    self.Label = _G["selected" .. names][1]
                else
                    self.Label = _G["selected" .. names][1] .. ", ..."
                end
            else
                _G["selected" .. names] = {}
                for _, i in ipairs(value) do
                    table.insert(_G["selected" .. names], self.Options[i])
                end
                if #_G["selected" .. names] == 0 then
                    self.Label = "N/A"
                else
                    self.Label = table.concat(_G["selected" .. names], ", ")
                end
            end
        else
            self.Label = self.Options[value] or "N/A"
        end
        _G['Select Weapon'] = self.Options[value]
        Config["Select Weapon"] = self.Options[value]
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end,
})
end
task.spawn(function()
    while task.wait() do
        pcall(function()
            local player = game.Players.LocalPlayer
            local backpack = player.Backpack
            local char = player.Character
            local weaponType = _G['Select Weapon']
            local targetToolTip = nil
            if weaponType == "Melee" then
                targetToolTip = "Melee"
            elseif weaponType == "Sword" then
                targetToolTip = "Sword"
            elseif weaponType == "Gun" then
                targetToolTip = "Gun"
            elseif weaponType == "Fruit" then
                targetToolTip = "Blox Fruit"
            end
            if targetToolTip then
                for _, tool in pairs(backpack:GetChildren()) do
                    if tool:IsA("Tool") and tool.ToolTip == targetToolTip then
                        _G['Select Weapon'] = tool.Name
                    end
                end
            end
        end)
    end
end)
row = titledRow(form, "Gun No Cooldown Mode","No cooldown for gun")
if math.random(1, 2) == downpress then
local popUpButton = row:Right():PopUpButton({
    Options = { "Fast", "Super (Risk)" },
    Value =  (function()
        for i, v in ipairs({ "Fast", "Super (Risk)" }) do
            if v == Config["Gun No Cooldown Mode"] then
                return i
            end
        end
        return 1
    end)(),
    ValueChanged = function(self, value)
        _G['Gun No Cooldown Mode'] = self.Options[value]
        Config["Gun No Cooldown Mode"] = self.Options[value]
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end,
})
else
row:Right():PullDownButton({
    Options = { "Fast", "Super (Risk)" },
    Label = "N/A",
    Multi = false,
    Selected = "Gun No Cooldown Mode",
    ValueLabel = 2,
    Value = (function()
        for i, v in ipairs({ "Fast", "Super (Risk)" }) do
            if v == Config["Gun No Cooldown Mode"] then
                return i
            end
        end
        return 1
    end)(),
    ValueChanged = function(self, value)
        local names = self.Selected
        if self.Multi then
            if self.ValueLabel == 1 then
                _G["selected" .. names] = {}
                for _, i in ipairs(value) do
                    table.insert(_G["selected" .. names], self.Options[i])
                end
                if #_G["selected" .. names] == 0 then
                    self.Label = "N/A"
                elseif #_G["selected" .. names] == 1 then
                    self.Label = _G["selected" .. names][1]
                else
                    self.Label = _G["selected" .. names][1] .. ", ..."
                end
            else
                _G["selected" .. names] = {}
                for _, i in ipairs(value) do
                    table.insert(_G["selected" .. names], self.Options[i])
                end
                if #_G["selected" .. names] == 0 then
                    self.Label = "N/A"
                else
                    self.Label = table.concat(_G["selected" .. names], ", ")
                end
            end
        else
            self.Label = self.Options[value] or "N/A"
        end
        _G['Gun No Cooldown Mode'] = self.Options[value]
        Config["Gun No Cooldown Mode"] = self.Options[value]
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end,
})
end
row = titledRow(form, "Fast Attack","quick attack")
row:Right():Toggle({
    Value = Config["Fast Attack"] or true,
    ValueChanged = function(self, value)
        _G['Fast Attack'] = value
        Config["Fast Attack"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end,
})
row = titledRow(form, "Damage Aura","for attack players")
row:Right():Toggle({
    Value = Config["Damage Aura"] or false,
    ValueChanged = function(self, value)
        _G['Damage Aura'] = value
        Config["Damage Aura"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end,
})
spawn(function()
    while task.wait() do
        if _G['Fast Attack'] then
            pcall(function()
                for i, v in next, workspace.Enemies:GetChildren() do
                    if v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= tonumber(60) then
                        game:GetService("ReplicatedStorage").Modules.Net:WaitForChild("RE/RegisterAttack")
                            :FireServer(0)
                        local args = {
                            [1] = v:FindFirstChild("HumanoidRootPart"),
                            [2] = {}
                        }
                        for _, e in next, workspace:WaitForChild("Enemies"):GetChildren() do
                            if e:FindFirstChild("Humanoid") and e.Humanoid.Health > 0 then
                                table.insert(args[2], {
                                    [1] = e,
                                    [2] = e:FindFirstChild("HumanoidRootPart") or e:FindFirstChildOfClass("BasePart")
                                })
                            end
                        end
                        game:GetService("ReplicatedStorage").Modules.Net:WaitForChild("RE/RegisterHit"):FireServer(
                            unpack(args))
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while task.wait() do
        if _G['Damage Aura'] then
            pcall(function()
                for i, v in next, workspace.Characters:GetChildren() do
                    if v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= tonumber(60) then
                        game:GetService("ReplicatedStorage").Modules.Net:WaitForChild("RE/RegisterAttack")
                            :FireServer(0)
                        local args = {
                            [1] = v:FindFirstChild("HumanoidRootPart"),
                            [2] = {}
                        }
                        for _, e in next, workspace:WaitForChild("Characters"):GetChildren() do
                            if e:FindFirstChild("Humanoid") and e.Humanoid.Health > 0 then
                                table.insert(args[2], {
                                    [1] = e,
                                    [2] = e:FindFirstChild("HumanoidRootPart") or e:FindFirstChildOfClass("BasePart")
                                })
                            end
                        end
                        game:GetService("ReplicatedStorage").Modules.Net:WaitForChild("RE/RegisterHit"):FireServer(
                            unpack(args))
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if _G['Fast Attack'] then
            pcall(function()
                for i, enemy in pairs(game.workspace.Enemies:GetChildren()) do
                    if enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                        local args = {
                            [1] = enemy.HumanoidRootPart.Position,
                            [2] = 1
                        }
                        game:GetService("Players").LocalPlayer.Character:FindFirstChild("T-Rex-T-Rex")
                            .LeftClickRemote:FireServer(unpack(args))
                        --[[]
                    for i, player in pairs(game.workspace.Characters:GetChildren()) do
                        if player:FindFirstChild("HumanoidRootPart") and player:FindFirstChild("Humanoid") and player.Humanoid.Health > 0 then
                            local args = {
                            [1] = player.HumanoidRootPart.Position,
                            [2] = 1
                        }
                        game:GetService("Players").LocalPlayer.Character:FindFirstChild("T-Rex-T-Rex").LeftClickRemote:FireServer(unpack(args))
                    end
                    end
                    --]]
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if _G['Fast Attack'] then
            pcall(function()
                for i, player in pairs(game.workspace.Characters:GetChildren()) do
                    if player:FindFirstChild("HumanoidRootPart") and player:FindFirstChild("Humanoid") and player.Humanoid.Health > 0 then
                        if (player.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 1250 then
                            local args = {
                                [1] = player.HumanoidRootPart.Position,
                                [2] = 1
                            }
                            game:GetService("Players").LocalPlayer.Character:FindFirstChild("T-Rex-T-Rex")
                                .LeftClickRemote:FireServer(unpack(args))
                        end
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while wait(0.1) do
        if _G['Fast Attack'] then
            pcall(function()
                for i, enemy in pairs(game.workspace.Enemies:GetChildren()) do
                    if enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                        local args = {
                            [1] = enemy.HumanoidRootPart.Position,
                            [2] = 1
                        }
                        game:GetService("Players").LocalPlayer.Character:FindFirstChild("Yeti-Yeti").LeftClickRemote
                            :FireServer(unpack(args))
                        --[[]
                    for i, player in pairs(game.workspace.Characters:GetChildren()) do
                        if player:FindFirstChild("HumanoidRootPart") and player:FindFirstChild("Humanoid") and player.Humanoid.Health > 0 then
                            local args = {
                            [1] = player.HumanoidRootPart.Position,
                            [2] = 1
                        }
                        game:GetService("Players").LocalPlayer.Character:FindFirstChild("T-Rex-T-Rex").LeftClickRemote:FireServer(unpack(args))
                    end
                    end
                    --]]
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while wait(0.1) do
        if _G['Fast Attack'] then
            pcall(function()
                for i, player in pairs(game.workspace.Characters:GetChildren()) do
                    if player:FindFirstChild("HumanoidRootPart") and player:FindFirstChild("Humanoid") and player.Humanoid.Health > 0 then
                        if (player.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 1250 then
                            local args = {
                                [1] = player.HumanoidRootPart.Position,
                                [2] = 1
                            }
                            game:GetService("Players").LocalPlayer.Character:FindFirstChild("Yeti-Yeti")
                                .LeftClickRemote:FireServer(unpack(args))
                        end
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while wait(0.1) do
        if _G['Fast Attack'] then
            pcall(function()
                for i, enemy in pairs(game.workspace.Enemies:GetChildren()) do
                    if enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                        local args = {
                            [1] = enemy.HumanoidRootPart.Position,
                            [2] = 1
                        }
                        game:GetService("Players").LocalPlayer.Character:FindFirstChild("Blade-Blade")
                            .LeftClickRemote:FireServer(unpack(args))
                        --[[]
                    for i, player in pairs(game.workspace.Characters:GetChildren()) do
                        if player:FindFirstChild("HumanoidRootPart") and player:FindFirstChild("Humanoid") and player.Humanoid.Health > 0 then
                            local args = {
                            [1] = player.HumanoidRootPart.Position,
                            [2] = 1
                        }
                        game:GetService("Players").LocalPlayer.Character:FindFirstChild("T-Rex-T-Rex").LeftClickRemote:FireServer(unpack(args))
                    end
                    end
                    --]]
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while wait(0.1) do
        if _G['Fast Attack'] then
            pcall(function()
                for i, player in pairs(game.workspace.Characters:GetChildren()) do
                    if player:FindFirstChild("HumanoidRootPart") and player:FindFirstChild("Humanoid") and player.Humanoid.Health > 0 then
                        if (player.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 1250 then
                            local args = {
                                [1] = player.HumanoidRootPart.Position,
                                [2] = 1
                            }
                            game:GetService("Players").LocalPlayer.Character:FindFirstChild("Blade-Blade")
                                .LeftClickRemote:FireServer(unpack(args))
                        end
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while wait(0.1) do
        if _G['Fast Attack'] then
            pcall(function()
                for i, enemy in pairs(game.workspace.Enemies:GetChildren()) do
                    if enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                        local args = {
                            [1] = enemy.HumanoidRootPart.Position,
                            [2] = 1
                        }
                        game:GetService("Players").LocalPlayer.Character:FindFirstChild("Mammoth-Mammoth")
                            .LeftClickRemote:FireServer(unpack(args))
                        --[[]
                    for i, player in pairs(game.workspace.Characters:GetChildren()) do
                        if player:FindFirstChild("HumanoidRootPart") and player:FindFirstChild("Humanoid") and player.Humanoid.Health > 0 then
                            local args = {
                            [1] = player.HumanoidRootPart.Position,
                            [2] = 1
                        }

                        game:GetService("Players").LocalPlayer.Character:FindFirstChild("T-Rex-T-Rex").LeftClickRemote:FireServer(unpack(args))
                    end
                    end
                    --]]
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while wait(0.1) do
        if _G['Fast Attack'] then
            pcall(function()
                for i, player in pairs(game.workspace.Characters:GetChildren()) do
                    if player:FindFirstChild("HumanoidRootPart") and player:FindFirstChild("Humanoid") and player.Humanoid.Health > 0 then
                        if (player.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 1250 then
                            local args = {
                                [1] = player.HumanoidRootPart.Position,
                                [2] = 1
                            }
                            game:GetService("Players").LocalPlayer.Character:FindFirstChild("Mammoth-Mammoth")
                                .LeftClickRemote:FireServer(unpack(args))
                        end
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while wait(0.1) do
        if _G['Fast Attack'] then
            pcall(function()
                for i, enemy in pairs(game.workspace.Enemies:GetChildren()) do
                    if enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                        local args = {
                            [1] = enemy.HumanoidRootPart.Position,
                            [2] = 1
                        }
                        game:GetService("Players").LocalPlayer.Character:FindFirstChild("Gas-Gas").LeftClickRemote
                            :FireServer(unpack(args))
                        --[[]
                    for i, player in pairs(game.workspace.Characters:GetChildren()) do
                        if player:FindFirstChild("HumanoidRootPart") and player:FindFirstChild("Humanoid") and player.Humanoid.Health > 0 then
                            local args = {
                            [1] = player.HumanoidRootPart.Position,
                            [2] = 1
                        }
                        game:GetService("Players").LocalPlayer.Character:FindFirstChild("T-Rex-T-Rex").LeftClickRemote:FireServer(unpack(args))
                    end
                    end
                    --]]
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while wait(0.1) do
        if _G['Fast Attack'] then
            pcall(function()
                for i, player in pairs(game.workspace.Characters:GetChildren()) do
                    if player:FindFirstChild("HumanoidRootPart") and player:FindFirstChild("Humanoid") and player.Humanoid.Health > 0 then
                        if (player.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 1250 then
                            local args = {
                                [1] = player.HumanoidRootPart.Position,
                                [2] = 1
                            }
                            game:GetService("Players").LocalPlayer.Character:FindFirstChild("Gas-Gas")
                                .LeftClickRemote:FireServer(unpack(args))
                        end
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while wait(0.1) do
        if _G['Fast Attack'] then
            pcall(function()
                for i, enemy in pairs(game.workspace.Enemies:GetChildren()) do
                    if enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                        local args = {
                            [1] = enemy.HumanoidRootPart.Position,
                            [2] = 1
                        }
                        game:GetService("Players").LocalPlayer.Character:FindFirstChild("Leopard-Leopard")
                            .LeftClickRemote:FireServer(unpack(args))
                        --[[]
                    for i, player in pairs(game.workspace.Characters:GetChildren()) do
                        if player:FindFirstChild("HumanoidRootPart") and player:FindFirstChild("Humanoid") and player.Humanoid.Health > 0 then
                            local args = {
                            [1] = player.HumanoidRootPart.Position,
                            [2] = 1
                        }
                        game:GetService("Players").LocalPlayer.Character:FindFirstChild("T-Rex-T-Rex").LeftClickRemote:FireServer(unpack(args))
                    end
                    end
                    --]]
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if _G['Fast Attack'] then
            pcall(function()
                for i, player in pairs(game.workspace.Characters:GetChildren()) do
                    if player:FindFirstChild("HumanoidRootPart") and player:FindFirstChild("Humanoid") and player.Humanoid.Health > 0 then
                        if (player.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 1250 then
                            local args = {
                                [1] = player.HumanoidRootPart.Position,
                                [2] = 1
                            }
                            game:GetService("Players").LocalPlayer.Character:FindFirstChild("Leopard-Leopard")
                                .LeftClickRemote:FireServer(unpack(args))
                        end
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if _G['Fast Attack'] then
            pcall(function()
                for i, enemy in pairs(game.workspace.Enemies:GetChildren()) do
                    if enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                        local args = {
                            [1] = enemy.HumanoidRootPart.Position,
                            [2] = 1,
                            [3] = true
                        }
                        game:GetService("Players").LocalPlayer.Character:FindFirstChild("Kitsune-Kitsune")
                            .LeftClickRemote:FireServer(unpack(args))
                        --[[]
                    for i, player in pairs(game.workspace.Characters:GetChildren()) do
                        if player:FindFirstChild("HumanoidRootPart") and player:FindFirstChild("Humanoid") and player.Humanoid.Health > 0 then
                            local args = {
                            [1] = player.HumanoidRootPart.Position,
                            [2] = 1
                        }
                        game:GetService("Players").LocalPlayer.Character:FindFirstChild("T-Rex-T-Rex").LeftClickRemote:FireServer(unpack(args))
                    end
                    end
                    --]]
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while wait(0.1) do
        if _G['Fast Attack'] then
            pcall(function()
                for i, player in pairs(game.workspace.Characters:GetChildren()) do
                    if player:FindFirstChild("HumanoidRootPart") and player:FindFirstChild("Humanoid") and player.Humanoid.Health > 0 then
                        if (player.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 1250 then
                            local args = {
                                [1] = player.HumanoidRootPart.Position,
                                [2] = 1,
                                [3] = true
                            }
                            game:GetService("Players").LocalPlayer.Character:FindFirstChild("Kitsune-Kitsune")
                                .LeftClickRemote:FireServer(unpack(args))
                        end
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while wait(0.1) do
        if _G['Fast Attack'] then
            pcall(function()
                for i, enemy in pairs(game.workspace.Enemies:GetChildren()) do
                    if enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                        local args = {
                            [1] = enemy.HumanoidRootPart.Position,
                            [2] = 1
                        }
                        game:GetService("Players").LocalPlayer.Character:FindFirstChild("Dragon-Dragon")
                            .LeftClickRemote:FireServer(unpack(args))
                        --[[]
                    for i, player in pairs(game.workspace.Characters:GetChildren()) do
                        if player:FindFirstChild("HumanoidRootPart") and player:FindFirstChild("Humanoid") and player.Humanoid.Health > 0 then
                            local args = {
                            [1] = player.HumanoidRootPart.Position,
                            [2] = 1
                        }
                        game:GetService("Players").LocalPlayer.Character:FindFirstChild("T-Rex-T-Rex").LeftClickRemote:FireServer(unpack(args))
                    end
                    end
                    --]]
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while wait(0.1) do
        if _G['Fast Attack'] then
            pcall(function()
                for i, player in pairs(game.workspace.Characters:GetChildren()) do
                    if player:FindFirstChild("HumanoidRootPart") and player:FindFirstChild("Humanoid") and player.Humanoid.Health > 0 then
                        if (player.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 1250 then
                            local args = {
                                [1] = player.HumanoidRootPart.Position,
                                [2] = 1
                            }
                            game:GetService("Players").LocalPlayer.Character:FindFirstChild("Dragon-Dragon")
                                .LeftClickRemote:FireServer(unpack(args))
                        end
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if _G['Fast Attack'] then
            pcall(function()
                for i,v in pairs(game.workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                        if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 50 then
                            local args = {
                                [1] = "TAP",
                                [2] = v.HumanoidRootPart.Position,
                                [3] = v.HumanoidRootPart.Position
                            }
                            
                            game:GetService("Players").LocalPlayer.Character.Humanoid:FindFirstChild(""):InvokeServer(unpack(args))
                        end
                    end
                end
            end)
        end
    end
end)
_G['Bring Mob'] = true
spawn(function()
    while wait(0) do
        pcall(function()
            if _G['Bring Mob'] then
                CheckQuest()
                for i, v in pairs(workspace.Enemies:GetChildren()) do
                    if _G['Auto Farm Level'] and _G['StartMagnet'] and v.Name == Mon and (Mon == "Factory Staff" or Mon == "Monkey" or Mon == "Dragon Crew Warrior" or Mon == "Dragon Crew Archer") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 250 then
                        v.HumanoidRootPart.CFrame = _G['PosMon']
                        v.Humanoid:ChangeState(14)
                        v.HumanoidRootPart.CanCollide = false
                        v.Head.CanCollide = false
                        if v.Humanoid:FindFirstChild("Animator") then
                            v.Humanoid.Animator:Destroy()
                        end
                        sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                    elseif _G['Auto Farm Level'] and _G['StartMagnet'] and v.Name == Mon and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= _G['BringMode'] then
                        v.HumanoidRootPart.CFrame = _G['PosMon']
                        v.Humanoid:ChangeState(14)
                        v.HumanoidRootPart.CanCollide = false
                        v.Head.CanCollide = false
                        if v.Humanoid:FindFirstChild("Animator") then
                            v.Humanoid.Animator:Destroy()
                        end
                        sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                    end
                    if _G['Auto Farm [Nearest Mob]'] and _G['StartN'] and v.Name == Mon and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= _G['BringMode'] then
                        v.HumanoidRootPart.CFrame = _G['PosMonN']
                        v.Humanoid:ChangeState(14)
                        v.HumanoidRootPart.CanCollide = false
                        v.Head.CanCollide = false
                        if v.Humanoid:FindFirstChild("Animator") then
                            v.Humanoid.Animator:Destroy()
                        end
                        sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                    end
                    if _G.AutoEctoplasm and StartEctoplasmMagnet then
                        if string.find(v.Name, "Ship") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and (v.HumanoidRootPart.Position - EctoplasmMon.Position).Magnitude <= _G['BringMode'] then
                            v.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
                            v.HumanoidRootPart.CFrame = EctoplasmMon
                            v.Humanoid:ChangeState(14)
                            v.HumanoidRootPart.CanCollide = false
                            v.Head.CanCollide = false
                            if v.Humanoid:FindFirstChild("Animator") then
                                v.Humanoid.Animator:Destroy()
                            end
                            sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                        end
                    end
                    if _G.AutoRengoku and StartRengokuMagnet then
                        if (v.Name == "Snow Lurker" or v.Name == "Arctic Warrior") and (v.HumanoidRootPart.Position - RengokuMon.Position).Magnitude <= _G['BringMode'] and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                            v.HumanoidRootPart.Size = Vector3.new(1500, 1500, 1500)
                            v.Humanoid:ChangeState(14)
                            v.HumanoidRootPart.CanCollide = false
                            v.Head.CanCollide = false
                            v.HumanoidRootPart.CFrame = RengokuMon
                            if v.Humanoid:FindFirstChild("Animator") then
                                v.Humanoid.Animator:Destroy()
                            end
                            sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                        end
                    end
                    if _G['Auto Bartilo Quest'] and _G['AutoBartiloBring'] then
                        if v.Name == "Swan Pirate" and (v.HumanoidRootPart.Position - PosMonBarto.Position).Magnitude <= _G['BringMode'] and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                            v.Humanoid:ChangeState(14)
                            v.HumanoidRootPart.CanCollide = false
                            v.Head.CanCollide = false
                            v.HumanoidRootPart.CFrame = _G['PosMonBarto']
                            if v.Humanoid:FindFirstChild("Animator") then
                                v.Humanoid.Animator:Destroy()
                            end
                            sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                        end
                    end
                    if _G['Auto Farm Fast Mode'] and _G['Fast Mode'] then
                        if v.Name == "Swan Pirate" and (v.HumanoidRootPart.Position - PosMonBarto.Position).Magnitude <= _G['BringMode'] and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                            v.Humanoid:ChangeState(14)
                            v.HumanoidRootPart.CanCollide = false
                            v.Head.CanCollide = false
                            v.HumanoidRootPart.CFrame = _G['PosMonFastMode']
                            if v.Humanoid:FindFirstChild("Animator") then
                                v.Humanoid.Animator:Destroy()
                            end
                            sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                        end
                    end
                    if _G['Auto Farm Bone'] and _G['StartMagnetBoneMon'] then
                        if (v.Name == "Reborn Skeleton" or v.Name == "Living Zombie" or v.Name == "Demonic Soul" or v.Name == "Posessed Mummy") and (v.HumanoidRootPart.Position - PosMonBone.Position).Magnitude <= _G['BringMode'] and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                            v.Humanoid:ChangeState(14)
                            v.HumanoidRootPart.CanCollide = false
                            v.Head.CanCollide = false
                            v.HumanoidRootPart.CFrame = _G['PosMonBone']
                            if v.Humanoid:FindFirstChild("Animator") then
                                v.Humanoid.Animator:Destroy()
                            end
                            sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                        end
                    end
                    if _G['Auto Fram Cake Prince'] and _G['MagnetDought'] then
                        if (v.Name == "Cookie Crafter" or v.Name == "Cake Guard" or v.Name == "Baking Staff" or v.Name == "Head Baker") and (v.HumanoidRootPart.Position - PosMonDoughtOpenDoor.Position).Magnitude <= _G['BringMode'] and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                            v.Humanoid:ChangeState(14)
                            v.HumanoidRootPart.CanCollide = false
                            v.Head.CanCollide = false
                            v.HumanoidRootPart.CFrame = _G['PosMonDoughtOpenDoor']
                            if v.Humanoid:FindFirstChild("Animator") then
                                v.Humanoid.Animator:Destroy()
                            end
                            sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                        end
                    end
                end
            end
        end)
    end
end)
if World1 then
    _G['BringMode'] = 325
end
if L_4442272183_ then
    _G['BringMode'] = 325
end
if L_7449423635_ then
    _G['BringMode'] = 325
end


local TweenService = game:GetService("TweenService")
-- แบบบินมอน
--[[function BringMob(pos)
    local BlacklistMob = {
        "rip_indra", "Ice Admiral", "Saber Expert", "The Saw", "Greybeard", "Mob Leader",
        "The Gorilla King", "Bobby", "Yeti", "Vice Admiral", "Warden", "Chief Warden",
        "Swan", "Magma Admiral", "Fishman Lord", "Wysper", "Thunder God", "Cyborg",
        "Don Swan", "Diamond", "Jeremy", "Fajita", "Smoke Admiral", "Awakened Ice Admiral",
        "Tide Keeper", "Order", "Darkbeard", "Stone", "Island Empress", "Kilo Admiral",
        "Captain Elephant", "Beautiful Pirate", "Cake Queen", "rip_indra True Form",
        "Longma", "Soul Reaper", "Cake Prince", "Dough King"
    }

    pcall(function()
        for _, v in pairs(workspace.Enemies:GetChildren()) do
            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                if not table.find(BlacklistMob, v.Name) then
                    local p = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                    local m = v.HumanoidRootPart.Position
                    if (m - p).Magnitude <= 200 then
                        v.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
                        v.Head.CanCollide = false
                        v.HumanoidRootPart.CanCollide = false
                        v.Humanoid.WalkSpeed = 0
                        if sethiddenproperty then
                            sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                        end
                        local distance = (v.HumanoidRootPart.Position - pos.Position).Magnitude
                        if distance > 100 then
                            speedfbbffb = 275
                        elseif distance <= 100 then
                            speedfbbffb = 1000
                        end
                        local timeToReach = distance / speedfbbffb
                        local tweenInfo = TweenInfo.new(
                            timeToReach,
                            Enum.EasingStyle.Linear,
                            Enum.EasingDirection.Out,
                            0,
                            false,
                            0
                        )
                        local goal = {CFrame = CFrame.new(pos.Position)}
                        local tween = TweenService:Create(v.HumanoidRootPart, tweenInfo, goal)
                        tween:Play()
                        spawn(function()
                            while v and v.Parent and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 do wait()
                                local randomX = math.random(-360, 360)
                                local randomY = math.random(-360, 360)
                                local randomZ = math.random(-360, 360)
                                local rotateInfo = TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
                                local rotateGoal = {Orientation = Vector3.new(randomX, randomY, randomZ)}
                                local rotateTween = TweenService:Create(v.HumanoidRootPart, rotateInfo, rotateGoal)
                                rotateTween:Play()
                                wait()
                            end
                        end)
                    end
                end
            end
        end
    end)
end--]]
-- แบบดึงมอนมาหาเรา
--[[function BringMob(pos)
    local BlacklistMob = {
        "rip_indra", "Ice Admiral", "Saber Expert", "The Saw", "Greybeard", "Mob Leader",
        "The Gorilla King", "Bobby", "Yeti", "Vice Admiral", "Warden", "Chief Warden",
        "Swan", "Magma Admiral", "Fishman Lord", "Wysper", "Thunder God", "Cyborg",
        "Don Swan", "Diamond", "Jeremy", "Fajita", "Smoke Admiral", "Awakened Ice Admiral",
        "Tide Keeper", "Order", "Darkbeard", "Stone", "Island Empress", "Kilo Admiral",
        "Captain Elephant", "Beautiful Pirate", "Cake Queen", "rip_indra True Form",
        "Longma", "Soul Reaper", "Cake Prince", "Dough King"
    }
    pcall(function()
        for _, v in pairs(workspace.Enemies:GetChildren()) do
            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                if not table.find(BlacklistMob, v.Name) then
                    local p = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                    local m = v.HumanoidRootPart.Position
                    if (m - p).Magnitude <= 200 then
                        v.HumanoidRootPart.CFrame = pos
                        v.HumanoidRootPart.Size = Vector3.new(2,2,1)
                        v.Head.CanCollide = false
                        v.HumanoidRootPart.CanCollide = false
                        v.Humanoid.WalkSpeed = 0
                        if sethiddenproperty then
                           sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                        end
                        spawn(function()
                            while v and v.Parent and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 do wait(0.3)
                                local randomX = math.rad(math.random(-360, 360))
                                local randomY = math.rad(math.random(-360, 360))
                                local randomZ = math.rad(math.random(-360, 360))
                                v.HumanoidRootPart.CFrame = pos
                                --v.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.Angles(math.rad(10), math.rad(10), math.rad(10))
                                wait(0.3)
                            end
                        end)
                    end
                end
            end
        end
    end)
end--]]
-- แบบดึงมอนหามอน
function BringMob(pos)
    local BlacklistMob = {
        "rip_indra", "Ice Admiral", "Saber Expert", "The Saw", "Greybeard", "Mob Leader",
        "The Gorilla King", "Bobby", "Yeti", "Vice Admiral", "Warden", "Chief Warden",
        "Swan", "Magma Admiral", "Fishman Lord", "Wysper", "Thunder God", "Cyborg",
        "Don Swan", "Diamond", "Jeremy", "Fajita", "Smoke Admiral", "Awakened Ice Admiral",
        "Tide Keeper", "Order", "Darkbeard", "Stone", "Island Empress", "Kilo Admiral",
        "Captain Elephant", "Beautiful Pirate", "Cake Queen", "rip_indra True Form",
        "Longma", "Soul Reaper", "Cake Prince", "Dough King"
    }
    pcall(function()
        for i, v in pairs(workspace.Enemies:GetChildren()) do
            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                if not table.find(BlacklistMob, v.Name) then
                    local p = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position
                    local m = v.HumanoidRootPart.Position
                    if (m - p).Magnitude <= 100 then
                        wait(0.3)
                        v.HumanoidRootPart.CFrame = pos
                        v.Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
                        v.Humanoid:ChangeState(14)
                        v.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                        v.HumanoidRootPart.RotVelocity = Vector3.new(0, 0, 0)
                        local bp = Instance.new("BodyPosition", v.HumanoidRootPart)
                        bp.MaxForce = Vector3.new(1e6, 1e6, 1e6)
                        bp.Position = pos.Position
                        bp.P = 1e6
                        local bg = Instance.new("BodyGyro", v.HumanoidRootPart)
                        bg.MaxTorque = Vector3.new(1e6, 1e6, 1e6)
                        bg.CFrame = pos
                        sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                        setscriptable(game.Players.LocalPlayer, "SimulationRadius", true)
                    end
                end
            end
        end
    end)
end
function BringMobFast(pos)
    local BlacklistMob = {
        "rip_indra", "Ice Admiral", "Saber Expert", "The Saw", "Greybeard", "Mob Leader",
        "The Gorilla King", "Bobby", "Yeti", "Vice Admiral", "Warden", "Chief Warden",
        "Swan", "Magma Admiral", "Fishman Lord", "Wysper", "Thunder God", "Cyborg",
        "Don Swan", "Diamond", "Jeremy", "Fajita", "Smoke Admiral", "Awakened Ice Admiral",
        "Tide Keeper", "Order", "Darkbeard", "Stone", "Island Empress", "Kilo Admiral",
        "Captain Elephant", "Beautiful Pirate", "Cake Queen", "rip_indra True Form",
        "Longma", "Soul Reaper", "Cake Prince", "Dough King"
    }
    pcall(function()
        for i, v in pairs(workspace.Enemies:GetChildren()) do
            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                if not table.find(BlacklistMob, v.Name) then
                    local p = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position
                    local m = v.HumanoidRootPart.Position
                    if (m - p).Magnitude <= 150 then
                        v.HumanoidRootPart.CFrame = pos
                        v.HumanoidRootPart.CanCollide = false
                        if v:FindFirstChild("Head") then
                            v.Head.CanCollide = false
                        end
                        v.Humanoid.WalkSpeed = 0
                        v.Humanoid.JumpHeight = 0
                        v.Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
                        v.Humanoid:ChangeState(14)
                        v.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                        v.HumanoidRootPart.RotVelocity = Vector3.new(0, 0, 0)
                        local bp = Instance.new("BodyPosition", v.HumanoidRootPart)
                        bp.MaxForce = Vector3.new(1e6, 1e6, 1e6)
                        bp.Position = pos.Position
                        bp.P = 1e6
                        local bg = Instance.new("BodyGyro", v.HumanoidRootPart)
                        bg.MaxTorque = Vector3.new(1e6, 1e6, 1e6)
                        bg.CFrame = pos
                        if v.Humanoid:FindFirstChild("Animator") then
                            v.Humanoid.Animator:Destroy()
                        end
                        sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                        setscriptable(game.Players.LocalPlayer, "SimulationRadius", true)
                    end
                end
            end
        end
    end)
end
function BringMobCakePrince(pos)
    local BlacklistMob = {
        "rip_indra", "Ice Admiral", "Saber Expert", "The Saw", "Greybeard", "Mob Leader",
        "The Gorilla King", "Bobby", "Yeti", "Vice Admiral", "Warden", "Chief Warden",
        "Swan", "Magma Admiral", "Fishman Lord", "Wysper", "Thunder God", "Cyborg",
        "Don Swan", "Diamond", "Jeremy", "Fajita", "Smoke Admiral", "Awakened Ice Admiral",
        "Tide Keeper", "Order", "Darkbeard", "Stone", "Island Empress", "Kilo Admiral",
        "Captain Elephant", "Beautiful Pirate", "Cake Queen", "rip_indra True Form",
        "Longma", "Soul Reaper", "Cake Prince", "Dough King"
    }
    pcall(function()
        for i, v in pairs(workspace.Enemies:GetChildren()) do
            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                if not table.find(BlacklistMob, v.Name) then
                    local p = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position
                    local m = v.HumanoidRootPart.Position
                    if (m - p).Magnitude <= 140 then
                        v.HumanoidRootPart.CFrame = pos
                        v.HumanoidRootPart.CanCollide = false
                        if v:FindFirstChild("Head") then
                            v.Head.CanCollide = false
                        end
                        v.Humanoid.WalkSpeed = 0
                        v.Humanoid.JumpHeight = 0
                        v.Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
                        v.Humanoid:ChangeState(14)
                        v.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                        v.HumanoidRootPart.RotVelocity = Vector3.new(0, 0, 0)
                        local bp = Instance.new("BodyPosition", v.HumanoidRootPart)
                        bp.MaxForce = Vector3.new(1e6, 1e6, 1e6)
                        bp.Position = pos.Position
                        bp.P = 1e6
                        local bg = Instance.new("BodyGyro", v.HumanoidRootPart)
                        bg.MaxTorque = Vector3.new(1e6, 1e6, 1e6)
                        bg.CFrame = pos
                        if v.Humanoid:FindFirstChild("Animator") then
                            v.Humanoid.Animator:Destroy()
                        end
                        sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                        setscriptable(game.Players.LocalPlayer, "SimulationRadius", true)
                    end
                end
            end
        end
    end)
end
--[[]
function BringMonster(TargetName, TargetCFrame)
local sethiddenproperty = sethiddenproperty or (function(...) return ... end)
for i,v in pairs(workspace.Enemies:GetChildren()) do
    if v.Name == TargetName then
        if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < tonumber(bringfrec) then
                v.HumanoidRootPart.CFrame = TargetCFrame
                v.HumanoidRootPart.CanCollide = false
                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                v.HumanoidRootPart.Transparency = 1
                v.Humanoid:ChangeState(11)
                v.Humanoid:ChangeState(14)
                if v.Humanoid:FindFirstChild("Animator") then
                    v.Humanoid.Animator:Destroy()
                end
                --sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
            end
        end
    end
end
pcall(sethiddenproperty, game.Players.LocalPlayer, "SimulationRadius", math.huge)
end
bringfrec = 250
local Toggle = Tabs.FarmSettings:AddToggle("Bring Mob", {
Title = "Bring Mob",
Description = "",
Default = true,
Callback = function(Value)
    BringMobs = Value
end
})
spawn(function()
while task.wait() do
    if BringMobs and (_G['Auto Farm Level'] or LevelFarmNoQuest) then
        pcall(function()
            BringMonster(Level_Farm_Name, Level_Farm_CFrame)
        end)
    elseif BringMobs and Farm_Bone then
        pcall(function()
            BringMonster(Bone_Farm_Name, Bone_Farm_CFrame)
        end)
    elseif BringMobs and Farm_Ectoplasm then
        pcall(function()
            BringMonster(Ecto_Farm_Name, Ecto_Farm_CFrame)
        end)
    elseif BringMobs and Nearest_Farm then
        pcall(function()
            BringMonster(Nearest_Farm_Name, Nearest_Farm_CFrame)
        end)
    elseif BringMobs and (SelectMonster_Quest_Farm or SelectMonster_NoQuest_Farm) then
        pcall(function()
            BringMonster(SelectMonster_Farm_Name, SelectMonster_Farm_CFrame)
        end)
    elseif BringMobs and Auto_Farm_Material then
        pcall(function()
            BringMonster(Material_Farm_Name, Material_Farm_CFrame)
        end)
    elseif BringMobs and (GunMastery_Farm or DevilMastery_Farm) then
        pcall(function()
            BringMonster(Mastery_Farm_Name, Mastery_Farm_CFrame)
        end)
    elseif BringMobs and AutoRengoku then
        pcall(function()
            BringMonster(Rengoku_Farm_Name, Rengoku_Farm_CFrame)
        end)
    elseif BringMobs and AutoCakePrince then
        pcall(function()
            BringMonster(CakePrince_Farm_Name, CakePrince_Farm_CFrame)
        end)
    elseif BringMobs and _G.AutoDoughKing then
        pcall(function()
            BringMonster(DoughKing_Farm_Name, DoughKing_Farm_CFrame)
        end)
    elseif BringMobs and AutoCitizen then
        pcall(function()
            BringMonster(Citizen_Farm_Name, Citizen_Farm_CFrame)
        end)
    elseif BringMobs and AutoEvoRace then
        pcall(function()
            BringMonster(EvoV2_Farm_Name, EvoV2_Farm_CFrame)
        end)
    elseif BringMobs and AutoBartilo then
        pcall(function()
            BringMonster(Bartilo_Farm_Name, Bartilo_Farm_CFrame)
        end)
    elseif BringMobs and AutoSoulGuitar then
        pcall(function()
            BringMonster(SoulGuitar_Farm_Name, SoulGuitar_Farm_CFrame)
        end)
    elseif BringMobs and AutoMusketeer then
        pcall(function()
            BringMonster(Musketere_Farm_Name, Musketere_Farm_CFrame)
        end)
    elseif BringMobs and AutoTrain then
        pcall(function()
            BringMonster(Ancient_Farm_Name, Ancient_Farm_CFrame)
        end)
    elseif BringMobs and AutoPirateCastle then
        pcall(function()
            BringMonster(PirateCastle_Name, PirateCastle_CFrame)
        end)
    elseif BringMobs and BlazeEmberFarm then
        pcall(function()
            BringMonster(BlazeEmber_Farm_Name, BlazeEmber_Farm_CFrame)
        end)
    end
end
end)
]]
GetWeaponData = require(game:GetService("ReplicatedStorage").Modules.CombatUtil):GetWeaponData("Slingshot")
GetWeaponData1 = require(game:GetService("ReplicatedStorage").Modules.CombatUtil):GetWeaponData("Flintlock")
GetWeaponData2 = require(game:GetService("ReplicatedStorage").Modules.CombatUtil):GetWeaponData("Musket")
GetWeaponData3 = require(game:GetService("ReplicatedStorage").Modules.CombatUtil):GetWeaponData("Acidum Rifle")
GetWeaponData4 = require(game:GetService("ReplicatedStorage").Modules.CombatUtil):GetWeaponData("Bizarre Revolver")
GetWeaponData5 = require(game:GetService("ReplicatedStorage").Modules.CombatUtil):GetWeaponData("Cannon")
GetWeaponData6 = require(game:GetService("ReplicatedStorage").Modules.CombatUtil):GetWeaponData("Dual Flintlock")
GetWeaponData7 = require(game:GetService("ReplicatedStorage").Modules.CombatUtil):GetWeaponData("Magma Blaster")
GetWeaponData8 = require(game:GetService("ReplicatedStorage").Modules.CombatUtil):GetWeaponData("Refined Slingshot")
GetWeaponData9 = require(game:GetService("ReplicatedStorage").Modules.CombatUtil):GetWeaponData("Bazooka")
GetWeaponData10 = require(game:GetService("ReplicatedStorage").Modules.CombatUtil):GetWeaponData("Kabucha")
GetWeaponData11 = require(game:GetService("ReplicatedStorage").Modules.CombatUtil):GetWeaponData("Venom Bow")
GetWeaponData12 = require(game:GetService("ReplicatedStorage").Modules.CombatUtil):GetWeaponData("Dragonstorm")
GetWeaponData13 = require(game:GetService("ReplicatedStorage").Modules.CombatUtil):GetWeaponData("Skull Guitar")
row = titledRow(form, "Gun No Cooldown","Shoot without gun cooldown")
row:Right():Toggle({
    Value = Config["Gun No Cooldown"] or false,
    ValueChanged = function(self, value)
        _G['Gun No Cooldown'] = value
        Config["Gun No Cooldown"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end,
})
spawn(function()
    while wait() do
        if _G['Gun No Cooldown'] then
            pcall(function()
                if _G['Gun No Cooldown Mode'] == "Fast" then
                    GetWeaponData.Cooldown = 0.06
                    GetWeaponData1.Cooldown = 0.06
                    GetWeaponData2.Cooldown = 0.06
                    GetWeaponData3.Cooldown = 0.06
                    GetWeaponData4.Cooldown = 0.06
                    GetWeaponData4.ShootInterval = 0.06
                    GetWeaponData5.Cooldown = 0.06
                    GetWeaponData6.Cooldown = 0.06
                    GetWeaponData7.Cooldown = 0.06
                    GetWeaponData8.Cooldown = 0.06
                    GetWeaponData9.Cooldown = 0.06
                    GetWeaponData10.Cooldown = 0.06
                    GetWeaponData11.Cooldown = 0.06
                    GetWeaponData12.Cooldown = 0.06
                    GetWeaponData13.Cooldown = 0.06
                elseif _G['Gun No Cooldown Mode'] == "Super (Risk)" then
                    GetWeaponData.Cooldown = -999999999999999999999999999999999999999999999999999999999999999
                    GetWeaponData1.Cooldown = -999999999999999999999999999999999999999999999999999999999999999
                    GetWeaponData2.Cooldown = -999999999999999999999999999999999999999999999999999999999999999
                    GetWeaponData3.Cooldown = -999999999999999999999999999999999999999999999999999999999999999
                    GetWeaponData4.Cooldown = -999999999999999999999999999999999999999999999999999999999999999
                    GetWeaponData4.ShootInterval = -999999999999999999999999999999999999999999999999999999999999999
                    GetWeaponData5.Cooldown = -999999999999999999999999999999999999999999999999999999999999999
                    GetWeaponData6.Cooldown = -999999999999999999999999999999999999999999999999999999999999999
                    GetWeaponData7.Cooldown = -999999999999999999999999999999999999999999999999999999999999999
                    GetWeaponData8.Cooldown = -999999999999999999999999999999999999999999999999999999999999999
                    GetWeaponData9.Cooldown = -999999999999999999999999999999999999999999999999999999999999999
                    GetWeaponData10.Cooldown = -999999999999999999999999999999999999999999999999999999999999999
                    GetWeaponData11.Cooldown = -999999999999999999999999999999999999999999999999999999999999999
                    GetWeaponData12.Cooldown = -999999999999999999999999999999999999999999999999999999999999999
                    GetWeaponData13.Cooldown = -999999999999999999999999999999999999999999999999999999999999999
                end
            end)
        else
            GetWeaponData.Cooldown = 0.4
            GetWeaponData1.Cooldown = 1.8
            GetWeaponData2.Cooldown = 2.7
            GetWeaponData3.Cooldown = 2
            GetWeaponData4.Cooldown = 2.6
            GetWeaponData4.ShootInterval = 1
            GetWeaponData5.Cooldown = 3.5
            GetWeaponData6.Cooldown = 1.6
            GetWeaponData7.Cooldown = 2.3
            GetWeaponData8.Cooldown = 0.4
            GetWeaponData9.Cooldown = 3.5
            GetWeaponData10.Cooldown = 0.45
            GetWeaponData11.Cooldown = 1
            GetWeaponData12.Cooldown = 0.08
            GetWeaponData13.Cooldown = 1.5
        end
    end
end)
row = titledRow(form, "Auto Haki","Automatic Haki")
row:Right():Toggle({
    Value = Config["Auto Haki"] or true,
    ValueChanged = function(self, value)
        _G['Auto Haki'] = value
        Config["Auto Haki"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end,
})
spawn(function()
    while wait(.1) do
        if _G['Auto Haki'] then
            if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
                local args = {
                    [1] = "Buso"
                }
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
            end
        end
    end
end)
row = titledRow(form, "Auto Set Spawn Point","Automatically set spawn point")
row:Right():Toggle({
    Value = Config["Auto Set Spawn Point"] or false,
    ValueChanged = function(self, value)
        _G['Auto Set Spawn Point'] = value
        Config["Auto Set Spawn Point"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end,
})
spawn(function()
    while wait() do
        if _G['Auto Set Spawn Point'] then
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
            end)
        end
    end
end)
row = titledRow(form, "Bypass TP")
row:Right():Toggle({
    Value = Config["Bypass TP"] or false,
    ValueChanged = function(self, value)
        Config["Bypass TP"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end,
})
row = titledRow(form, "Hide Notifications","Hide notifications")
row:Right():Toggle({
    Value = Config["Hide Notifications"] or false,
    ValueChanged = function(self, value)
        _G['Hide Notifications'] = value
        Config["Hide Notifications"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end,
})
spawn(function()
    while wait() do
        pcall(function()
            if _G['Hide Notifications'] then
                game:GetService("Players").LocalPlayer.PlayerGui.Notifications.Enabled = false
            else
                game:GetService("Players").LocalPlayer.PlayerGui.Notifications.Enabled = true
            end
        end)
    end
end)
row = titledRow(form, "White Screen")
row:Right():Toggle({
    Value = Config["White Screen"] or false,
    ValueChanged = function(self, value)
        Config["White Screen"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        if value then
            game:GetService('RunService'):Set3dRenderingEnabled(false)
        else
            game:GetService('RunService'):Set3dRenderingEnabled(true)
        end
    end,
})
row = titledRow(form, "Enabled Full Bright")
row:Right():Toggle({
    Value = Config["Enabled Full Bright"] or false,
    ValueChanged = function(self, value)
        Config["Enabled Full Bright"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end,
})
spawn(function()
    while task.wait() do
        if Config["Enabled Full Bright"] then
            pcall(function()
                game:GetService("Lighting").ClockTime = 14
            end)
        end
    end
end)
local row = form:Row({
    SearchIndex = "Farm Distance",
})
local frea_D = row:Left():TitleStack({
    Title = "Farm Distance",
})
spawn(function()
    while task.wait() do
        pcall(function()
            frea_D.Title = "Farm Distance " .. "( " .. tostring(Config["Farm Distance"]) .. " )"
        end)
    end
end)
row:Right():Slider({
    Minimum = 5,
    Maximum = 40,
    Value = Config["Farm Distance"] or 16,
    ValueChanged = function(self, value)
    local num = tonumber(value)
        if num then
            num = math.floor(num)
            PosY = num
            Config["Farm Distance"] = num
            getgenv()['Update_Setting'](getgenv()['MyName'])
        end
    end,
})
local row = form:Row({
    SearchIndex = "Tween Speed",
})
local T_D = row:Left():TitleStack({
    Title = "Tween Speed",
})
spawn(function()
    while task.wait() do
        pcall(function()
            T_D.Title = "Tween Speed " .. "( " .. tostring(Config["Tween Speed"]) .. " )"
        end)
    end
end)
row:Right():Slider({
    Minimum = 50,
    Maximum = 300,
    Value = Config["Tween Speed"] or 275,
    ValueChanged = function(self, value)
    local num = tonumber(value)
        if num then
            num = math.floor(num)
            L_3c2 = num
            Config["Tween Speed"] = num
            getgenv()['Update_Setting'](getgenv()['MyName'])
        end
    end,
})
local row = form:Row({
    SearchIndex = "Boat Tween Speed",
})
local BT_D = row:Left():TitleStack({
    Title = "Boat Tween Speed",
})
spawn(function()
    while task.wait() do
        pcall(function()
            BT_D.Title = "Boat Tween Speed " .. "( " .. tostring(Config["Boat Tween Speed"]) .. " )"
        end)
    end
end)
row:Right():Slider({
    Minimum = 50,
    Maximum = 350,
    Value = Config["Boat Tween Speed"] or 300,
    ValueChanged = function(self, value)
    local num = tonumber(value)
        if num then
            num = math.floor(num)
            spppp = num
            Config["Boat Tween Speed"] = num
            getgenv()['Update_Setting'](getgenv()['MyName'])
        end
    end,
})
form = Tabs.FarmSettings:PageSection({ Title = "Settings Skills" }):Form()
row = titledRow(form, "Skill")
local Sk = row:Right():PullDownButton({
    Options = {
        "Z",
        "X",
        "C",
        "V",
        "F",
    },
    Label = "N/A",
    Multi = true,
    ValueLabel = 2,
    Selected = "Skills",
    Value = Config["Skills"] or {},
    ValueChanged = function(self, value)
        local names = self.Selected
        if self.Multi then
            if self.ValueLabel == 1 then
                _G["selected" .. names] = {}
                for _, i in ipairs(value) do
                    table.insert(_G["selected" .. names], self.Options[i])
                end
                if #_G["selected" .. names] == 0 then
                    self.Label = "N/A"
                elseif #_G["selected" .. names] == 1 then
                    self.Label = _G["selected" .. names][1]
                else
                    self.Label = _G["selected" .. names][1] .. ", ..."
                end
            else
                _G["selected" .. names] = {}
                for _, i in ipairs(value) do
                    table.insert(_G["selected" .. names], self.Options[i])
                end
                if #_G["selected" .. names] == 0 then
                    self.Label = "N/A"
                else
                    self.Label = table.concat(_G["selected" .. names], ", ")
                end
            end
        else
            self.Label = self.Options[value] or "N/A"
        end
        Config["Skills"] = value
        _G.Skills = _G["selected" .. names]
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end,
})
spawn(function()
    while wait() do
        if _G['UseSkill'] then
            pcall(function()
                for i,v in pairs(_G.Skills) do
                    if v == "Z" then
                        game:service("VirtualInputManager"):SendKeyEvent(true, "Z", false, game)
                        wait(0.1)
                        game:service("VirtualInputManager"):SendKeyEvent(false, "Z", false, game)
                    end
                    if v == "X" then
                        game:service("VirtualInputManager"):SendKeyEvent(true, "X", false, game)
                        wait(0.1)
                        game:service("VirtualInputManager"):SendKeyEvent(false, "X", false, game)
                    end
                    if v == "C" then
                        game:service("VirtualInputManager"):SendKeyEvent(true, "C", false, game)
                        wait(0.1)
                        game:service("VirtualInputManager"):SendKeyEvent(false, "C", false, game)
                    end
                    if v == "V" then
                        game:service("VirtualInputManager"):SendKeyEvent(true, "V", false, game)
                        wait(0.1)
                        game:service("VirtualInputManager"):SendKeyEvent(false, "V", false, game)
                    end
                    if v == "F" then
                        game:service("VirtualInputManager"):SendKeyEvent(true, "F", false, game)
                        wait(0.1)
                        game:service("VirtualInputManager"):SendKeyEvent(false, "F", false, game)
                    end
                end
            end)
        end
    end
end)
form = Tabs.Main:PageSection({ Title = "Farm" }):Form()
row = titledRow(
    form,
    "Auto Farm Level",
    "automatic farm level"
)
row:Right():Toggle({
    Value = Config["Auto Farm Level"] or false,
    ValueChanged = function(self, value)
        Config["Auto Farm Level"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Farm Level"])
    end,
})
row = titledRow(
    form,
    "Auto Farm [ Nearest Mob ]",
    "Attacks the nearest monster."
)
row:Right():Toggle({
    Value = Config["Auto Farm [Nearest Mob]"] or false,
    ValueChanged = function(self, value)
        Config["Auto Farm [Nearest Mob]"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Farm [Nearest Mob]"])
    end,
})
form = Tabs.Main:PageSection({ Title = "Next World" }):Form()
row = titledRow(form, "Auto Second Sea","Automatically do tasks in the Second Sea")
row:Right():Toggle({
    Value = Config["Auto Second Sea"] or false,
    ValueChanged = function(self, value)
        Config["Auto Second Sea"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Second Sea"])
    end,
})
row = titledRow(form, "Auto Third Sea","Automatically do tasks in the Third Sea")
row:Right():Toggle({
    Value = Config["Auto Third Sea"] or false,
    ValueChanged = function(self, value)
        Config["Auto Third Sea"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Third Sea"])
    end,
})
form = Tabs.Main:PageSection({ Title = "Boss" }):Form()
row = titledRow(form, "Select Boss","Select the boss to fight")
if math.random(1, 2) == downpress then
local S_B = row:Right():PopUpButton({
    Options = bossCheck,
    Value = (function()
        for i, v in ipairs(bossCheck) do
            if v == Config["Select Boss"] then
                return i
            end
        end
        return 1
    end)(),
    ValueChanged = function(self, value)
        _G['Select Boss'] = self.Options[value]
        Config["Select Boss"] = self.Options[value]
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end,
})
row:Right():Button({
    Label = "Refresh Boss",
    State = "Primary",
    Pushed = function(self)
        local bossCheck = updateBossList()
        S_B.Options = bossCheck
    end,
})
else
local S_B = row:Right():PullDownButton({
    Options = bossCheck,
    Label = "N/A",
    Multi = false,
    ValueLabel = 2,
    Selected = "Select Boss",
    Value = (function()
        for i, v in ipairs(bossCheck) do
            if v == Config["Select Boss"] then
                return i
            end
        end
        return 1
    end)(),
    ValueChanged = function(self, value)
        local names = self.Selected
        if self.Multi then
            if self.ValueLabel == 1 then
                _G["selected" .. names] = {}
                for _, i in ipairs(value) do
                    table.insert(_G["selected" .. names], self.Options[i])
                end
                if #_G["selected" .. names] == 0 then
                    self.Label = "N/A"
                elseif #_G["selected" .. names] == 1 then
                    self.Label = _G["selected" .. names][1]
                else
                    self.Label = _G["selected" .. names][1] .. ", ..."
                end
            else
                _G["selected" .. names] = {}
                for _, i in ipairs(value) do
                    table.insert(_G["selected" .. names], self.Options[i])
                end
                if #_G["selected" .. names] == 0 then
                    self.Label = "N/A"
                else
                    self.Label = table.concat(_G["selected" .. names], ", ")
                end
            end
        else
            self.Label = self.Options[value] or "N/A"
        end
        _G['Select Boss'] = self.Options[value]
        Config["Select Boss"] = self.Options[value]
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end,
})
row:Right():Button({
    Label = "Refresh Boss",
    State = "Primary",
    Pushed = function(self)
        local bossCheck = updateBossList()
        S_B.Options = bossCheck
    end,
})
end
row = titledRow(
    form,
    "Auto Farm Boss",
    "Automatically farm the boss"
)
row:Right():Toggle({
    Value = Config["Auto Farm Boss"] or false,
    ValueChanged = function(self, value)
        Config["Auto Farm Boss"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Farm Boss"])
    end,
})
row = titledRow(
    form,
    "Auto Farm All Boss",
    "Automatically farm all bosses"
)
row:Right():Toggle({
    Value = Config["Auto Farm All Boss"] or false,
    ValueChanged = function(self, value)
        Config["Auto Farm All Boss"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Farm All Boss"])
    end,
})
row = titledRow(
    form,
    "Enabled Accept Quest",
    "Accept quest before fighting the boss"
)
row:Right():Toggle({
    Value = Config["Enabled Accept Quest"] or false,
    ValueChanged = function(self, value)
        Config["Enabled Accept Quest"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end,
})
local bait = {}
local baitrequire = require(game:GetService("ReplicatedStorage").Modules.Asset.ItemData.Types.Bait)
for i,v in pairs(baitrequire) do
    table.insert(bait,i)
end
form = Tabs.Main:PageSection({ Title = "Fishing" }):Form()
local row = form:Row({
    SearchIndex = "Kill At Health %",
})
local K_A = row:Left():TitleStack({
    Title = "Position Fishing",
    getgenv()['Update_Setting'](getgenv()['MyName'])
})
spawn(function()
    while task.wait() do
        pcall(function()
            local pos = LoadCFrame(Config["Position Fishing"])
            if pos then
                K_A.Title = string.format("Position Fishing : X %.2f Y %.2f Z %.2f", pos.X, pos.Y, pos.Z)
            else
                K_A.Title = "Position Fishing : None"
            end
        end)
    end
end)
row = titledRow(form, "Select Bait","Allows you to select the type of bait for fishing. This setting determines which bait will be used when the auto-fishing system runs.")
row:Right():PopUpButton({
    Options = bait,
    Value = (function()
        for i, v in ipairs(bait) do
            if v == Config["Select Bait"] then
                return i
            end
        end
        return 1
    end)(),
    ValueChanged = function(self, value)
        Config["Select Bait"] = self.Options[value]
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end,
})
row = titledRow(form, "Auto Fishing","Automatically performs fishing without manual input. Useful for farming fish, items, or bait continuously without needing to control the character.")
row:Right():Toggle({
    Value = Config["Auto Fishing"] or false,
    ValueChanged = function(self, value)
        Config["Auto Fishing"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Fishing"])
    end,
})
row = titledRow(form, "Auto Buy Bait","Automatically purchases the selected bait when your stock runs out, ensuring the fishing process continues without manual buying.")
row:Right():Toggle({
    Value = Config["Auto Buy Bait"] or false,
    ValueChanged = function(self, value)
        Config["Auto Buy Bait"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Buy Bait"])
    end,
})
row = titledRow(form, "Set Position")
row:Right():Button({
    Label = "Click here!",
    State = "Primary",
    Pushed = function(self)
        local cf = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        Config["Position Fishing"] = SaveCFrame(cf)
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end,
})
row = titledRow(form, "Get Fishing Rod")
row:Right():Button({
    Label = "Click here!",
    State = "Primary",
    Pushed = function(self)
        local args = {"FishingNPC","FirstTimeFreeRod"} game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/JobsRemoteFunction"):InvokeServer(unpack(args))
    end,
})
form = Tabs.Main:PageSection({ Title = "Mastery" }):Form()
row = titledRow(form, "Select Method","Choose method")
if math.random(1, 2) == downpress then
row:Right():PopUpButton({
    Options = {"Level","Bone","Cake Prince"},
    Value = (function()
        for i, v in ipairs({"Level","Bone","Cake Prince"}) do
            if v == Config["Select Method"] then
                return i
            end
        end
        return 1
    end)(),
    ValueChanged = function(self, value)
        Config["Select Method"] = self.Options[value]
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end,
})
else
row:Right():PullDownButton({
    Options = {"Level","Bone","Cake Prince"},
    Label = "N/A",
    Multi = false,
    Selected = "Select Method",
    ValueLabel = 2,
    Value = (function()
        for i, v in ipairs({"Level","Bone","Cake Prince"}) do
            if v == Config["Select Method"] then
                return i
            end
        end
        return 1
    end)(),
    ValueChanged = function(self, value)
        local names = self.Selected
        if self.Multi then
            if self.ValueLabel == 1 then
                _G["selected" .. names] = {}
                for _, i in ipairs(value) do
                    table.insert(_G["selected" .. names], self.Options[i])
                end
                if #_G["selected" .. names] == 0 then
                    self.Label = "N/A"
                elseif #_G["selected" .. names] == 1 then
                    self.Label = _G["selected" .. names][1]
                else
                    self.Label = _G["selected" .. names][1] .. ", ..."
                end
            else
                _G["selected" .. names] = {}
                for _, i in ipairs(value) do
                    table.insert(_G["selected" .. names], self.Options[i])
                end
                if #_G["selected" .. names] == 0 then
                    self.Label = "N/A"
                else
                    self.Label = table.concat(_G["selected" .. names], ", ")
                end
            end
        else
            self.Label = self.Options[value] or "N/A"
        end
        _G['Select Method'] = self.Options[value]
        Config["Select Method"] = self.Options[value]
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end,
})
end
local row = form:Row({
    SearchIndex = "Kill At Health %",
})
local K_A = row:Left():TitleStack({
    Title = "Kill At Health %",
})
spawn(function()
    while task.wait() do
        pcall(function()
            K_A.Title = "Kill At Health " .. "( " .. tostring(Config["Kill At"]) .. " %" .. " )"
        end)
    end
end)
row:Right():Slider({
    Minimum = 1,
    Maximum = 100,
    Value = Config["Kill At"] or 25,
    ValueChanged = function(self, value)
    local num = tonumber(value)
        if num then
            num = math.floor(num)
            Config["Kill At"] = num
            getgenv()['Update_Setting'](getgenv()['MyName'])
        end
    end,
})
row = titledRow(form, "Auto Farm Mastery Fruit","Automatically farm Mastery Fruit")
row:Right():Toggle({
    Value = Config["Auto Farm Mastery Fruit"] or false,
    ValueChanged = function(self, value)
        Config["Auto Farm Mastery Fruit"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Farm Mastery Fruit"])
    end,
})
row = titledRow(form, "Auto Farm Mastery Gun","Automatically farm Mastery Gun")
row:Right():Toggle({
    Value = Config["Auto Farm Mastery Gun"] or false,
    ValueChanged = function(self, value)
        Config["Auto Farm Mastery Gun"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Farm Mastery Gun"])
    end,
})
form = Tabs.Main:PageSection({ Title = "Chest" }):Form()
row = titledRow(form, "Auto Farm Chest [ Tweem ]","Automatically farm chests [Tweem]")
row:Right():Toggle({
    Value = Config["Auto Farm Chest [ Tweem ]"] or false,
    ValueChanged = function(self, value)
        Config["Auto Farm Chest [ Tweem ]"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Farm Chest [ Tweem ]"])
    end,
})
row = titledRow(form, "Auto Farm Chest [ TP ] ( Risk )","Automatically farm chests [TP]")
row:Right():Toggle({
    Value = Config["Auto Farm Chest [ TP ] ( Risk )"] or false,
    ValueChanged = function(self, value)
        Config["Auto Farm Chest [ TP ] ( Risk )"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Farm Chest [ TP ] ( Risk )"])
    end,
})
form = Tabs.Main:PageSection({ Title = "Ectoplasm" }):Form()
row = titledRow(form, "Auto Farm Ectoplasm","Automatically farms Ectoplasm")
row:Right():Toggle({
    Value = Config["Auto Farm Ectoplasm"] or false,
    ValueChanged = function(self, value)
        Config["Auto Farm Ectoplasm"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Farm Ectoplasm"])
    end,
})
form = Tabs.Main:PageSection({ Title = "Tyrant of the Skies" }):Form()
row = titledRow(form, "Auto Tyrant of the Skies","Automatically farms or fights the Tyrant of the Skies boss")
row:Right():Toggle({
    Value = Config["Auto Tyrant of the Skies"] or false,
    ValueChanged = function(self, value)
        Config["Auto Tyrant of the Skies"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Tyrant of the Skies"])
    end,
})
form = Tabs.Main:PageSection({ Title = "Factory" }):Form()
row = titledRow(form, "Auto Factory","Automatically raids the Factory")
row:Right():Toggle({
    Value = Config["Auto Factory"] or false,
    ValueChanged = function(self, value)
        Config["Auto Factory"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Factory"])
    end,
})
form = Tabs.Main:PageSection({ Title = "Castle Pirate Raid" }):Form()
row = titledRow(form, "Auto Castle Pirate Raid","Automatically fights the Castle Pirate Raid")
row:Right():Toggle({
    Value = Config["Auto Castle Pirate Raid"] or false,
    ValueChanged = function(self, value)
        Config["Auto Castle Pirate Raid"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Castle Pirate Raid"])
    end,
})
form = Tabs.Main:PageSection({ Title = "Bone" }):Form()
local row = form:Row({
    SearchIndex = "lnfomation",
})
local BT_D = row:Left():TitleStack({
    Title = "lnfomation",
    Subtitle = ""
})
spawn(function()
    while task.wait() do
        pcall(function()
            if L_7449423635_ then
                BT_D.Subtitle = "You Have : " .. tostring(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones", "Check") .. " Bones")
            else
                BT_D.Subtitle = "You Don't Have Bone"
            end
        end)
    end
end)
row = titledRow(form, "Auto Farm Bone","Automatically farms Bones")
row:Right():Toggle({
    Value = Config["Auto Farm Bone"] or false,
    ValueChanged = function(self, value)
        Config["Auto Farm Bone"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Farm Bone"])
    end,
})
row = titledRow(form, "Enabled Random Bone Surprise","Use Bones to trade for rewards")
row:Right():Toggle({
    Value = Config["Enabled Random Bone Surprise"] or false,
    ValueChanged = function(self, value)
        Config["Enabled Random Bone Surprise"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Enabled Random Bone Surprise"])
    end,
})
form = Tabs.Main:PageSection({ Title = "Cake Prince" }):Form()
local row = form:Row({
    SearchIndex = "lnfomation",
})
local BT_D = row:Left():TitleStack({
    Title = "lnfomation",
    Subtitle = ""
})
spawn(function()
    while task.wait() do
        pcall(function()
            if string.len(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == (88) then
                BT_D.Subtitle = ("Defeat : " ..
                    string.sub(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner"),
                        39,
                        41))
            elseif string.len(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == (87) then
                BT_D.Subtitle = ("Defeat : " ..
                    string.sub(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner"),
                        39,
                        40))
            elseif string.len(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == (86) then
                BT_D.Subtitle = ("Defeat : " ..
                    string.sub(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner"),
                        39,
                        39))
            else
                BT_D.Subtitle = ("Boss Is Spawning")
            end
            if L_2753915549_ or L_4442272183_ then
                BT_D.Subtitle = ("Defeat : N/A")
            end
        end)
    end
end)
row = titledRow(form, "Auto Farm Cake Prince","Automatically farms or fights the Cake Prince boss")
row:Right():Toggle({
    Value = Config["Auto Farm Cake Prince"] or false,
    ValueChanged = function(self, value)
        Config["Auto Farm Cake Prince"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Farm Cake Prince"])
    end,
})
row = titledRow(form, "Enabled Spawn Cake Prince","Allows the Cake Prince boss to spawn when enabled")
row:Right():Toggle({
    Value = Config["Enabled Spawn Cake Prince"] or false,
    ValueChanged = function(self, value)
        Config["Enabled Spawn Cake Prince"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Enabled Spawn Cake Prince"])
    end,
})
form = Tabs.Main:PageSection({ Title = "Sea Beasts" }):Form()
row = titledRow(form, "Auto Farm Sea Beasts","Automatically hunts or farms Sea Beasts")
row:Right():Toggle({
    Value = Config["Auto Farm Sea Beasts"] or false,
    ValueChanged = function(self, value)
        Config["Auto Farm Sea Beasts"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Farm Sea Beasts"])
        if not Value then
            StopBoatsTween()
        else
            _G.StopTweenBoat = false
        end
    end,
})
form = Tabs.Main:PageSection({ Title = "Evo" }):Form()
row = titledRow(form, "Auto Evo Race V2","Automatically completes the quest to evolve your Race to V2")
row:Right():Toggle({
    Value = Config["Auto Evo Race V2"] or false,
    ValueChanged = function(self, value)
        Config["Auto Evo Race V2"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Evo Race V2"])
    end,
})
form = form:PageSection({ Title = "Observations" }):Form()
local row = form:Row({
    SearchIndex = "Observations",
})
local BT_D = row:Left():TitleStack({
    Title = "Observations",
    Subtitle = ""
})
spawn(function()
    while task.wait() do
        BT_D.Subtitle = ("Observation Exp : " .. game:GetService("Players").LocalPlayer.VisionRadius.Value)
    end
end)
row = titledRow(form, "Auto Farm Observation Exp","Automatically farms Observation Haki experience")
row:Right():Toggle({
    Value = Config["Auto Farm Observation Exp"] or false,
    ValueChanged = function(self, value)
        Config["Auto Farm Observation Exp"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Farm Observation Exp"])
    end,
})
row = titledRow(form, "Auto Farm Observation Exp Hop","Automatically farms Observation Haki Exp by server hopping")
row:Right():Toggle({
    Value = Config["Auto Farm Observation Exp Hop"] or false,
    ValueChanged = function(self, value)
        Config["Auto Farm Observation Exp Hop"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Farm Observation Exp Hop"])
    end,
})
form = Tabs.Sub_Farming:PageSection({ Title = "Automatic" })
form = Tabs.Sub_Farming:Form()
if L_2753915549_ then
form = Tabs.Sub_Farming:PageSection({ Title = "Saber" }):Form()
row = titledRow(form, "Auto Saber","Automatically completes the quest and defeats the boss required to obtain the Saber sword.")
row:Right():Toggle({
    Value = Config["Auto Saber"] or false,
    ValueChanged = function(self, value)
        Config["Auto Saber"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Saber"])
    end,
})
form = Tabs.Sub_Farming:PageSection({ Title = "Pole" }):Form()
row = titledRow(form, "Auto Pole v1","Automatically hunts the boss Enel (Thunder God) until the Pole v1 weapon drops.")
row:Right():Toggle({
    Value = Config["Auto Pole v1"] or false,
    ValueChanged = function(self, value)
        Config["Auto Pole v1"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Pole v1"])
    end,
})
row = titledRow(form, "Auto Pole v1 Hop","Automatically hunts the boss Enel, and if the boss or drop isn’t found, it will server-hop to increase the chance of getting Pole v1 faster.")
row:Right():Toggle({
    Value = Config["Auto Pole v1 Hop"] or false,
    ValueChanged = function(self, value)
        Config["Auto Pole v1 Hop"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        if value then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",
            Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047))
        end
    end,
})
form = Tabs.Sub_Farming:PageSection({ Title = "Bisento V2" }):Form()
row = titledRow(form, "Auto Bisento V2","Automatically hunts the boss or completes the requirements to obtain the Bisento V2 weapon on the current server.")
row:Right():Toggle({
    Value = Config["Auto Bisento V2"] or false,
    ValueChanged = function(self, value)
        Config["Auto Bisento V2"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Bisento v2"])
    end,
})
row = titledRow(form, "Auto Bisento V2 Hop","Automatically farms the boss or requirements, and if Bisento V2 hasn’t dropped, it will server-hop to increase the chance of obtaining it faster.")
row:Right():Toggle({
    Value = Config["Auto Bisento V2 Hop"] or false,
    ValueChanged = function(self, value)
        Config["Auto Bisento V2 Hop"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end,
})
elseif L_4442272183_ then
form = Tabs.Sub_Farming:PageSection({ Title = "Swan Glasses" }):Form()
row = titledRow(form, "Auto Swan Glasses","Automatically hunts the boss Don Swan until the Swan Glasses accessory drops.")
row:Right():Toggle({
    Value = Config["Auto Swan Glasses"] or false,
    ValueChanged = function(self, value)
        Config["Auto Swan Glasses"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Swan Glasses"])
    end,
})
form = Tabs.Sub_Farming:PageSection({ Title = "Bartilo" }):Form()
row = titledRow(form, "Auto Bartilo Quest","Automatically completes all the quests from NPC Bartilo, from start to finish, without requiring manual effort.")
row:Right():Toggle({
    Value = Config["Auto Bartilo Quest"] or false,
    ValueChanged = function(self, value)
        Config["Auto Bartilo Quest"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Bartilo Quest"])
    end,
})
form = Tabs.Sub_Farming:PageSection({ Title = "Lengedary Sword" }):Form()
local row = form:Row({
    SearchIndex = "lnfomation",
})
local BT_D = row:Left():TitleStack({
    Title = "lnfomation"
})
spawn(function()
    pcall(function()
        while wait() do
            if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer", "1") then
                BT_D.Subtitle = ("Sword Spawn : Shisui 🟢")
            elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer","2") then
                BT_D.Subtitle = ("Sword Spawn : Wando 🟢")
            elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer","3") then
                BT_D.Subtitle = ("Sword Spawn : Saddi 🟢")
            else
                BT_D.Subtitle = ("Not Found Lengedary Sword 🔴")
            end
        end
    end)
end)
row = titledRow(form, "Auto Buy Lengedary Sword","Automatically purchases the Legendary Sword for you as soon as it becomes available.")
row:Right():Toggle({
    Value = Config["Auto Buy Lengedary Sword"] or false,
    ValueChanged = function(self, value)
        Config["Auto Buy Lengedary Sword"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end,
})
row = titledRow(form, "Auto Buy Lengedary Sword Hop","Automatically purchases the Legendary Sword, and if it’s not available, it will server-hop to increase the chance of buying it faster.")
row:Right():Toggle({
    Value = Config["Auto Buy Lengedary Sword Hop"] or false,
    ValueChanged = function(self, value)
        Config["Auto Buy Lengedary Sword Hop"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end,
})
form = Tabs.Sub_Farming:PageSection({ Title = "Order - Law" }):Form()
row = titledRow(form, "Auto Farm Order Boss","Automatically fights and farms the Order (Law) boss")
row:Right():Toggle({
    Value = Config["Auto Farm Order Boss"] or false,
    ValueChanged = function(self, value)
        Config["Auto Farm Order Boss"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Farm Order Boss"])
    end,
})
row = titledRow(form, "Enabled Buy Raid Chip","When enabled, the system will automatically purchase a Raid Chip required to start a Raid.")
row:Right():Toggle({
    Value = Config["Enabled Buy Raid Chip"] or false,
    ValueChanged = function(self, value)
        Config["Enabled Buy Raid Chip"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Enabled Buy Raid Chip"])
    end,
})
row:Right():Button({
    Label = "Buy Raid Chip",
    State = "Primary",
    Pushed = function(self)
        local args = {
            [1] = "BlackbeardReward",
            [2] = "Microchip",
            [3] = "2"
         }
         game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end,
})
row = titledRow(form, "Enabled Start Raid","When enabled, the system will automatically start a Raid once a Raid Chip is available.")
row:Right():Toggle({
    Value = Config["Enabled Start Raid"] or false,
    ValueChanged = function(self, value)
        Config["Enabled Start Raid"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Enabled Start Raid"])
    end,
})
row:Right():Button({
    Label = "Start Raid",
    State = "Primary",
    Pushed = function(self)
        fireclickdetector(game:GetService("Workspace").Map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
    end,
})
else
form = Tabs.Sub_Farming:PageSection({ Title = "Elite Hunter" }):Form()
local row = form:Row({
    SearchIndex = "Elite Hunter : Waiting for spawn",
})
local BT_D = row:Left():TitleStack({
    Title = "Elite Hunter : Waiting for spawn",
})
spawn(function()
    while task.wait() do
        pcall(function()
            if game:GetService("ReplicatedStorage"):FindFirstChild("Diablo") or game:GetService("ReplicatedStorage"):FindFirstChild("Deandre") or game:GetService("ReplicatedStorage"):FindFirstChild("Urban") or workspace.Enemies:FindFirstChild("Diablo") or workspace.Enemies:FindFirstChild("Deandre") or workspace.Enemies:FindFirstChild("Urban") then
                BT_D.Title = ("Status : spawn 🟢")
            else
                BT_D.Title = ("Status : Not spawn 🔴")
            end
        end)
    end
end)
local row = form:Row({
    SearchIndex = "Already Kill",
})
local BT_D = row:Left():TitleStack({
    Title = "Already Kill"
})
spawn(function()
    while task.wait() do
        if L_4442272183_ then
        BT_D.Subtitle = ("Already Kill Elite Hunter : " ..
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter", "Progress"))
        else
            BT_D.Subtitle = ("Already Kill Elite Hunter : " .. "None")
        end
    end
end)
row = titledRow(form, "Auto Farm Elite Hunter","Automatically hunts Elite Hunters")
row:Right():Toggle({
    Value = Config["Auto Farm Elite Hunter"] or false,
    ValueChanged = function(self, value)
        Config["Auto Farm Elite Hunter"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Farm Elite Hunter"])
    end,
})
form = Tabs.Sub_Farming:PageSection({ Title = "Cursed Dual Katana" }):Form()
row = titledRow(form, "Auto Get Cursed Dual Katana","Automatically completes the questline, defeats the required boss, and grants you the Cursed Dual Katana upon success.")
row:Right():Toggle({
    Value = Config["Auto Get Cursed Dual Katana"] or false,
    ValueChanged = function(self, value)
        Config["Auto Get Cursed Dual Katana"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Get Cursed Dual Katana"])
    end,
})
row = titledRow(form, "Auto Quest Yama","If you already own the Yama sword, this will automatically complete its quest, required to unlock the Cursed Dual Katana.")
row:Right():Toggle({
    Value = Config["Auto Quest Yama"] or false,
    ValueChanged = function(self, value)
        Config["Auto Quest Yama"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Quest Yama"])
    end,
})
row = titledRow(form, "Auto Quest Tushita","If you already own the Tushita sword, this will automatically complete its quest, required to unlock the Cursed Dual Katana.")
row:Right():Toggle({
    Value = Config["Auto Quest Tushita"] or false,
    ValueChanged = function(self, value)
        Config["Auto Quest Tushita"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Quest Tushita"])
    end,
})
form = Tabs.Sub_Farming:PageSection({ Title = "Hallow Sycthe" }):Form()
row = titledRow(form, "Auto Hallow Sycthe","Automatically farms the boss and requirements needed to obtain the Hallow Scythe sword.")
row:Right():Toggle({
    Value = Config["Auto Hallow Sycthe"] or false,
    ValueChanged = function(self, value)
        Config["Auto Hallow Sycthe"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Hallow Sycthe"])
    end,
})
form = Tabs.Sub_Farming:PageSection({ Title = "Budy Sword" }):Form()
row = titledRow(form, "Auto Budy Sword","Automatically fights the boss that drops the Buddy Sword until the sword is obtained.")
row:Right():Toggle({
    Value = Config["Auto Budy Sword"] or false,
    ValueChanged = function(self, value)
        Config["Auto Budy Sword"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Budy Sword"])
    end,
})
row = titledRow(form, "Auto Budy Sword Hop","Automatically fights the boss that drops the Buddy Sword, and if the boss is not available, it will server-hop to find another boss.")
row:Right():Toggle({
    Value = Config["Auto Budy Sword Hop"] or false,
    ValueChanged = function(self, value)
        Config["Auto Budy Sword Hop"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end,
})
form = Tabs.Sub_Farming:PageSection({ Title = "Canvander" }):Form()
row = titledRow(form, "Auto Canvander","Automatically fights the boss that drops the Canvander until the sword is obtained.")
row:Right():Toggle({
    Value = Config["Auto Canvander"] or false,
    ValueChanged = function(self, value)
        Config["Auto Canvander"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Canvander"])
    end,
})
row = titledRow(form, "Auto Canvander Hop","Automatically fights the boss that drops the Canvander. If the boss is not available, it will server-hop to find another boss and increase the chance of obtaining the sword faster.")
row:Right():Toggle({
    Value = Config["Auto Canvander Hop"] or false,
    ValueChanged = function(self, value)
        Config["Auto Canvander Hop"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end,
})
form = Tabs.Sub_Farming:PageSection({ Title = "Yama" }):Form()
row = titledRow(form, "Auto Yama","Automatically completes all the required quests and steps to obtain the Yama sword without manual effort.")
row:Right():Toggle({
    Value = Config["Auto Yama"] or false,
    ValueChanged = function(self, value)
        Config["Auto Yama"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Yama"])
    end,
})
form = Tabs.Sub_Farming:PageSection({ Title = "Tushita" }):Form()
row = titledRow(form, "Auto Tushita","Automatically completes all required quests and steps to obtain the Tushita sword without manual effort.")
row:Right():Toggle({
    Value = Config["Auto Tushita"] or false,
    ValueChanged = function(self, value)
        Config["Auto Tushita"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Tushita"])
    end,
})
row = titledRow(form, "Auto Holy Torch")
row:Right():Toggle({
    Value = Config["Auto Holy Torch"] or false,
    ValueChanged = function(self, value)
        Config["Auto Holy Torch"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Holy Torch"])
    end,
})
form = Tabs.Sub_Farming:PageSection({ Title = "Twin Hooks" }):Form()
row = titledRow(form, "Auto Twin Hooks","Automatically fights the boss that drops the Twin Hooks until the weapon is obtained.")
row:Right():Toggle({
    Value = Config["Auto Twin Hooks"] or false,
    ValueChanged = function(self, value)
        Config["Auto Twin Hooks"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Twin Hooks"])
    end,
})
row = titledRow(form, "Auto Twin Hooks Hop","Automatically fights the boss that drops the Twin Hooks. If the boss is not available, it will server-hop to find another boss and increase the chance of obtaining the weapon faster.")
row:Right():Toggle({
    Value = Config["Auto Twin Hooks Hop"] or false,
    ValueChanged = function(self, value)
        Config["Auto Twin Hooks Hop"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end,
})
form = Tabs.Sub_Farming:PageSection({ Title = "Soul Guitar" }):Form()
row = titledRow(form, "Auto Soul Guitar","Automatically completes all the required quests and steps to obtain the Soul Guitar without manual effort.")
row:Right():Toggle({
    Value = Config["Auto Soul Guitar"] or false,
    ValueChanged = function(self, value)
        Config["Auto Soul Guitar"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Soul Guitar"])
    end,
})
form = Tabs.Sub_Farming:PageSection({ Title = "Observations V2" }):Form()
row = titledRow(form, "Auto Farm Observation V2","Automatically farms Observation Haki V2 experience")
row:Right():Toggle({
    Value = Config["Auto Farm Observation V2"] or false,
    ValueChanged = function(self, value)
        Config["Auto Farm Observation V2"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Farm Observation V2"])
    end,
})
form = Tabs.Sub_Farming:PageSection({ Title = "Musketeer Hat" }):Form()
row = titledRow(form, "Auto Musketeer Hat","This feature automatically completes the quest to unlock and obtain the Musketeer Hat, so you don’t have to do it manually.")
row:Right():Toggle({
    Value = Config["Auto Musketeer Hat"] or false,
    ValueChanged = function(self, value)
        Config["Auto Musketeer Hat"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Musketeer Hat"])
    end,
})
form = Tabs.Sub_Farming:PageSection({ Title = "Rainbow Haki" }):Form()
row = titledRow(form, "Auto Rainbow Haki","This feature automatically completes all the required quests to unlock Rainbow Haki, so you don’t need to do each step manually, such as fighting NPCs or finishing side missions.")
row:Right():Toggle({
    Value = Config["Auto Rainbow Haki"] or false,
    ValueChanged = function(self, value)
        Config["Auto Rainbow Haki"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Rainbow Haki"])
    end,
})
end
form = Tabs.Misc_Farming:PageSection({ Title = "Fighting Styles" }):Form()
row = titledRow(form, "Auto Superhuman","This feature automatically unlocks the Superhuman Fighting Style. The system will purchase it from the NPC once all requirements are met, such as having 300+ mastery in the four basic fighting styles (Black Leg, Electro, Fishman Karate, and Dragon Claw")
row:Right():Toggle({
    Value = Config["Auto Superhuman"] or false,
    ValueChanged = function(self, value)
        Config["Auto Superhuman"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Superhuman"])
    end,
})
row = titledRow(form, "Auto Death Step","This feature automatically unlocks the Death Step Fighting Style. The system handles the required steps for you, such as purchasing it from the NPC Phoeyu the Reformed in the Second Sea, provided you meet the requirements (Black Leg with 400+ mastery, enough money, and fragments).")
row:Right():Toggle({
    Value = Config["Auto Death Step"] or false,
    ValueChanged = function(self, value)
        Config["Auto Death Step"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Death Step"])
    end,
})
row = titledRow(form, "Auto Sharkman Karate","This feature automatically unlocks the Sharkman Karate Fighting Style. The system will handle the required quest and purchase it from the NPC once you meet all conditions, such as completing Daigrock the Sharkman’s quest, having 400+ mastery in Fishman Karate, enough money, and fragments.")
row:Right():Toggle({
    Value = Config["Auto Sharkman Karate"] or false,
    ValueChanged = function(self, value)
        Config["Auto Sharkman Karate"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Sharkman Karate"])
    end,
})
row = titledRow(form, "Auto Electric Claw","This feature automatically unlocks the Electric Claw Fighting Style. The system purchases it from the NPC once all requirements are met, such as having 400+ mastery in the Electric base style, enough money, and fragments.")
row:Right():Toggle({
    Value = Config["Auto Electric Claw"] or false,
    ValueChanged = function(self, value)
        Config["Auto Electric Claw"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Electric Claw"])
    end,
})
row = titledRow(form, "Auto Dragon Talon","This feature automatically unlocks the Dragon Talon Fighting Style. The system purchases it from the NPC once all requirements are met, such as having 400+ mastery in the Dragon Claw base style, enough money, and fragments.")
row:Right():Toggle({
    Value = Config["Auto Dragon Talon"] or false,
    ValueChanged = function(self, value)
        Config["Auto Dragon Talon"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Dragon Talon"])
    end,
})
row = titledRow(form, "Auto Godhuman","This feature automatically unlocks the Godhuman Fighting Style. The system purchases it from the NPC once all requirements are met, such as having 400+ mastery in the Superhuman base style, enough money, and fragments.")
row:Right():Toggle({
    Value = Config["Auto Godhuman"] or false,
    ValueChanged = function(self, value)
        Config["Auto Godhuman"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Godhuman"])
    end,
})
row = titledRow(form, "Auto Godhuman Full","This feature automatically obtains the Godhuman Fighting Style at full mastery. It handles all steps, from checking requirements, purchasing the skill, to upgrading the Superhuman mastery to the maximum, without manual effort.")
row:Right():Toggle({
    Value = Config["Auto Godhuman Full"] or false,
    ValueChanged = function(self, value)
        Config["Auto Godhuman Full"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Godhuman Full"])
    end,
})
local materialsdd = {
    "Leather";
    "Scrap Meta";
    "Fiah Tail";
    "Magma Ore";
    "Angel Wings";
    "Radioactive Materials";
    "Demonic Wips";
    "Vampire Fang";
    "Mini Tusk";
    "Gunpowder";
}
form = Tabs.Misc_Farming:PageSection({ Title = "Materials" }):Form()
row = titledRow(form, "Select Materials","Choose which materials to farm")
row:Right():PullDownButton({
    Options = materialsdd,
    Label = "N/A",
    Multi = false,
    Selected = "Select Materials",
    ValueLabel = 2,
    Value = (function()
        for i, v in ipairs(materialsdd) do
            if v == Config["Select Materials"] then
                return i
            end
        end
        return 1
    end)(),
    ValueChanged = function(self, value)
        local names = self.Selected
        if self.Multi then
            if self.ValueLabel == 1 then
                _G["selected" .. names] = {}
                for _, i in ipairs(value) do
                    table.insert(_G["selected" .. names], self.Options[i])
                end
                if #_G["selected" .. names] == 0 then
                    self.Label = "N/A"
                elseif #_G["selected" .. names] == 1 then
                    self.Label = _G["selected" .. names][1]
                else
                    self.Label = _G["selected" .. names][1] .. ", ..."
                end
            else
                _G["selected" .. names] = {}
                for _, i in ipairs(value) do
                    table.insert(_G["selected" .. names], self.Options[i])
                end
                if #_G["selected" .. names] == 0 then
                    self.Label = "N/A"
                else
                    self.Label = table.concat(_G["selected" .. names], ", ")
                end
            end
        else
            self.Label = self.Options[value] or "N/A"
        end
        Config["Select Materials"] = self.Options[value]
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end,
})
row = titledRow(form, "Auto Farm Materials","Automatically farms the selected materials without manual control, useful for collecting large quantities for crafting or item upgrades")
row:Right():Toggle({
    Value = Config["Auto Farm Materials"] or false,
    ValueChanged = function(self, value)
        Config["Auto Farm Materials"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Farm Materials"])
    end,
})
form = Tabs.MirageandRace:PageSection({ Title = "Mirage Island" }):Form()
local row = form:Row({
    SearchIndex = "Already Kill",
})
local BT_D = row:Left():TitleStack({
    Title = "Mirage Island Spawned: "
})
spawn(function()
    while wait() do
        pcall(function()
            if game.Workspace._WorldOrigin.Locations:FindFirstChild('Mirage Island') then
                BT_D.Title = ("Mirage Island Spawned: 🟢")
            else
                BT_D.Title = ("Mirage Island Spawned: 🔴")
            end
        end)
    end
end)
row = titledRow(form, "Auto Find Mirage Island","Automatically finds the location of Mirage Island without manual searching")
row:Right():Toggle({
    Value = Config["Auto Find Mirage Island"] or false,
    ValueChanged = function(self, value)
        Config["Auto Find Mirage Island"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Find Mirage Island"])
        if not value then
            StopBoatsTween()
        else
            _G.StopTweenBoat = false
        end
    end,
})
row = titledRow(form, "Teleport to Mirage Island","Teleports you directly to Mirage Island, works together with the finding feature for fast access")
row:Right():Toggle({
    Value = Config["Teleport to Mirage Island"] or false,
    ValueChanged = function(self, value)
        Config["Teleport to Mirage Island"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Teleport to Mirage Island"])
    end,
})
row = titledRow(form, "Auto Find Advanced Fruit Dealer","Automatically locates the Advanced Fruit Dealer NPC without manual searching, useful for quickly buying fruits or items")
row:Right():Toggle({
    Value = Config["Auto Find Advanced Fruit Dealer"] or false,
    ValueChanged = function(self, value)
        Config["Auto Find Advanced Fruit Dealer"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Find Advanced Fruit Dealer"])
    end,
})
row = titledRow(form, "Auto Find Gear","Automatically finds the Gear location in the game without manual searching, useful for quickly collecting Gear for farming or combat")
row:Right():Toggle({
    Value = Config["Auto Find Gear"] or false,
    ValueChanged = function(self, value)
        Config["Auto Find Gear"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Find Gear"])
    end,
})
row = titledRow(form, "Auto Lock Camera to Moon","Automatically locks the game camera to the Moon, useful for continuously tracking it without manually adjusting the camera")
row:Right():Toggle({
    Value = Config["Auto Lock Camera to Moon"] or false,
    ValueChanged = function(self, value)
        Config["Auto Lock Camera to Moon"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Lock Camera to Moon"])
    end,
})
form = Tabs.MirageandRace:PageSection({ Title = "Misc" }):Form()
row = titledRow(form, "Remove Rocks")
row:Right():Button({
    Label = "Click here!",
    State = "Primary",
    Pushed = function(self)
        RemoveRocks("Rocks")
    end,
})
form = Tabs.MirageandRace:PageSection({ Title = "Race V4" }):Form()
local row = form:Row({
    SearchIndex = "Already Kill",
})
local BT_D = row:Left():TitleStack({
    Title = "Full Moon : "
})
spawn(function()
    while wait() do
        if game:GetService("Lighting").Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709149431" then
            BT_D.Title = ("Full Moon : 100%")
        elseif game:GetService("Lighting").Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709149052" then
            BT_D.Title = ("Full Moon : 75%")
        elseif game:GetService("Lighting").Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709143733" then
            BT_D.Title = ("Full Moon : 50%")
        elseif game:GetService("Lighting").Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709150401" then
            BT_D.Title = ("Full Moon : 25%")
        elseif game:GetService("Lighting").Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709149680" then
            BT_D.Title = ("Full Moon : 15%")
        else
            BT_D.Title = ("Full Moon : 0%")
        end
    end
end)
spawn(function()
    while wait() do
        if L_2753915549_ or L_4442272183_ then
            Checkmoon:SetTitle("Full Moon : 0%")
        end
    end
end)
row = titledRow(form, "Auto Complete Trail")
row:Right():Toggle({
    Value = Config["Auto Complete Trail"] or false,
    ValueChanged = function(self, value)
        Config["Auto Complete Trail"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Complete Trail"])
    end,
})
row = titledRow(form, "Teleport to Race Door")
row:Right():Toggle({
    Value = Config["Teleport to Race Door"] or false,
    ValueChanged = function(self, value)
        Config["Teleport to Race Door"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Teleport to Race Door"])
    end,
})
row = titledRow(form, "Teleport To Top Of Great Tree")
row:Right():Button({
    Label = "Click here!",
    State = "Primary",
    Pushed = function(self)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",
        Vector3.new(28286.35546875, 14895.3017578125, 102.62469482421875))
        wait()
        TP(CFrame.new(28606.3496, 14896.7402, 106.031876, 0.0915592983, 6.7893291e-09, -0.995799601, -1.50961377e-08, 1, 5.42994494e-09, 0.995799601, 1.45355656e-08, 0.0915592983))
        wait(1.5)
        PosGt = CFrame.new(28606.3496, 14896.7402, 106.031876, 0.0915592983, 6.7893291e-09, -0.995799601, -1.50961377e-08, 1, 5.42994494e-09, 0.995799601, 1.45355656e-08, 0.0915592983)
        if (PosGt.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 20 then
        local args = {
            [1] = "RaceV4Progress",
            [2] = "TeleportBack"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
    end
    end,
})
row = titledRow(form, "Teleport To Race Door")
row:Right():Button({
    Label = "Click here!",
    State = "Primary",
    Pushed = function(self)
        Posrd = CFrame.new(28286.35546875, 14895.3017578125, 102.62469482421875)
        if (Posrd.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1500 then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",
            Vector3.new(28286.35546875, 14895.3017578125, 102.62469482421875))
        end
        if game:GetService("Players").LocalPlayer.Data.Race.Value == "Human" then
            TP(game.workspace.Map["Temple of Time"].HumanCorridor.Door.Entrance.CFrame * CFrame.new(0,0,2))
        elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Mink" then
            TP(game.workspace.Map["Temple of Time"].MinkCorridor.Door.Entrance.CFrame * CFrame.new(0,0,2))
        elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Fishman" then
            TP(game.workspace.Map["Temple of Time"].FishmanCorridor.Door.Entrance.CFrame * CFrame.new(0,0,2))
        elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Cyborg" then
            TP(game.workspace.Map["Temple of Time"].CyborgCorridor.Door.Entrance.CFrame * CFrame.new(0,0,2))
        elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Skypiea" then
            TP(game.workspace.Map["Temple of Time"].SkypieaCorridor.Door.Entrance.CFrame * CFrame.new(0,0,2))
        elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Ghoul" then
            TP(game.workspace.Map["Temple of Time"].GhoulCorridor.Door.Entrance.CFrame * CFrame.new(0,0,2))
        end
    end,
})
row = titledRow(form, "Teleport To Acient One")
row:Right():Button({
    Label = "Click here!",
    State = "Primary",
    Pushed = function(self)
        Posrd = CFrame.new(28286.35546875, 14895.3017578125, 102.62469482421875)
        if (Posrd.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1500 then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",
            Vector3.new(28286.35546875, 14895.3017578125, 102.62469482421875))
            wait()
            TP(CFrame.new(28976.4473, 14889.8643, -117.574387, 0.551705182, 4.59173677e-08, 0.834039211, 6.1822341e-08, 1, -9.59488133e-08, -0.834039211, 1.04497715e-07, 0.551705182))
        end
    end,
})
row = titledRow(form, "Teleport To Temple Of Time")
row:Right():Button({
    Label = "Click here!",
    State = "Primary",
    Pushed = function(self)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",
                        Vector3.new(28286.35546875, 14895.3017578125, 102.62469482421875))
    end,
})
row = titledRow(form, "Teleport To Lever Pull")
row:Right():Button({
    Label = "Click here!",
    State = "Primary",
    Pushed = function(self)
        Posrd = CFrame.new(28286.35546875, 14895.3017578125, 102.62469482421875)
        if (Posrd.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1500 then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",
            Vector3.new(28286.35546875, 14895.3017578125, 102.62469482421875))
        end
        wait()
        TP(CFrame.new(28575.4512, 14938.0664, 72.468811, -0.999988019, -1.0370087e-07, -0.00488974992, -1.03699634e-07, 1, -5.07071718e-10, 0.00488974992, -3.83642954e-16, -0.999988019))
    end,
})
row = titledRow(form, "Unlock Lever")
row:Right():Button({
    Label = "Click here!",
    State = "Primary",
    Pushed = function(self)
        if game:GetService("Workspace").Map["Temple of Time"].Lever.Prompt:FindFirstChild("ProximityPrompt") then
            game:GetService("Workspace").Map["Temple of Time"].Lever.Prompt:FindFirstChild("ProximityPrompt"):Remove()
        else
        end
        wait(0.1)
        local ProximityPrompt = Instance.new("ProximityPrompt")
        ProximityPrompt.Parent = game:GetService("Workspace").Map["Temple of Time"].Lever.Prompt
        ProximityPrompt.MaxActivationDistance = 10
        ProximityPrompt.ActionText = "Secrets Beholds Inside"
        ProximityPrompt.ObjectText = "An unknown lever of time"
        function onProximity()
            local part = game:GetService("Workspace").Map["Temple of Time"].MainDoor1
            local TweenService = game:GetService("TweenService")
            local startPosition = part.Position
            local endPosition = startPosition + Vector3.new(0, -50, 0)
            local tweenInfo = TweenInfo.new(10, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
            local tween = TweenService:Create(part, tweenInfo, {Position = endPosition})
            tween:Play()
            local partnew = game:GetService("Workspace").Map["Temple of Time"].MainDoor2
            local TweenService = game:GetService("TweenService")
            local startPosition = partnew.Position
            local endPosition = startPosition + Vector3.new(0, -50, 0)
            local tweenInfo = TweenInfo.new(10, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
            local tween = TweenService:Create(partnew, tweenInfo, {Position = endPosition})
            tween:Play()
            local SoundSFX = Instance.new("Sound")
            SoundSFX.Parent = workspace
            SoundSFX.SoundId = "rbxassetid://1904813041"
            SoundSFX:Play()
            SoundSFX.Name = "POwfpxzxzfFfFF"
            game:GetService("Workspace").Map["Temple of Time"].Lever.Prompt:FindFirstChild("ProximityPrompt"):Remove()
            wait(5)
            workspace:FindFirstChild("POwfpxzxzfFfFF"):Remove()
            game:GetService("Workspace").Map["Temple of Time"].NoGlitching:Remove()
            game:GetService("Workspace").Map["Temple of Time"].NoGlitching:Remove()
            game:GetService("Workspace").Map["Temple of Time"].NoGlitching:Remove()
        end
        ProximityPrompt.Triggered:Connect(onProximity)
    end,
})
form = Tabs.Events:PageSection({ Title = "Celebration" }):Form()
row = titledRow(form, "Auto Farm Agony")
row:Right():Toggle({
    Value = Config["Auto Farm Agony"] or false,
    ValueChanged = function(self, value)
        Config["Auto Farm Agony"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Farm Agony"])
    end,
})
row = titledRow(form, "Auto Farm Ashen")
row:Right():Toggle({
    Value = Config["Auto Farm Ashen"] or false,
    ValueChanged = function(self, value)
        Config["Auto Farm Ashen"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Farm Ashen"])
    end,
})
row = titledRow(form, "Auto Farm Lightning Bandit")
row:Right():Toggle({
    Value = Config["Auto Farm Lightning Bandit"] or false,
    ValueChanged = function(self, value)
        Config["Auto Farm Lightning Bandit"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Farm Lightning Bandit"])
    end,
})
row = titledRow(form, "Teleport to Normal World")
row:Right():Button({
    Label = "Click here!",
    State = "Primary",
    Pushed = function(self)
        local args = {
            "CelebrationTeleport"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/CelebrationTeleport"):InvokeServer(unpack(args))
    end,
})
local ZoneSeaEvents = {
    "Sea 1 [Low]",
    "Sea 2 [Medium]",
    "Sea 3 [High]",
    "Sea 4 [Extreme]",
    "Sea 5 [Crazy]",
    "Sea 6 [???]",
    "Beyond the Sea"
}
local waypoints = {
    ["Sea 1 [Low]"] = CFrame.new(-11887.5742, -0.306667894, 16193.2705, -0.9691163899999538, 1.139396772487089E-7,
        -0.246603817, 1.1896467e-7, 1, -5.478531E-9, 0.246603817, -3.4646476E-8, -0.9691163899999538),
    ["Sea 2 [Medium]"] = CFrame.new(-11000.5625, -0.306667894, 21056.0312, -0.796931446, -6.017189E-8, -0.604069769,
        -7.449085E-8, 1, -1.3372562E-9, 0.604069769, 4.3931966E-8, -0.796931446),
    ["Sea 3 [High]"] = CFrame.new(-29340.5703, 22.8379154, 4827.75684),
    ["Sea 4 [Extreme]"] = CFrame.new(-31926.0684, 22.835228, 5976.42578),
    ["Sea 5 [Crazy]"] = CFrame.new(-36413.8828, 22.8379078, 8448.82227),
    ["Sea 6 [???]"] = CFrame.new(-40640, 22.837904, 11140.7646),
    ["Beyond the Sea"] = CFrame.new(-99999999, 10.964323997497559, -324.4842224121094)
}
form = Tabs.Events:PageSection({ Title = "Sea Events" }):Form()
row = titledRow(form, "Select Zone","Choose the sea zone where you want the system to operate. Different zones may have different events, so this tells the script where to farm.")
row:Right():PullDownButton({
    Options = ZoneSeaEvents,
    Label = "N/A",
    Multi = false,
    Selected = "Select Zone",
    ValueLabel = 2,
    Value = (function()
        for i, v in ipairs(ZoneSeaEvents) do
            if v == Config["Select Zone"] then
                return i
            end
        end
        return 1
    end)(),
    ValueChanged = function(self, value)
        local names = self.Selected
        if self.Multi then
            if self.ValueLabel == 1 then
                _G["selected" .. names] = {}
                for _, i in ipairs(value) do
                    table.insert(_G["selected" .. names], self.Options[i])
                end
                if #_G["selected" .. names] == 0 then
                    self.Label = "N/A"
                elseif #_G["selected" .. names] == 1 then
                    self.Label = _G["selected" .. names][1]
                else
                    self.Label = _G["selected" .. names][1] .. ", ..."
                end
            else
                _G["selected" .. names] = {}
                for _, i in ipairs(value) do
                    table.insert(_G["selected" .. names], self.Options[i])
                end
                if #_G["selected" .. names] == 0 then
                    self.Label = "N/A"
                else
                    self.Label = table.concat(_G["selected" .. names], ", ")
                end
            end
        else
            self.Label = self.Options[value] or "N/A"
        end
        _G['Select Zone'] = self.Options[value]
        Config["Select Zone"] = self.Options[value]
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end,
})
row = titledRow(form, "Start Farm Sea Events","After selecting a zone, activate this option to automatically farm sea events such as fighting monsters, collecting treasures, or gathering rewards that spawn in the sea.")
row:Right():Toggle({
    Value = Config["Auto Farm Sea Events"] or false,
    ValueChanged = function(self, value)
        Config["Auto Farm Sea Events"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Farm Sea Events"])
        if not value then
            StopBoatsTween()
        else
            _G.StopTweenBoat = false
        end
    end,
})
row = titledRow(form, "Auto Kill Piranha","Automatically hunts and kills Piranhas in the sea, making it easier to farm drops and EXP.")
row:Right():Toggle({
    Value = Config["Auto Kill Piranha"] or false,
    ValueChanged = function(self, value)
        Config["Auto Kill Piranha"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Kill Piranha"])
    end,
})
row = titledRow(form, "Auto Kill Shark","Automatically attacks and kills Sharks in the sea, perfect for farming without manual control.")
row:Right():Toggle({
    Value = Config["Auto Kill Shark"] or false,
    ValueChanged = function(self, value)
        Config["Auto Kill Shark"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Kill Shark"])
    end,
})
row = titledRow(form, "Auto Kill Terrorshark","Automatically hunts the powerful Terrorshark, which usually drops rare or valuable items.")
row:Right():Toggle({
    Value = Config["Auto Kill Terrorshark"] or false,
    ValueChanged = function(self, value)
        Config["Auto Kill Terrorshark"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Kill Terrorshark"])
    end,
})
row = titledRow(form, "Auto Kill Fish Crew Member","Automatically kills Fish Crew NPCs for farming EXP or item drops.")
row:Right():Toggle({
    Value = Config["Auto Kill Fish Crew Member"] or false,
    ValueChanged = function(self, value)
        Config["Auto Kill Fish Crew Member"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Kill Fish Crew Member"])
    end,
})
row = titledRow(form, "Auto Kill Sea Beasts","Automatically fights Sea Beasts, large sea monsters that often drop valuable and rare rewards.")
row:Right():Toggle({
    Value = Config["Auto Kill Sea Beasts"] or false,
    ValueChanged = function(self, value)
        Config["Auto Kill Sea Beasts"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Kill Sea Beasts"])
    end,
})
row = titledRow(form, "Auto Kill Raid Ship","Automatically destroys Raid Ships or Pirate Ships when they spawn in the sea.")
row:Right():Toggle({
    Value = Config["Auto Kill Raid Ship"] or false,
    ValueChanged = function(self, value)
        Config["Auto Kill Raid Ship"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Kill Raid Ship"])
    end,
})
form = Tabs.Events:PageSection({ Title = "Kitsune" }):Form()
local row = form:Row({
    SearchIndex = "Already Kill",
})
local BT_D = row:Left():TitleStack({
    Title = "Kitsune Island Spawned: "
})
spawn(function()
    while wait() do
        pcall(function()
            if game.Workspace._WorldOrigin.Locations:FindFirstChild('Kitsune Island') then
                BT_D.Title = ("Kitsune Island Spawned: 🟢")
            else
                BT_D.Title = ("Kitsune Island Spawned: 🔴")
            end
        end)
    end
end)
row = titledRow(form, "Auto Find Kitsune Island","Automatically locates the Kitsune Island in the game, saving you from manually searching. Useful for joining events or farming items on the island.")
row:Right():Toggle({
    Value = Config["Auto Find Kitsune Island"] or false,
    ValueChanged = function(self, value)
        Config["Auto Find Kitsune Island"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Find Kitsune Island"])
    end,
})
row = titledRow(form, "Teleport to Kitsune Island","Once the island’s location is known, this function allows you to teleport directly to Kitsune Island without walking.")
row:Right():Toggle({
    Value = Config["Teleport to Kitsune Island"] or false,
    ValueChanged = function(self, value)
        Config["Teleport to Kitsune Island"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Teleport to Kitsune Island"])
    end,
})
row = titledRow(form, "Auto Collect Azure Ember","Automatically collects Azure Ember items in the game without manual effort. Useful for farming large amounts or participating in events that require Azure Ember as a resource.")
row:Right():Toggle({
    Value = Config["Auto Collect Azure Ember"] or false,
    ValueChanged = function(self, value)
        Config["Auto Collect Azure Ember"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Collect Azure Ember"])
    end,
})
local row = form:Row({
    SearchIndex = "Values Azure Ember",
})
local BT_D = row:Left():TitleStack({
    Title = "Values Azure Ember",
})
spawn(function()
    while task.wait() do
        pcall(function()
            BT_D.Title = "Values Azure Ember " .. "( " .. tostring(Config["Values Azure Ember"]) .. " )"
        end)
    end
end)
row:Right():Slider({
    Minimum = 1,
    Maximum = 25,
    Value = Config["Values Azure Ember"] or 20,
    ValueChanged = function(self, value)
    local num = tonumber(value)
        if num then
            num = math.floor(num)
            Config["Values Azure Ember"] = num
            getgenv()['Update_Setting'](getgenv()['MyName'])
        end
    end,
})
row = titledRow(form, "Auto Trade Azure Ember","Automatically trades or exchanges Azure Ember items. The system checks your inventory and performs the trade to obtain desired items, rewards, or currency. Useful for farming and collecting items continuously without manual effort.")
row:Right():Toggle({
    Value = Config["Auto Trade Azure Ember"] or false,
    ValueChanged = function(self, value)
        Config["Auto Trade Azure Ember"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Trade Azure Ember"])
    end,
})
form = Tabs.Events:PageSection({ Title = "Misc" }):Form()
row = titledRow(form, "Remove Rocks")
row:Right():Button({
    Label = "Click here!",
    State = "Primary",
    Pushed = function(self)
        RemoveRocks("Rocks")
    end,
})
form = Tabs.VolcanoEvents:PageSection({ Title = "Dojo" }):Form()
local row = form:Row({
    SearchIndex = "Dragon Hunter Quest: N/A",
})
local BT_D = row:Left():TitleStack({
    Title = "Dragon Hunter Quest: N/A",
})
spawn(function()
    while task.wait() do
        if getgenv().Config["Auto Dragon Hunter"] or getgenv().Config["Auto Dragon HunterMagnet"] then
            local questData = game:GetService("ReplicatedStorage").Modules.Net["RF/DragonHunter"]:InvokeServer({
                ["Context"] = "Check" })
            if questData then
                local questTitle = "Dragon Hunter Quest: N/A"
                for _, value in pairs(questData) do
                    if value == "Defeat 3 Venomous Assailants on Hydra Island." or
                        value == "Defeated 1/3 Venomous Assailants on Hydra Island." or
                        value == "Defeated 2/3 Venomous Assailants on Hydra Island." then
                        questTitle = "Dragon Hunter Quest: Kill 3 Venomous Assailants"
                        break
                    elseif value == "Defeat 3 Hydra Enforcers on Hydra Island." or
                        value == "Defeated 1/3 Hydra Enforcers on Hydra Island." or
                        value == "Defeated 2/3 Hydra Enforcers on Hydra Island." then
                        questTitle = "Dragon Hunter Quest: Kill 3 Hydra Enforcers"
                        break
                    elseif value == "Destroy 10 trees on Hydra Island." or
                        value == "Destroyed 1/10 trees on Hydra Island." or
                        value == "Destroyed 2/10 trees on Hydra Island." or
                        value == "Destroyed 3/10 trees on Hydra Island." or
                        value == "Destroyed 4/10 trees on Hydra Island." or
                        value == "Destroyed 5/10 trees on Hydra Island." or
                        value == "Destroyed 6/10 trees on Hydra Island." or
                        value == "Destroyed 7/10 trees on Hydra Island." or
                        value == "Destroyed 8/10 trees on Hydra Island." or
                        value == "Destroyed 9/10 trees on Hydra Island." then
                        questTitle = "Dragon Hunter Quest: Destroy 10 Trees"
                        break
                    end
                end
                BT_D.Title = (questTitle)
            end
        end
    end
end)
row = titledRow(form, "Auto Dragon Hunter","Automatically completes the Dragon Hunter quest in the Dojo. The system handles everything: traveling to the Dojo, fighting quest-related monsters or bosses, and collecting quest rewards. Ideal for players who want to complete quests continuously without manual effort.")
row:Right():Toggle({
    Value = Config["Auto Dragon Hunter"] or false,
    ValueChanged = function(self, value)
        Config["Auto Dragon Hunter"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Dragon Hunter"])
    end,
})
row = titledRow(form, "Auto Dojo Quest","Automatically completes all Dojo quests. The system handles traveling to the Dojo, fighting quest-related monsters or bosses, and collecting quest rewards. Ideal for players who want to complete Dojo quests continuously without manual effort.")
row:Right():Toggle({
    Value = Config["Auto Dojo Quest"] or false,
    ValueChanged = function(self, value)
        Config["Auto Dojo Quest"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Dojo Quest"])
        if not value then
            StopBoatsTween()
        else
            _G.StopTweenBoat = false
        end
    end,
})
row = titledRow(form, "Auto Craft Volcanic Magnet","Automatically crafts Volcanic Magnet items. The system checks your materials and crafts the items for you. Useful for players who want to collect a large number of Volcanic Magnets without crafting them manually.")
row:Right():Toggle({
    Value = Config["Auto Craft Volcanic Magnet"] or false,
    ValueChanged = function(self, value)
        Config["Auto Craft Volcanic Magnet"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Craft Volcanic Magnet"])
    end,
})
row = titledRow(form, "Auto Collect Blaze Ember","Automatically collects Blaze Ember items. The system finds and collects the items during Volcano Events or Dojo activities without manual effort. Useful for farming large quantities of Blaze Ember for crafting or trading rewards.")
row:Right():Toggle({
    Value = Config["Auto Collect Blaze Ember"] or false,
    ValueChanged = function(self, value)
        Config["Auto Collect Blaze Ember"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Collect Blaze Ember"])
    end,
})
form = Tabs.VolcanoEvents:PageSection({ Title = "Prehistoric Island" }):Form()
local row = form:Row({
    SearchIndex = "Already Kill",
})
local BT_D = row:Left():TitleStack({
    Title = "Prehistoric Island Spawned: "
})
spawn(function()
    while wait() do
        pcall(function()
            if game.Workspace._WorldOrigin.Locations:FindFirstChild('Prehistoric Island') then
                BT_D.Title = ("Prehistoric Island Spawned: 🟢")
            else
                BT_D.Title = ("Prehistoric Island Spawned: 🔴")
            end
        end)
    end
end)
row = titledRow(form, "Auto Find Prehistoric Island","Automatically locates Prehistoric Island in the game without manual searching. Useful for players who want to participate in events or farm items on this island quickly and continuously.")
row:Right():Toggle({
    Value = Config["Auto Find Prehistoric Island"] or false,
    ValueChanged = function(self, value)
        Config["Auto Find Prehistoric Island"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Find Prehistoric Island"])
        if not value then
            StopBoatsTween()
        else
            _G.StopTweenBoat = false
        end
    end,
})
row = titledRow(form, "Teleport to Prehistoric Island","Allows players to teleport directly to Prehistoric Island without manually traveling or sailing. The system takes you straight to the island’s location, ideal for participating in events, farming items, or completing quests efficiently.")
row:Right():Toggle({
    Value = Config["Teleport to Prehistoric Island"] or false,
    ValueChanged = function(self, value)
        Config["Teleport to Prehistoric Island"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Teleport to Prehistoric Island"])
    end,
})
row = titledRow(form, "Auto Relic Events","Automatically participates in Relic Events. The system handles everything: traveling to event locations, completing related battles or quests, and collecting rewards or items. Ideal for players who want to farm items, XP, or other rewards from Relic Events without manual effort.")
row:Right():Toggle({
    Value = Config["Auto Relic Events"] or false,
    ValueChanged = function(self, value)
        Config["Auto Relic Events"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Relic Events"])
    end,
})
row = titledRow(form, "Auto Collect Dinosaur Bones","Automatically collects Dinosaur Bones on Prehistoric Island for crafting or trading without manual effort")
row:Right():Toggle({
    Value = Config["Auto Collect Dinosaur Bones"] or false,
    ValueChanged = function(self, value)
        Config["Auto Collect Dinosaur Bones"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Collect Dinosaur Bones"])
    end,
})
row = titledRow(form, "Auto Collect Dragon Egg","Automatically collects Dragon Eggs in the game for crafting or trading without manual effort")
row:Right():Toggle({
    Value = Config["Auto Collect Dragon Egg"] or false,
    ValueChanged = function(self, value)
        Config["Auto Collect Dragon Egg"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Collect Dragon Egg"])
    end,
})
form = Tabs.VolcanoEvents:PageSection({ Title = "Misc" }):Form()
row = titledRow(form, "Remove Rocks")
row:Right():Button({
    Label = "Click here!",
    State = "Primary",
    Pushed = function(self)
        RemoveRocks("Rocks")
    end,
})
form = Tabs.PvP:PageSection({ Title = "Combat" }):Form()
local row = form:Row({
    SearchIndex = "Already Kill",
})
local BT_D = row:Left():TitleStack({
    Title = "Players"
})
spawn(function()
    while wait() do
        pcall(function()
            for i, v in pairs((game:GetService("Players")):GetPlayers()) do
                if i == 12 then
                    BT_D.Title = ("Players :" .. " " .. i .. " " .. "/" .. " " .. "12" .. " " .. "(Max)")
                elseif i >= 12 then
                    BT_D.Title = ("Player :" .. " " .. i .. " " .. "/" .. " " .. "12" .. "" .. "(???)")
                elseif i == 1 then
                    BT_D.Title = ("Player :" .. " " .. i .. " " .. "/" .. " " .. "12")
                else
                    BT_D.Title = ("Players :" .. " " .. i .. " " .. "/" .. " " .. "12")
                end
            end
        end)
    end
end)
row = titledRow(form, "Select Players","Choose target players in PvP mode")
local S_B = row:Right():PullDownButton({
    Options = getPlayers(),
    Label = "N/A",
    Multi = false,
    Selected = "Select Player",
    ValueLabel = 2,
    Value = (function()
        for i, v in ipairs(getPlayers()) do
            if v == Config["Select Players"] then
                return i
            end
        end
        return 1
    end)(),
    ValueChanged = function(self, value)
        local names = self.Selected
        if self.Multi then
            if self.ValueLabel == 1 then
                _G["selected" .. names] = {}
                for _, i in ipairs(value) do
                    table.insert(_G["selected" .. names], self.Options[i])
                end
                if #_G["selected" .. names] == 0 then
                    self.Label = "N/A"
                elseif #_G["selected" .. names] == 1 then
                    self.Label = _G["selected" .. names][1]
                else
                    self.Label = _G["selected" .. names][1] .. ", ..."
                end
            else
                _G["selected" .. names] = {}
                for _, i in ipairs(value) do
                    table.insert(_G["selected" .. names], self.Options[i])
                end
                if #_G["selected" .. names] == 0 then
                    self.Label = "N/A"
                else
                    self.Label = table.concat(_G["selected" .. names], ", ")
                end
            end
        else
            self.Label = self.Options[value] or "N/A"
        end
        _G['Select Player'] = self.Options[value]
        Config["Select Players"] = self.Options[value]
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end,
})
row:Right():Button({
    Label = "Refresh Players",
    State = "Primary",
    Pushed = function(self)
        local bossCheck = getPlayers()
        S_B.Options = bossCheck
    end,
})
row = titledRow(form, "Position Method","Allows you to choose how to determine the target's position, e.g., automatically or manually. Useful for controlling PvP features or teleporting accurately to targets")
row:Right():PullDownButton({
    Options = { "Above", "Beside", "Lower" },
    Label = "N/A",
    Multi = false,
    Selected = "Position Method",
    ValueLabel = 2,
    Value = (function()
        for i, v in ipairs({ "Above", "Beside", "Lower" }) do
            if v == Config["Position"] then
                return i
            end
        end
        return 1
    end)(),
    ValueChanged = function(self, value)
        local names = self.Selected
        if self.Multi then
            if self.ValueLabel == 1 then
                _G["selected" .. names] = {}
                for _, i in ipairs(value) do
                    table.insert(_G["selected" .. names], self.Options[i])
                end
                if #_G["selected" .. names] == 0 then
                    self.Label = "N/A"
                elseif #_G["selected" .. names] == 1 then
                    self.Label = _G["selected" .. names][1]
                else
                    self.Label = _G["selected" .. names][1] .. ", ..."
                end
            else
                _G["selected" .. names] = {}
                for _, i in ipairs(value) do
                    table.insert(_G["selected" .. names], self.Options[i])
                end
                if #_G["selected" .. names] == 0 then
                    self.Label = "N/A"
                else
                    self.Label = table.concat(_G["selected" .. names], ", ")
                end
            end
        else
            self.Label = self.Options[value] or "N/A"
        end
        _G['Position'] = self.Options[value]
        Config["Position"] = self.Options[value]
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end,
})
row = titledRow(form, "Spectate to Players","Watch target players in real-time")
row:Right():Toggle({
    Value = Config["Spectate to Players"] or false,
    ValueChanged = function(self, value)
        Config["Spectate to Players"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Spectate to Players"])
    end,
})
row = titledRow(form, "Teleport to Players","Teleport directly to target players")
row:Right():Toggle({
    Value = Config["Teleport to Players"] or false,
    ValueChanged = function(self, value)
        Config["Teleport to Players"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Teleport to Players"])
    end,
})
row = titledRow(form, "Auto Kill Players","Automatically attack target players")
row:Right():Toggle({
    Value = Config["Auto Kill Players"] or false,
    ValueChanged = function(self, value)
        Config["Auto Kill Players"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Kill Players"])
    end,
})
local row = form:Row({
    SearchIndex = "Position Z [ Beside ]",
})
local BT_D = row:Left():TitleStack({
    Title = "Position Z [ Beside ]",
})
spawn(function()
    while task.wait() do
        pcall(function()
            BT_D.Title = "Position Z [ Beside ] " .. "( " .. tostring(Config["Position Z [ Beside ]"]) .. " )"
        end)
    end
end)
row:Right():Slider({
    Minimum = 10,
    Maximum = 60,
    Value = Config["Position Z [ Beside ]"] or 25,
    ValueChanged = function(self, value)
    local num = tonumber(value)
        if num then
            num = math.floor(num)
            Config["Position Z [ Beside ]"] = num
            getgenv()['Update_Setting'](getgenv()['MyName'])
        end
    end,
})
local row = form:Row({
    SearchIndex = "Height",
})
local BT_D = row:Left():TitleStack({
    Title = "Height",
})
spawn(function()
    while task.wait() do
        pcall(function()
            BT_D.Title = "Height " .. "( " .. tostring(Config["Height"]) .. " )"
        end)
    end
end)
row:Right():Slider({
    Minimum = 10,
    Maximum = 60,
    Value = Config["Height"] or 25,
    ValueChanged = function(self, value)
    local num = tonumber(value)
        if num then
            num = math.floor(num)
            Config["Height"] = num
            getgenv()['Update_Setting'](getgenv()['MyName'])
        end
    end,
})
local row = form:Row({
    SearchIndex = "Lowness",
})
local BT_D = row:Left():TitleStack({
    Title = "Lowness",
})
spawn(function()
    while task.wait() do
        pcall(function()
            BT_D.Title = "Lowness " .. "( " .. tostring(Config["Lowness"]) .. " )"
        end)
    end
end)
row:Right():Slider({
    Minimum = 10,
    Maximum = 60,
    Value = Config["Lowness"] or 25,
    ValueChanged = function(self, value)
    local num = tonumber(value)
        if num then
            num = math.floor(num)
            Config["Lowness"] = num
            getgenv()['Update_Setting'](getgenv()['MyName'])
        end
    end,
})
form = Tabs.PvP:PageSection({ Title = "Aimbot Settings" }):Form()
row = titledRow(form, "Enabled Aimbot","Enable aim-assist for precise attacks")
row:Right():Toggle({
    Value = Config["Enabled Aimbot"] or false,
    ValueChanged = function(self, value)
        _G['Enabled Aimbot'] = value
        Config["Enabled Aimbot"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Enabled Aimbot"])
    end,
})
row = titledRow(form, "Enabled PvP","Enables Player vs Player (PvP) mode, allowing you to attack or be attacked by other players. Useful for training PvP skills or using other PvP features like Auto Kill / Aimbot / Teleport")
row:Right():Toggle({
    Value = Config["Enabled PvP"] or false,
    ValueChanged = function(self, value)
        Config["Enabled PvP"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Enabled PvP"])
    end,
})
row = titledRow(form, "Auto Activate Ability","Automatically uses your character’s abilities or skills based on set conditions, such as attacking players or enemies. Useful in PvP or PvE for faster and more precise combat")
row:Right():Toggle({
    Value = Config["Auto Activate Ability"] or false,
    ValueChanged = function(self, value)
        Config["Auto Activate Ability"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Activate Ability"])
    end,
})
row = titledRow(form, "Safe Mode","Keeps gameplay safe from detection or game restrictions by limiting certain actions. Useful for players who want to use automation features safely")
row:Right():Toggle({
    Value = Config["Safe Mode"] or false,
    ValueChanged = function(self, value)
        Config["Safe Mode"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Safe Mode"])
    end,
})
form = Tabs.Stats:PageSection({ Title = "Stats" }):Form()
local row = form:Row({
    SearchIndex = "Points: ",
})
local BT_D = row:Left():TitleStack({
    Title = "Points: ",
})
spawn(function()
    while task.wait() do
        pcall(function()
            BT_D.Title = "Your Points : " .. "( " .. tostring(game:GetService("Players").LocalPlayer.Data.Points.Value) .. " )"
        end)
    end
end)
local row = form:Row({
    SearchIndex = "Points",
})
local BT_D = row:Left():TitleStack({
    Title = "Points",
})
spawn(function()
    while task.wait() do
        pcall(function()
            BT_D.Title = "Points " .. "( " .. tostring(Config["Points Stats"]) .. " )"
        end)
    end
end)
row:Right():Slider({
    Minimum = 1,
    Maximum = 100,
    Value = Config["Points Stats"] or 1,
    ValueChanged = function(self, value)
    local num = tonumber(value)
        if num then
            num = math.floor(num)
            _G['Point Stats'] = num
            Config["Points Stats"] = num
            getgenv()['Update_Setting'](getgenv()['MyName'])
        end
    end,
})
row = titledRow(form, "Auto Stats Melee")
row:Right():Toggle({
    Value = Config["Auto Stats Melee"] or false,
    ValueChanged = function(self, value)
        Config["Auto Stats Melee"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end,
})
row = titledRow(form, "Auto Stats Defense")
row:Right():Toggle({
    Value = Config["Auto Stats Defense"] or false,
    ValueChanged = function(self, value)
        Config["Auto Stats Defense"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end,
})
row = titledRow(form, "Auto Stats Sword")
row:Right():Toggle({
    Value = Config["Auto Stats Sword"] or false,
    ValueChanged = function(self, value)
        Config["Auto Stats Sword"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end,
})
row = titledRow(form, "Auto Stats Gun")
row:Right():Toggle({
    Value = Config["Auto Stats Gun"] or false,
    ValueChanged = function(self, value)
        Config["Auto Stats Gun"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end,
})
row = titledRow(form, "Auto Stats Demon Fruit")
row:Right():Toggle({
    Value = Config["Auto Stats Demon Fruit"] or false,
    ValueChanged = function(self, value)
        Config["Auto Stats Demon Fruit"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end,
})
local IslandList
form = Tabs.Dungeons:PageSection({ Title = "Riads" }):Form()
local Chips = { "Flame", "Ice", "Quake", "Light", "Dark", "Spider", "Rumble", "Magma", "Buddha", "Sand", "Phoenix",
    "Dough" }
row = titledRow(form, "Select Chip Raid","Allows you to select the type of raid chip you want (e.g., Flame, Ice, Light, Dark). Each chip is required to start a dungeon raid where you fight bosses and unlock Fruit Awakenings.")
row:Right():PullDownButton({
    Options = Chips,
    Label = "N/A",
    Multi = false,
    Selected = "Select Chip Raid",
    ValueLabel = 2,
    Value = (function()
        for i, v in ipairs(Chips) do
            if v == Config["Select Chip Raid"] then
                return i
            end
        end
        return 1
    end)(),
    ValueChanged = function(self, value)
        local names = self.Selected
        if self.Multi then
            if self.ValueLabel == 1 then
                _G["selected" .. names] = {}
                for _, i in ipairs(value) do
                    table.insert(_G["selected" .. names], self.Options[i])
                end
                if #_G["selected" .. names] == 0 then
                    self.Label = "N/A"
                elseif #_G["selected" .. names] == 1 then
                    self.Label = _G["selected" .. names][1]
                else
                    self.Label = _G["selected" .. names][1] .. ", ..."
                end
            else
                _G["selected" .. names] = {}
                for _, i in ipairs(value) do
                    table.insert(_G["selected" .. names], self.Options[i])
                end
                if #_G["selected" .. names] == 0 then
                    self.Label = "N/A"
                else
                    self.Label = table.concat(_G["selected" .. names], ", ")
                end
            end
        else
            self.Label = self.Options[value] or "N/A"
        end
        Config["Select Chip Raid"] = self.Options[value]
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end,
})
row = titledRow(form, "Auto Buy Chip","When enabled, the system will automatically purchase the raid chip from the NPC without you having to manually buy it. Useful for continuous raid farming.")
row:Right():Toggle({
    Value = Config["Auto Buy Chip"] or false,
    ValueChanged = function(self, value)
        Config["Auto Buy Chip"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end,
})
row:Right():Button({
    Label = "Buy Chip",
    State = "Primary",
    Pushed = function(self)
        local args = {
            [1] = "RaidsNpc",
            [2] = "Select",
            [3] = getgenv().Config["Select Chip Raid"]
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end,
})
row = titledRow(form, "Auto Start Raid","When enabled, the system will automatically start a raid as soon as you have a Raid Chip in your inventory. You don’t need to manually talk to the NPC or press start. This is useful for continuous raid farming, such as unlocking Fruit Awakenings or collecting dungeon rewards.")
row:Right():Toggle({
    Value = Config["Auto Start Raid"] or false,
    ValueChanged = function(self, value)
        Config["Auto Start Raid"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end,
})
row:Right():Button({
    Label = "Start Raid",
    State = "Primary",
    Pushed = function(self)
        if L_4442272183_ then
            fireclickdetector(game:GetService("Workspace").Map.CircleIsland.RaidSummon2.Button.Main
                .ClickDetector)
        elseif L_7449423635_ then
            fireclickdetector(game:GetService("Workspace").Map["Boat Castle"].RaidSummon2.Button.Main
                .ClickDetector)
        end
    end,
})
row = titledRow(form, "Auto Awaken Skill","Automatically awakens your Devil Fruit skills right after finishing a Raid if you have enough Fragments, without needing to talk to the NPC manually.")
row:Right():Toggle({
    Value = Config["Auto Awaken"] or false,
    ValueChanged = function(self, value)
        Config["Auto Awaken"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end,
})
row = titledRow(form, "Kill Aura","When enabled, your character will automatically attack nearby enemies without manual input. Useful for fighting multiple enemies or farming efficiently.")
row:Right():Toggle({
    Value = Config["Kill Aura"] or false,
    ValueChanged = function(self, value)
        Config["Kill Aura"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end,
})
row = titledRow(form, "Auto Dungeon","Automatically plays and farms Dungeons (Raids).")
row:Right():Toggle({
    Value = Config["Auto Dungeon"] or false,
    ValueChanged = function(self, value)
        Config["Auto Dungeon"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        _St(Config["Auto Dungeon"])
    end,
})
form = Tabs.DevilFruit:PageSection({ Title = "Fruit" }):Form()
local row = form:Row({
    SearchIndex = "Points",
})
local BT_D = row:Left():TitleStack({
    Title = "Points",
})
spawn(function()
    local lastCheckTime = 0
    while wait() do
        if tick() - lastCheckTime > 1 then
            lastCheckTime = tick()
            local foundFruit = false
            for _, v in pairs(game.workspace:GetDescendants()) do
                if string.find(v.Name, "Fruit") and v:FindFirstChild("Fruit") and v:FindFirstChild("RootPart") then
                    foundFruit = true
                    break
                end
            end
            if foundFruit then
                BT_D.Title = ("Fruit Spawned: 🟢")
            else
                BT_D.Title = ("Fruit Spawned: 🔴")
            end
        end
    end
end)
row = titledRow(form, "Auto Random Fruit","Automatically picks a random Devil Fruit when buying or receiving from NPC, without manual selection")
row:Right():Toggle({
    Value = Config["Auto Random Fruit"] or false,
    ValueChanged = function(self, value)
        Config["Auto Random Fruit"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end,
})
row:Right():Button({
    Label = "Random Fruit",
    State = "Primary",
    Pushed = function(self)
        local args = {
            [1] = "Cousin",
            [2] = "Buy"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end,
})
row = titledRow(form, "Auto Store Fruit","Automatically stores your Devil Fruits in the inventory or vault to manage space and avoid clutter")
row:Right():Toggle({
    Value = Config["Auto Store Fruit"] or false,
    ValueChanged = function(self, value)
        Config["Auto Store Fruit"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end,
})
row = titledRow(form, "Teleport to Fruit","Instantly moves your character to the location of a Devil Fruit")
row:Right():Toggle({
    Value = Config["Teleport to Fruit"] or false,
    ValueChanged = function(self, value)
        Config["Teleport to Fruit"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end,
})
form = Tabs.Shop:PageSection({ Title = "Bone - Ectoplasm - Fragment" }):Form()
row = titledRow(form, "Buy Race Ghoul [ $100 Ectoplasm ]")
row:Right():Button({
    Label = "Click here!",
    State = "Primary",
    Pushed = function(self)
        local args1 = {
            [1] = "Ectoplasm",
            [2] = "BuyCheck",
            [3] = 4
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args1))
        local args2 = {
            [1] = "Ectoplasm",
            [2] = "Change",
            [3] = 4
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args2))
    end,
})
row = titledRow(form, "Buy Race Cyborg [ f1,500 Fragment ]")
row:Right():Button({
    Label = "Click here!",
    State = "Primary",
    Pushed = function(self)
        local args = {
            [1] = "CyborgTrainer",
            [2] = "Buy"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end,
})
row = titledRow(form, "Random Race [ f3,000 Fragment ]")
row:Right():Button({
    Label = "Click here!",
    State = "Primary",
    Pushed = function(self)
        local args = {
            [1] = "BlackbeardReward",
            [2] = "Reroll",
            [3] = "2"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end,
})
row = titledRow(form, "Reset Stats [ f2,500 Fragment ]")
row:Right():Button({
    Label = "Click here!",
    State = "Primary",
    Pushed = function(self)
        local args = {
            [1] = "BlackbeardReward",
            [2] = "Refund",
            [3] = "2"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end,
})
form = Tabs.Shop:PageSection({ Title = "Abilities" }):Form()
row = titledRow(form, "Buy Skyjump [ $10,000 Beli ]")
row:Right():Button({
    Label = "Click here!",
    State = "Primary",
    Pushed = function(self)
        local args = {
            [1] = "BuyHaki",
            [2] = "Geppo"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end,
})
row = titledRow(form, "Buy Buso Haki [ $25,000 Beli ]")
row:Right():Button({
    Label = "Click here!",
    State = "Primary",
    Pushed = function(self)
        local args = {
            [1] = "BuyHaki",
            [2] = "Buso"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end,
})
row = titledRow(form, "Buy Soru [ $100,000 Beli ]")
row:Right():Button({
    Label = "Click here!",
    State = "Primary",
    Pushed = function(self)
        local args = {
            [1] = "BuyHaki",
            [2] = "Soru"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end,
})
row = titledRow(form, "Buy Observation haki [ $750,000 Beli ]")
row:Right():Button({
    Label = "Click here!",
    State = "Primary",
    Pushed = function(self)
        local args = {
            [1] = "KenTalk",
            [2] = "Buy"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end,
})
form = Tabs.Shop:PageSection({ Title = "Fighting" }):Form()
row = titledRow(form, "Buy Black Leg [ $150,000 Beli ]")
row:Right():Button({
    Label = "Click here!",
    State = "Primary",
    Pushed = function(self)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBlackLeg")
    end,
})
row = titledRow(form, "Buy Electro [ $550,000 Beli ]")
row:Right():Button({
    Label = "Click here!",
    State = "Primary",
    Pushed = function(self)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectro")
    end,
})
row = titledRow(form, "Buy Fishman Karate [ $750,000 Beli ]")
row:Right():Button({
    Label = "Click here!",
    State = "Primary",
    Pushed = function(self)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyFishmanKarate")
    end,
})
row = titledRow(form, "Buy Dragon Claw [ $1,500 Fragments ]")
row:Right():Button({
    Label = "Click here!",
    State = "Primary",
    Pushed = function(self)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","1")
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","2")
    end,
})
row = titledRow(form, "Buy Superhuman [ $3,000,000 Beli ]")
row:Right():Button({
    Label = "Click here!",
    State = "Primary",
    Pushed = function(self)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySuperhuman")
    end,
})
row = titledRow(form, "Buy Death Step [ $5,000 Fragments / $5,000,000 Beli ]")
row:Right():Button({
    Label = "Click here!",
    State = "Primary",
    Pushed = function(self)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDeathStep")
    end,
})
row = titledRow(form, "Buy Sharkman Karate [ $5,000 Fragments / $2,500,000 Beli ]")
row:Right():Button({
    Label = "Click here!",
    State = "Primary",
    Pushed = function(self)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate",true)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate")
    end,
})
row = titledRow(form, "Buy Electric Claw [ $5,000 Fragments / $3,000,000 Beli ]")
row:Right():Button({
    Label = "Click here!",
    State = "Primary",
    Pushed = function(self)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw")
    end,
})
row = titledRow(form, "Buy Dragon Talon [ $5,000 Fragments / $3,000,000 Beli ]")
row:Right():Button({
    Label = "Click here!",
    State = "Primary",
    Pushed = function(self)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon")
    end,
})
row = titledRow(form, "Buy GodHuman [ $5,000 Fragments / $5,000,000 Beli ]")
row:Right():Button({
    Label = "Click here!",
    State = "Primary",
    Pushed = function(self)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyGodhuman")
    end,
})
form = Tabs.Shop:PageSection({ Title = "Sword" }):Form()
row = titledRow(form, "Buy Cutlass [ $1,000 Beli ]")
row:Right():Button({
    Label = "Click here!",
    State = "Primary",
    Pushed = function(self)
        local args = {
            [1] = "BuyItem",
            [2] = "Cutlass"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end,
})
row = titledRow(form, "Buy Katana [ $1,000 Beli ]")
row:Right():Button({
    Label = "Click here!",
    State = "Primary",
    Pushed = function(self)
        local args = {
            [1] = "BuyItem",
            [2] = "Katana"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end,
})
row = titledRow(form, "Buy Dual Katana [ $12,000 Beli ]")
row:Right():Button({
    Label = "Click here!",
    State = "Primary",
    Pushed = function(self)
        local args = {
            [1] = "BuyItem",
            [2] = "Dual Katana"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end,
})
row = titledRow(form, "Buy Iron Mace [ $25,000 Beli ]")
row:Right():Button({
    Label = "Click here!",
    State = "Primary",
    Pushed = function(self)
        local args = {
            [1] = "BuyItem",
            [2] = "Iron Mace"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end,
})
row = titledRow(form, "Buy Triple Katana [ $60,000 Beli ]")
row:Right():Button({
    Label = "Click here!",
    State = "Primary",
    Pushed = function(self)
        local args = {
            [1] = "BuyItem",
            [2] = "Triple Katana"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end,
})
row = titledRow(form, "Buy Pipe [ $100,000 Beli ]")
row:Right():Button({
    Label = "Click here!",
    State = "Primary",
    Pushed = function(self)
        local args = {
            [1] = "BuyItem",
            [2] = "Pipe"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end,
})
row = titledRow(form, "Buy Dual-Headed Blade [ $400,000 Beli ]")
row:Right():Button({
    Label = "Click here!",
    State = "Primary",
    Pushed = function(self)
        local args = {
            [1] = "BuyItem",
            [2] = "Dual-Headed Blade"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end,
})
row = titledRow(form, "Buy Soul Cane [ $750,000 Beli ]")
row:Right():Button({
    Label = "Click here!",
    State = "Primary",
    Pushed = function(self)
        local args = {
            [1] = "BuyItem",
            [2] = "Soul Cane"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end,
})
row = titledRow(form, "Buy Bisento [ $1,200,000 Beli ]")
row:Right():Button({
    Label = "Click here!",
    State = "Primary",
    Pushed = function(self)
        local args = {
            [1] = "BuyItem",
            [2] = "Bisento"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end,
})
row = titledRow(form, "Pole v2 [ f5,000 Fragments ]")
row:Right():Button({
    Label = "Click here!",
    State = "Primary",
    Pushed = function(self)
        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ThunderGodTalk")
    end,
})
form = Tabs.Miscellaneous:Form()
row = titledRow(form, "Join Team")
row:Right():Button({
    Label = "Join Pirates Team",
    State = "Primary",
    Pushed = function(self)
        Pirates()
    end,
})
row:Right():Button({
    Label = "Join Marines Team",
    State = "Primary",
    Pushed = function(self)
        Marines()
    end,
})
form = Tabs.Miscellaneous:Form()
row = titledRow(form, "Server")
row:Right():Button({
    Label = "Rejoin Server",
    State = "Primary",
    Pushed = function(self)
        Rejoin()
    end,
})
row:Right():Button({
    Label = "Hop Server",
    State = "Primary",
    Pushed = function(self)
        Hop()
    end,
})
function Hop()
    local PlaceID = game.PlaceId
    local AllIDs = {}
    local foundAnything = ""
    local actualHour = os.date("!*t").hour
    local Deleted = false
    function TPReturner()
        local Site
        if foundAnything == "" then
            Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' ..
                PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
        else
            Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' ..
                PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
        end
        local ID = ""
        if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
            foundAnything = Site.nextPageCursor
        end
        local num = 0
        for i, v in pairs(Site.data) do
            local Possible = true
            ID = tostring(v.id)
            if tonumber(v.maxPlayers) > tonumber(v.playing) then
                for _, Existing in pairs(AllIDs) do
                    if num ~= 0 then
                        if ID == tostring(Existing) then
                            Possible = false
                        end
                    else
                        if tonumber(actualHour) ~= tonumber(Existing) then
                            local delFile = pcall(function()
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
                        wait()
                        game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID,
                            game.Players.LocalPlayer)
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
    Teleport()
end
row:Right():Button({
    Label = "Hop Server Low",
    State = "Primary",
    Pushed = function(self)
        TPReturner()
    end,
})
form = Tabs.Miscellaneous:PageSection({ Title = "Join Severs" }):Form()
row = titledRow(form, "Server Jop ID")
row:Left():TextField({
    Placeholder = "Jop ID",
    Value = nil,
    ValueChanged = function(self, value)
        jobId = value
    end,
    TextChanged = function(self, value)
        jobId = value
    end,
})
row:Right():Button({
    Label = "Join Server",
    State = "Primary",
    Pushed = function(self)
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, jobId, game.Players.LocalPlayer)
    end,
})
row:Right():Button({
    Label = "Copy Jop ID",
    State = "Primary",
    Pushed = function(self)
        setclipboard(game.JobId)
    end,
})
form = Tabs.Miscellaneous:PageSection({ Title = "Local Player" }):Form()
row = titledRow(form, "No Clip")
row:Right():Toggle({
    Value = Config["No Clip"] or false,
    ValueChanged = function(self, value)
        _G['No Clip'] = value
        Config["No Clip"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        if value then
            noclip()
        else
            unnoclip()
        end
    end,
})
local LocalPlayer = game:GetService'Players'.LocalPlayer
local originalstam = LocalPlayer.Character.Energy.Value
function infinitestam()
    LocalPlayer.Character.Energy.Changed:connect(function()
        if InfiniteEnergy then
            LocalPlayer.Character.Energy.Value = originalstam
        end 
    end)
end
spawn(function()
    pcall(function()
        while wait(.1) do
            if InfiniteEnergy then
                wait(0.3)
                originalstam = LocalPlayer.Character.Energy.Value
                infinitestam()
            end
        end
    end)
end)
local myname = game.Players.LocalPlayer.Name
local Walkonwater = function(boo)
    for i,v in pairs(game.Workspace.Characters:GetChildren()) do
        if v.Name == myname then
            v:SetAttribute("WaterWalking",boo)
        end
    end
end
row = titledRow(form, "Walk on water")
row:Right():Toggle({
    Value = Config["Walk on water"] or false,
    ValueChanged = function(self, value)
        _G['Walk on water'] = value
        Config["Walk on water"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        if value then
            Walkonwater(true)
        else
           Walkonwater(false)
        end
    end,
})
row = titledRow(form, "Infinit Soru")
row:Right():Toggle({
    Value = Config["Infinit Soru"] or false,
    ValueChanged = function(self, value)
        Config["Infinit Soru"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        local water = game.workspace.Map:FindFirstChild("WaterBase-Plane")
    end,
})
spawn(function()
    while wait() do
        if Config["Infinit Soru"] then
            pcall(function()
                for _, character in pairs(game.Workspace.Characters:GetChildren()) do
                    local speed = character:GetAttribute("FlashstepCooldown")
                    if speed and speed >= 0 and speed <= 9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999 then
                        character:SetAttribute("FlashstepCooldown", 1000000000000000000000)
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while task.wait() do
        if not Config["Infinit Soru"] then
            pcall(function()
                for _, character in pairs(game.Workspace.Characters:GetChildren()) do
                    local speed = character:GetAttribute("FlashstepCooldown")
                    if speed and speed >= 0 and speed <= 9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999 then
                        character:SetAttribute("FlashstepCooldown", 0)
                    end
                end
            end)
        end
    end
end)
row = titledRow(form, "Infinit Energy")
row:Right():Toggle({
    Value = Config["Infinit Energy"] or false,
    ValueChanged = function(self, value)
        Config["Infinit Energy"] = value
        InfiniteEnergy = value
        originalstam = LocalPlayer.Character.Energy.Value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        local water = game.workspace.Map:FindFirstChild("WaterBase-Plane")
    end,
})
row = titledRow(form, "Infinit Ability")
row:Right():Toggle({
    Value = Config["Infinit Ability"] or false,
    ValueChanged = function(self, value)
        Config["Infinit Ability"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        local water = game.workspace.Map:FindFirstChild("WaterBase-Plane")
    end,
})
spawn(function()
    while wait() do
        if InfAbility then
            pcall(function()
                InfAb()
            end)
        end
    end
end)
row = titledRow(form, "Dodge No Cooldown")
row:Right():Toggle({
    Value = Config["Dodge No Cooldown"] or false,
    ValueChanged = function(self, value)
        if value then
        nododgecool = value
        NoDodgeCool()
        else
        nododgecool = value
            NoDodgeCool()
        end
        Config["Dodge No Cooldown"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        local water = game.workspace.Map:FindFirstChild("WaterBase-Plane")
    end,
})
row = titledRow(form, "Auto Dodge")
row:Right():Toggle({
    Value = Config["Auto Dodge"] or false,
    ValueChanged = function(self, value)
        Config["Auto Dodge"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
        local water = game.workspace.Map:FindFirstChild("WaterBase-Plane")
    end,
})
spawn(function()
    while task.wait() do
        if Config["Auto Dodge"] then
            pcall(function()
                for i = 1,5 do
                game:service("VirtualInputManager"):SendKeyEvent(true, "Q", false, game)
                end
            end)
        end
    end
end)
spawn(function()
    while task.wait() do
        if Config["Auto Dodge"] then
            pcall(function()
                for i = 1,5 do
                game:service("VirtualInputManager"):SendKeyEvent(true, "Q", false, game)
                end
            end)
        end
    end
end)
form = Tabs.Miscellaneous:PageSection({ Title = "Lighting" }):Form()
row = titledRow(form, "FPS Boots")
row:Right():Button({
    Label = "Click here!",
    State = "Primary",
    Pushed = function(self)
        local function FPSBooster()
            local decalsyeeted = true
            local g = game
            local w = g.Workspace
            local l = g.Lighting
            local t = w.Terrain
            pcall(function() sethiddenproperty(l, "Technology", 2) end)
            pcall(function() sethiddenproperty(t, "Decoration", false) end)
            t.WaterWaveSize = 0
            t.WaterWaveSpeed = 0
            t.WaterReflectance = 0
            t.WaterTransparency = 0
            l.GlobalShadows = false
            l.FogEnd = 9e9
            l.Brightness = 0
            pcall(function() settings().Rendering.QualityLevel = "Level01" end)
            for _, v in pairs(g:GetDescendants()) do
                pcall(function()
                    if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
                        v.Material = "Plastic"
                        v.Reflectance = 0
                    elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
                        v.Transparency = 1
                    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                        v.Lifetime = NumberRange.new(0)
                    elseif v:IsA("Explosion") then
                        v.BlastPressure = 1
                        v.BlastRadius = 1
                    elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
                        v.Enabled = false
                    elseif v:IsA("MeshPart") then
                        v.Material = "Plastic"
                        v.Reflectance = 0
                        v.TextureID = 10385902758728957
                    end
                end)
            end
            for _, e in pairs(l:GetChildren()) do
                pcall(function()
                    if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
                        e.Enabled = false
                    end
                end)
            end
        end
        local success, errorMsg = pcall(FPSBooster)
        if not success then
            warn("Error occurred in FPSBooster: " .. errorMsg)
        end
    end,
})
row = titledRow(form, "Redeem Codes")
row:Right():Button({
    Label = "Click here!",
    State = "Primary",
    Pushed = function(self)
        local redeemCodes = {
            "fudd10_v2", "Sub2Fer999", "Enyu_is_Pro", "JCWK", "StarcodeHEO",
            "MagicBUS", "KittGaming", "Sub2CaptainMaui", "Sub2OfficialNoobie",
            "TheGreatAce", "Sub2NoobMaster123", "Sub2Daigrock", "Axiore",
            "StrawHatMaine", "TantaiGaming", "Bluxxy", "SUB2GAMERROBOT_EXP1",
            "KITT_RESET", "Sub2UncleKizaru", "SUB2GAMERROBOT_RESET1"
        }
        local function RedeemCode(value)
            local replicatedStorage = game:GetService("ReplicatedStorage")
            local remote = replicatedStorage.Remotes:FindFirstChild("Redeem")
            if remote then
                remote:InvokeServer(value)
            else
                warn("Redeem remote not found!")
            end
        end
        for _, code in pairs(redeemCodes) do
            RedeemCode(code)
        end
    end,
})
form = Tabs.Window:PageSection({ Title = "Appearance" }):Form()
row = titledRow(
    form,
    "Dark mode",
    "An application appearance setting that uses a dark color palette to provide a comfortable viewing experience tailored for low-light environments."
)
row:Right():Toggle({
    Value = true,
    ValueChanged = function(self, value)
        app.Theme = value and cascade.Themes.Dark or cascade.Themes.Light
    end,
})
form = Tabs.Window:PageSection({ Title = "Advanced Settings" }):Form()
local row = form:Row({
    SearchIndex = "FPS",
})
local BT_D = row:Left():TitleStack({
    Title = "FPS",
})
spawn(function()
    while task.wait() do
        pcall(function()
            BT_D.Title = "FPS " .. "( " .. tostring(Config["FPS"]) .. " )"
        end)
    end
end)
row:Right():Slider({
    Minimum = 1,
    Maximum = 240,
    Value = Config["FPS"] or 60,
    ValueChanged = function(self, value)
    local num = tonumber(value)
        if num then
            num = math.floor(num)
            Config["FPS"] = num
            getgenv()['Update_Setting'](getgenv()['MyName'])
        end
    end,
})
row = titledRow(
    form,
    "FPS Look"
)
row:Right():Toggle({
    Value = Config["FPS Look"] or false,
    ValueChanged = function(self, value)
        Config["FPS Look"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end,
})
spawn(function()
    while task.wait() do
        if Config["FPS Look"] then
            pcall(function()
                setfpscap(Config["FPS"])
            end)
        else
            setfpscap(9999)
        end
    end
end)
row = titledRow(
    form,
    "Reset UI Size"
)
row:Right():Button({
    Label = "Click here!",
    State = "Primary",
    Pushed = function(self)
        window.Size = userInputService.TouchEnabled and UDim2.fromOffset(550, 325) or UDim2.fromOffset(850, 530)
    end,
})
row = titledRow(
    form,
    "Auto Hide UI"
)
row:Right():Toggle({
    Value = Config["Auto Hide UI"] or false,
    ValueChanged = function(self, value)
        Config["Auto Hide UI"] = value
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end,
})
form = Tabs.Window:PageSection({ Title = "Input" }):Form()
row = titledRow(form, "Minimize shortcut")
row:Right():KeybindField({
    Value = minimizeKeybind,
    ValueChanged = function(self, value)
        minimizeKeybind = value
    end,
})
row = titledRow(
    form,
    "Searchable",
    "Allows users to search for content in a page with a search-field in the titlebar."
)
row:Right():Toggle({
    Value = window.Searching,
    ValueChanged = function(self, value)
        window.Searching = value
    end,
})
row = titledRow(form, "Draggable", "Allows users to move the window with a mouse or touch device.")
row:Right():Toggle({
    Value = window.Draggable,
    ValueChanged = function(self, value)
        window.Draggable = value
    end,
})
local row =
    titledRow(form, "Resizable", "Allows users to resize the window with a mouse or touch device.")
row:Right():Toggle({
    Value = window.Resizable,
    ValueChanged = function(self, value)
        window.Resizable = value
    end,
})
form = Tabs.Window:PageSection({
    Title = "Effects",
    Subtitle = "These effects may be resource intensive across different systems.",
}):Form()
row = titledRow(form, "Dropshadow", "Enables a dropshadow effect on the window.")
row:Right():Toggle({
    Value = window.Dropshadow,
    ValueChanged = function(self, value)
        window.Dropshadow = value
    end,
})
row = titledRow(
    form,
    "Background blur",
    "Enables a UI background blur effect on the window. This can be detectable in some games."
)
row:Right():Toggle({
    Value = window.UIBlur,
    ValueChanged = function(self, value)
        window.UIBlur = value
    end,
})
code.sleep(1);
if Config["Auto Hide UI"] then
    window.Minimized = not window.Minimized
end;
