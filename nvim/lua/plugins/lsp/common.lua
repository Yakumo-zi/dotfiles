return {
	{

		"RRethy/vim-illuminate",
		event = "LspAttach",
	},
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				{
					path = "luvit-meta/library",
					words = { "vim%.uv" },
				},
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
	{
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async",
		},
		config = function()
			vim.o.foldcolumn = "1" -- '0' is not bad
			vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true

			-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
			vim.keymap.set("n", "zR", require("ufo").openAllFolds)
			vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
		end,
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
			"ray-x/go.nvim",
		},
		opts = {
			ensure_installed = {},
			automatic_installation = true,
		},
		config = function()
			require("mason").setup({
				ui = {
					border = "rounded",
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
			require("mason-lspconfig").setup()

			-- LSP appearance config
			vim.diagnostic.config({ virtual_text = true }, nil)

			-- LSP config
			local default_cap = require("cmp_nvim_lsp").default_capabilities()

			default_cap.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}

			local keymaps = require("plugins.lsp.configs.keymaps")
			local on_attach = function(client, bufnr)
				keymaps.on_attach(client, bufnr)
				require("lsp_signature").on_attach({
					bind = true,
					handler_opts = {
						border = "rounded",
					},
				}, bufnr)
			end

			local lspconfig = require("lspconfig")

			local lsp_autoconfig = {
				function(server_name)
					require("lspconfig")[server_name].setup({
						on_attach = on_attach,
						capabilities = default_cap,
					})
				end,
				["clangd"] = function()
					lspconfig.clangd.setup({
						cmd = { "clangd" },
						on_attach = function(client, bufnr)
							local cpp_runner = require("test.cpp_runner_ui")
							local map = require("helpers.keys").lsp_map
							on_attach(client, bufnr)
							map("<leader>cr", cpp_runner.run, bufnr, "Run cpp code")
							map("<leader>cp", cpp_runner.compile, bufnr, "Compile cpp code")
						end,
						capabilities = default_cap,
					})
				end,
				["gopls"] = function()
					local cfg = require("go.lsp").config()
					cfg.on_attach = on_attach
					lspconfig.gopls.setup(cfg)
				end,
			}

			require("mason-lspconfig").setup_handlers(lsp_autoconfig)
			require("ufo").setup()
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
