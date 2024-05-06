local wezterm = require('wezterm')

local font = 'FiraCode Nerd Font'

return {
  font = wezterm.font(font),
  freetype_load_target = 'Normal', ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
  freetype_render_target = 'Normal', ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
}
