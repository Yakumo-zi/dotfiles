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
    BlinkCmpMenu = { fg = "base05", bg = "base01" },
    BlinkCmpMenuSelection = { fg = "base05", bg = "base03", bold = true },
    BlinkCmpLabel = { fg = "base05" },
    BlinkCmpLabelMatch = { fg = "base0D", bold = true },
    BlinkCmpSource = { fg = "base06", italic = true },
    BlinkCmpDoc = { fg = "base05", bg = "base01" },
    BlinkCmpMenuBorder = { fg = "base03", bg = "base01" },
    BlinkCmpDocBorder = { fg = "base03", bg = "base01" },
  },
}

return M
