local beautiful = require "beautiful"
local awful = require "awful"
local clientkeys = require "src.bindings.clientkeys"
local clientbuttons = require "src.bindings.clientbuttons"

return {
	{
		rule = { },
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = clientkeys,
			buttons = clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen,
			maximized = false,
			maximized_vertical = false,
			maximized_horizontal = false
		},
	},

	{
		rule_any = {
			class = {
				"pinentry",
			},
		},

		properties = {
			floating = true
		}
	},

	{
		rule_any = {
			type = {
				"normal",
				"dialog"
			}
		},
		properties = {
			titlebars_enabled = true
		}
	},
}
