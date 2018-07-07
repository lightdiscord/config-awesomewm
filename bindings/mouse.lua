-- # Mouse bindings

-- ## Imports
local gears = require('gears')
local awful = require('awful')
local mymainmenu = require('../launcher').mymainmenu

-- ## Some functions

-- Toggle menu
local function toggle_menu() mymainmenu:toggle() end

-- ## Bindings

local mousekeys = gears.table.join(
    -- Toggle menu on right clic
    awful.button({}, 3, toggle_menu),

    -- Next tag on scroll up
    awful.button({}, 4, awful.tag.viewnext),

    -- Previous tag on scroll down
    awful.button({}, 5, awful.tag.viewprev)
)

-- Return buttons
return mousekeys
