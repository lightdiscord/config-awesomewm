local beautiful = require('beautiful')

local function focus(client)
	client.border_color = beautiful.border_focus
end

client.connect_signal('focus', focus)
