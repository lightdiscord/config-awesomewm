local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')

local mylauncher = require('../launcher').mylauncher

local tasklist_buttons = require('../bindings/tasklist_buttons')
local taglist_buttons = require('../bindings/taglist_buttons')

local mytextclock = wibox.widget.textclock()
local mykeyboardlayout = awful.widget.keyboardlayout()

local set_wallpaper = require('./utils/set_wallpaper')

local function layoutinc(n)
    return function () awful.layout.inc(n) end
end

local function connect(s)
    set_wallpaper(s)

    awful.tag({ 
        '1', '2', '3', '4', '5', '6', '7', '8', '9' 
    }, s, awful.layout.layouts[1])

    local buttons = gears.table.join(
        awful.button({ }, 1, layoutinc(1)),
        awful.button({ }, 3, layoutinc(-1)),
        awful.button({ }, 4, layoutinc(1)),
        awful.button({ }, 5, layoutinc(-1))
    )

    s.mypromptbox = awful.widget.prompt()
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(buttons)
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)
    s.mywibox = awful.wibar({ position = 'top', screen = s })

    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        {
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist,
        {
            layout = wibox.layout.fixed.horizontal,
            mykeyboardlayout,
            wibox.widget.systray(),
            mytextclock,
            s.mylayoutbox,
        },
    }

end

return connect