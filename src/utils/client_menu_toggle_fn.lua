local awful = require "awful"

return function()
	local instance = nil

	return function ()
		if instance and instance.wibox.visible then
			instance:hide()
			instance = nil
		else
			instance = awful.menu.clients({
				theme = {
					width = 250
				}
			})
		end
	end
end
