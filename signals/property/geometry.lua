local set_wallpaper = require('../../utils/set_wallpaper')

screen.connect_signal('property::geometry', set_wallpaper)