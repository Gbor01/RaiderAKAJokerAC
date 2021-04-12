fx_version 'bodacious'

game 'gta5'

client_scripts {
    'configs/**/*.l*a',
    'client/**/*.l*a',
    
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    '@async/async.lua',
    'configs/*.l*a',
    'server/**/*.l*a',
   
}
 

ui_page "html/ui.html"

files {"html/ui.html", "html/config.js"}




