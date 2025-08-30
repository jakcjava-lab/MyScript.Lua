-- 🟢 Main Tab
local MainTab = Window:CreateTab("Main", 4483362458)
MainTab:CreateSection("Main Features")

-- List of killers
local Killers = {
   ["coolkid"] = true,
   ["1x1x1x1"] = true,
   ["noli"] = true,
   ["jason"] = true,
   ["slasher"] = true,
   ["john doe"] = true,
}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local UIS = game:GetService("UserInputService")

-- Toggle for Aimbot
MainTab:CreateToggle({
   Name = "Killer Aimbot (On Shoot)",
   CurrentValue = false,
   Flag = "KillerAimbot",
   Callback = function(Value)
      getgenv().AimbotEnabled = Value
      print("Killer Aimbot set to: " .. tostring(Value))
   end,
})

-- Aimbot function
local function AimAt(targetPart)
   if targetPart then
      Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetPart.Position)
   end
end

-- Detect mouse click
UIS.InputBegan:Connect(function(input, gp)
   if gp then return end
   if input.UserInputType == Enum.UserInputType.MouseButton1 then
      if getgenv().AimbotEnabled then
         -- Find nearest killer
         local closest, dist = nil, math.huge
         for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and Killers[string.lower(player.Name)] then
               if player.Character and player.Character:FindFirstChild("Head") then
                  local head = player.Character.Head
                  local mag = (head.Position - Camera.CFrame.Position).Magnitude
                  if mag < dist then
                     closest, dist = head, mag
                  end
               end
            end
         end
         -- Aim at nearest killer
         if closest then
            AimAt(closest)
         end
      end
   end
end)
