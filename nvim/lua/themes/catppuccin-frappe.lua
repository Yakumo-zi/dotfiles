---@type Base46Table
local M = {}

local c = {
  rosewater = "#f2d5cf",
  flamingo = "#eebebe",
  pink = "#f4b8e4",
  mauve = "#ca9ee6",
  red = "#e78284",
  maroon = "#ea999c",
  peach = "#ef9f76",
  yellow = "#e5c890",
  green = "#a6d189",
  teal = "#81c8be",
  sky = "#99d1db",
  sapphire = "#85c1dc",
  blue = "#8caaee",
  lavender = "#babbf1",
  text = "#c6d0f5",
  subtext1 = "#b5bfe2",
  subtext0 = "#a5adce",
  overlay2 = "#949cbb",
  overlay1 = "#838ba7",
  overlay0 = "#737994",
  surface2 = "#626880",
  surface1 = "#51576d",
  surface0 = "#414559",
  base = "#303446",
  mantle = "#292c3c",
  crust = "#232634",
}

M.base_30 = {
  white = c.text,
  darker_black = c.mantle,
  black = c.base,
  black2 = c.surface0,
  one_bg = c.surface0,
  one_bg2 = c.surface1,
  one_bg3 = c.surface2,
  grey = c.overlay0,
  grey_fg = c.overlay1,
  grey_fg2 = c.overlay2,
  light_grey = c.subtext0,
  red = c.red,
  baby_pink = c.flamingo,
  pink = c.pink,
  line = c.surface1,
  green = c.green,
  vibrant_green = c.green,
  nord_blue = c.blue,
  blue = c.blue,
  yellow = c.yellow,
  sun = c.peach,
  purple = c.mauve,
  dark_purple = c.mauve,
  teal = c.teal,
  orange = c.peach,
  cyan = c.sky,
  statusline_bg = c.mantle,
  lightbg = c.surface0,
  pmenu_bg = c.blue,
  folder_bg = c.blue,
  lavender = c.lavender,
}

M.base_16 = {
  base00 = c.base,
  base01 = c.mantle,
  base02 = c.surface0,
  base03 = c.surface1,
  base04 = c.surface2,
  base05 = c.text,
  base06 = c.subtext1,
  base07 = c.lavender,
  base08 = c.red,
  base09 = c.peach,
  base0A = c.yellow,
  base0B = c.green,
  base0C = c.teal,
  base0D = c.blue,
  base0E = c.mauve,
  base0F = c.maroon,
}

M.polish_hl = {
  treesitter = {
    ["@property"] = { fg = M.base_30.teal },
    ["@variable"] = { fg = M.base_30.lavender },
    ["@variable.builtin"] = { fg = M.base_30.red },
  },
}

M.type = "dark"

M = require("base46").override_theme(M, "catppuccin-frappe")

return M
