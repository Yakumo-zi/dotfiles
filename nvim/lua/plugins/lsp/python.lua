return {
	setup = function(lspconfig, lsp)
		lsp.pylsp.setup({
			on_attach = lspconfig.on_attach,
			capabilities = lspconfig.capabilities,
		})
	end,
}
