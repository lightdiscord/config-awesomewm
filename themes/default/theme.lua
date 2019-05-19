-- # Default Awesome theme

local lfs = require "lfs"
local theme_assets = require "beautiful.theme_assets"
local xresources = require "beautiful.xresources"
local awful = require "awful"
local gfs = require "gears.filesystem"
local gcolor = require "gears.color"

local dpi = xresources.apply_dpi

local themes_path = gfs.get_configuration_dir() .. "themes/default/"
local layout_path = themes_path .. "layouts/"
local titlebar_path = themes_path .. "titlebar/"

local theme = {}

theme.font          = "sans 10"

local bg_normal     = "#000000A6"
local bg_focus      = "#0D47A1CC"

theme.bg_normal     = bg_normal
theme.bg_focus      = bg_focus
theme.bg_urgent     = "#B71C1CCC"
theme.bg_minimize   = bg_normal
theme.bg_systray    = bg_normal

local fg_normal     = "#ffffff"
local fg_focus      = "#ffffff"

theme.fg_normal     = fg_normal
theme.fg_focus      = fg_focus
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.useless_gap   = dpi(0)
theme.border_width  = dpi(0)
theme.border_normal = "#000000"
theme.border_focus  = "#535d6c"
theme.border_marked = "#91231c"

theme.hotkeys_bg = bg_normal
theme.hotkeys_fg = "#FAFAFA"
theme.hotkeys_label_bg = theme.hotkeys_bg
theme.hotkeys_label_fg = theme.hotkeys_fg
theme.hotkeys_modifiers_fg = "#E0E0E0"
theme.hotkeys_group_margin = dpi(25)
theme.hotkeys_font = "sans 10"
theme.hotkeys_description_font = "sans 8"

local size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(size, fg_normal)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(size, fg_normal)

-- Notifications icon size, it works only after Awesome 4.2
theme.notification_icon_size = dpi(200)

theme.menu_submenu_icon = themes_path .. "submenu.png"
theme.menu_height = dpi(25)
theme.menu_width  = dpi(200)

theme.titlebar_close_button_normal = titlebar_path .. "close_normal.png"
theme.titlebar_close_button_focus  = titlebar_path .. "close_focus.png"

theme.titlebar_minimize_button_normal = titlebar_path .. "minimize_normal.png"
theme.titlebar_minimize_button_focus  = titlebar_path .. "minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = titlebar_path .. "ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = titlebar_path .. "ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = titlebar_path .. "ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = titlebar_path .. "ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = titlebar_path .. "sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = titlebar_path .. "sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = titlebar_path .. "sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = titlebar_path .. "sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = titlebar_path .. "floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = titlebar_path .. "floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = titlebar_path .. "floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = titlebar_path .. "floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = titlebar_path .. "maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = titlebar_path .. "maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = titlebar_path .. "maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = titlebar_path .. "maximized_focus_active.png"

local function fetchFiles(folder)
	local arr = {}

  for v in lfs.dir(folder) do
		if v ~= "." and v ~= ".." and v ~= "readme.md" then
			arr[#arr + 1] = v
		end
	end

  return arr
end

-- TODO: With awesome v4.4, use gears.filesystem.get_random_file_from_dir
theme.wallpaper = function(screen)
	local orientation = screen.geometry.width > screen.geometry.height
		and "landscape"
		or "portrait"

	local path = themes_path .. "wallpapers/" .. orientation .. "/"

	local files = fetchFiles(path)

	if #files == 0 then
		return nil
	else
		return path .. files[math.random(#files)]
	end
end

theme.layout_tile = layout_path .. "tilew.png"
theme.layout_floating  = layout_path .. "floatingw.png"
theme.layout_fairv = layout_path .. "fairvw.png"
theme.layout_dwindle = layout_path .. "dwindlew.png"
theme.layout_max = layout_path .. "maxw.png"
theme.layout_magnifier = layout_path .. "magnifierw.png"
theme.layout_fullscreen = layout_path .. "fullscreenw.png"

theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height, bg_focus, fg_focus)
theme.icon_theme = nil

return theme
