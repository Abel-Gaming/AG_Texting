RegisterServerEvent('AG_Phone:SendMessage')
AddEventHandler('AG_Phone:SendMessage', function(playerID, message, personalID)
    for k,v in ipairs(GetPlayers()) do
        local id = v
        if v == playerID then
            local sender = GetPlayerName(source)
            local recipient = GetPlayerName(playerID)
            TriggerClientEvent('AG_Phone:MessageRecieved', playerID, sender, personalID, message)
            TriggerClientEvent('AG_Phone:MessageSent', source, recipient)
        end
    end
end)