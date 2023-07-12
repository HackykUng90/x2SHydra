local Chests = workspace.Chests
local DamageParts = workspace.DamageParts
local Effect = workspace.Effects
local Live = workspace.Live
local Map = workspace.Map
local NPCS = workspace.NPCS
local QuestMarkers = workspace.QuestMarkers
local Drops = workspace.Drops
local QuestBoards = workspace.QuestBoards
local PlayerValues = Player.PlayerValues

RunService.Stepped:Connect(function()
    sethiddenproperty(Player, "SimulationRadius", 1000)
end)

local Mobs = {}
for i,v in next, Live:GetChildren() do
    if not table.find(Mobs, v.Name) then
        table.insert(Mobs, v.Name)
    end
end
local Quests = {}
for i,v in next, Player.Quests:GetChildren() do
    if not table.find(Quests, v.Name) then
        table.insert(Quests, v.Name)
    end
end
local Codes = {}
for i,v in next, Player.Codes:GetChildren() do
    if not table.find(Codes, v.Name) then
        table.insert(Codes, v.Name)
    end
end
local Fruits = {
    Common = {
        "Nagi Nagi no mi",
        "Suke Suke no mi",
        "Guru Guru no mi",
        "Sube Sube no mi",
        "Dark Magic (Simon)",
        "Purple Flare",
        "Airwalk",
        "Blaze",
    },
    Rare = {
        "Mera Mera no mi",
        "Zushi Zushi no mi",
        "Goro Goro no mi",
        "Suna Suna no mi",
        "Moku Moku no mi",
        "Yami Yami no mi",
        "Gomu Gomu no mi",
        "Pika Pika no mi",
        "Hie Hie no mi",
        "Gura Gura no mi",
        "Blueflame"
    },
    Legendary = {
        "Anti Magic",
        "Sunshine (Escanor)",
        "Lightning Dragon Slayer Magic",
        "Fire Dragon Slayer Magic",
        "Fire Dragon Slayer Magic v2",
        "One For All: Prime"
    }
}
local Specializations = {
    "Haoshoku Haki",
    "Flashstep",
    "Kenbunshoku Haki",
    "Sonido",
    "Busoshoku Haki"
}
local Races = {
    "Human",
    "Kumate Tribe",
    "Skypiean",
    "Dodoria's Race",
    "Burter's Race",
    "Namekian",
    "Saiyan",
    "Frieza Race (First Form)",
    "Bojack's Race",
    "Android",
    "Uzumaki Clan",
    "Cerealian",
    "Hybrid Saiyan",
    "Angel (In Training)",
    "Demon",
    "Fanalis",
    "Lunarian",
    "Mink",
    "Angel",
    "Baby (Possessed)",
    "Heeter Race",
    "Toppo's Race",
    "Beerus' Race",
}
local removeCommon = function(A)
    for i,v in next, Player.Backpack:GetChildren() do
        if v:IsA("Tool") and table.find(Fruits.Common, v.Name) then
            v.Parent = nil
        end
    end
end
local removeCommonBags = function()
    for i,v in next, Player.Backpack:GetChildren() do
        if v:IsA("Tool") and v:FindFirstChild("Rarity", true) and v:FindFirstChild("Rarity", true).Text == "Common" then
            v.Parent = nil
        end
    end
end
local removeUnCommonBags = function()
    for i,v in next, Player.Backpack:GetChildren() do
        if v:IsA("Tool") and v:FindFirstChild("Rarity", true) and v:FindFirstChild("Rarity", true).Text == "Uncommon" then
            v.Parent = nil
        end
    end
end

local Checkrace = function()
    return Player.PlayerValues.Race.Value 
end
local RollRace = function(A)
    if A ~= Player.PlayerValues.Race.Value  then
        for i,v in next, Player.Backpack:GetChildren() do
            if v:IsA("Tool") and v:FindFirstChild("Heart", true) then
                Player.Character:FindFirstChildWhichIsA("Humanoid"):EquipTool(v)
                ReplicatedStorage:WaitForChild("RemoteEvents"):FindFirstChild("ItemRemote"):FireServer()
                break
            elseif not v:IsA("Tool") and not v:FindFirstChild("Heart", true) then
                ReplicatedStorage:WaitForChild("RemoteEvents"):FindFirstChild("RaceSpinRemote"):FireServer(1)
                break
            end
        end
    end
