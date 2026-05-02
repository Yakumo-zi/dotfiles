local M = {}

local function map(bufnr, lhs, rhs, desc)
  vim.keymap.set("n", lhs, rhs, {
    buffer = bufnr,
    desc = desc,
    silent = true,
  })
end

local function set_default_keymaps(bufnr)
  vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

  map(bufnr, "gD", vim.lsp.buf.declaration, "Go to declaration")
  map(bufnr, "gd", vim.lsp.buf.definition, "Go to definition")
  map(
    bufnr,
    "<leader>wa",
    vim.lsp.buf.add_workspace_folder,
    "Add workspace folder"
  )
  map(
    bufnr,
    "<leader>wr",
    vim.lsp.buf.remove_workspace_folder,
    "Remove workspace folder"
  )
  map(bufnr, "<leader>D", vim.lsp.buf.type_definition, "Go to type definition")
  map(bufnr, "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
  map(
    bufnr,
    "K",
    function() vim.lsp.buf.hover({ border = "rounded" }) end,
    "Hover"
  )
  map(
    bufnr,
    "<leader>wl",
    function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
    "List workspace folders"
  )
end

local function set_rust_keymaps(bufnr)
  map(
    bufnr,
    "<leader>ca",
    function() vim.cmd.RustLsp("codeAction") end,
    "Code actions"
  )
  map(
    bufnr,
    "K",
    function() vim.cmd.RustLsp({ "hover", "actions" }) end,
    "Rust hover actions"
  )
end

function M.on_attach(client, bufnr)
  set_default_keymaps(bufnr)

  if
    client
    and (client.name == "rust-analyzer" or client.name == "rust_analyzer")
  then
    set_rust_keymaps(bufnr)
  end
end

return M
