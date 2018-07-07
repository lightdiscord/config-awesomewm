local beautiful = require('beautiful')

local function unfocus(client)
    client.border_color = beautiful.border_normal
end

client.connect_signal('unfocus', unfocus)