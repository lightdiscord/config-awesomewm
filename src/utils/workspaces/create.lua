local awful = require "awful"

return function(s)
	local t = awful.tag.add(#s.tags + 1, {
		screen = s,
		-- TODO: Add a setting to get the default layout
		layout = awful.layout.layouts[1],
	})

	t:view_only()

	return t
end
