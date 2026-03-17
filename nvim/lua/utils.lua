local uv = vim.uv or vim.loop

return {
  path_exist = function(path)
    return uv.fs_stat(path) ~= nil
  end,
}
