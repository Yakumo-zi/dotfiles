local env = require("env")

local M = {}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local uv = vim.uv or vim.loop

local function clone_lazy()
  if not env.executable("git") then
    vim.notify(
      "lazy.nvim is not installed and git is missing; starting without plugins",
      vim.log.levels.WARN
    )
    return false
  end

  local command = {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }

  if vim.system then
    local ok, result = pcall(
      function() return vim.system(command, { text = true }):wait(15000) end
    )
    return ok and result and result.code == 0
  end

  vim.fn.system(command)
  return vim.v.shell_error == 0
end

function M.setup()
  if not uv.fs_stat(lazypath) and not clone_lazy() then return end

  vim.opt.rtp:prepend(lazypath)

  local ok, lazy = pcall(require, "lazy")
  if not ok then return end

  lazy.setup({
    { import = "plugins" },
  }, require("core.lazy"))
end

return M
