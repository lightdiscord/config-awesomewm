local settings = {}

settings.modkey = 'Mod4'
settings.terminal = 'alacritty'
settings.editor = os.getenv('EDITOR') or 'nvim'
settings.editor_cmd = settings.terminal .. ' -e ' .. settings.editor

return settings