end



local Teleport = function(A)
    Player.Character:FindFirstChild("HumanoidRootPart").CFrame = A 
end
local Hit = function(A)
    ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("BladeCombatRemote"):FireServer(false, Vector3.new(A:FindFirstChildWhichIsA("BasePart").Position), CFrame.new(A:FindFirstChildWhichIsA("BasePart").Position))
end
local Equip = function()
    if Player.Character:FindFirstChildWhichIsA("Tool", true) then
        Player.Character.Humanoid:UnequipTools()
    end
    if not Player.Character:FindFirstChildWhichIsA("Tool", true) then
        local v = Player.Backpack:FindFirstChild("Combat Script", true).Parent
        Player.Character.Humanoid:EquipTool(v) 
    end
end
local repo = 'https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/'
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/1201for/LinoriaLib/main/Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
local Window = Library:CreateWindow({
    Title = "Gay Hub Premium",
    Center = true, 
    AutoShow = true,
})

local Tabs = {
    Main = Window:AddTab('Main'), 
    ['UI Settings'] = Window:AddTab('UI Settings'),
}

local LeftGroupBox = Tabs.Main:AddLeftGroupbox('AutoFarms')
local RightGroupBox = Tabs.Main:AddRightGroupbox('StatusGay')
local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')

LeftGroupBox:AddToggle('AutoFarming', {Text = 'Tee Mons', Default = false,Tooltip = ''})
Toggles.AutoFarming:OnChanged(function(State)
H = Toggles.AutoFarming.Value 
    RunService.Stepped:Connect(function()
        pcall(function()
            if H then
                Player.Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(11)
            end
        end)
    end)
    spawn(function()
        while wait(.1) and H do 
            pcall(function()
                for i,v in next, Live:GetChildren() do
                    if v:IsA("Model") and v.Name == ddd and v.Humanoid.Health ~= 0 then
                        Teleport(CFrame.new(v:GetModelCFrame().Position + Vector3.new(0,-7,0)))
                        Equip()
                        Hit(v)
                        if v.Humanoid.Health ~= v.Humanoid.MaxHealth then
                            v.Humanoid.Health = 0
                        end
                    end
                end
            end)
        end
    end)
end)

LeftGroupBox:AddDropdown('Mobs1', {Values = Mobs, Default = 1, Multi = false, Text = 'Mobs', Tooltip = ''})
Options.Mobs1:OnChanged(function(S)
    ddd = Options.Mobs1.Value
end)



LeftGroupBox:AddToggle('Autoquest', {Text = 'Auto Quest', Default = false,Tooltip = ''})
Toggles.Autoquest:OnChanged(function(State)
Go = Toggles.Autoquest.Value 
    RunService.Stepped:Connect(function()
        pcall(function()
            if Go then
                Player.Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(11)
            end
        end)
    end)
    spawn(function()
        while wait(.1) and Go do 
            pcall(function()
                local Quest = Player.PlayerGui.Menu.QuestFrame
                if not Quest.Visible then
                    Teleport(QuestBoards:FindFirstChild(Quest1, true).CFrame)
                    wait(1)
                    fireclickdetector(QuestBoards:FindFirstChild(Quest1, true).ClickDetector)
                end
                if Quest.Visible then
                    Teleport(CFrame.new(QuestMarkers[Quest.QuestName.Text].Position + Vector3.new(0, -50, 0)))
                    for i,v in next, Live:GetChildren() do
                        if string.find(Quest.QuestName.Text, v.Name) then
                            v.HumanoidRootPart.CFrame = Player.Character:GetModelCFrame() * CFrame.new(0,0,-3)
                            Equip()
                            Hit(v)
                            if v.Humanoid.Health ~= v.Humanoid.MaxHealth then
                                Humanoid.Health = 0
                            end
                        end
                    end
                end
            end)
        end
    end)
end)
LeftGroupBox:AddDropdown('Que', {Values = Quests, Default = 1, Multi = false, Text = 'Quests1', Tooltip = ''})
Options.Que:OnChanged(function(S)
    Quest1 = S
end)

