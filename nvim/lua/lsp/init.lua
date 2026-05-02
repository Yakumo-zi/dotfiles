local M = {}

local augroup = vim.api.nvim_create_augroup("UserLspConfig", { clear = true })
local keymaps = require("lsp.keymaps")
local servers = require("lsp.servers")

local function load_server_config(name)
  local module_name = "lsp." .. name
  local module_path = ("lua/%s.lua"):format(module_name:gsub("%.", "/"))
  if #vim.api.nvim_get_runtime_file(module_path, false) == 0 then return {} end

  return require(module_name)
end

local function setup_lsp_attach()
  vim.api.nvim_clear_autocmds({ group = augroup })

  vim.api.nvim_create_autocmd("LspAttach", {
    group = augroup,
    callback = function(ev)
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      keymaps.on_attach(client, ev.buf)
    end,
  })
end

function M.setup()
  setup_lsp_attach()

  for _, server in ipairs(servers) do
    vim.lsp.config(server, load_server_config(server))
  end

  vim.lsp.enable(servers)
end

return M
