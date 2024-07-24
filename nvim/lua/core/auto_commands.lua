local utils = require("helpers.utils")
vim.api.nvim_create_autocmd({ "VimEnter" }, {
	pattern = { "*.*" },
	command = "lcd %:p:h",
})
