local M = {}

local capabilities = require("cmp_nvim_lsp").default_capabilities()

M["rust_analyzer"] = function(server_name)
	vim.g.rustaceanvim = {
		server = {
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
	}
end

return M
