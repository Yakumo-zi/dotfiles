return {
	{
		"folke/neodev.nvim",
		lazy = true,
	},
	{

		"RRethy/vim-illuminate",
		event = "LspAttach",
	},
	{
		"j-hui/fidget.nvim",
		branch = "legacy",
		lazy = true,
	},
	{
		"aznhe21/actions-preview.nvim",
		config = function()
			vim.keymap.set({ "v", "n" }, "<leader>ca", require("actions-preview").code_actions)
			require("actions-preview").setup({
				telescope = {
					sorting_strategy = "ascending",
					layout_strategy = "vertical",
					layout_config = {
						width = 0.8,
						height = 0.9,
						prompt_position = "top",
						preview_cutoff = 20,
						preview_height = function(_, _, max_lines)
							return max_lines - 15
						end,
					},
				},
			})
		end,
	},
	"neovim/nvim-lspconfig",
	event = { "CursorHold", "CursorHoldI" },
	init = function()
		vim.diagnostic.config({
			float = {
				show_header = true,
				source = "if_many",
				border = "rounded",
				focusable = false,
			},
		}, nil)
	end,
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		opts = {
			ensure_installed = {
				"lua_ls",
				"clangd",
				"rust-analyzer",
			},
			automatic_installation = true,
		},
		config = function()
			-- Neodev setup before LSP config
			require("neodev").setup()
			require("mason").setup()
			require("mason-lspconfig").setup()

			-- Turn on LSP status information
			require("fidget").setup({
				window = { winblend = 0 },
			})
			-- LSP appearance config
			vim.diagnostic.config({ virtual_text = true }, nil)

			-- LSP config
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local server_configs = require("plugins.lsp.configs.server_configs")
			local keymaps = require("plugins.lsp.configs.keymaps")
			local lsp_autoconfig = {
				function(server_name)
					require("lspconfig")[server_name].setup({
						on_attach = function(client, bufnr)
							keymaps.on_attach(client, bufnr)
							require("lsp_signature").on_attach({
								bind = true,
								handler_opts = {
									border = "rounded",
								},
							}, bufnr)
						end,
						capabilities = capabilities,
					})
				end,
				["rust_analyzer"] = function() end,
			}

			require("mason-lspconfig").setup_handlers(lsp_autoconfig)
		end,
	},
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {},
		config = function(_, opts)
			require("lsp_signature").setup(opts)
		end,
	},
}
