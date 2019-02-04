local awful = require "awful"
local gears = require "gears"

local function toggle(c)
	if c == client.focus then
		c.minimized = true
	else
		c.minimized = false

		if not c:isvisible() and c.first_tag then
			c.first_tag:view_only()
		end

		client.focus = c
		c:raise()
	end
end

local function focus(x)
	return function () awful.client.focus.byidx(x) end
end

local tasklist_buttons = gears.table.join(
	awful.button({ }, 1, toggle),
	awful.button({ }, 3, require("src.utils.client_menu_toggle_fn")()),
	awful.button({ }, 4, focus(1)),
	awful.button({ }, 5, focus(-1))
)

return tasklist_buttons
