local wibox = require "wibox"
local awful = require "awful"
local createworkspace = require "src.utils.workspaces.create"

local widget = wibox.widget {
	widget = wibox.widget.textbox,
	paddings = 2,
	markup = '+',
	align = 'center',
	valign = 'center'
}

widget:connect_signal("button::press", function(_, _, _, button)
	if (button == 1) then
		createworkspace(mouse.screen)
	end
end)

return widget
