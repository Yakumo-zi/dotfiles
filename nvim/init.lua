vim.g.mapleader = " "

require("core.options")
require("core.mappings")
require("core.autocmd")
require("core.bootstrap").setup()

if not pcall(vim.cmd.colorscheme, "catppuccin-latte") then
  vim.cmd.colorscheme("default")
end
