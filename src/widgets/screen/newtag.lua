local wibox = require "wibox"
local awful = require "awful"
local createworkspace = require "src.utils.workspaces.create"

return function(s)
	local widget = wibox.widget {
		widget = wibox.widget.textbox,
		paddings = 2,
		markup = '+',
		align = 'center',
		valign = 'center'
	}

	widget:connect_signal("button::press", function(_, _, _, button)
		if (button == 1) then
			createworkspace(s)
		end
	end)

	return widget
end
