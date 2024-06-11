local LastSender = 0
local playersInLobby = {}

---------- COMMANDS ----------
RegisterCommand('+usephone', function(source, args)
	NewTextMessage()
end, false)

RegisterCommand('-usephone', function(source, args)
	
end, false)

RegisterCommand('reply', function(source, args)
    local message = table.concat(args, " ")
    local personalID = PlayerPedId()
    TriggerServerEvent('AG_Phone:SendMessage', LastSender, message, personalID)
end, false)
---------- KEP MAPPINGS ----------
RegisterKeyMapping('+usephone', 'Mobile Phone', 'keyboard', 'U')

---------- MESSAGE INPUT DIALOG ----------
function NewTextMessage()
    local input = lib.inputDialog('New Message', {'Player ID', 'Message'})
 
    if not input then return end
    local playerID = input[1]
    local message = input[2]
    local personalID = PlayerPedId()
	TriggerServerEvent('AG_Phone:SendMessage', playerID, message, personalID)
end

---------- EVENTS ----------
RegisterNetEvent('AG_Phone:MessageRecieved')
AddEventHandler('AG_Phone:MessageRecieved', function(sender, senderID, message)
    LastSender = senderID
    PlaySoundFrontend( -1, Config.NotificationSoundName, Config.NotificationSoundSetName, 1)
    TriggerEvent("chatMessage", "^2Text Message ^1(" .. sender .. ")", {0, 0, 0}, "^7" .. message)
end)

RegisterNetEvent('AG_Phone:MessageSent')
AddEventHandler('AG_Phone:MessageSent', function(recipient)
    lib.notify({
        title = 'Message Sent',
        description = 'Your message to ' .. recipient .. ' has been sent!',
        type = 'success'
    })
end)

RegisterNetEvent('AG_Phone:ErrorMessage')
AddEventHandler('AG_Phone:ErrorMessage', function(errorMessage)
    lib.notify({
        title = 'Message Error',
        description = 'Error: ' .. errorMessage,
        type = 'error'
    })
end)

---------- SCRIPT LOAD ----------
print('Using mobile phone script by AbelGaming#9428')