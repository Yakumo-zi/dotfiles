---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "catppuccin-latte",
  transparency = false,
  hl_override = {
    Pmenu = { fg = "base05", bg = "base01" },
    PmenuSel = { fg = "base05", bg = "base03", bold = true },
    PmenuSbar = { bg = "base01" },
    PmenuThumb = { bg = "base03" },
    CmpPmenu = { fg = "base05", bg = "base01" },
    CmpSel = { fg = "base05", bg = "base03", bold = true },
    CmpItemAbbr = { fg = "base05" },
    CmpItemAbbrMatch = { fg = "base0D", bold = true },
    CmpItemMenu = { fg = "base06", italic = true },
    CmpDoc = { fg = "base05", bg = "base01" },
    CmpBorder = { fg = "base03", bg = "base01" },
    CmpDocBorder = { fg = "base03", bg = "base01" },
  },
}

return M
