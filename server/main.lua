RegisterServerEvent('AG_Phone:SendMessage')
AddEventHandler('AG_Phone:SendMessage', function(playerID, message, personalID)
    local sender = GetPlayerName(source)
    local recipient = GetPlayerName(playerID)
    TriggerClientEvent('AG_Phone:MessageRecieved', playerID, sender, source, message)
    TriggerClientEvent('AG_Phone:MessageSent', source, recipient)

    if Config.EnableDiscordLog then
        PerformHttpRequest(
            Config.DiscordWebHook, 
            function(err, text, headers) end, 
            'POST', 
            json.encode(
                {
                    username = 'Phone System', 
                    content = sender .. " (" .. source .. ")** has just sent a text message. \n\n**Recipient:** *" .. recipient .. " (" .. playerID .. ")* \n**Message: *" .. message .. "*" }
                ), 
                { ['Content-Type'] = 'application/json' }
        )
    end
end)