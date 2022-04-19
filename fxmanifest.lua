fx_version 'cerulean'
game 'gta5'
description 'Abel Gaming - Standalone phone system for FiveM'
author 'Abel Gaming'
version '1.0'
lua54 'yes'

server_scripts {
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'config.lua',
	'client/main.lua'
}

dependencies {
    'nh-context', -- https://github.com/nerohiro/nh-context
    'nh-keyboard' -- https://github.com/nerohiro/nh-keyboard
}

escrow_ignore {
    'config.lua'
}