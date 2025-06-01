local wezterm = require 'wezterm'

-- To enable syncing with your OS theme, use wezterm.gui.get_appearance()
function scheme_for_appearance(appearance)
    if appearance:find "Dark" then
        return "Catppuccin Mocha"
    else
        return "Catppuccin Latte"
    end
end

local config = {
    -- color_scheme = "Catppuccin Mocha",
    color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),
}

-- Scrollbar
config.enable_scroll_bar = true

-- Fonts
config.font = wezterm.font 'JetBrains Mono NL'
config.font_size = 14

-- Animation FPS
config.animation_fps = 1
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'

-- Background
config.window_background_opacity = 0.9

-- Front-end 
-- ("OpenGL - GPU Accelaerated", 
-- "Software - CPU Accelaerated", 
-- "WebGpu - GPU Accelaerated")
config.front_end = "OpenGL"

-- Reset font and window size
config.keys = {
    {
        key = '0',
        mods = 'CTRL',
        action = wezterm.action.ResetFontAndWindowSize,
    },
}

-- Window initial size
config.initial_cols = 140
config.initial_rows = 30

return config
