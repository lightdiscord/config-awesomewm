local gears = require "gears"
local awful = require "awful"

local function toggle_menu() require("src.launcher").mymainmenu:toggle() end

local mousekeys = gears.table.join(
	awful.button({}, 3, toggle_menu),
	awful.button({}, 4, awful.tag.viewnext),
	awful.button({}, 5, awful.tag.viewprev)
)

return mousekeys
