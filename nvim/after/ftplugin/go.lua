local defaults = vim.lsp.config["gopls"]
local my_opts = require("lsp.gopls")
local capabilities = require("blink.cmp").get_lsp_capabilities()

local config = vim.tbl_deep_extend("force", {}, defaults, my_opts)
config.capabilities = capabilities

vim.lsp.start(config)
