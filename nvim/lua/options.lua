local o = vim.o

o.laststatus = 3 -- global statusline
o.showmode = false

o.clipboard = "unnamedplus"

-- Indenting
o.expandtab = true
o.shiftwidth = 4
o.smartindent = true
o.tabstop = 4
o.softtabstop = 4

vim.opt.fillchars = { eob = " " }
o.ignorecase = true
o.smartcase = true
o.mouse = "a"

o.number = true

o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.termguicolors = true
o.timeoutlen = 400
o.undofile = true
o.cursorline = true



vim.api.nvim_set_hl(0, "IndentLine", { link = "Comment" })
