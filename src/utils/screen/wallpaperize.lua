local gears = require "gears"
local beautiful = require "beautiful"

return function (s)
	if not beautiful.wallpaper then return end

	local wallpaper = beautiful.wallpaper

	if type(wallpaper) == "function" then
		wallpaper = wallpaper(s)
	end

	if wallpaper ~= nil then
		gears.wallpaper.maximized(wallpaper, s, false)
	end
end
