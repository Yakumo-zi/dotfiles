local M = {}
M.on_attach = function(client, bufnr)
  local buf_set_keymap = vim.api.nvim_buf_set_keymap
  buf_set_keymap(bufnr, "n", "<leader>ca", ":lua vim.lsp.buf.code_action()<CR>", {})
  buf_set_keymap(bufnr, "n", "gd", ":lua vim.lsp.buf.definition()<CR>", {})
  buf_set_keymap(bufnr, "n", "K", ":lua vim.lsp.buf.hover()<CR>", {})
  buf_set_keymap(bufnr, "n", "<leader>fm", ":lua vim.lsp.buf.format { async = true }<CR>", {})
end
M.auto_cmp = function(cmp, luasnip)
  return cmp.mapping.preset.insert({
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-u>"] = cmp.mapping.scroll_docs(4),
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
