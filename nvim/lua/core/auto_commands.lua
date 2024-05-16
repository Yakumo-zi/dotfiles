local utils = require("helpers.utils")
local map = require("helpers.keys").map
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  pattern = { "*.*" },
  command = "lcd %:p:h",
})
