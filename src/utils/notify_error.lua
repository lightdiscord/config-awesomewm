local naughty = require "naughty"

local function throw (title, text)
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = title,
		text = text
	})
end

return throw
