---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "catppuccin-latte",
  transparency = false,
  hl_override = {
    Pmenu = { fg = "base05", bg = "none" },
    PmenuSel = { fg = "base05", bg = "base03", bold = true },
    PmenuSbar = { bg = "none" },
    PmenuThumb = { bg = "base03" },
    CmpPmenu = { fg = "base05", bg = "none" },
    CmpSel = { fg = "base05", bg = "base03", bold = true },
    CmpItemAbbr = { fg = "base05" },
    CmpItemAbbrMatch = { fg = "base0D", bold = true },
    CmpItemMenu = { fg = "base06", italic = true },
    CmpDoc = { fg = "base05", bg = "none" },
    CmpBorder = { fg = "base03", bg = "none" },
    CmpDocBorder = { fg = "base03", bg = "none" },
  },
}

return M
