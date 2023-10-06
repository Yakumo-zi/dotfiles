return {
  setup = function(lspconfig, lsp)
    local on_attach = function(client, bufnr)
      vim.lsp.inlay_hint(bufnr, true)
      require("lsp-inlayhints").on_attach(client, bufnr)
      lspconfig.on_attach(client, bufnr)
    end
    lsp.clangd.setup({
      on_attach = on_attach,
      capabilities = lspconfig.capabilities,
      filetypes = { "c", "cpp" },
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
