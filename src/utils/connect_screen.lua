local awful = require "awful"
local wibox = require "wibox"
local gears = require "gears"
local settings = require "src.settings"

local tasklist_buttons = require "src.bindings.tasklist_buttons"
local taglist_buttons = require "src.bindings.taglist_buttons"
local set_wallpaper = require "src.utils.set_wallpaper"

local widgets = {
	textclock = wibox.widget.textclock(),
	keyboardlayout = awful.widget.keyboardlayout()
}

local function layoutinc(n)
	return function () awful.layout.inc(n) end
end

local function connect(s)
	set_wallpaper(s)

	awful.tag({"1"}, s, settings.default_layout)

	local mylayoutbox = awful.widget.layoutbox(s)
	mylayoutbox:buttons(gears.table.join(
		awful.button({ }, 1, layoutinc(1)),
		awful.button({ }, 3, layoutinc(-1)),
		awful.button({ }, 4, layoutinc(1)),
		awful.button({ }, 5, layoutinc(-1))
	))

	local mywibox = awful.wibar({ position = "top", screen = s })
	mywibox:setup {
		layout = wibox.layout.align.horizontal,
		{
			layout = wibox.layout.fixed.horizontal,
			awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons),
			require("src.widgets.screen.newtag")(s),
			awful.widget.prompt(),
		},
		awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons),
		{
			layout = wibox.layout.fixed.horizontal,
			widgets.keyboardlayout,
			wibox.widget.systray(),
			widgets.textclock,
			mylayoutbox,
		},
	}
end

return connect
