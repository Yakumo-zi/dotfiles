return {
  setup = function(lspconfig, lsp)
    local default_lsps = { "cmake", "bashls", "slint_lsp" }
    for _, server in pairs(default_lsps) do
      lsp[server].setup({
        on_attach = lspconfig.on_attach,
        capabilities = lspconfig.capabilities,
      })
    end
  end,
}
