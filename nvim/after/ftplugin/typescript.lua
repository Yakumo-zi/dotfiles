local defaults = vim.lsp.config["ts_ls"]

local opts = require("lsp.ts_js")
local config = vim.tbl_deep_extend("force", {}, defaults, opts)
config.capabilities =
  require("blink.cmp").get_lsp_capabilities(config.capabilities)

vim.lsp.start(config)