LeftGroupBox:AddToggle('Tof', {Text = 'Auto Chest', Default = false,Tooltip = ''})
Toggles.Tof:OnChanged(function(State)
Tof = Toggles.Tof.Value 
    RunService.Stepped:Connect(function()
        pcall(function()
            if Tof then
                Player.Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(11)
            end
        end)
    end)
    spawn(function()
        while wait() and Tof do
            pcall(function()
                for i,v in next, Chests:GetChildren() do
                    if v.Transparency == 0 then
                        Teleport(CFrame.new(v.Position + Vector3.new(0,0, 0)))
                        wait(1)
                        firetouchinterest(Player.Character.HumanoidRootPart, v, 0)
                        break
                    end
                end
            end)
        end
    end)
end)

LeftGroupBox:AddToggle('NIG', {Text = 'Auto Skill', Default = false,Tooltip = ''})
Toggles.NIG:OnChanged(function(State)
NIG = Toggles.NIG.Value 
    spawn(function()
        while wait() and NIG do
            pcall(function()
                for i,v in next, {"X", "Z", "C", "V", "R", "E"} do
                    game:GetService("VirtualInputManager"):SendKeyEvent(true,v,false,game,0)
                end
            end)
        end
    end)
end)
LeftGroupBox:AddToggle('FRo', {Text = 'Auto Drop', Default = false,Tooltip = ''})
Toggles.FRo:OnChanged(function(State)
FRo = Toggles.FRo.Value
    spawn(function()
        while wait() and FRo do
            pcall(function()
                for i,v in next, Drops:GetChildren() do
                    firetouchinterest(Player.Character.HumanoidRootPart, v.Handle, 0)
                end
            end)
        end
    end)
end)

LeftGroupBox:AddToggle('RRR', {Text = 'Remove Common Fruits', Default = false,Tooltip = ''})
Toggles.RRR:OnChanged(function(State)
RRR = Toggles.RRR.Value
    spawn(function()
        while wait() and RRR do
            pcall(function()
                removeCommon()
            end)
        end
    end)
end)
LeftGroupBox:AddToggle('TTT', {Text = 'Remove Common Bags', Default = false,Tooltip = ''})
Toggles.TTT:OnChanged(function(State)
TTT = Toggles.TTT.Value
    spawn(function()
        while wait() and TTT do
            pcall(function()
                removeCommonBags()
            end)
        end
    end)
end)

LeftGroupBox:AddToggle('Sex', {Text = 'Remove UnCommon Bags', Default = false,Tooltip = ''})
Toggles.Sex:OnChanged(function(State)
Sex = Toggles.Sex.Value
    spawn(function()
        while wait() and Sex do
            pcall(function()
                removeUnCommonBags()
            end)
        end
    end)
end)

RightGroupBox:AddToggle('Roll', {Text = 'RandomRace', Default = false,Tooltip = ''})
Toggles.Roll:OnChanged(function(State)
Roll = Toggles.Roll.Value 
    spawn(function()
        while wait() and Roll do
            RollRace(Races1)    
        end
    end)
end)
RightGroupBox:AddDropdown('Races', {Values = Races, Default = 1, Multi = false, Text = 'Races', Tooltip = ''})

Options.Races:OnChanged(function()
    Races1 = Options.Races.Value
end)
local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/1201for/V.G-Hub/main/Karrot-Esp"))()
RightGroupBox:AddToggle('ESP1', {Text = 'Esp Toggle', Default = false,Tooltip = ''})
Toggles.ESP1:OnChanged(function(State)
ESP:Toggle(Toggles.ESP1.Value)
end)

RightGroupBox:AddToggle('ESP2', {Text = 'Esp Players', Default = false,Tooltip = ''})
Toggles.ESP2:OnChanged(function(State)
ESP.Players = Toggles.ESP2.Value
end)

