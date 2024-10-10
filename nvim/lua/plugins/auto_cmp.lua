-- 代码补全插件
-- 必须将依赖插件放到外部安装，否则会出现module not found
return {
	{
		"hrsh7th/cmp-nvim-lsp",
		lazy = true,
	},
	{

		"hrsh7th/cmp-buffer",
		lazy = true,
	},
	{

		"hrsh7th/cmp-path",
		lazy = true,
	},
	{
		"rafamadriz/friendly-snippets",
	},
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		event = "InsertEnter",
		dependencies = {
			{
				{ "saadparwaiz1/cmp_luasnip" },
				{
					"rafamadriz/friendly-snippets",
					config = function()
						require("luasnip.loaders.from_vscode").lazy_load()
					end,
				},
			},
		},
	},
	{
		"echasnovski/mini.pairs",
		version = "*",
		config = function()
			require("mini.pairs").setup({})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dnpendencies = {
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
		},
		opts = function(_, opts)
			opts.sources = opts.sources or {}
			table.insert(opts.sources, {
				name = "lazydev",
				group_index = 0, -- set group index to 0 to skip loading LuaLS completions
			})
		end,
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")
			cmp.setup({
				enabled = true,
				-- set the completion window border
				window = {
					completion = {
						border = "rounded", -- 使用圆角边框
						winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
					},
					documentation = {
						border = "rounded", -- 使用圆角边框
						winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
					},
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body) -- For `luasnip` users.
					end,
				},
				sources = cmp.config.sources({
					{ name = "copilot" },
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "treesitter" },
					{ name = "path" },
				}),
				mapping = require("plugins.lsp.configs.keymaps").auto_cmp(cmp, luasnip),
				formatting = {
					expandable_indicator = true,
					fields = { "abbr", "kind", "menu" },

					format = function(entry, vim_item)
						lspkind.cmp_format({
							mode = "symbol_text", -- show only symbol annotations
							maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
							ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
							show_labelDetails = true, -- show labelDetails in menu. Disabled by default
							symbol_map = { Copilot = "" },
						})(entry, vim_item)
						return vim_item
					end,
				},
			})
		end,
	},
}
