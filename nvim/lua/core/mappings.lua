local env = require("env")
local map = vim.keymap.set

local function edit_file_prompt()
  local file = vim.fn.input("Edit file: ", "", "file")
  if file ~= "" then vim.cmd.edit(vim.fn.fnameescape(file)) end
end

local function select_buffer()
  local buffers = vim.tbl_filter(
    function(buffer) return buffer.listed == 1 end,
    vim.fn.getbufinfo()
  )

  vim.ui.select(buffers, {
    prompt = "Buffers",
    format_item = function(buffer)
      local name = vim.fn.fnamemodify(buffer.name, ":~:.")
      if name == "" then name = "[No Name]" end
      return ("%d: %s"):format(buffer.bufnr, name)
    end,
  }, function(buffer)
    if buffer then vim.cmd.buffer(buffer.bufnr) end
  end)
end

local function help_prompt()
  local topic = vim.fn.input("Help: ")
  if topic ~= "" then vim.cmd.help(vim.fn.fnameescape(topic)) end
end

local function grep_prompt()
  local pattern = vim.fn.input("Grep: ")
  if pattern == "" then return end

  vim.cmd("silent grep! " .. vim.fn.shellescape(pattern))
  vim.cmd.copen()
end

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

if not env.executable("fzf") then
  map("n", "<leader>pf", edit_file_prompt, { desc = "Find Files" })
  map("n", "<leader>pb", select_buffer, { desc = "Buffers" })
  map("n", "<leader>ph", help_prompt, { desc = "Help" })
  map("n", "<leader>pk", "<cmd>map<CR>", { desc = "Keymaps" })
end

if not env.executable("fzf") and env.executable("rg") then
  map("n", "<leader>ps", grep_prompt, { desc = "Grep Project" })
end

if not env.executable("yazi") then
  map({ "n", "v" }, "<leader>-", "<cmd>Explore<CR>", { desc = "Open files" })
  map("n", "<leader>cw", "<cmd>Explore .<CR>", { desc = "Open cwd" })
  map("n", "<c-up>", "<cmd>Explore<CR>", { desc = "Open files" })
end
