-- # Global bindings

-- ## Import
local gears = require "gears"
local awful = require "awful"
local hotkeys_popup = require("awful.hotkeys_popup").widget
local menubar = require "menubar"
local settings = require "src.settings"
local mymainmenu = require("src.launcher").mymainmenu
local createworkspace = require "src.utils.workspaces.create"

local modkey = settings.modkey

-- ## Some functions

-- Returns a table with a description and a group.
local function infos(description, group) return {description=description, group=group} end

-- Focus another application
local function focus(x)
	return function () awful.client.focus.byidx(x) end
end

-- Show menu
local function show_menu() mymainmenu:show() end

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

-- ## Bindings

local globalkeys = gears.table.join(
	awful.key({ modkey }, "s", hotkeys_popup.show_help, infos("show help", "awesome")),
	awful.key({ modkey }, "Left", awful.tag.viewprev, infos("view previous", "tag")),
	awful.key({ modkey }, "Right", awful.tag.viewnext, infos("view next", "tag")),
	awful.key({ modkey }, "Escape", awful.tag.history.restore, infos("go back", "tag")),

	awful.key({ modkey }, "j", focus(1), infos("focus next by index", "client")),
	awful.key({ modkey }, "k", focus(-1), infos("focus previous by index", "client")),

	awful.key({ modkey }, "w", show_menu, infos("show main menu", "awesome")),
	awful.key(
		{ modkey }, "KP_Add",
		function()
			createworkspace(awful.screen.focused())
		end,
		infos("create a new workspace", "screen")
	),

	-- Layout manipulation
	awful.key({ modkey, "Shift" }, "j", swap(1), infos("swap with next client by index", "client")),
	awful.key({ modkey, "Shift" }, "k", swap(-1), infos("swap with previous client by index", "client")),

	awful.key({ modkey, "Control" }, "j", focus_relative(1), infos("focus the next screen", "screen")),
	awful.key({ modkey, "Control" }, "k", focus_relative(-1), infos("focus the previous screen", "screen")),

	awful.key({ modkey }, "u", awful.client.urgent.jumpto, infos("jump to urgent client", "client")),
	awful.key({ modkey }, "Tab", last_focused, infos("go back", "client")),

	-- Standard program
	awful.key({ modkey }, "Return", spawn(settings.terminal), infos("open a terminal", "launcher")),

	awful.key({ modkey, "Control" }, "r", awesome.restart, infos("reload awesome", "awesome")),
	awful.key({ "Mod1", "Control" }, "Delete", awesome.quit, infos("quit awesome", "awesome")),

	awful.key({ modkey }, "space", layout(1), infos("select next", "layout")),
	awful.key({ modkey, "Shift" }, "space", layout(-1), infos("select previous", "layout")),

	awful.key({ modkey, "Control" }, "n", restore_minimized, infos("restore minimized", "client")),

	-- Prompt
	awful.key({ modkey }, "r", run_prompt, infos("run prompt", "launcher")),
	awful.key({ modkey }, "p", menubar.show, infos("show the menubar", "launcher")),
	awful.key({ modkey, "Shift" }, "p", menubar.refresh, infos("show the menubar", "launcher"))
)

return globalkeys
