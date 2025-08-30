-- Load correct Rayfield GUI
local success, Rayfield = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/mrj500807-beep/Rayfield/main/source.lua", true))()
end)

if not success then
    warn("Failed to load Rayfield GUI")
    return
end

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

local Window = Rayfield:CreateWindow({
    Name = "Forsaken - Chance Tools",
    LoadingTitle = "Forsaken Hub",
    LoadingSubtitle = "by jakcjava",
    ConfigurationSaving = {Enabled = true, FolderName = "ForsakenHub", FileName = "ChanceConfig"}
})

local ChanceTab = Window:CreateTab("Chance Mode", 4483362458)

if char.Name == "Chance" then
    ChanceTab:CreateToggle({
        Name = "Enable Aimbot",
        CurrentValue = false,
        Flag = "ChanceAimbot",
        Callback = function(Value)
            if Value then
                print("Aimbot Enabled for Chance")
            else
                print("Aimbot Disabled")
            end
        end,
    })

    ChanceTab:CreateButton({
        Name = "Do 360 Trickshot",
        Callback = function()
            for i = 1, 36 do
                hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(10), 0)
                task.wait()
            end
        end,
    })
else
    ChanceTab:CreateParagraph({Title = "Notice", Content = "You are not Chance, so these features are disabled."})
end
