--// Services
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local Camera = game:GetService("Workspace").CurrentCamera
local LocalPlayer = Players.LocalPlayer

--// Killer list
local Killers = {
   ["coolkidd"] = true,
   ["1x1x1x1"] = true,
   ["noli"] = true,
   ["jason"] = true,
   ["slasher"] = true,
   ["john doe"] = true,
}

--// Rayfield Loader
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
   Name = "Forsaken GUI",
   LoadingTitle = "Forsaken Script",
   LoadingSubtitle = "By jakcjava",
   ConfigurationSaving = {
      Enabled = false
   },
   Discord = {
      Enabled = false
   }
})

--// Main Tab
local MainTab = Window:CreateTab("Main", 4483362458)

-- Aimbot Toggle
MainTab:CreateToggle({
   Name = "Aimbot (Killer Only)",
   CurrentValue = false,
   Flag = "AimbotToggle",
   Callback = function(Value)
      getgenv().AimbotEnabled = Value
      print("Aimbot Enabled: " .. tostring(Value))
   end,
})

-- Silent Trickshot Toggle
MainTab:CreateToggle({
   Name = "360 Silent Trickshot",
   CurrentValue = false,
   Flag = "SilentTrickshot",
   Callback = function(Value)
      getgenv().SilentTrickshot = Value
      print("Silent Trickshot Enabled: " .. tostring(Value))
   end,
})

-- Trickshot Chance Slider
MainTab:CreateSlider({
   Name = "Trickshot Chance %",
   Range = {0, 100},
   Increment = 5,
   Suffix = "%",
   CurrentValue = 50,
   Flag = "TrickshotChance",
   Callback = function(Value)
      getgenv().TrickshotChance = Value
   end,
})

--// Aim Function
function AimAt(part)
   if part and part.Position then
      Camera.CFrame = CFrame.new(Camera.CFrame.Position, part.Position)
   end
end

--// Shooting Listener
UIS.InputBegan:Connect(function(input, gp)
   if gp then return end
   if input.UserInputType == Enum.UserInputType.MouseButton1 then
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

      if closest then
         if getgenv().SilentTrickshot then
            if math.random(1,100) <= (getgenv().TrickshotChance or 50) then
               local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
               if hrp then
                  for i = 1, 12 do -- 12x30° = full spin
                     hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(30), 0)
                     task.wait(0.02)
                  end
               end
               AimAt(closest)
            else
               AimAt(closest)
            end
         elseif getgenv().AimbotEnabled then
            AimAt(closest)
         end
      end
   end
end)
