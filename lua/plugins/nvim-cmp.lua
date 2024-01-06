return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		{
			"L3MON4D3/LuaSnip",
			dependencies = {
				"rafamadriz/friendly-snippets",
				"saadparwaiz1/cmp_luasnip",
				"hrsh7th/vim-vsnip",
				"hrsh7th/cmp-vsnip",
			},
		},
	},
	config = function()
		local cmp = require('cmp')
		local luasnip = require("luasnip")

		luasnip.config.set_config({
			history = false,
			updateevents = "TextChanged,TextChangedI",
		})

		luasnip.snippets = {
			html = {}
		}

		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},

			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
				["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
				["<C-e>"] = cmp.mapping.abort(),    -- close completion window
				["<CR>"] = cmp.mapping.confirm({ select = false }),

				["<Tab>"] = cmp.mapping(function(fallback) -- tab to jump to next snippet's placeholder
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s" }),

				["<S-Tab>"] = cmp.mapping(function(fallback) -- shift-tab to jump to previous snippet's placeholder
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),

			-- Order of sources determines order of sourcing
			sources = cmp.config.sources({
				{ name = "vsnip" },
				{ name = "nvim_lsp" },
				{ name = "treesitter" },
				{ name = "buffer" },
				{ name = "luasnip" },
				{ name = "nvim_lua" },
				{ name = "path" },
			}),
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
		})
	end
}
