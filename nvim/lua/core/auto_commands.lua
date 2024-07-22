vim.api.nvim_create_autocmd({ "VimEnter" }, {
  pattern = { "*.*" },
  command = "lcd %:p:h",
})
