-- bootstrap plugins & lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim" -- path where its going to be installed
local uv = vim.uv or vim.loop

if not uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "

require("lazy").setup({
  { import = "plugins" },
}, require("lazy_config"))
require("options")
require("mappings")
require("autocmd")

vim.cmd("colorscheme catppuccin-latte")
