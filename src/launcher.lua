local awful = require "awful"
local beautiful = require "beautiful"
local gcolor = require "gears.color"
local settings = require "src.settings"
local hotkeys_popup = require("awful.hotkeys_popup").widget
local wibox = require "wibox"

local awesomemenu = {
	{ "Hotkeys", function() return false, hotkeys_popup.show_help end},
	{ "Restart", awesome.restart },
	{ "Quit", function() awesome.quit() end}
}

return awful.menu({
	items = {
		{ "Awesome menu", awesomemenu },
		{
			"Reload wallpaper",
			function()
				local screen = awful.screen.focused()
				require("src.utils.screen.wallpaperize")(screen)
			end
		}
	}
})
