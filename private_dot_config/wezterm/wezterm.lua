local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "Tokyo Night"

config.enable_tab_bar = false
config.window_background_opacity = 0.9

config.font = wezterm.font("FiraCode Nerd Font", { weight = "Regular" })
config.font_size = 9

return config
