return {
  rust_setup = function(lspconfig, lsp)
    lsp.rust_analyzer.setup({
      on_attach = lspconfig.on_attach,
      capabilities = lspconfig.capabilities,
    })
  end,
  rust_tool_setup = function()
    local rt = require("rust-tools")
    rt.setup({
      server = {
        on_attach = function(_, bufnr)
          -- Hover actions
          vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
          -- Code action groups
          vim.keymap.set("n", "<leader>la", rt.code_action_group.code_action_group, { buffer = bufnr })
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
