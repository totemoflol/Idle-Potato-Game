local ShopTab = Window:CreateTab("Shop", 4483362458) -- Title, Image
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
