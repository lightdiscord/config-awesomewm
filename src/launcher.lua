local awful = require "awful"
local beautiful = require "beautiful"
local gcolor = require "gears.color"
local settings = require "src.settings"
local hotkeys_popup = require("awful.hotkeys_popup").widget
local wibox = require "wibox"

local module = {}

module.myawesomemenu = {
	{ "hotkeys", function() return false, hotkeys_popup.show_help end},
	{ "restart", awesome.restart },
	{ "quit", function() awesome.quit() end}
}

module.mymainmenu = awful.menu({ items = {
	{ "awesome", module.myawesomemenu },
	{ "reload wallpaper", function()
		local screen = awful.screen.focused()

		require("src.utils.set_wallpaper")(screen)
	end}
}})

module.mylauncher = awful.widget.launcher({
	image = beautiful.launcher_icon,
	menu = module.mymainmenu,
})

return module
