local defaults = vim.lsp.config["ocamllsp"]

local opts = require("lsp.ocaml")
local config = vim.tbl_deep_extend("force", {}, defaults, opts)
config.capabilities =
  require("blink.cmp").get_lsp_capabilities(config.capabilities)

vim.lsp.start(config)
