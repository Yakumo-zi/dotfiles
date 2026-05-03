local config = require("command_card.config")

local M = {}

local function close(win)
  if win and vim.api.nvim_win_is_valid(win) then
    vim.api.nvim_win_close(win, true)
  end
end

function M.open(opts)
  opts = opts or {}

  local width = math.max(44, math.min(64, vim.o.columns - 4))
  local height = 7
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)
  local bufnr = vim.api.nvim_create_buf(false, true)
  local lines = {
    " Confirm",
    "",
    " " .. (opts.message or "Are you sure?"),
    "",
    " y yes   n no   q cancel",
  }

  local win = vim.api.nvim_open_win(bufnr, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = config.get().ui.border,
    title = " Confirm ",
    title_pos = "center",
  })

  vim.bo[bufnr].buftype = "nofile"
  vim.bo[bufnr].bufhidden = "wipe"
  vim.bo[bufnr].swapfile = false
  vim.bo[bufnr].modifiable = true
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
  vim.bo[bufnr].modifiable = false
  vim.wo[win].number = false
  vim.wo[win].relativenumber = false
  vim.wo[win].signcolumn = "no"

  local ns = vim.api.nvim_create_namespace("command-card-confirm")
  vim.api.nvim_buf_add_highlight(bufnr, ns, "Title", 0, 0, -1)
  vim.api.nvim_buf_add_highlight(bufnr, ns, "Comment", 4, 0, -1)

  vim.keymap.set("n", "y", function()
    close(win)
    if opts.on_confirm then opts.on_confirm() end
  end, { buffer = bufnr, silent = true, desc = "Confirm" })

  for _, lhs in ipairs({ "n", "q", "<Esc>" }) do
    vim.keymap.set("n", lhs, function()
      close(win)
      if opts.on_cancel then opts.on_cancel() end
    end, { buffer = bufnr, silent = true, desc = "Cancel" })
  end
end

return M
