local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "kanagawabones"

config.enable_tab_bar = false
config.window_background_opacity = 0.85

config.font = wezterm.font("JetBrainsMono Nerd Font")
-- config.font = wezterm.font_with_fallback({ "Tamzen", "Cozette" })
config.font_size = 9

return config
