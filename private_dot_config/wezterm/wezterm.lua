local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "kanagawabones"

config.enable_tab_bar = false
config.adjust_window_size_when_changing_font_size = false

-- config.font = wezterm.font_with_fallback({ { family = "TX-02 Condensed", weight = "Regular" }, "TX02 Nerd Font Mono" })
config.font_size = 10

config.font = wezterm.font({ family = "IosevkaTerm Nerd Font", weight = "Regular" })
-- config.font_rules = {
-- 	{
-- 		intensity = "Normal",
-- 		italic = true,
-- 		font = wezterm.font({ family = "VictorMono Nerd Font", style = "Italic" }),
-- 	},
-- }
--
config.enable_wayland = true

return config
