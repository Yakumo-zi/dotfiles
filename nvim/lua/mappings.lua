local map = vim.keymap.set

-- general mappings
map("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
map("i", "jk", "<Esc>", { desc = "Exit insert mode" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "Copy whole file" })
map(
  "n",
  "<leader>ep",
  "<cmd>edit ~/.config/nvim/init.lua<CR>",
  { desc = "Edit config" }
)

map("n", "QQ", "<cmd>q<CR>", { desc = "Close window" })

-- native comment operator
map("n", "<leader>/", "gcc", { desc = "Toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "Toggle comment", remap = true })

-- change window
map({ "n", "t" }, "<c-h>", "<cmd>wincmd h<CR>", { desc = "Go to left window" })
map({ "n", "t" }, "<c-j>", "<cmd>wincmd j<CR>", { desc = "Go to lower window" })
map({ "n", "t" }, "<c-k>", "<cmd>wincmd k<CR>", { desc = "Go to upper window" })
map({ "n", "t" }, "<c-l>", "<cmd>wincmd l<CR>", { desc = "Go to right window" })
