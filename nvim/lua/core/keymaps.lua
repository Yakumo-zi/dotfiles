require("helpers.keys").set_leader(" ")
local utils = require("helpers.utils")
local map = require("helpers.keys").map
local buffers = require("helpers.buffers")


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

map({ "n", "t" }, "<A-f>", utils.bash_float, "Open float term")
map({ "n", "t" }, "<C-t>", utils.bash, "Toggle term")

map("n", "bn", ":bnext<CR>")
map("n", "bp", ":bprevious<CR>")

map("n", "Q", buffers.delete_this, "Current buffer")
map("n", "<leader>do", buffers.delete_others, "Other buffers")

map("i", "<C-h>", "<Left>", "Move to left in insert mode")
map("i", "<C-l>", "<Right>", "Move to right in insert mode")
map({ "i", "v" }, "jk", "<esc>")

map("v", "<", "<gv")
map("v", ">", ">gv")
