-- Detect LocalPlayer + Character
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

-- Rayfield Setup
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/mrj500807-beep/Rayfield/main/source.lua"))() -- Only if you don't already have Rayfield loaded
local Window = Rayfield:CreateWindow({
    Name = "Forsaken - Chance Tools",
    LoadingTitle = "Forsaken Hub",
    LoadingSubtitle = "by jakcjava",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "ForsakenHub",
        FileName = "ChanceConfig"
    }
})

-- Add tab for Chance
local ChanceTab = Window:CreateTab("Chance Mode", 4483362458)

-- Only works if you are Chance
if char.Name == "Chance" then
    -- Aimbot Toggle
    ChanceTab:CreateToggle({
        Name = "Enable Aimbot",
        CurrentValue = false,
        Flag = "ChanceAimbot",
        Callback = function(Value)
            if Value then
                print("Aimbot Enabled for Chance")
                -- insert your aimbot logic here
            else
                print("Aimbot Disabled")
            end
        end
    })

    -- 360 Trickshot Button
    ChanceTab:CreateButton({
        Name = "Do 360 Trickshot",
        Callback = function()
            print("Performing 360 Trickshot!")
            local hrp = char:WaitForChild("HumanoidRootPart")
            for i = 1, 36 do
                hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(10), 0)
                task.wait()
            end
            -- fire flintlock shot here
        end
    })
else
    ChanceTab:CreateParagraph({Title = "Notice", Content = "You are not Chance, so these features are disabled."})
end

-- Infinite Stamina Toggle
ChanceTab:CreateToggle({
    Name = "Infinite Stamina",
    CurrentValue = false,
    Flag = "InfiniteStamina",
    Callback = function(Value)
        _G.InfiniteStamina = Value
    end
})

-- Update stamina every frame
local RunService = game:GetService("RunService")
RunService.RenderStepped:Connect(function()
    if _G.InfiniteStamina then
        local character = player.Character
        if character then
            local humanoid = character:FindFirstChild("Humanoid")
            if humanoid and humanoid:FindFirstChild("Stamina") then
                humanoid.Stamina.Value = humanoid.Stamina.MaxValue
            end
        end
    end
end)
