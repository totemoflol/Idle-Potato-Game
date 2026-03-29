local ShopTab = Window:CreateTab("Shop", "cake-slice") -- Title, Image
local autobuy = false
local ProductionAutoBuyToggle = ShopTab:CreateToggle({
   Name = "Production AutoBuy",
   CurrentValue = false,
   Flag = "ProductionAutoBuy",
   Callback = function(ProductionPotion)
      AutoBuyProductionPotion = ProductionPotion
      task.spawn(function()
         while AutoBuyProductionPotion do
            local args = {
               "potion_production"
            }

            game:GetService("ReplicatedStorage")
               :WaitForChild("Remotes")
               :WaitForChild("PurchaseShopPotato")
               :FireServer(unpack(args))
            task.wait(60) -- change speed if needed
         end
      end)
   end,
})

local autobuyluck = false
local LuckAutoBuyToggle = ShopTab:CreateToggle({
   Name = "Luck AutoBuy",
   CurrentValue = false,
   Flag = "LuckAutoBuy",
   Callback = function(LuckPotion)
      AutoBuyLuckPotion = LuckPotion
      task.spawn(function()
         while AutoBuyLuckPotion do
            local args = {
               "potion_luck"
            }

            game:GetService("ReplicatedStorage")
               :WaitForChild("Remotes")
               :WaitForChild("PurchaseShopPotato")
               :FireServer(unpack(args))
            task.wait(60) -- change speed if needed
         end
      end)
   end,
})

local autobuygolden = false
local GoldenAutoBuyToggle = ShopTab:CreateToggle({
   Name = "GoldenAutoBuy",
   CurrentValue = false,
   Flag = "GoldenAutoBuy",
   Callback = function(GoldenPotion)
      AutoBuyGoldenPotion = GoldenPotion
      task.spawn(function()
         while AutoBuyGoldenPotion do
            local args = {
               "potion_golden"
            }

            game:GetService("ReplicatedStorage")
               :WaitForChild("Remotes")
               :WaitForChild("PurchaseShopPotato")
               :FireServer(unpack(args))
            task.wait(60) -- change speed if needed
         end
      end)
   end,
})
local AutoBuyClickPotion = false
local ClickAutoBuyToggle = ShopTab:CreateToggle({
   Name = "Click AutoBuy",
   CurrentValue = false,
   Flag = "ClickAutoBuy",
   Callback = function(ClickPotion)
      AutoBuyClickPotion = ClickPotion
      task.spawn(function()
         while AutoBuyClickPotion do
            local args = {
               "potion_click"
            }

            game:GetService("ReplicatedStorage")
               :WaitForChild("Remotes")
               :WaitForChild("PurchaseShopPotato")
               :FireServer(unpack(args))
            task.wait(60) -- change speed if needed
         end
      end)
   end,
})

local MysteryPotatoDivider = ShopTab:CreateDivider()

local player = game:GetService("Players").LocalPlayer
local AllowedTaters = getgenv().whitelistedtaters or {}

if AllowedTaters[player.UserId] then
    local EmojiBuying = false

    ShopTab:CreateToggle({
        Name = "Emoji Mystery Potato Auto Buy",
        CurrentValue = false,
        Flag = "EmojiBuy",
        Callback = function(EmojiAutoBuy)
            EmojiBuying = EmojiAutoBuy

            if EmojiBuying then
                task.spawn(function()
                    while EmojiBuying do
                        game:GetService("ReplicatedStorage")
                            :WaitForChild("Remotes")
                            :WaitForChild("PurchaseShopPotato")
                            :FireServer("emoji_mystery_potato")

                        task.wait(60)
                    end
                end)
            end
        end,
    })
end
      

print("Shop Tab Loaded V1.10")