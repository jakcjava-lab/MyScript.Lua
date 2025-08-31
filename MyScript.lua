--// Local player setup
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

--// Vars
local killers = {
    ["C00LKIDD"] = true,
    ["1x1x1x1"] = true,
    ["Slasher"] = true,
    ["Noli"] = true,
    ["John Doe"] = true
}
local fovRadius = 100

--// Find killer
local function getKillerTarget(radius)
    local closest, dist = nil, radius
    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr ~= player and killers[plr.Name] and plr.Character and plr.Character:FindFirstChild("Head") then
            local mag = (hrp.Position - plr.Character.Head.Position).Magnitude
            if mag < dist then
                dist = mag
                closest = plr
            end
        end
    end
    return closest
end

--// Create mobile button GUI
local ScreenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
ScreenGui.ResetOnSpawn = false

local Button = Instance.new("TextButton")
Button.Parent = ScreenGui
Button.Size = UDim2.new(0, 80, 0, 40)
Button.Position = UDim2.new(0.02, 0, 0.5, 0) -- Left side middle
Button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.Text = "360 🔫"
Button.Font = Enum.Font.GothamBold
Button.TextSize = 16
Button.AutoButtonColor = true
Button.BorderSizePixel = 2
Button.BackgroundTransparency = 0.2

--// Make button draggable
local UIS = game:GetService("UserInputService")
local dragging, dragInput, dragStart, startPos

Button.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Button.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Button.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        Button.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

--// Button Action: 360 + Aim Killer + Shoot
Button.MouseButton1Click:Connect(function()
    -- 360 spin
    for i = 1, 36 do
        hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(10), 0)
        task.wait(0.01)
    end

    -- Aim at killer
    local target = getKillerTarget(fovRadius)
    if target and target.Character:FindFirstChild("Head") then
        hrp.CFrame = CFrame.new(hrp.Position, target.Character.Head.Position)
        print("Locked onto killer: " .. target.Name)

        -- Shoot if tool equipped
        local tool = player.Character:FindFirstChildOfClass("Tool")
        if tool and tool:FindFirstChild("Activate") then
            tool:Activate()
            print("Shot fired at " .. target.Name)
        else
            print("No weapon/tool equipped!")
        end
    else
        print("No killer found in range")
    end
end)
