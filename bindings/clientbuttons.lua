local gears = require('gears')
local awful = require('awful')

local modkey = require('../settings').modkey

local function focus(c)
	client.focus = c
	c:raise()
end

local clientbuttons = gears.table.join(
	awful.button({ }, 1, focus),
	awful.button({ modkey }, 1, awful.mouse.client.move),
	awful.button({ modkey }, 3, awful.mouse.client.resize)
)

return clientbuttons
