local utils = require("helpers.utils")
local map = require("helpers.keys").map
vim.api.nvim_create_autocmd({ "BufWinEnter", "BufEnter" }, {
  pattern = { "*.*" },
  command = "lcd %:p:h",
})
