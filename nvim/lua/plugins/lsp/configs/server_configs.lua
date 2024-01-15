local M = {}

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local keymaps_on_attach = require("plugins.lsp.configs.keymaps").on_attach

local lsp_signature_on_attach = function(bufnr)
  require("lsp_signature").on_attach({
    bind = true,
    handler_opts = {
      border = "rounded"
    }
  }, bufnr)
end

local base_configuration = function(client, bufnr)
  keymaps_on_attach(client, bufnr)
  lsp_signature_on_attach(bufnr)
end

M["rust_analyzer"] = function(server_name)
  require("lspconfig")[server_name].setup({
    on_attach = function(client, bufnr)
      base_configuration(client, bufnr)
    end,
    capabilities = capabilities,
  })
  require("rust-tools").setup {}
end


return M
