return {
	setup = function(lspconfig, lsp)
		lsp.lua_ls.setup({
			on_attach = lspconfig.on_attach,
			capabilities = lspconfig.capabilities,
			settings = {
				Lua = {
					completion = {
						callSnippet = "Replace",
					},
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
          hint={
            enable=true
          }
				},
			},
		})
	end,
}
