local M = {}

M["rust_analyzer"] = function(server_name)
  require("lspconfig")[server_name].setup({
    on_attach = require("keymaps").on_attach
  })
  require("rust-tools").setup {}
end


return M
