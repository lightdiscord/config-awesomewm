local awful = require('awful')
local beautiful = require('beautiful')
local menubar = require('menubar')

local settings = require('./settings')
local notify_error = require('./utils/notify_error')

require('awful.autofocus')
require('awful.hotkeys_popup.keys')

if awesome.startup_errors then
    notify_error('Oops, there were errors during startup!', awesome.startup_errors)
end

do
    require('./signals/debug/error')
end

beautiful.init(awful.util.getdir('config') .. '/themes/default/theme.lua')

awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.fair,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.magnifier,
}

menubar.utils.terminal = settings.terminal

local connect_screen = require('./utils/connect_screen')

awful.screen.connect_for_each_screen(connect_screen)

local globalkeys = require('./bindings/global')
local mousekeys = require('./bindings/mouse')
local rules = require('./rules')

root.keys(globalkeys)
root.buttons(mousekeys)
awful.rules.rules = rules

require('./signals/property/geometry')
require('./signals/manage')
require('./signals/request/titlebars')
require('./signals/mouse/enter')
require('./signals/focus')
require('./signals/unfocus')
