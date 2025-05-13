dofile(vim.g.base46_cache .. "lsp")
require("nvchad.lsp").diagnostic_config()
local map = vim.keymap.set
local unmap = vim.keymap.del
local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"

-- default server
local servers = {
  "gopls",
  "rust_analyzer",
}

local configs = {
  lua_ls = require "configs.lsp_server_configs.lua_ls",
  clangd = require "configs.lsp_server_configs.clangd",
}

-- default keymap
local attach = function(client, bufnr)
  nvlsp.on_attach(client, bufnr)
  unmap("n", "<leader>ra", { buffer = bufnr })
  unmap("n", "K", { buffer = bufnr })
  map("n", "gr", "<cmd> Telescope lsp_references<CR>", { buffer = bufnr, desc = "LSP find references" })
  map("n", "<leader>rn", require "nvchad.lsp.renamer", { buffer = bufnr, desc = "LSP NvRenamer" })
  map("n", "K", function()
    vim.lsp.buf.hover { border = "rounded" }
  end, { buffer = bufnr, desc = "LSP show details" })
end

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- specific server with custom config
for server, config in pairs(configs) do
  require("lspconfig")[server].setup(vim.tbl_deep_extend("force", {
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
