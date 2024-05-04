return {
	"mrcjkb/rustaceanvim",
	version = "^4", -- Recommended
	ft = { "rust" },
	opt = {
		server = {
			cmd = function()
				local mason_registry = require("mason-registry")
				local ra_binary = mason_registry.is_installed("rust-analyzer")
						-- This may need to be tweaked, depending on the operating system.
						and mason_registry.get_package("rust-analyzer"):get_install_path() .. "/rust-analyzer"
					or "rust-analyzer"
				return { ra_binary } -- You can add args to the list, such as '--log-file'
			end,
			on_attach = function(client, bufnr)
				local opts = { silent = true, buffer = bufnr }
				vim.keymap.set("n", "<leader>ca", function()
					vim.cmd.RustLsp("codeAction")
				end, opts)
				vim.keymap.set("n", "K", function()
					vim.cmd.RustLsp("openDocs")
				end, opts)
				vim.keymap.set("n", "<leader>oc", function()
					vim.cmd.RustLsp("openCargo")
				end, opts)
			end,
		},
	},
}
