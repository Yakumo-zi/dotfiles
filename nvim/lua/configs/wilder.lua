local wilder = require "wilder"
wilder.setup {
  modes = { ":", "/", "?" },
  next_key = 0,
  previous_key = 0,
  reject_key = 0,
  accept_key = 0,
}
local gradient = {
  "#f4468f",
  "#fd4a85",
  "#ff507a",
  "#ff566f",
  "#ff5e63",
  "#ff6658",
  "#ff704e",
  "#ff7a45",
  "#ff843d",
  "#ff9036",
  "#f89b31",
  "#efa72f",
  "#e6b32e",
  "#dcbe30",
  "#d2c934",
  "#c8d43a",
  "#bfde43",
  "#b6e84e",
  "#aff05b",
}

for i, fg in ipairs(gradient) do
  gradient[i] = wilder.make_hl("WilderGradient" .. i, "Pmenu", { { a = 1 }, { a = 1 }, { foreground = fg } })
end

-- 设置source
wilder.set_option("pipeline", {
  wilder.branch(
    -- 当默认无输入时 展示15条历史记录
    {
      wilder.check(function(_, x)
        return vim.fn.empty(x)
      end),
      wilder.history(15),
    },
    -- 当输入时 展示所有匹配项(模糊匹配)
    wilder.cmdline_pipeline {
      fuzzy = 1,
      fuzzy_filter = wilder.vim_fuzzy_filter(),
    },
    -- pipeline for search
    wilder.search_pipeline()
  ),
})
-- 设置样式
wilder.set_option(
  "renderer",
  wilder.popupmenu_renderer(wilder.popupmenu_palette_theme {
    highlights = {
      gradient = gradient, -- must be set
      -- selected_gradient key can be set to apply gradient highlighting for the selected candidate.
    },
    highlighter = wilder.highlighter_with_gradient {
      wilder.basic_highlighter(), -- or wilder.lua_fzy_highlighter(),
    },
    -- 'single', 'double', 'rounded' or 'solid'
    -- can also be a list of 8 characters, see :h wilder#popupmenu_palette_theme() for more details
    border = "rounded",
    max_height = "75%", -- max height of the palette
    min_height = 0, -- set to the same as 'max_height' for a fixed height window
    prompt_position = "top", -- 'top' or 'bottom' to set the location of the prompt
    reverse = 0, -- set to 1 to reverse the order of the list, use in combination with 'prompt_position'
  })
)
-- 设置高亮
-- 设置快捷键
vim.api.nvim_set_keymap(
  "c",
  "<tab>",
  [[wilder#in_context() ? wilder#next() : '<tab>']],
  { noremap = true, expr = true }
)
vim.api.nvim_set_keymap(
  "c",
  "<S-tab>",
  [[wilder#in_context() ? wilder#previous() : '<up>']],
  { noremap = true, expr = true }
)
vim.api.nvim_set_keymap("c", "0", "0", {}) -- 不清楚原因导致0无法使用 强制覆盖
