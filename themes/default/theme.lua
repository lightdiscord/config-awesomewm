-- # Default Awesome theme

local lfs = require "lfs"
local theme_assets = require "beautiful.theme_assets"
local xresources = require "beautiful.xresources"
local awful = require "awful"
local gfs = require "gears.filesystem"
local gcolor = require "gears.color"
local gstring = require "gears.string"

local filter = require "lib.fun.filter"
local collect = require "lib.fun.collect"

local dpi = xresources.apply_dpi
local themes_path = gfs.get_configuration_dir() .. "themes/default/"
local layout_path = themes_path .. "layouts/"
local titlebar_path = themes_path .. "titlebar/"
local icons_path = themes_path .. "icons/"
local bg_normal = "#000000A6"
local bg_focus = "#0D47A1CC"
local fg_normal = "#ffffff"
local fg_focus = "#ffffff"
local hotkeys_bg = bg_normal
local hotkeys_fg = "#fafafa"
local size = dpi(4)
local menu_height = dpi(25)

local function fetchFiles(folder)
	local function predicate(filename)
		return gstring.endswith(filename, ".png") or gstring.endswith(filename, ".jpg")
	end

	return collect(filter(predicate)(lfs.dir(folder)))
end

-- TODO(v4.4): use gears.filesystem.get_random_file_from_dir
local function wallpaper(screen)
	local orientation = screen.geometry.width > screen.geometry.height
		and "landscape"
		or "portrait"

	local path = themes_path .. "wallpapers/" .. orientation .. "/"
	local files = fetchFiles(path)

	return #files > 0 and path .. files[math.random(#files)] or nil
end

return {
	font = "sans 10",
	bg_normal = bg_normal,
	bg_focus = bg_focus,
	bg_urgent = "#B71C1CCC",
	bg_minimize = bg_normal,
	bg_systray = bg_normal,

	fg_normal = fg_normal,
	fg_focus = fg_focus,
	fg_urgent = "#ffffff",
	fg_minimize = "#ffffff",

	titlebar_bg_focus = bg_normal,

	useless_gap = dpi(0),
	border_width = dpi(0),
	border_normal = "#000000",
	border_focus = "#535d6c",
	border_marked = "#91231c",

	hotkeys_bg = hotkeys_bg,
	hotkeys_fg = hotkeys_fg,
	hotkeys_label_bg = hotkeys_bg,
	hotkeys_label_fg = hotkeys_fg,
	hotkeys_modifiers_fg = "#E0E0E0",
	hotkeys_group_margin = dpi(25),
	hotkeys_font = "sans 10",
	hotkeys_description_font = "sans 8",

	taglist_squares_sel = theme_assets.taglist_squares_sel(size, fg_normal),
	taglist_squares_unsel = theme_assets.taglist_squares_unsel(size, fg_normal),

	notification_max_width = dpi(600),
	notification_max_height = dpi(100),

	notification_icon_size = dpi(100),

	menu_submenu_icon = themes_path .. "submenu.png",
	menu_height = menu_height,
	menu_width = dpi(200),

	titlebar_close_button_normal = titlebar_path .. "close_normal.png",
	titlebar_close_button_focus = titlebar_path .. "close_focus.png",
	titlebar_minimize_button_normal = titlebar_path .. "minimize_normal.png",
	titlebar_minimize_button_focus = titlebar_path .. "minimize_focus.png",
	titlebar_ontop_button_normal_inactive = titlebar_path .. "ontop_normal_inactive.png",
	titlebar_ontop_button_focus_inactive  = titlebar_path .. "ontop_focus_inactive.png",
	titlebar_ontop_button_normal_active = titlebar_path .. "ontop_normal_active.png",
	titlebar_ontop_button_focus_active = titlebar_path .. "ontop_focus_active.png",
	titlebar_sticky_button_normal_inactive = titlebar_path .. "sticky_normal_inactive.png",
	titlebar_sticky_button_focus_inactive = titlebar_path .. "sticky_focus_inactive.png",
	titlebar_sticky_button_normal_active = titlebar_path .. "sticky_normal_active.png",
	titlebar_sticky_button_focus_active = titlebar_path .. "sticky_focus_active.png",
	titlebar_floating_button_normal_inactive = titlebar_path .. "floating_normal_inactive.png",
	titlebar_floating_button_focus_inactive = titlebar_path .. "floating_focus_inactive.png",
	titlebar_floating_button_normal_active = titlebar_path .. "floating_normal_active.png",
	titlebar_floating_button_focus_active = titlebar_path .. "floating_focus_active.png",
	titlebar_maximized_button_normal_inactive = titlebar_path .. "maximized_normal_inactive.png",
	titlebar_maximized_button_focus_inactive = titlebar_path .. "maximized_focus_inactive.png",
	titlebar_maximized_button_normal_active = titlebar_path .. "maximized_normal_active.png",
	titlebar_maximized_button_focus_active = titlebar_path .. "maximized_focus_active.png",

	wallpaper = wallpaper,

	layout_tile = layout_path .. "tilew.png",
	layout_floating = layout_path .. "floatingw.png",
	layout_fairv = layout_path .. "fairvw.png",
	layout_dwindle = layout_path .. "dwindlew.png",
	layout_max = layout_path .. "maxw.png",
	layout_magnifier = layout_path .. "magnifierw.png",
	layout_fullscreen = layout_path .. "fullscreenw.png",

	icon_clock = icons_path .. "clock-regular.svg",
	icon_calendar = icons_path .. "calendar-alt-regular.svg",
	icon_keyboard = icons_path .. "keyboard-regular.svg",

	awesome_icon = theme_assets.awesome_icon(menu_height, bg_focus, fg_focus),
	icon_theme = nil,
}
