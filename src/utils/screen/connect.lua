local awful = require "awful"
local beautiful = require "beautiful"
local wibox = require "wibox"
local gears = require "gears"
local settings = require "src.settings"

local tasklist_buttons = require "src.bindings.tasklist_buttons"
local taglist_buttons = require "src.bindings.taglist_buttons"
local wallpaperize = require "src.utils.screen.wallpaperize"

local function layoutinc(n)
	return function () awful.layout.inc(n) end
end

return function(s)
	wallpaperize(s)

	awful.tag({"1", "2", "3", "4", "5", "6", "7", "8", "9", "10"}, s, settings.default_layout)

	local mylayoutbox = awful.widget.layoutbox(s)
	mylayoutbox:buttons(gears.table.join(
		awful.button({ }, 1, layoutinc(1)),
		awful.button({ }, 3, layoutinc(-1)),
		awful.button({ }, 4, layoutinc(1)),
		awful.button({ }, 5, layoutinc(-1))
	))

	s.mypromptbox = awful.widget.prompt()

	local mywibox = awful.wibar({ position = "top", screen = s })
	mywibox:setup {
		layout = wibox.layout.align.horizontal,
		{
			layout = wibox.layout.fixed.horizontal,
			awful.widget.taglist {
				screen = s,
				filter = awful.widget.taglist.filter.all,
				buttons = taglist_buttons
			},
			awful.widget.tasklist {
				screen = s,
				filter = awful.widget.tasklist.filter.currenttags,
				buttons = tasklist_buttons,
				widget_template = {
					{
						{
							id = "icon_role",
							widget = wibox.widget.imagebox
						},
						left = 5,
						right = 5,
						widget = wibox.container.margin
					},
					id = "background_role",
					widget = wibox.container.background
				}
			}
		},
		{ layout = wibox.layout.flex.horizontal },
		{
			layout = wibox.layout.fixed.horizontal,
			wibox.widget.systray(),
			{
				layout = wibox.layout.fixed.horizontal,
				wibox.container.margin(wibox.widget.imagebox(beautiful.icon_keyboard), 5, 5, 5, 5),
				awful.widget.keyboardlayout()
			},
			{
				layout = wibox.layout.fixed.horizontal,
				wibox.container.margin(wibox.widget.imagebox(beautiful.icon_calendar), 5, 5, 5, 5),
				wibox.widget.textclock("%d.%m.%Y")
			},
			{
				layout = wibox.layout.fixed.horizontal,
				wibox.container.margin(wibox.widget.imagebox(beautiful.icon_clock), 5, 5, 5, 5),
				wibox.widget.textclock("%H:%M")
			},
			mylayoutbox,
		},
	}
end
