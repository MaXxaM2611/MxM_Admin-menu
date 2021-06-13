fx_version 'bodacious'
game 'gta5'
author 'MaXxaM#0511'
description 'MxM Admin Menu'
version '3.0'


shared_scripts {
    "entityiter.lua",
    'config/shared.lua',
}

client_scripts {
    "entityiter.lua",
    'project/client/MxM_C.lua',
    'client/menu.lua',
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'project/server/MxM_S.lua',
    'config/config_server.lua',
    'server/server.lua',
}

