---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "catppuccin-latte",
  transparency = false,
  hl_override = {
    Pmenu = { fg = "#4C4F69", bg = "#EFF1F5" },
    PmenuSel = { fg = "#4C4F69", bg = "#CCD0DA", bold = true },
    CmpPmenu = { fg = "#4C4F69", bg = "#EFF1F5" },
    CmpSel = { fg = "#4C4F69", bg = "#CCD0DA", bold = true },
    CmpItemAbbr = { fg = "#4C4F69" },
    CmpItemAbbrMatch = { fg = "#1E66F5", bold = true },
    CmpItemMenu = { fg = "#6C6F85", italic = true },
    CmpDoc = { fg = "#4C4F69", bg = "#EFF1F5" },
    CmpBorder = { fg = "#9CA0B0", bg = "#EFF1F5" },
    CmpDocBorder = { fg = "#9CA0B0", bg = "#EFF1F5" },
  },
}

return M
