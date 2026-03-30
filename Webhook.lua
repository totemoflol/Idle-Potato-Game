if getgenv().whitelistedtaters[player.UserId] then
    local WebhookTab = Window:CreateTab("Webhook", 4483362458)

    local messageText = player.Name .. " just executed the script!"

    WebhookTab:CreateInput({
        Name = "Webhook Message",
        PlaceholderText = "Type message here",
        RemoveTextAfterFocusLost = false,
        Callback = function(Webhook)
            messageText = Webhook
        end,
    })

    WebhookTab:CreateButton({
        Name = "Send Webhook",
        Callback = function()
            local formatted = "`" .. messageText .. "`"

            local data = {
                ["content"] = formatted
            }

            local success, result = pcall(function()
                return requestFunc({
                    Url = url,
                    Method = "POST",
                    Headers = {
                        ["Content-Type"] = "application/json"
                    },
                    Body = HttpService:JSONEncode(data)
                })
            end)

            if success then
                Rayfield:Notify({
                    Title = "Webhook",
                    Content = "Message sent",
                    Duration = 3,
                    Image = 4483362458,
                })
            else
                Rayfield:Notify({
                    Title = "Webhook Error",
                    Content = tostring(result),
                    Duration = 5,
                    Image = 4483362458,
                })
            end
        end,
    })
end