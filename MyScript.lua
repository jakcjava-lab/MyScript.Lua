-- Load Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Create Window
local Window = Rayfield:CreateWindow({
   Name = "My Hub",
   LoadingTitle = "Loading My Hub",
   LoadingSubtitle = "by jakcjava-lab",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "MyHubConfig"
   },
   Discord = {
      Enabled = false,
      Invite = "",
      RememberJoins = true
   },
   KeySystem = false,
   KeySettings = {
      Title = "My Hub Key",
      Subtitle = "Key System",
      Note = "Join Discord for key!",
      FileName = "MyHubKey",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"ABC123"}
   }
})

-- 🟢 First Tab
local MainTab = Window:CreateTab("Main", 4483362458) -- icon id
MainTab:CreateSection("Main Features")

MainTab:CreateButton({
   Name = "Click Me",
   Callback = function()
      print("Main Tab Button clicked!")
   end,
})

-- 🔵 Second Tab
local FunTab = Window:CreateTab("Fun", 4483362458)
FunTab:CreateSection("Fun Stuff")

FunTab:CreateToggle({
   Name = "Funny Toggle",
   CurrentValue = false,
   Flag = "Toggle1",
   Callback = function(Value)
      print("Funny Toggle is now " .. tostring(Value))
   end,
})

-- 🔴 Third Tab
local SettingsTab = Window:CreateTab("Settings", 4483362458)
SettingsTab:CreateSection("Adjustments")

SettingsTab:CreateSlider({
   Name = "WalkSpeed",
   Range = {16, 100},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "Slider1",
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})
