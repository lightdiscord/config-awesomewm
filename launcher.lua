local awful = require('awful')
local beautiful = require('beautiful')
local settings = require('../settings')
local hotkeys_popup = require("awful.hotkeys_popup").widget

local module = {}

module.myawesomemenu = {
   { 'hotkeys', function() return false, hotkeys_popup.show_help end},
   { 'manual', settings.terminal .. ' -e man awesome' },
   { 'edit config', settings.editor_cmd .. ' ' .. awesome.conffile },
   { 'restart', awesome.restart },
   { 'quit', function() awesome.quit() end}
}

module.mymainmenu = awful.menu({ items = {
    { 'awesome', module.myawesomemenu },
    { 'open terminal', terminal }
}})

module.mylauncher = awful.widget.launcher({ 
    image = beautiful.awesome_icon,
    menu = module.mymainmenu
})

return module