-- Spin + Lock + Shoot function
local function spinAndLock()
    -- 360 spin
    for i = 1, 36 do
        if hrp then
            hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(10), 0)
        end
        task.wait(0.01)
    end

    -- Find nearest killer
    local target = getKillerTarget(fovRadius)
    if target and target.Character and target.Character:FindFirstChild("Head") then
        hrp.CFrame = CFrame.new(hrp.Position, target.Character.Head.Position)
        print("Locked onto killer: " .. target.Name)

        -- Shoot if tool equipped
        local tool = player.Character and player.Character:FindFirstChildOfClass("Tool")
        if tool and tool:FindFirstChild("Activate") then
            tool:Activate()
            print("Shot fired at " .. target.Name)
        else
            print("No weapon equipped!")
        end
    else
        print("No killer found in range")
    end
end

-- Bind to GUI button
Button.MouseButton1Click:Connect(spinAndLock)

-- Bind to key (RightBracket) for "One Shoot Skill"
local UIS = game:GetService("UserInputService")
UIS.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.RightBracket then
        spinAndLock()
    end
end)
