local awful = require "awful"

local terminal = "alacritty"
local editor = os.getenv("EDITOR") or "nvim"

return {
	modkey = "Mod4",
	terminal = terminal,
	editor = editor,
	editor_cmd = terminal .. " -e " .. editor,
	default_layout = awful.layout.suit.spiral.dwindle,
}