RightGroupBox:AddToggle('ESP3', {Text = 'Esp Tracers', Default = false,Tooltip = ''})
Toggles.ESP3:OnChanged(function(State)
ESP.Tracers = Toggles.ESP3.Value
end)

RightGroupBox:AddToggle('ESP4', {Text = 'Esp Names', Default = false,Tooltip = ''})
Toggles.ESP4:OnChanged(function(State)
ESP.EspNames = Toggles.ESP4.Value
end)

RightGroupBox:AddToggle('ESP5', {Text = 'Esp Boxes', Default = false,Tooltip = ''})
Toggles.ESP5:OnChanged(function(State)
ESP.Boxes = Toggles.ESP5.Value
end)


RightGroupBox:AddToggle('SSS1', {Text = 'Walk&Jump', Default =  Toggle,Tooltip = 'This is a tooltip'})
Toggles.SSS1:OnChanged(function(State)
    Toggle = State 
    Toggles.SSS1.Value = Toggle
    Stepped:Connect(function()
        pcall(function()
            if Toggle then
                Player.Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = WalkSpeed
                Player.Character:FindFirstChildWhichIsA("Humanoid").JumpPower = JumpPower
            end 
        end)
    end)
end)

RightGroupBox:AddInput('SSF2', {Default = 'WalkSpeed',Numeric = true,Finished = false,Text = 'WalkSpeed',Tooltip = 'Numbers Only',Placeholder = 'WalkSpeed',})
Options.SSF2:OnChanged(function(State)
    WalkSpeed = State
    Options.SSF2.Value = WalkSpeed
end)

RightGroupBox:AddInput('SSF3', {Default = 'JumpPower',Numeric = true,Finished = false,Text = 'JumpPower',Tooltip = 'Numbers Only',Placeholder = 'JumpPower',})

Options.SSF3:OnChanged(function(State)
    JumpPower = State
    Options.SSF3.Value = JumpPower
end)

RightGroupBox:AddToggle('SSS4', {Text = 'Infinite Jump',Default =  InfiniteJump,Tooltip = 'This is a tooltip', 
})

Toggles.SSS4:OnChanged(function(State)
InfiniteJump = State
Toggles.SSS4.Value = InfiniteJump
UserInputService.JumpRequest:connect(
    function()
        if InfiniteJump then
            Player.Character:FindFirstChildWhichIsA("Humanoid"):ChangeState("Jumping")
        end
    end
)
end)

RightGroupBox:AddToggle('SSS5', {Text = 'N NoClip',Default =  Sex2,Tooltip = 'This is a tooltip'})
Toggles.SSS5:OnChanged(function(State)
    Sex2 = State
    Toggles.SSS5.Value = Sex2
    RunService.Stepped:connect(function(v)
        if noclips then
            pcall(function()
                NoClip2(Player.Character)
            end)
        end
    end)
end)

