local awful = require "awful"

local terminal = "alacritty"
local editor = os.getenv("EDITOR") or "nvim"

return {
	modkey = "Mod1",
	terminal = terminal,
	editor = editor,
	editor_cmd = terminal .. " sh -c " .. editor,
	default_layout = awful.layout.suit.tile,
}
