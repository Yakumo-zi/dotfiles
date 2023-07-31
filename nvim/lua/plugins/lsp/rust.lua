return {
  rust_setup = function(lspconfig, lsp)
    local on_attach = function(client, bufnr)
      vim.lsp.inlay_hint(bufnr, true)
      require("lsp-inlayhints").on_attach(client, bufnr)
      lspconfig.on_attach(client, bufnr)
    end
    lsp.rust_analyzer.setup({
      on_attach = on_attach,
      capabilities = lspconfig.capabilities,
    })
  end,
  rust_tool_setup = function()
    local rt = require("rust-tools")
    rt.setup({
      server = {
        on_attach = function(_, bufnr)
          local lsp_map = require("helpers.keys").lsp_map
          -- Hover actions
          lsp_map("K", rt.hover_actions.hover_actions, { buffer = bufnr })
          -- Code action groups
          lsp_map("<leader>la", rt.code_action_group.code_action_group, { buffer = bufnr })
        end,
      },
      tools = {
        inlay_hints = {
          auto = false,
        },
      },
    })
  end,
}
