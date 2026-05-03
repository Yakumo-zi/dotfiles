local env = require("env")

local servers = {
  "clangd",
  "gopls",
  "lua_ls",
  "ocamllsp",
  "pyright",
  "ts_ls",
  "zls",
}

return env.filter_available(servers, env.lsp_commands)
