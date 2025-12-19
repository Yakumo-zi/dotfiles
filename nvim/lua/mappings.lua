local map = vim.keymap.set

-- general mappings
map("n", "<C-s>", "<cmd> w <CR>")
map("i", "jk", "<ESC>")
map("n", "<C-c>", "<cmd> %y+ <CR>") -- copy whole filecontent
map("n", "<leader>ep", "<cmd>edit ~/.config/nvim/init.lua <CR>", { remap = true })

-- bufferline, cycle buffers
map("n", "<Tab>", "<cmd> BufferNext <CR>")
map("n", "<S-Tab>", "<cmd> BufferPrevious <CR>")
map("n", "<C-q>", "<cmd> bd <CR>")

-- comment.nvim
map("n", "<leader>/", "gcc", { remap = true })
map("v", "<leader>/", "gc", { remap = true })

-- change window
map({ "n", "t" }, "<c-h>", "<cmd> wincmd h<CR>")
map({ "n", "t" }, "<c-j>", "<cmd> wincmd j<CR>")
map({ "n", "t" }, "<c-k>", "<cmd> wincmd k<CR>")
map({ "n", "t" }, "<c-l>", "<cmd> wincmd l<CR>")
