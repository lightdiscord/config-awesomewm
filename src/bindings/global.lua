-- # Global bindings

-- ## Import
local gears = require "gears"
local awful = require "awful"
local hotkeys_popup = require("awful.hotkeys_popup").widget
local menubar = require "menubar"
local settings = require "src.settings"
local mainmenu = require "src.launcher"
local newtag = require "src.utils.screen.newtag"

local modkey = settings.modkey

-- ## Some functions

-- Returns a table with a description and a group.
local function infos(description, group) return {description=description, group=group} end

-- Focus another application
local function focus(x)
	return function () awful.client.focus.byidx(x) end
end

-- Show menu
local function show_menu() mainmenu:show() end

-- Swap applications indexes
local function swap(x)
	return function () awful.client.swap.byidx(x) end
end

-- Focus another screen relatively
local function focus_relative(x)
	return function () awful.screen.focus_relative(x) end
end

-- Go to last focused application
local function last_focused()
	awful.client.focus.history.previous()
	if client.focus then
		client.focus:raise()
	end
end

-- Spawn an application
local function spawn(application)
	return function () awful.spawn(application) end
end

-- Iterate over layouts
local function layout(x)
	return function () awful.layout.inc(x) end
end

-- Restore a minimized client
local function restore_minimized()
	local c = awful.client.restore()

	if c then
		client.focus = c
		c:raise()
	end
end

-- Show run prompt
local function run_prompt() awful.screen.focused().mypromptbox:run() end

-- View tag
local function view_tag(i)
	return function()
		local screen = awful.screen.focused()
		local tag = screen.tags[i]
		if tag then
			tag:view_only()
		end
	end
end

-- Toggle tag display
local function toggle_tag(i)
	return function()
		local screen = awful.screen.focused()
		local tag = screen.tags[i]
		if tag then
			awful.tag.viewtoggle(tag)
		end
	end
end

-- Move client to tag
local function move_to_tag(i)
	return function()
		if client.focus then
			local tag = client.focus.screen.tags[i]
			if tag then
				client.focus:move_to_tag(tag)
			end
		end
	end
end

-- Toggle tag on focused client
local function toggle_client_tag(i)
	return function()
		if client.focus then
			local tag = client.focus.screen.tags[i]
			if tag then
				client.focus:toggle_tag(tag)
			end
		end
	end
end

local tag_bindings = gears.table.join();

for i = 1, 10 do
	tag_bindings = gears.table.join(
		tag_bindings,

		awful.key({ modkey }, "#" .. i + 9, view_tag(i), infos("view tag #" .. i, "tag")),
		awful.key({ modkey, "Shift" }, "#" .. i + 9, move_to_tag(i), infos("move focused client to tag #" .. i, "tag"))
	)
end

-- ## Bindings

return gears.table.join(
	tag_bindings,

	-- Audio
	awful.key({ }, "XF86AudioMute", spawn("amixer set Master toggle"), infos("(un)mute master volume", "audio")),
	awful.key({ }, "XF86AudioRaiseVolume", spawn("amixer set Master 5%+"), infos("raise master volume", "audio")),
	awful.key({ }, "XF86AudioLowerVolume", spawn("amixer set Master 5%-"), infos("lower master volume", "audio")),

	-- Brightness
	awful.key({ }, "XF86MonBrightnessUp", spawn("light -A 5"), infos("increase brightness", "brightness")),
	awful.key({ }, "XF86MonBrightnessDown", spawn("light -U 5"), infos("decrease brightness", "brightness")),

	awful.key({ modkey }, "s", hotkeys_popup.show_help, infos("show help", "awesome")),
	awful.key({ modkey }, "Left", awful.tag.viewprev, infos("view previous", "tag")),
	awful.key({ modkey }, "Right", awful.tag.viewnext, infos("view next", "tag")),
	awful.key({ modkey }, "Escape", awful.tag.history.restore, infos("go back", "tag")),

	awful.key({ modkey }, "j", focus(1), infos("focus next by index", "client")),
	awful.key({ modkey }, "k", focus(-1), infos("focus previous by index", "client")),

	awful.key({ modkey }, "w", show_menu, infos("show main menu", "awesome")),

	-- Layout manipulation
	awful.key({ modkey, "Shift" }, "Left", swap(1), infos("swap with next client by index", "client")),
	awful.key({ modkey, "Shift" }, "Right", swap(-1), infos("swap with previous client by index", "client")),

	awful.key({ modkey, "Control" }, "Left", focus_relative(1), infos("focus the next screen", "screen")),
	awful.key({ modkey, "Control" }, "Right", focus_relative(-1), infos("focus the previous screen", "screen")),

	awful.key({ modkey }, "Tab", last_focused, infos("go back", "client")),

	-- Standard program
	awful.key({ modkey }, "Return", spawn(settings.terminal), infos("open a terminal", "launcher")),

	awful.key({ modkey, "Control" }, "n", restore_minimized, infos("restore minimized", "client")),

	-- Prompt
	awful.key({ modkey }, "space", menubar.show, infos("show the menubar", "launcher"))
	-- awful.key({ modkey, "Shift" }, "p", menubar.refresh, infos("show the menubar", "launcher"))
)
