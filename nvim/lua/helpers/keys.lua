local M = {}

---map key
---@param mode string|table
---@param lhs string
---@param rhs function|string
---@param desc string|nil
M.map = function(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

---map key in buffer
---@param lhs string
---@param rhs string|function
---@param bufnr integer
---@param desc string|nil
M.lsp_map = function(lhs, rhs, bufnr, desc)
  vim.keymap.set("n", lhs, rhs, { silent = true, buffer = bufnr, desc = desc })
end

M.dap_map = function(mode, lhs, rhs, desc)
  M.map(mode, lhs, rhs, desc)
end

M.set_leader = function(key)
  vim.g.mapleader = key
  vim.g.maplocalleader = key
  M.map({ "n", "v" }, key, "<nop>")
end

return M
