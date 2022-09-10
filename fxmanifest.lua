fx_version "adamant"

-- Protection / Support
-- discord.gg/EkwWvFS

game "gta5"

client_scripts {
    'config.lua',
    'client.lua'
}

shared_script 'config.lua'

server_scripts {
	"server.lua",
    'config.lua',
    '@mysql-async/lib/MySQL.lua'
}



