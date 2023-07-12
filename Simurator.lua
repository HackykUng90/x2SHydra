local Player = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Gay Noon", "Synapse")



local Tab = Window:NewTab("Warp")

local Section = Tab:NewSection("Warp")

Section:NewButton("1", "ButtonInfo", function()
    Player.CFrame = CFrame.new(-10280.3135, 3.82143283, 55.0902901, 0.676419914, 1.63782339e-08, -0.736516178, -4.31956826e-09, 1, 1.82703275e-08, 0.736516178, -9.17698095e-09, 0.676419914)
end)

Section:NewButton("2", "ButtonInfo", function()
    Player.CFrame = CFrame.new(-10270.6855, 3.82155442, 602.659119, -0.536696494, -1.36333012e-09, 0.843775392, -2.79489099e-09, 1, -1.61983885e-10, -0.843775392, -2.44519649e-09, -0.536696494)
end)

Section:NewButton("3", "ButtonInfo", function()
    Player.CFrame = CFrame.new(11629.8984, 8.83869457, 91.0130386, -0.99222821, 3.28136238e-08, 0.124431647, 2.73173484e-08, 1, -4.5877254e-08, -0.124431647, -4.21215631e-08, -0.99222821)
end)

Section:NewButton("4", "ButtonInfo", function()
    Player.CFrame = CFrame.new(-10308.0908, 4.01421833, -854.797058, -0.98587358, -1.15368373e-08, -0.167491168, -1.58383795e-08, 1, 2.43463809e-08, 0.167491168, 2.66552416e-08, -0.98587358)
end)

