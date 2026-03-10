local CoreGui = game:GetService("CoreGui")

local old = CoreGui:FindFirstChild("Rayfield")
if old then
    old:Destroy()
end

local s1 = Instance.new("Sound", workspace)
s1.SoundId = "rbxassetid://5793681247"

local s2 = Instance.new("Sound", workspace)
s2.SoundId = "rbxassetid://219332153"
s2.Looped = true

s1:Play()
s1.Ended:Connect(function()
    s2:Play()
end)
Version = "V2.0"
print(Version)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
-- Window
local Window = Rayfield:CreateWindow({
   Name = "Potato Script V2.0",
   Icon = "venetian-mask", -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Idle Potato Game (T)",
   LoadingSubtitle = "by Totemoflol",
   ShowText = "Tato", -- for mobile users to unhide Rayfield, change if you'd like
   Theme = "Serenity", -- Check https://docs.sirius.menu/rayfield/configuration/themes

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
local Label = SellTab:CreateLabel("Auto Sell", 4483362458, Color3.fromRGB(255, 255, 255), false) -- Title, Icon, Color, IgnoreTheme
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

-- Toggle
local selling = false

local SellAllToggle = SellTab:CreateToggle({
    Name = "Auto Sell Golden Potatoes",
    CurrentValue = false,
    Flag = "AutoSellGolden",
    Callback = function(state)
        selling = state
    end,
})

-- Persistent selling loop
task.spawn(function()
    local player = game:GetService("Players").LocalPlayer
    local gui = player.PlayerGui:WaitForChild("PotatoGameGUI")
        .Background.ClickerArea.ClickerContainer.CurrencyFrame
    local goldLabel = gui:WaitForChild("GoldenRow"):WaitForChild("GoldenCount")
    local r = game:GetService("ReplicatedStorage"):WaitForChild("Remotes")

    -- Cash label path (Stats Area)
    local cashLabel = player.PlayerGui:WaitForChild("PotatoGameGUI")
        .Background.StatsArea.StatsScrollFrame.StatsContainer
        :WaitForChild("SectionCard_Balances")
        :WaitForChild("SB_Cash")

    -- Function to parse numbers with M/B suffix
    local function parseText(text)
        local num = tonumber(string.match(text, "%d+%.?%d*")) or 0
        if string.find(text, "B") then
            return num * 1e9
        elseif string.find(text, "M") then
            return num * 1e6
        else
            return num
        end
    end

    while true do
        if selling then
            -- Sell all golden potatoes
            local gold = tonumber(goldLabel.Text) or 0
            if gold > 0 then
                r.SellGoldenPotatoes:FireServer(gold)
            end

            -- Read cash from ContentText (optional debug)
            local cash = parseText(cashLabel.ContentText)
            -- print("Current cash:", cash)
        end
        task.wait(0.1)
    end
end)

-- Auto Tab
local AutoTab = Window:CreateTab("Auto", "circuit-board") -- Title, Image
local AutoClickLabel = AutoTab:CreateLabel("Auto Clicker", 4483362458, Color3.fromRGB(255, 255, 255), false) -- Title, Icon, Color, IgnoreTheme
-- Auto Click
local Clicking = false
local AutoClickToggle = AutoTab:CreateToggle({
    Name = "Auto Click (0.02s)",
    CurrentValue = false,
    Flag = "AutoClickToggle",
    Callback = function(Clicks)
        Clicking = Clicks

        task.spawn(function()
            while Clicks do
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
local AscendLabel = RebirthTab:CreateLabel("Ascension Upgrades", 4483362458, Color3.fromRGB(255, 255, 255), false) -- Title, Icon, Color, IgnoreTheme
local AscendToggle = RebirthTab:CreateToggle({
    Name = "Abundance Ascension",
    CurrentValue = false,
    Flag = "AutoAscend",
    Callback = function(abundance)
        local abundant = abundance
        spawn(function()
            while abundant do
                local args = {
                    "abundance"
                }
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PerformAscension"):FireServer(unpack(args))
                task.wait(60) -- waits 60 seconds (1 minute)
            end
        end)
    end,
})

local PrestigeAscend = false

local PrestigeAscendToggle = RebirthTab:CreateToggle({
   Name = "Prestige Ascension",
   CurrentValue = false,
   Flag = "PrestigeAscension",
   Callback = function(PrestigeA)
      PrestigeAscend = PrestigeA

      while PrestigeA do
         local args = {
            "prestige"
         }

         game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PerformAscension"):FireServer(unpack(args))

         task.wait(60)
      end
   end,
})

local Divider = RebirthTab:CreateDivider()
local PrestigeSection = RebirthTab:CreateSection("Prestige")
local PrestigeLabel = RebirthTab:CreateLabel("Auto Prestige", 4483362458, Color3.fromRGB(255, 255, 255), false) -- Title, Icon, Color, IgnoreTheme
local Prestiging = false
local AutoPrestigeToggle = RebirthTab:CreateToggle({
    Name = "Auto Prestige (32s)",
    CurrentValue = false,
    Flag = "AutoPrestigeToggle",
    Callback = function(APrestige)
        Prestiging = APrestige

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

-- Anti-AFK (runs instantly when script runs)

local Players = game:GetService("Players")
local player = Players.LocalPlayer

if getconnections then
    for _, connection in pairs(getconnections(player.Idled)) do
        if connection.Disable then
            connection:Disable()
        elseif connection.Disconnect then
            connection:Disconnect()
        end
    end
else
    player.Idled:Connect(function()
        game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
end

--Macro Tab
local MacroTab = Window:CreateTab("Macro", "bitcoin") -- Title, Image
local Section = MacroTab:CreateSection("Prestige Macro 15-30")
local StableMacroLabel = MacroTab:CreateLabel("Stable Macro", 4483362458, Color3.fromRGB(255, 255, 255), false) -- Title, Icon, Color, IgnoreTheme

local Remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes")
local MPrestige = Remotes:WaitForChild("PerformPrestige")
local MGoldenSell = Remotes:WaitForChild("SellGoldenPotatoes")
local MWisdom = Remotes:WaitForChild("PurchaseClickUpgrade"):FireServer("grandfathers_wisdom")
local MEnergy = Remotes:WaitForChild("PurchaseClickUpgrade"):FireServer("infinite_energy")
local MOmni = Remotes:WaitForChild("PurchaseClickUpgrade"):FireServer("omnipotato_blessing")
local MHarvest = Remotes:WaitForChild("PurchaseClickUpgrade"):FireServer("transcendent_harvest")
local MGalactic = Remotes:WaitForChild("PurchaseClickUpgrade"):FireServer("galactic_harvest")


local macroing = false
local MacroV1Toggle = MacroTab:CreateToggle({
    Name = "Macro V1",
    CurrentValue = false,
    Flag = "MacroV1",
    Callback = function(MacroV1)
        macroing = MacroV1

        task.spawn(function()
            while macroing do
               -- Prestige                  
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PerformPrestige"):FireServer()
                task.wait(5)
                  
               -- 200K Sell (1)
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SellGoldenPotatoes"):FireServer(200000)
                task.wait(0.5)
                  
               -- Wisdom 1 (2)
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PurchaseClickUpgrade"):FireServer("grandfathers_wisdom")
                task.wait(0.5)
                  
               -- 1M Sell (3)
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SellGoldenPotatoes"):FireServer(1000000)
                task.wait(1)

               -- Wisdom 2 (4)
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PurchaseClickUpgrade"):FireServer("grandfathers_wisdom")
                task.wait(2)

               -- 28M Sell (5)
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SellGoldenPotatoes"):FireServer(28000000)
                task.wait(1)

               -- Energy 1 (6)
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PurchaseClickUpgrade"):FireServer("infinite_energy")
                task.wait(1)
                  
               -- 100M Sell And Energy 2 (7)
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SellGoldenPotatoes"):FireServer(100000000)
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PurchaseClickUpgrade"):FireServer("infinite_energy")
                task.wait(3)
               
               -- 300M Sell And Energy 3 (8)
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SellGoldenPotatoes"):FireServer(300000000)
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PurchaseClickUpgrade"):FireServer("infinite_energy")
                task.wait(3)

               -- 1B Sell And Omni 1 (9)
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SellGoldenPotatoes"):FireServer(1000000000)
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PurchaseClickUpgrade"):FireServer("omnipotato_blessing")
                task.wait(4)
                  
               -- 1.8B Sell And Omni 2 (10)
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SellGoldenPotatoes"):FireServer(1800000000)
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PurchaseClickUpgrade"):FireServer("omnipotato_blessing")
                task.wait(8)

                -- 14B Final Sell (11)  
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SellGoldenPotatoes"):FireServer(14000000000)
                task.wait(1)
            end
        end)
    end,
})


local ksmacro = false

local MacroV1Toggle = MacroTab:CreateToggle({
    Name = "KS Macro V1",
    CurrentValue = false,
    Flag = "KSMacroV1",
    Callback = function(KSMacro1)
        ksmacro = KSMacro1

        task.spawn(function()
            while KSMacro1 do
               -- Prestige                  
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PerformPrestige"):FireServer()
                task.wait(5)
                  
               -- 200K Sell (1)
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SellGoldenPotatoes"):FireServer(200000)
                task.wait(0.5)
                  
               -- Wisdom 1 (2)
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PurchaseClickUpgrade"):FireServer("grandfathers_wisdom")
                task.wait(0.5)
                  
               -- 1M Sell (3)
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SellGoldenPotatoes"):FireServer(1000000)
                task.wait(1)

               -- Wisdom 2 (4)
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PurchaseClickUpgrade"):FireServer("grandfathers_wisdom")
                task.wait(2)

               -- 28M Sell (5)
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SellGoldenPotatoes"):FireServer(28000000)
                task.wait(1)

               -- Energy 1 (6)
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PurchaseClickUpgrade"):FireServer("infinite_energy")
                task.wait(1)
                  
               -- 100M Sell And Energy 2 (7)
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SellGoldenPotatoes"):FireServer(100000000)
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PurchaseClickUpgrade"):FireServer("infinite_energy")
                task.wait(3)
               
               -- 300M Sell And Energy 3 (8)
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SellGoldenPotatoes"):FireServer(300000000)
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PurchaseClickUpgrade"):FireServer("infinite_energy")
                task.wait(3)

               -- 1B Sell And Omni 1 (9)
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SellGoldenPotatoes"):FireServer(1000000000)
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PurchaseClickUpgrade"):FireServer("omnipotato_blessing")
                task.wait(4)
                  
               -- 1.8B Sell And Omni 2 (10)
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SellGoldenPotatoes"):FireServer(1800000000)
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PurchaseClickUpgrade"):FireServer("omnipotato_blessing")
                task.wait(8)

                -- 8B Final Sell (11)  
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SellGoldenPotatoes"):FireServer(8000000000)
                task.wait(1)
            end
        end)
    end,
})

local SuperHumanMacroDivider = MacroTab:CreateDivider()
local SuperHumanMacroLabel = MacroTab:CreateLabel("SuperHuman Macro", 4483362458, Color3.fromRGB(255, 255, 255), false) -- Title, Icon, Color, IgnoreTheme

local superhumanmacro = false
local MacroV1Toggle = MacroTab:CreateToggle({
    Name = "SuperHumanMacro V1",
    CurrentValue = false,
    Flag = "SuperHumanMacroV1",
    Callback = function(MicroMacroV1)
        superhumanmacro = MicroMacroV1

        task.spawn(function()
            while MicroMacroV1 do
               -- Prestige                  
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PerformPrestige"):FireServer()
                task.wait(2.6)
                  
               -- 245K Sell (1)
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SellGoldenPotatoes"):FireServer(245_000)
                task.wait(0.05)
                  
               -- Wisdom 1 (2)
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PurchaseClickUpgrade"):FireServer("grandfathers_wisdom")
                task.wait(0.8)
                  
               -- 428.7K Sell (3)
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SellGoldenPotatoes"):FireServer(428_700)
                task.wait(0.05)

               -- Wisdom 2 (4)
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PurchaseClickUpgrade"):FireServer("grandfathers_wisdom")
                task.wait(2.9)

               -- 140M Sell (5)
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SellGoldenPotatoes"):FireServer(140_000_000)
                task.wait(0.05)

               -- Energy 1 (6)
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PurchaseClickUpgrade"):FireServer("infinite_energy")
                task.wait(0.3)
                  
               -- 150M Sell And Energy 2 (7)
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SellGoldenPotatoes"):FireServer(150_000_000)
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PurchaseClickUpgrade"):FireServer("infinite_energy")
                task.wait(0.6)
               
               -- 300M Sell And Energy 3 (8)
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SellGoldenPotatoes"):FireServer(300_000_000)
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PurchaseClickUpgrade"):FireServer("infinite_energy")
                task.wait(2)

               -- 2.86B Sell And Omni 1 (9)
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SellGoldenPotatoes"):FireServer(2_870_000_000)
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PurchaseClickUpgrade"):FireServer("omnipotato_blessing")
                task.wait(2)
                  
               -- 4B Sell And Omni 2 (10)
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SellGoldenPotatoes"):FireServer(4_000_000_000)
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PurchaseClickUpgrade"):FireServer("omnipotato_blessing")
                task.wait(2)
               
               -- 8B Sell And Harvest 1 (11)
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SellGoldenPotatoes"):FireServer(8_000_000_000)
                local args = {
	            "transcendent_harvest"
                }
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PurchaseClickUpgrade"):FireServer(unpack(args))
                task.wait(3.6)
               
               -- 27.83B Sell And Harvest 2 (12)
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SellGoldenPotatoes"):FireServer(27_830_000_000)
                local args = {
             	"transcendent_harvest"
                }
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PurchaseClickUpgrade"):FireServer(unpack(args))
                task.wait(0.05)

			   -- Galactic 1
				local args = {
                "galactic_harvest"
                }
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PurchaseClickUpgrade"):FireServer(unpack(args))
				task.wait(2)

			   -- 55.67B Sell And Galactic 2
				game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SellGoldenPotatoes"):FireServer(40_670_000_000)
				local args = {
                "galactic_harvest"
                }
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PurchaseClickUpgrade"):FireServer(unpack(args))
				task.wait(11)
               
               -- 300B Final Sell (13)  
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SellGoldenPotatoes"):FireServer(300_000_000_000)
                task.wait(0.5)
            end
        end)
    end,
})


local MiscTab = Window:CreateTab("Misc", 4483362458) -- Title, Image
local Players = game:GetService("Players")
local NotificationContainer = Players.LocalPlayer.PlayerGui:WaitForChild("PotatoGameGUI"):WaitForChild("NotificationContainer")
local NoNotifToggle = MiscTab:CreateToggle({
   Name = "Disable Notifications",
   CurrentValue = false,
   Flag = "DisableNotifications", -- A flag is the identifier for the configuration file; make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(DisableNotifications)
			NotificationContainer.Visible = not DisableNotifications
   end,
})
Rayfield:LoadConfiguration()

-- Auto re-execute after teleport (like Infinite Yield)

local queue = queue_on_teleport or queueteleport or (syn and syn.queue_on_teleport)

if queue then
    queue('loadstring(game:HttpGet("https://raw.githubusercontent.com/totemoflol/Idle-Potato-Game/refs/heads/main/MainScript.lua"))()')
end
