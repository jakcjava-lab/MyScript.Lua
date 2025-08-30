-- Load Rayfield Library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Create Window
local Window = Rayfield:CreateWindow({
   Name = "My Hub",
   LoadingTitle = "Loading My Hub",
   LoadingSubtitle = "by jakcjava-lab",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub configs
      FileName = "MyHubConfig"
   },
   Discord = {
      Enabled = false,
      Invite = "", -- Discord invite code, e.g. "sirius"
      RememberJoins = true
   },
   KeySystem = false, -- Set to true if you want a key system
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

-- Create Tab
local MainTab = Window:CreateTab("Main", 4483362458) -- icon id

-- Create Section
local Section = MainTab:CreateSection("Example Features")

-- Add Button
MainTab:CreateButton({
   Name = "Click Me",
   Callback = function()
      print("Button was clicked!")
   end,
})

-- Add Toggle
MainTab:CreateToggle({
   Name = "Example Toggle",
   CurrentValue = false,
   Flag = "Toggle1",
   Callback = function(Value)
      print("Toggle value is: " .. tostring(Value))
   end,
})
