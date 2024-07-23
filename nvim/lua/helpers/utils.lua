local Terminal      = require('toggleterm.terminal').Terminal
local M             = {}

---@type TermCreateArgs
local term_opts     = {
  direction = "float",
  display_name = "float_term"
}

local term_float    = Terminal:new(term_opts)

M.term_float_toggle = function()
  term_float:toggle()
end

M.get_config_path   = function()
  local os = jit.os
  local config_path = vim.fn.stdpath('config')
  if os == "Linux" then
    return config_path .. "/init.lua"
  elseif os == "Windows" then
    return config_path .. "\\init.lua"
  end
end

M.get_sources_file  = function(suffix)
  local f = io.popen("ls", "r")
  if f == nil then
    os.exit(1, true)
  end
  local source = {}
  for line in f:lines() do
    local res = string.match(line, "[a-zA-z0-9]*." .. suffix .. "$")
    if res ~= nil then
      source[#source + 1] = res
    end
  end
  return source
end

---@param input string
---@param delimiter string
---@return string[]
function string.split(input, delimiter)
  input = tostring(input)
  delimiter = tostring(delimiter)
  if (delimiter == '') then delimiter = " " end
  local pos, arr = 0, {}
  -- for each divider found
  for st, sp in function() return string.find(input, delimiter, pos, true) end do
    table.insert(arr, string.sub(input, pos, st - 1))
    pos = sp + 1
  end
  table.insert(arr, string.sub(input, pos))
  return arr
end

--- @param bufnr integer
--- @return string
M.get_buffer_path = function(bufnr)
  bufnr = bufnr or 0
  local path = vim.api.nvim_buf_get_name(bufnr)
  return path
end


--- @param path string
--- @param patterns string[]
--- @return string
M.get_current_file_root_path = function(path, patterns)
  if path == "" or path == nil then
    return vim.fn.getcwd()
  end
  local paths = string.split(path, "/")
  local newPaths = {}
  for i = 2, #paths - 1 do
    newPaths[i] = table.concat(paths, "/", 1, i)
  end
  for i = #newPaths, 2, -1 do
    for j = 1, #patterns do
      if vim.fn.filereadable(newPaths[i] .. "/" .. patterns[j]) == 1 then
        return newPaths[i]
      end
    end
  end
  return vim.fn.getcwd()
end

RootPathCache = {}

---cached_get_current_file_root_path
---@return string
M.cached_get_current_file_root_path = function()
  local path = M.get_buffer_path(0)
  path = string.match(path, "(.*/)")
  if path == nil then
    return vim.fn.getcwd()
  end
  local patterns = { "Cargo.toml", "go.mod", "Makefile", "CMakeLists.txt", "package.json", "pytprojcet.toml" }
  if RootPathCache[path] == nil then
    RootPathCache[path] = M.get_current_file_root_path(path, patterns)
  end
  return RootPathCache[path]
end


return M
