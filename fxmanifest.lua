fx_version 'cerulean'
game 'gta5'
description 'Abel Gaming - Standalone messaging phone system for FiveM'
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

shared_script '@ox_lib/init.lua'