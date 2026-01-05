local defaults = vim.lsp.config["sourcekit"]
local my_opts = require("lsp.swift")

local config = vim.tbl_deep_extend("force", {}, defaults, my_opts)
config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)

vim.lsp.start(config)
