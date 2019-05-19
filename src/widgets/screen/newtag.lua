local wibox = require "wibox"
local awful = require "awful"
local newtag = require "src.utils.screen.newtag"

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
			newtag(s)
		end
	end)

	return widget
end
