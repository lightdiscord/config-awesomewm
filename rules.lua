local beautiful = require('beautiful')
local awful = require('awful')

local clientkeys = require('./bindings/clientkeys')
local clientbuttons = require('./bindings/clientbuttons')

local rules = {
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
			placement = awful.placement.no_overlap + awful.placement.no_offscreen
		}
	},

	{
		rule_any = {
			instance = {
				'DTA',
				'copyq',
			},

			class = {
				'Arandr',
				'Gpick',
				'Kruler',
				'MessageWin',
				'Sxiv',
				'Wpa_gui',
				'pinentry',
				'veromix',
				'xtightvncviewer'
			},

			name = {
				'Event Tester',
			},

			role = {
				'AlarmWindow',
				'pop-up',
			}
		},

		properties = {
			floating = true
		}
	},

	{
		rule_any = {
			type = {
				'normal',
				'dialog'
			}
		},
		properties = {
			titlebars_enabled = true
		}
	},
}

return rules
