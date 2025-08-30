-- Detect LocalPlayer + Character
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

-- Rayfield Setup (you already have this part)
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

-- Check if the character is Chance
if char.Name == "Chance" then
    -- Add Aimbot + 360 Trickshot buttons
    local AimbotToggle = ChanceTab:CreateToggle({
        Name = "Enable Aimbot",
        CurrentValue = false,
        Flag = "ChanceAimbot",
        Callback = function(Value)
            if Value then
                print("Aimbot Enabled for Chance")
                -- put your aimbot logic here
            else
                print("Aimbot Disabled")
            end
        end,
    })

    local TrickshotBtn = ChanceTab:CreateButton({
        Name = "Do 360 Trickshot",
        Callback = function()
            print("Performing 360 trickshot!")
            local hrp = char:WaitForChild("HumanoidRootPart")
            for i = 1, 36 do
                hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(10), 0)
                task.wait()
            end
            -- fire flintlock shot here
        end,
    })
else
    ChanceTab:CreateParagraph({Title = "Notice", Content = "You are not Chance, so these features are disabled."})
end
-- Add Infinite Stamina toggle to your existing window
Window:CreateToggle({
    Name = "Infinite Stamina",
    CurrentValue = false,
    Flag = "InfiniteStamina",
    Callback = function(Value)
        if Value then
            _G.InfiniteStamina = true
            spawn(function()
                while _G.InfiniteStamina do
                    local player = game.Players.LocalPlayer
                    local character = player.Character
                    if character then
                        local humanoid = character:FindFirstChild("Humanoid")
                        if humanoid and humanoid:FindFirstChild("Stamina") then
                            humanoid.Stamina.Value = humanoid.Stamina.MaxValue
                        end
                    end
                    wait(0.1) -- repeat every 0.1 sec
                end
            end)
        else
            _G.InfiniteStamina = false
        end
    end
})
