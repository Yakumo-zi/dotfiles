dofile(vim.g.base46_cache .. "lsp")
require("nvchad.lsp").diagnostic_config()
local map = vim.keymap.set
local lspconfig = require "lspconfig"

-- default server
local servers = {
  "html",
  "cssls",
  "gopls",
  "rust_analyzer",
  "ruby_lsp",
  "pyright",
  "bashls",
  "asm_lsp"
}
local nvlsp = require "nvchad.configs.lspconfig"
-- default keymap
local attach = function(client, bufnr)
  nvlsp.on_attach(client, bufnr)
  map("n", "gr", "<cmd> Telescope lsp_references<CR>", { buffer = bufnr })
end


-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

local configs = {
  lua_ls = require("configs.lsp_server_configs.lua_ls"),
  clangd = require("configs.lsp_server_configs.clangd")
}

-- specific server with custom config
for server, config in pairs(configs) do
  require("lspconfig")[server].setup(vim.tbl_deep_extend('force', {
    on_attach = function(client, bufnr)
      attach(client, bufnr)
      if config.on_attach ~= nil then
        config.on_attach(client, bufnr)
      end
    end,
    capabilities = nvlsp.capabilities,
    on_init = nvlsp.on_init,
  }, config.opts))
end
