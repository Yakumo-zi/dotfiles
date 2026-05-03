return {
  {
    "stevearc/conform.nvim",
    keys = {
      {
        "<leader>fm",
        function() require("conform").format({ lsp_format = "fallback" }) end,
        desc = "Format Files",
      },
    },
    opts = function(_, opts)
      return vim.tbl_deep_extend(
        "force",
        opts or {},
        require("configs.conform")
      )
    end,
  },
}
