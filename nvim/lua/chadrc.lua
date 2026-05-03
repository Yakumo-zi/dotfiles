---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "catppuccin-latte",
  transparency = false,
  hl_override = {
    Pmenu = { fg = "base05", bg = "base00" },
    PmenuSel = { fg = "base05", bg = "base03", bold = true },
    CmpPmenu = { fg = "base05", bg = "base00" },
    CmpSel = { fg = "base05", bg = "base03", bold = true },
    CmpItemAbbr = { fg = "base05" },
    CmpItemAbbrMatch = { fg = "base0D", bold = true },
    CmpItemMenu = { fg = "base06", italic = true },
    CmpDoc = { fg = "base05", bg = "base00" },
    CmpBorder = { fg = "base03", bg = "base00" },
    CmpDocBorder = { fg = "base03", bg = "base00" },
  },
}

return M
