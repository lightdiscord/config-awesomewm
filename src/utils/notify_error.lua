local naughty = require "naughty"

return function(title, text)
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = title,
		text = text
	})
end
