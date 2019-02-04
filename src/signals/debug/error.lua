local notify = require "src.utils.notify_error"

local in_error = false

local function error(err)
	if in_error then return end

	in_error = true

	notify("Oops, an error happened!", tostring(err))

	in_error = false
end

awesome.connect_signal("debug::error", error)
