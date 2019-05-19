local awful = require "awful"
local settings = require "src.settings"

return function(s)
	local t = awful.tag.add(#s.tags + 1, {
		screen = s,
		layout = settings.default_layout,
	})

	t:view_only()

	return t
end
