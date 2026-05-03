---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "catppuccin-latte",
  transparency = false,
  hl_override = {
    Pmenu = { fg = "base05" },
    PmenuSel = { fg = "base05", bg = "base03", bold = true },
    PmenuThumb = { bg = "base03" },
    CmpPmenu = { fg = "base05" },
    CmpSel = { fg = "base05", bg = "base03", bold = true },
    CmpItemAbbr = { fg = "base05" },
    CmpItemAbbrMatch = { fg = "base0D", bold = true },
    CmpItemMenu = { fg = "base06", italic = true },
    CmpDoc = { fg = "base05" },
    CmpBorder = { fg = "base03" },
    CmpDocBorder = { fg = "base03" },
    BlinkCmpMenu = { fg = "base05" },
    BlinkCmpMenuSelection = { fg = "base05", bg = "base03", bold = true },
    BlinkCmpLabel = { fg = "base05" },
    BlinkCmpLabelMatch = { fg = "base0D", bold = true },
    BlinkCmpSource = { fg = "base06", italic = true },
    BlinkCmpDoc = { fg = "base05" },
    BlinkCmpMenuBorder = { fg = "base03" },
    BlinkCmpDocBorder = { fg = "base03" },
  },
}

return M
