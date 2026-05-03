local M = {}

local defaults = {
  storage = {
    path = vim.fn.stdpath("config") .. "/command-card/commands.json",
  },
  project = {
    root_markers = { ".git", "go.mod", "package.json", "pyproject.toml" },
    root = nil,
  },
  ui = {
    border = "rounded",
    width = 0.72,
    height = 0.55,
  },
  output = {
    open = "split",
    height = 14,
  },
}

M.options = vim.deepcopy(defaults)

function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", vim.deepcopy(defaults), opts or {})
  return M.options
end

function M.get() return M.options end

return M
