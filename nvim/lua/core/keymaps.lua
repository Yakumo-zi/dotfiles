local map = require("helpers.keys").map

map("i", "jk", "<esc>")

map("n", "<C-h>", "<C-w><C-h>", "Navigate windows to the left")
map("n", "<C-j>", "<C-w><C-j>", "Navigate windows down")
map("n", "<C-k>", "<C-w><C-k>", "Navigate windows up")
map("n", "<C-l>", "<C-w><C-l>", "Navigate windows to the right")

map("n", "bn", ":bnext<CR>")
map("n", "bp", ":bprevious<CR>")

local buffers = require("helpers.buffers")
map("n", "<leader>dc", buffers.delete_this, "Current buffer")
map("n", "<leader>do", buffers.delete_others, "Other buffers")
map("n", "<leader>da", buffers.delete_all, "All buffers")


map("n", "<leader>ds", "<cmd>Lspsaga show_buf_diagnostics<CR>", "Open diagnostic")
map("n", "<leader>so", "<cmd>SymbolsOutline<CR>", "Open SymbosOutline")
map("n", "<leader>e", "<cmd>NeoTreeFloatToggle<CR>", "Open Neotree")

map({ "n", "t" }, "<C-t>", "<cmd>ToggleTerm<cr>", "ToggleTerm")

map("v", "<", "<gv")
map("v", ">", ">gv")
