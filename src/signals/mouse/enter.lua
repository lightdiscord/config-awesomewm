local awful = require "awful"

local function enter(c)
	local layout = awful.layout.get(c.screen)
	local magnifier = awful.layout.suit.magnifier

	if layout ~= magnifier and awful.client.focus.filter(c) then
		client.focus = c
	end
end

client.connect_signal("mouse::enter", enter)
