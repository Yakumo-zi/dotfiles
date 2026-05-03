require("nvchad.mappings")

local env = require("env")
local map = vim.keymap.set

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

map("n", "<leader>/", "gcc", { desc = "Toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "Toggle comment", remap = true })

map({ "n", "t" }, "<c-h>", "<cmd>wincmd h<CR>", { desc = "Go to left window" })
map({ "n", "t" }, "<c-j>", "<cmd>wincmd j<CR>", { desc = "Go to lower window" })
map({ "n", "t" }, "<c-k>", "<cmd>wincmd k<CR>", { desc = "Go to upper window" })
map({ "n", "t" }, "<c-l>", "<cmd>wincmd l<CR>", { desc = "Go to right window" })

map("n", "<leader>pf", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>pb", "<cmd>Telescope buffers<CR>", { desc = "Buffers" })
map("n", "<leader>ph", "<cmd>Telescope help_tags<CR>", { desc = "Help" })
map(
  "n",
  "<leader>pd",
  "<cmd>Telescope lsp_definitions<CR>",
  { desc = "Go to definition" }
)
map(
  "n",
  "<leader>pr",
  "<cmd>Telescope lsp_references<CR>",
  { desc = "References" }
)
map("n", "<leader>pk", "<cmd>Telescope keymaps<CR>", { desc = "Keymaps" })

if env.executable("rg") then
  map(
    "n",
    "<leader>ps",
    "<cmd>Telescope live_grep<CR>",
    { desc = "Grep project" }
  )
end

map(
  { "n", "v" },
  "<leader>-",
  "<cmd>NvimTreeFindFileToggle<CR>",
  { desc = "Open files" }
)
map("n", "<leader>cw", "<cmd>NvimTreeOpen .<CR>", { desc = "Open cwd" })
map("n", "<c-up>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle files" })
