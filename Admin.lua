local PremiumTab = Window:CreateTab("Premium", "gem") -- Title, Image
local AdminFeaturesLabel = PremiumTab:CreateLabel("Premium", 4483362458, Color3.fromRGB(255, 255, 255), false) -- Title, Icon, Color, IgnoreTheme

local player = game:GetService("Players").LocalPlayer
local AllowedTaters = getgenv().whitelistedtaters or {}

if AllowedTaters[player.UserId] then
    local EmojiBuying = false

    PremiumTab:CreateToggle({
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
