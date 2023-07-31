return {
  setup = function(lspconfig, lsp)
    local on_attach = function(client, bufnr)
      vim.lsp.inlay_hint(bufnr, true)
      require("lsp-inlayhints").on_attach(client, bufnr)
      lspconfig.on_attach(client, bufnr)
    end
    lsp.lua_ls.setup({
      on_attach = on_attach,
      capabilities = lspconfig.capabilities,
      settings = {
        Lua = {
          completion = {
            callSnippet = "Replace",
          },
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
          hint = {
            enable = true,
          },
        },
      },
    })
  end,
}
