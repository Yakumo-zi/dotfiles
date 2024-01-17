local M = {}
M.on_attach = function(client, bufnr)
  local buf_set_keymap = vim.api.nvim_buf_set_keymap
  buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>Lspsaga code_action<cr>", {})
  buf_set_keymap(bufnr, "n", "gd", "<cmd>Lspsaga peek_definition<cr>", {})
  buf_set_keymap(bufnr, "n", "gp", "<cmd>Lspsaga peek_type_definition<cr>", { desc = "Peek type definition" })
  buf_set_keymap(bufnr, "n", "K", "<cmd>Lspsaga hover_doc<cr>", { desc = "Hover doc" })
  -- buf_set_keymap(bufnr, "n", "<leader>fm", ":lua vim.lsp.buf.format { async = true }<CR>",
  --   { desc = "Format current buf" })
  buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>Lspsaga rename ++project<cr>", {})
  buf_set_keymap(bufnr, "n", "<leader>fr", "<cmd>Lspsaga finder<cr>", {})
  buf_set_keymap(bufnr, "n", "<leader>so", "<cmd>Lspsaga outline<cr>", {})
  buf_set_keymap(bufnr, "n", "<leader>gf", "<cmd>lua vim.diagnostic.open_float()<cr>", {})
end
M.auto_cmp = function(cmp, luasnip)
  return cmp.mapping.preset.insert({
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  })
end
return M
