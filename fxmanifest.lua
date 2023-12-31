fx_version 'adamant'
game 'gta5'
lua54 'yes'
author 'noway07'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
}

client_scripts {
    'client.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua',
}

dependency {
    'ox_lib',
}