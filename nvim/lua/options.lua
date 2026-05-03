require("nvchad.options")

local env = require("env")
local o = vim.o

o.laststatus = 3
o.showmode = false
o.showtabline = 2
o.updatetime = 300

if env.has_any(env.clipboard_commands) or vim.fn.has("wsl") == 1 then
  o.clipboard = "unnamedplus"
end

o.expandtab = true
o.shiftwidth = 4
o.smartindent = true
o.tabstop = 4
o.softtabstop = 4

vim.opt.fillchars = {
  eob = " ",
  horiz = "━",
  horizdown = "┳",
  horizup = "┻",
  vert = "┃",
  vertleft = "┫",
  vertright = "┣",
  verthoriz = "╋",
}

o.ignorecase = true
o.smartcase = true
if env.executable("rg") then
  o.grepprg = "rg --vimgrep --smart-case"
  o.grepformat = "%f:%l:%c:%m"
end

o.mouse = "a"
o.number = true
o.cursorline = true
o.cursorlineopt = "number,line"
o.pumblend = 0
o.pumheight = 12
o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.termguicolors = true
o.timeoutlen = 400
o.undofile = true
pcall(function() o.winborder = "rounded" end)

vim.diagnostic.config({
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
  },
  virtual_text = false,
})
