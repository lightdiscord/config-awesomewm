local awful = require "awful"
local beautiful = require "beautiful"
local settings = require "src.settings"
local hotkeys_popup = require("awful.hotkeys_popup").widget

local module = {}

module.myawesomemenu = {
	{ "hotkeys", function() return false, hotkeys_popup.show_help end},
	{ "restart", awesome.restart },
	{ "quit", function() awesome.quit() end}
}

module.mymainmenu = awful.menu({ items = {
	{ "awesome", module.myawesomemenu },
	{ "open terminal", terminal }
}})

module.mylauncher = awful.widget.launcher({
	image = beautiful.awesome_icon,
	menu = module.mymainmenu
})

return module
