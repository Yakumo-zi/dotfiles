return {
  setup = function(lspconfig, lsp)
    lsp.clangd.setup({
      on_attach = lspconfig.on_attach,
      capabilities = lspconfig.capabilities,
      cmd = {
        "clangd",
        "--offset-encoding=utf-16",
        "--background-index",
        "--clang-tidy",
        "--fallback-style=LLVM",
        "--header-insertion=iwyu",
        "--enable-config",
        "--completion-parse=auto",
        "--all-scopes-completion",
      },
    })
  end,
}
