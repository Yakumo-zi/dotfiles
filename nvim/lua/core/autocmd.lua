vim.o.updatetime = 300

local augroup = vim.api.nvim_create_augroup("UserAutocmds", { clear = true })

vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup,
  pattern = "*",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = "*",
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    if ft == "" then return end

    local ok, lang = pcall(vim.treesitter.language.get_lang, ft)
    if not ok or not lang then lang = ft end

    local parser = ("parser/%s.*"):format(lang)

    if #vim.api.nvim_get_runtime_file(parser, false) > 0 then
      pcall(vim.treesitter.start, args.buf, lang)
    end
  end,
})
