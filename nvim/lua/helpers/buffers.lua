local M = {}

M.delete_this = function()
  local buffers = vim.api.nvim_list_bufs()
  local current = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(buffers) do
    if buf == current then
      vim.api.nvim_buf_delete(buf, { force = true })
      break
    end
  end
end
M.delete_others = function()
  local buffers = vim.api.nvim_list_bufs()
  local current = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(buffers) do
    if buf ~= current then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end
end

return M
