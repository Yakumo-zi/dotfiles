local utils = require("utils")
local function set_python_path(command)
  local path = command.args
  local clients = vim.lsp.get_clients({
    bufnr = vim.api.nvim_get_current_buf(),
    name = "pyright",
  })
  for _, client in ipairs(clients) do
    if client.settings then
      client.settings.python = vim.tbl_deep_extend(
        "force",
        client.settings.python --[[@as table]],
        { pythonPath = path }
      )
    else
      client.config.settings = vim.tbl_deep_extend(
        "force",
        client.config.settings,
        { python = { pythonPath = path } }
      )
    end
    client:notify("workspace/didChangeConfiguration", { settings = nil })
  end
end

return {
  root_markers = {
    "pyrightconfig.json",
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    ".git",
  },
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "openFilesOnly",
      },
    },
  },
  on_attach = function(client, bufnr)
    local root_dir = client.config.root_dir
    local default_venv_path = root_dir .. "/" .. ".venv/bin/python"
    if utils.path_exist(default_venv_path) then
      set_python_path({
        args = default_venv_path,
      })
    end

    vim.api.nvim_buf_create_user_command(
      bufnr,
      "LspPyrightOrganizeImports",
      function()
        local params = {
          command = "pyright.organizeimports",
          arguments = { vim.uri_from_bufnr(bufnr) },
        }

        client.request("workspace/executeCommand", params, nil, bufnr)
      end,
      {
        desc = "Organize Imports",
      }
    )
    vim.api.nvim_buf_create_user_command(
      bufnr,
      "LspPyrightSetPythonPath",
      set_python_path,
      {
        desc = "Reconfigure pyright with the provided python path",
        nargs = 1,
        complete = "file",
      }
    )
  end,
}
