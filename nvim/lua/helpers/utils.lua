local Terminal     = require('toggleterm.terminal').Terminal
local M            = {}

local bash_float   = Terminal:new({ cmd = "bash", direction = "float" })
local bash         = Terminal:new({ cmd = "bash", direction = "horizontal" })

M.bash_float       = function()
  bash_float:toggle()
end
M.bash             = function()
  bash:toggle()
end

M.get_config_path  = function()
  local os = jit.os
  local config_path = vim.fn.stdpath('config')
  if os == "Linux" then
    return config_path .. "/init.lua"
  elseif os == "Windows" then
    return config_path .. "\\init.lua"
  end
end
M.get_sources_file = function(suffix)
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

return M
