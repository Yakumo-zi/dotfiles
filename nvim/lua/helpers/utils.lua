local Terminal   = require('toggleterm.terminal').Terminal
local M          = {}
local bash_float = Terminal:new({ cmd = "bash", direction = "float" })
local bash       = Terminal:new({ cmd = "bash", direction = "horizontal" })
M.bash_float     = function()
  bash_float:toggle()
end
M.bash           = function()
  bash:toggle()
end
return M
