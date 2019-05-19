local awful = require "awful"
local beautiful = require "beautiful"
local gcolor = require "gears.color"
local settings = require "src.settings"
local hotkeys_popup = require("awful.hotkeys_popup").widget
local wibox = require "wibox"

local awesomemenu = {
	{ "hotkeys", function() return false, hotkeys_popup.show_help end},
	{ "restart", awesome.restart },
	{ "quit", function() awesome.quit() end}
}

return awful.menu({
	items = {
		{ "awesome", awesomemenu },
		{
			"reload wallpaper",
			function()
				local screen = awful.screen.focused()

				require("src.utils.screen.wallpaperize")(screen)
			end
		}
	}
})
