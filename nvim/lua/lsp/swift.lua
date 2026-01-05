local cmd = { "sourcekit-lsp" }
if vim.fn.executable(cmd[1]) ~= 1 and vim.fn.executable("xcrun") == 1 then
  cmd = { "xcrun", "sourcekit-lsp" }
end

return {
  cmd = cmd,
}
