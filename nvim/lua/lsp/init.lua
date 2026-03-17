local M = {}

local augroup = vim.api.nvim_create_augroup("UserLspConfig", { clear = true })

local servers = {
  "clangd",
  "gopls",
  "lua_ls",
  "ocamllsp",
  "pyright",
  "ts_ls",
  "zls",
}

local function load_server_config(name)
  local module_name = "lsp." .. name
  local ok, config = pcall(require, module_name)

  if ok then return config end

  if config:find(("module '%s' not found"):format(module_name), 1, true) then
    return {}
  end

  error(config)
end

local function set_default_keymaps(bufnr)
  local opts = { buffer = bufnr, silent = true }

  vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set(
    "n",
    "K",
    function() vim.lsp.buf.hover({ border = "rounded" }) end,
    opts
  )
  vim.keymap.set(
    "n",
    "<space>wl",
    function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
    opts
  )
end

local function set_rust_keymaps(bufnr)
  local opts = { buffer = bufnr, silent = true }

  vim.keymap.set(
    "n",
    "<leader>ca",
    function() vim.cmd.RustLsp("codeAction") end,
    opts
  )

  vim.keymap.set("n", "K", function() vim.cmd.RustLsp({ "hover" }) end, opts)
end

local function setup_lsp_attach()
  vim.api.nvim_create_autocmd("LspAttach", {
    group = augroup,
    callback = function(ev)
      local client = vim.lsp.get_client_by_id(ev.data.client_id)

      set_default_keymaps(ev.buf)

      if
        client
        and (client.name == "rust-analyzer" or client.name == "rust_analyzer")
      then
        set_rust_keymaps(ev.buf)
      end
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
