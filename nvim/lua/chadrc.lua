-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}
local function Test()

end
Test()
M.base46 = {
  theme = "ayu_light",
  hl_override = {
    ["@comment"] = { italic = true },
  },

}
M.ui = {
  cmp = {
    style = "default",
    icons_left = true,
  },
  telescope = {
    style = "bordered"
  },
  statusline = {
    separator_style = "arrow"
  }
}
M.nvdash = {
  load_on_startup = true
}
M.term = {
  float = {
    border = 'rounded'
  }
}

return M
