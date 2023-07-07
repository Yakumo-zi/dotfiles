local map=require("helpers.keys").map

map("i","jk","<esc>")

map("n", "<C-h>", "<C-w><C-h>", "Navigate windows to the left")
map("n", "<C-j>", "<C-w><C-j>", "Navigate windows down")
map("n", "<C-k>", "<C-w><C-k>", "Navigate windows up")
map("n", "<C-l>", "<C-w><C-l>", "Navigate windows to the right")

map("n", "gn", ":bnext<CR>")
map("n", "gp", ":bprevious<CR>")

local buffers = require("helpers.buffers")
map("n", "<leader>dc", buffers.delete_this, "Current buffer")
map("n", "<leader>do", buffers.delete_others, "Other buffers")
map("n", "<leader>da", buffers.delete_all, "All buffers")

map("v", "<", "<gv")
map("v", ">", ">gv")
