local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
-- Window
local Window = Rayfield:CreateWindow({
   Name = "Potato Script",
   Icon = "venetian-mask", -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Idle Potato Game (T)",
   LoadingSubtitle = "by Totemoflol",
   ShowText = "Tato", -- for mobile users to unhide Rayfield, change if you'd like
   Theme = "AmberGlow", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   ToggleUIKeybind = "K", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from emitting warnings when the script has a version mismatch with the interface.

   ConfigurationSaving = {
      Enabled = true,
      FolderName = "Tato Script", -- Create a custom folder for your hub/game
      FileName = "Tato Hub"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include Discord.gg/. E.g. Discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the Discord every time they load it up
   },

   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "Key Up You Bot",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique, as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"TTT", "ttt"} -- List of keys that the system will accept, can be RAW file links (pastebin, github, etc.) or simple strings ("hello", "key22")
   }
})

-- Auto Sell Tab
local SellTab = Window:CreateTab("Sell", 4483362458) -- Title, Image
-- VARIABLES
local Amount = 1
local Delay = 1
local Running = false
-- INPUT: Amount Of Gold Potatoes
local AmountInput = SellTab:CreateInput({
   Name = "Amount Of Gold Potatoes",
   CurrentValue = "",
   PlaceholderText = "Enter Amount",
   RemoveTextAfterFocusLost = false,
   Flag = "AmountInput",
   Callback = function(Value)
      Amount = tonumber(Value) or 0
   end,
})
-- INPUT: Delay
local DelayInput = SellTab:CreateInput({
   Name = "Delay (seconds)",
   CurrentValue = "",
   PlaceholderText = "Enter Delay",
   RemoveTextAfterFocusLost = false,
   Flag = "DelayInput",
   Callback = function(Value)
      Delay = tonumber(Value) or 0
   end,
})
-- TOGGLE: Auto Sell
local AutoSellToggle = SellTab:CreateToggle({
   Name = "Auto Sell",
   CurrentValue = false,
   Flag = "AutoSellToggle",
   Callback = function(Value)
      Running = Value

      while Running do
         local args = {
            Amount
         }

         game:GetService("ReplicatedStorage")
            :WaitForChild("Remotes")
            :WaitForChild("SellGoldenPotatoes")
            :FireServer(unpack(args))

         task.wait(Delay)
      end
   end,
})

local Section = SellTab:CreateSection("Section Example")

-- Auto Tab
local AutoTab = Window:CreateTab("Auto", "circuit-board") -- Title, Image
-- Auto Click
local Clicking = false
local AutoClickToggle = AutoTab:CreateToggle({
    Name = "Auto Click (0.02s)",
    CurrentValue = false,
    Flag = "AutoClickToggle",
    Callback = function(Value)
        Clicking = Value

        task.spawn(function()
            while Clicking do
                game:GetService("ReplicatedStorage")
                    :WaitForChild("Remotes")
                    :WaitForChild("PerformClick")
                    :FireServer()

                task.wait(0.02)
            end
        end)
    end,
})

 -- Rebirth Tab    
local RebirthTab = Window:CreateTab("Rebirths", "aperture") -- Title, Image
local PrestigeSection = RebirthTab:CreateSection("Ascension")
local AscendToggle = RebirthTab:CreateToggle({
    Name = "Abundance Ascension",
    CurrentValue = false,
    Flag = "AutoAscend",
    Callback = function(Value)
        local running = Value
        spawn(function()
            while running do
                local args = {
                    "abundance"
                }
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PerformAscension"):FireServer(unpack(args))
                task.wait(60) -- waits 60 seconds (1 minute)
            end
        end)
    end,
})

local Divider = RebirthTab:CreateDivider()
local PrestigeSection = RebirthTab:CreateSection("Prestige")
local Prestiging = false
local AutoPrestigeToggle = RebirthTab:CreateToggle({
    Name = "Auto Prestige (32s)",
    CurrentValue = false,
    Flag = "AutoPrestigeToggle",
    Callback = function(Value)
        Prestiging = Value

        task.spawn(function()
            while Prestiging do
                game:GetService("ReplicatedStorage")
                    :WaitForChild("Remotes")
                    :WaitForChild("PerformPrestige")
                    :FireServer()

                task.wait(32)
            end
        end)
    end,
})


Rayfield:LoadConfiguration()
