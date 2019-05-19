math.randomseed(os.time())

local awful = require "awful"
local beautiful = require "beautiful"
local menubar = require "menubar"

-- TODO: Settings shouldn"t be in the sources
local settings = require "src.settings"
local notify_error = require "src.utils.notify_error"

require "awful.autofocus"
require "awful.hotkeys_popup.keys"

if awesome.startup_errors then
	notify_error("Oops, there were errors during startup!", awesome.startup_errors)
end

do
	require "src.signals.debug.error"
end

beautiful.init(require("themes.default.theme"))

awful.layout.layouts = {
	awful.layout.suit.tile,
	awful.layout.suit.floating,
	awful.layout.suit.fair,
	awful.layout.suit.spiral.dwindle,
	awful.layout.suit.max,
	awful.layout.suit.magnifier,
}

menubar.utils.terminal = settings.terminal
awful.screen.connect_for_each_screen(require("src.utils.screen.connect"))
root.keys(require("src.bindings.global"))
root.buttons(require("src.bindings.mouse"))
awful.rules.rules = require "src.rules"

require "src.signals.property.geometry"
require "src.signals.manage"
require "src.signals.request.titlebars"
require "src.signals.mouse.enter"
require "src.signals.focus"
require "src.signals.unfocus"
