local awful = require "awful"

local function manage(c)
	local user_position = c.size_hints.user_position
	local program_position = c.size_hints.program_position

	if awesome.startup and not user_position and not program_position then
		awful.placement.no_offscreen(c)
	end
end

client.connect_signal("manage", manage)
