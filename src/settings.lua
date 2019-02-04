local settings = {}

settings.modkey = "Mod1"
settings.terminal = "kitty"
settings.editor = os.getenv("EDITOR") or "nvim"
settings.editor_cmd = settings.terminal .. " sh -c " .. settings.editor

return settings
