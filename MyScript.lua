-- // Forsaken Auto Aim GUI (Rayfield Style)

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Forsaken | Chance One Shoot",
   LoadingTitle = "Forsaken Script",
   LoadingSubtitle = "by jakcjava",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "ForsakenScripts",
      FileName = "ChanceAutoAim"
   },
   Discord = {
      Enabled = false,
      Invite = "",
      RememberJoins = false
   },
   KeySystem = false
})

-- // Tab
local MainTab = Window:CreateTab("Main", 4483362458)
local Section = MainTab:CreateSection("Abilities")

-- // Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- // Killer List
local KillerNames = {
    ["C00LKIDD"] = true,
    ["1x1x1x1"] = true,
    ["John Doe"] = true,
    ["Slasher"] = true,
    ["Noli"] = true,
}

-- // Find Killer
local function GetKiller()
    for _, player in pairs(Players:GetPlayers()) do
        if KillerNames[player.Name] then
            local char = player.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                return char.HumanoidRootPart
            end
        end
    end
    return nil
end

-- // Spin + Lock
local function SpinAndLock()
    local killer = GetKiller()
    if killer then
        -- Quick 360 spin
        for i = 1, 36 do
            Camera.CFrame = Camera.CFrame * CFrame.Angles(0, math.rad(10), 0)
            task.wait(0.01)
        end
        -- Snap to killer
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, killer.Position)
    end
end

-- // Rayfield Button
MainTab:CreateButton({
   Name = "One Shoot Auto Aim",
   Callback = function()
       SpinAndLock()
   end,
})
