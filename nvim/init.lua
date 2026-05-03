vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46/"
vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    repo,
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "NvChad/NvChad",
    branch = "v2.5",
    import = "nvchad.plugins",
    lazy = false,
  },
  { import = "plugins" },
}, require("configs.lazy"))

for _, file in ipairs({ "defaults", "statusline" }) do
  local cache = vim.g.base46_cache .. file
  if (vim.uv or vim.loop).fs_stat(cache) then dofile(cache) end
end

require("options")
require("nvchad.autocmds")

vim.schedule(function()
  require("mappings")
  require("autocmds")
end)
