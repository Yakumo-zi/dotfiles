local uv = vim.uv or vim.loop

local M = {}

M.clipboard_commands = { "pbcopy", "xclip", "xsel", "wl-copy", "win32yank.exe" }

M.formatter_commands = {
  ruff_format = "ruff",
}

M.lsp_commands = {
  clangd = "clangd",
  gopls = "gopls",
  lua_ls = "lua-language-server",
  ocamllsp = "ocamllsp",
  pyright = "pyright-langserver",
  ts_ls = "typescript-language-server",
  zls = "zls",
}

function M.path_exist(path)
  return type(path) == "string" and uv.fs_stat(path) ~= nil
end

function M.executable(command)
  return type(command) == "string"
    and command ~= ""
    and vim.fn.executable(command) == 1
end

function M.first_executable(commands)
  for _, command in ipairs(commands or {}) do
    if M.executable(command) then return command end
  end
end

function M.has_any(commands) return M.first_executable(commands) ~= nil end

function M.filter_available(items, command_by_item)
  local available = {}

  for _, item in ipairs(items or {}) do
    local commands = command_by_item and command_by_item[item] or item
    local ok = type(commands) == "table" and M.has_any(commands)
      or M.executable(commands)

    if ok then table.insert(available, item) end
  end

  return available
end

function M.filter_formatters_by_ft(formatters_by_ft, command_by_formatter)
  local available = {}

  for filetype, formatters in pairs(formatters_by_ft or {}) do
    local filtered = M.filter_available(formatters, command_by_formatter)
    if #filtered > 0 then available[filetype] = filtered end
  end

  return available
end

return M