RightGroupBox:AddToggle('SSS6', {Text = 'H Fly',Default =  Sex,Tooltip = 'Fly By Pressing H'})
Toggles.SSS6:OnChanged(function(State)
Sex = State
Toggles.SSS6.Value = Sex
local Max = 0
local LP = Players.LocalPlayer
local Mouse = LP:GetMouse()
Mouse.KeyDown:connect(
    function(k)
        if k:lower() == "h" and Sex then
            Max = Max + 1
            getgenv().Fly = false
            if Sex then
                local T = LP.Character:FindFirstChild("UpperTorso",true) or LP.Character:FindFirstChild("HumanoidRootPart",true)
                local S = {
                    F = 0,
                    B = 0,
                    L = 0,
                    R = 0
                }
                local S2 = {
                    F = 0,
                    B = 0,
                    L = 0,
                    R = 0
                }
                local SPEED = 5
                local function FLY()
                    getgenv().Fly = true
                    local BodyGyro = Instance.new("BodyGyro", T)
                    local BodyVelocity = Instance.new("BodyVelocity", T)
                    BodyGyro.P = 9e4
                    BodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
                    BodyGyro.cframe = T.CFrame
                    BodyVelocity.velocity = Vector3.new(0, 0, 0)
                    BodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)
                    spawn(
                        function()
                            repeat
                                wait()
                                LP.Character.Humanoid.PlatformStand = true
                                if S.L + S.R ~= 0 or S.F + S.B ~= 0 then
                                    SPEED = 500
                                elseif not (S.L + S.R ~= 0 or S.F + S.B ~= 0) and SPEED ~= 0 then
                                    SPEED = 0
                                end
                                if (S.L + S.R) ~= 0 or (S.F + S.B) ~= 0 then
                                    BodyVelocity.velocity =
                                        ((Workspace.CurrentCamera.CoordinateFrame.lookVector * (S.F + S.B)) +
                                        ((Workspace.CurrentCamera.CoordinateFrame *
                                            CFrame.new(S.L + S.R, (S.F + S.B) * 0.2, 0).p) -
                                            Workspace.CurrentCamera.CoordinateFrame.p)) *
                                        SPEED
                                    S2 = {
                                        F = S.F,
                                        B = S.B,
                                        L = S.L,
                                        R = S.R
                                    }
                                elseif (S.L + S.R) == 0 and (S.F + S.B) == 0 and SPEED ~= 0 then
                                    BodyVelocity.velocity =
                                        ((Workspace.CurrentCamera.CoordinateFrame.lookVector * (S2.F + S2.B)) +
                                        ((Workspace.CurrentCamera.CoordinateFrame *
                                            CFrame.new(S2.L + S2.R, (S2.F + S2.B) * 0.2, 0).p) -
                                            Workspace.CurrentCamera.CoordinateFrame.p)) *
                                        SPEED
                                else
                                    BodyVelocity.velocity = Vector3.new(0, 0.1, 0)
                                end
                                BodyGyro.cframe = Workspace.CurrentCamera.CoordinateFrame
                            until not getgenv().Fly
                            S = {
                                F = 0,
                                B = 0,
                                L = 0,
                                R = 0
                            }
                            S2 = {
                                F = 0,
                                B = 0,
                                L = 0,
                                R = 0
                            }
                            SPEED = 0
                            BodyGyro:destroy()
                            BodyVelocity:destroy()
                            LP.Character.Humanoid.PlatformStand = false
                        end
                    )
                end
                Mouse.KeyDown:connect(
                    function(k)
                        if k:lower() == "w" then
                            S.F = 1
                        elseif k:lower() == "s" then
                            S.B = -1
                        elseif k:lower() == "a" then
                            S.L = -1
                        elseif k:lower() == "d" then
                            S.R = 1
                        end
                    end
                )
                Mouse.KeyUp:connect(
                    function(k)
                        if k:lower() == "w" then
                            S.F = 0
                        elseif k:lower() == "s" then
                            S.B = 0
                        elseif k:lower() == "a" then
                            S.L = 0
                        elseif k:lower() == "d" then
                            S.R = 0
                        end
                    end
                )
                FLY()
                if Max == 2 then
                    getgenv().Fly = false
                    Max = 0
                end
            end
        end
    end
)
end)

RightGroupBox:AddButton('FPS Booster', function()
    for i,v in pairs(game:GetDescendants()) do 
        if v:IsA("Texture") then
            v.Texture = ""
        elseif v:IsA("BasePart") then
            v.Material = Enum.Material.Wood
        end 
    end 
end)

RightGroupBox:AddButton('ServerHop', function() ServerHop() end)
RightGroupBox:AddButton('Rejoin', function() 
    local Success, ErrorMessage = pcall(function()
        Rejoin()
    end)
    if ErrorMessage and not Success then
        warn(ErrorMessage)
    elseif Success and not ErrorMessage then
        print(Success)
    end
end)
-- I set NoUI so it does not show up in the keybinds menu
MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = "Delete", NoUI = true, Text = 'Menu keybind' }) 

Library.ToggleKeybind = Options.MenuKeybind 
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings() 
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' }) 
ThemeManager:SetFolder('Gay Hub virus')
SaveManager:SetFolder("Gay Hub virus/" .. game.PlaceId)
SaveManager:BuildConfigSection(Tabs['UI Settings']) 
ThemeManager:ApplyToTab(Tabs['UI Settings'])
