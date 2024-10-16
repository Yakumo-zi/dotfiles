require("helpers.keys").set_leader(" ")
local map = require("helpers.keys").map
local utils = require("helpers.utils")

map("n", "j", "gj")
map("n", "k", "gk")

-- nvim keys
map("n", "<C-h>", "<C-w><C-h>", "Navigate windows to the left")
map("n", "<C-j>", "<C-w><C-j>", "Navigate windows down")
map("n", "<C-k>", "<C-w><C-k>", "Navigate windows up")
map("n", "<C-l>", "<C-w><C-l>", "Navigate windows to the right")

-- resise window
map({ "n" }, "<A-h>", "<cmd>vert res +1<cr>", "Increase window width")
map({ "n" }, "<A-l>", "<cmd>vert res -1<cr>", "Decrease window width")
map({ "n" }, "<A-k>", "<cmd>res +1<cr>", "Increase window height")
map({ "n" }, "<A-j>", "<cmd>res -1<cr>", "Decrease window height")

map("n", "<leader>bn", ":bnext<CR>")
map("n", "<leader>bp", ":bprevious<CR>")
map("n", "<leader>lt", "<cmd>luafile %<CR>")

map("i", "<C-h>", "<Left>", "Move to left in insert mode")
map("i", "<C-l>", "<Right>", "Move to right in insert mode")
map({ "i" }, "jk", "<esc>")

map("n", "<leader>fb", require("arena").toggle, "Open Arena")

map("v", "<", "<gv")
map("v", ">", ">gv")
