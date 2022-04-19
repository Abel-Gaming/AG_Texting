---------- COMMANDS ----------
RegisterCommand('+usephone', function(source, args)
	TriggerEvent('AG_Phone:MainMenu')
end, false)

RegisterCommand('-usephone', function(source, args)
	
end, false)

---------- KEP MAPPINGS ----------
RegisterKeyMapping('+usephone', 'Mobile Phone', 'keyboard', 'U')

---------- INTERNAL EVENTS ----------
RegisterNetEvent('AG_Phone:MainMenu')
AddEventHandler('AG_Phone:MainMenu', function()
	TriggerEvent("nh-context:createMenu", {
        {
            header = "------------------- Mobile Phone -------------------",
        },
        {
            header = "Send Text",
            context = "Send a text message",
            event = "AG_Phone:SendText",
            image = "",
            args = {1,2}
        }
    })
end)

RegisterNetEvent('AG_Phone:SendText', function()
	local keyboard, playerID, message = exports["nh-keyboard"]:Keyboard({
        header = "Send Message", 
        rows = {"Player ID", "Message"}
    })
    if keyboard ~= nil then
        if playerID and message then
			local personalID = PlayerPedId()
			TriggerServerEvent('AG_Phone:SendMessage', playerID, message, personalID)
        end
    end
end)

---------- EXTERNAL EVENTS ----------
RegisterNetEvent('AG_Phone:MessageRecieved')
AddEventHandler('AG_Phone:MessageRecieved', function(sender, senderID, message)
    -- Play sound
    PlayDeferredSoundFrontend(Config.NotificationSoundName, Config.NotificationSoundSetName)

	-- Get the ped headshot image.
    local handle = RegisterPedheadshot(senderID)
    
	-- Check to make sure the headshot is ready
	while not IsPedheadshotReady(handle) or not IsPedheadshotValid(handle) do
        Citizen.Wait(0)
    end

	-- Get the TXD from the headshot
    local txd = GetPedheadshotTxdString(handle)

    -- Add the notification text
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(message)

    -- Set the notification icon, title and subtitle.
    local title = sender
    local subtitle = "Private Message"
    local iconType = 0
    local flash = false
    EndTextCommandThefeedPostMessagetext(txd, txd, flash, iconType, title, subtitle)

    -- Draw the notification
    local showInBrief = true
    local blink = false
    EndTextCommandThefeedPostTicker(blink, showInBrief)
    
    -- Cleanup
    UnregisterPedheadshot(handle)
end)

RegisterNetEvent('AG_Phone:MessageSent')
AddEventHandler('AG_Phone:MessageSent', function(recipient)
    SetNotificationTextEntry('STRING')
	AddTextComponentSubstringPlayerName('~g~[SUCCESS]~w~ Your message to ~b~' .. recipient .. '~w~ has been sent!')
	DrawNotification(false, true)
end)

RegisterNetEvent('AG_Phone:ErrorMessage')
AddEventHandler('AG_Phone:ErrorMessage', function(errorMessage)
	SetNotificationTextEntry('STRING')
	AddTextComponentSubstringPlayerName('~r~[ERROR]~w~ ' .. errorMessage)
	DrawNotification(false, true)
	TriggerEvent('nh-context:cancelMenu')
end)

---------- SCRIPT LOAD ----------
print('Using mobile phone script by AbelGaming#9428')