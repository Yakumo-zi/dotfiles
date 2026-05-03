local M = {}

local function map(bufnr, lhs, rhs, desc)
  vim.keymap.set("n", lhs, rhs, {
    buffer = bufnr,
    desc = desc,
    silent = true,
  })
end

local function set_compat_keymaps(bufnr)
  vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

  map(bufnr, "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
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
  set_compat_keymaps(bufnr)

  if
    client
    and (client.name == "rust-analyzer" or client.name == "rust_analyzer")
  then
    set_rust_keymaps(bufnr)
  end
end

return M
