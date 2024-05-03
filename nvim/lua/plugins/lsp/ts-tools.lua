return {
	{
		"roobert/tailwindcss-colorizer-cmp.nvim",
		config = function()
			require("tailwindcss-colorizer-cmp").setup({
				color_square_width = 2,
			})
			require("cmp").config.formatting = {
				format = require("tailwindcss-colorizer-cmp").formatter,
			}
		end,
	},
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		config = function()
			local api = require("typescript-tools.api")
			require("typescript-tools").setup({
				handlers = {
					["textDocument/publishDiagnostics"] = api.filter_diagnostics({ 6133 }),
				},
				settings = {
					tsserver_file_preferences = {
						importModuleSpecifierPreference = "non-relative",
					},
				},
			})
			local autocmd = vim.api.nvim_create_autocmd
			autocmd("BufWritePre", {
				pattern = "*.ts,*.tsx,*.jsx,*.js",
				callback = function(args)
					vim.cmd("TSToolsAddMissingImports sync")
					vim.cmd("TSToolsOrganizeImports sync")
				end,
			})
		end,
	},
}
