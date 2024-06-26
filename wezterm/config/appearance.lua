local wezterm = require('wezterm')

return {
  term = "xterm-256color",
  animation_fps = 60,
  max_fps = 60,
  front_end = 'WebGpu',
  webgpu_power_preference = 'HighPerformance',

  -- color scheme
  -- colors = colors,
  color_scheme = "catppuccin-frappe",

  -- background
  window_background_opacity = 0.75,
  win32_system_backdrop = 'Acrylic',
  window_background_gradient = {
    colors = { '#2F3045', '#0B1F1F' },
    -- Specifices a Linear gradient starting in the top left corner.
    orientation = { Linear = { angle = -45.0 } },
  },

  -- tab bar
  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = false,
  use_fancy_tab_bar = true,
  tab_max_width = 25,
  show_tab_index_in_tab_bar = true,
  switch_to_last_active_tab_when_closing_tab = true,
  text_background_opacity = 0.75,

  -- cursor
  --SteadyBlock, BlinkingBlock, SteadyUnderline, BlinkingUnderline, SteadyBar, and BlinkingBar
  default_cursor_style = "BlinkingUnderline",
  cursor_blink_ease_in = "Linear",
  cursor_blink_ease_out = "Linear",
  cursor_blink_rate = 1000,

  -- window
  adjust_window_size_when_changing_font_size = true,
  window_decorations = "NONE",
  integrated_title_button_style = "Windows",
  integrated_title_button_color = "auto",
  integrated_title_button_alignment = "Right",
  initial_cols = 185,
  initial_rows = 44,
  window_padding = {
    left = 5,
    right = 10,
    top = 12,
    bottom = 7,
  },
  window_close_confirmation = 'AlwaysPrompt',
  window_frame = {
    active_titlebar_bg = '#0F2536',
    inactive_titlebar_bg = '#0F2536',
  },
  inactive_pane_hsb = { saturation = 1.0, brightness = 1.0 },
}
