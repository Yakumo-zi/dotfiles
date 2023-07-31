return {
  setup = function(lspconfig, lsp)
    local default_lsps = {
      "marksman",
      "pylsp",
      "bashls",
      "cmake",
      "slint_lsp",
      "dockerls",
      "docker_compose_language_service",
      "taplo",
      "yamlls",
    }
    for _, server in pairs(default_lsps) do
      lsp[server].setup({
        on_attach = lspconfig.on_attach,
        capabilities = lspconfig.capabilities,
      })
    end
  end,
}
