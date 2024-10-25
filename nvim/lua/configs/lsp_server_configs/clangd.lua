return {
  on_attach = function(client, buf)
    local group = vim.api.nvim_create_augroup("clangd_no_inlay_hints_in_insert", { clear = true })
    vim.keymap.set("n", "<leader>lh", function()
      if require("clangd_extensions.inlay_hints").toggle_inlay_hints() then
        vim.api.nvim_create_autocmd("InsertEnter", {
          group = group,
          buffer = buf,
          callback = require("clangd_extensions.inlay_hints").disable_inlay_hints
        })
        vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave" }, {
          group = group,
          buffer = buf,
          callback = require("clangd_extensions.inlay_hints").set_inlay_hints
        })
      else
        vim.api.nvim_clear_autocmds({ group = group, buffer = buf })
      end
    end, { buffer = buf, desc = "[l]sp [h]ints toggle" })
  end,
  opts = {
    keys = {
      { "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
    },
    root_dir = function(fname)
      return require("lspconfig.util").root_pattern(
        "Makefile",
        "configure.ac",
        "configure.in",
        "config.h.in",
        "meson.build",
        "meson_options.txt",
        "build.ninja"
      )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(
        fname
      ) or require("lspconfig.util").find_git_ancestor(fname)
    end,
    capabilities = {
      offsetEncoding = { "utf-16" },
    },
    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--header-insertion=iwyu",
      "--completion-style=detailed",
      "--function-arg-placeholders",
      "--fallback-style=llvm",
    },
    init_options = {
      usePlaceholders = true,
      completeUnimported = true,
      clangdFileStatus = true,
    },
  }
}
