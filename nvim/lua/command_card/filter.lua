local config = require("command_card.config")
local util = require("command_card.util")

local M = {}

local function close(win)
  if win and vim.api.nvim_win_is_valid(win) then
    vim.api.nvim_win_close(win, true)
  end
end

local function parse(bufnr)
  for _, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)) do
    local value = line:match("^%s*filter:%s*(.*)$")
    if value then return util.trim(value) end
  end

  return ""
end

function M.open(current, callback)
  local width = math.max(48, math.min(72, vim.o.columns - 4))
  local height = 7
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)
  local bufnr = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(bufnr, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = config.get().ui.border,
    title = " Filter Commands ",
    title_pos = "center",
  })

  vim.bo[bufnr].buftype = "nofile"
  vim.bo[bufnr].bufhidden = "wipe"
  vim.bo[bufnr].swapfile = false
  vim.bo[bufnr].filetype = "command-card-filter"
  vim.wo[win].number = false
  vim.wo[win].relativenumber = false
  vim.wo[win].signcolumn = "no"

  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {
    " Command Filter",
    "",
    " filter: " .. (current or ""),
    "",
    " s/<enter> apply   q cancel",
  })

  local ns = vim.api.nvim_create_namespace("command-card-filter")
  vim.api.nvim_buf_add_highlight(bufnr, ns, "Title", 0, 0, -1)
  vim.api.nvim_buf_add_highlight(bufnr, ns, "Identifier", 2, 1, 8)
  vim.api.nvim_buf_add_highlight(bufnr, ns, "Comment", 4, 0, -1)
  pcall(vim.api.nvim_win_set_cursor, win, { 3, 9 })

  local function apply()
    local value = parse(bufnr)
    close(win)
    if callback then callback(value) end
  end

  vim.keymap.set("n", "s", apply, {
    buffer = bufnr,
    silent = true,
    desc = "Apply filter",
  })
  vim.keymap.set("n", "<CR>", apply, {
    buffer = bufnr,
    silent = true,
    desc = "Apply filter",
  })
  for _, lhs in ipairs({ "q", "<Esc>" }) do
    vim.keymap.set("n", lhs, function() close(win) end, {
      buffer = bufnr,
      silent = true,
      desc = "Cancel filter",
    })
  end
end

return M
