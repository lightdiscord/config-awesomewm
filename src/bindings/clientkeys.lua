local gears = require "gears"
local awful = require "awful"
local gmath = require "gears.math"
local createworkspace = require "src.utils.workspaces.create"

local modkey = require("src.settings").modkey

local function infos(description)
	return {description = description, group = "client"}
end

local function toggle_fullscreen(c)
	c.fullscreen = not c.fullscreen
	c:raise()
end

local function close(c)
	c:kill()
end

local function move_to_master(c)
	c:swap(awful.client.getmaster())
end

local function move_to_screen(c)
	c:move_to_screen()
end

local function toggle_ontop(c)
	c.ontop = not c.ontop
end

local function minimize(c)
	c.minimize = true
end

local function toggle_maximize(vertical, horizontal)
	return function(c)
		if vertical and horizontal then
			c.maximized = not c.maximized
		elseif vertical then
			c.maximized_vertical = not c.maximized_vertical
		elseif horizontal then
			c.maximized_horizontal = not c.maximized_horizontal
		end

		c:raise()
	end
end

local function move_to_relative_tag(i)
	return function(c)
		local s = c.screen

		c:move_to_tag(s.tags[gmath.cycle(#s.tags, s.selected_tag.index + i)])
	end
end

local clientkeys = gears.table.join(
	awful.key({modkey}, "f", toggle_fullscreen, infos("toggle fullscreen")),
	awful.key({modkey, "Shift"}, "c", close, infos("close")),
	awful.key({modkey, "Control"}, "space", awful.client.floating.toggle, infos("toggle floating")),
	awful.key({modkey, "Control"}, "Return", move_to_master, infos("move to master")),
	awful.key({modkey}, "o", move_to_screen, infos("move to screen")),
	awful.key({modkey}, "t", toggle_ontop, infos("toggle keep on top")),
	awful.key({modkey}, "n", minimize, infos("minimize")),
	awful.key({modkey}, "m", toggle_maximize(true, true), infos("(un)maximize")),
	awful.key({modkey, "Control"}, "m", toggle_maximize(true, false), infos("(un)maximize vertically")),
	awful.key({modkey, "Shift"}, "m", toggle_maximize(false, true), infos("(un)maximize horizontally")),
	awful.key({modkey, "Shift"}, "Left", move_to_relative_tag(-1), infos("move client to previous tag", "tag")),
	awful.key({modkey, "Shift"}, "Right", move_to_relative_tag(1), infos("move client to next tag", "tag")),
	awful.key(
		{modkey, "Shift"},
		"KP_Add",
		function(c)
			local t = createworkspace(c.screen)
			c:move_to_tag(t)
		end,
		infos("move client to a new tag", "client")
	)
)

return clientkeys
