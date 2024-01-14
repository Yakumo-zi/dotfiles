vim.api.nvim_create_autocmd({ "BufWinEnter", "BufEnter" }, {
  pattern = { "*.*" },
  command = "lcd %:p:h",
})
