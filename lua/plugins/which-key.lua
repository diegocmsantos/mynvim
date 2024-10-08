return {
	-- which-key helps you remember key bindings by showing a popup
	-- with the active keybindings of the command you started typing.
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		-- opts = {
		--   plugins = { spelling = true },
		--   defaults = {
		--     mode = { "n", "v" },
		--     ["g"] = { name = "+goto" },
		--     ["gs"] = { name = "+surround" },
		--     ["]"] = { name = "+next" },
		--     ["["] = { name = "+prev" },
		--     ["<leader><tab>"] = { name = "+tabs" },
		--     ["<leader>b"] = { name = "+buffer" },
		--     ["<leader>c"] = { name = "+code" },
		--     ["<leader>f"] = { name = "+file/find" },
		--     ["<leader>g"] = { name = "+git" },
		--     ["<leader>gh"] = { name = "+hunks" },
		--     ["<leader>q"] = { name = "+quit/session" },
		--     ["<leader>s"] = { name = "+search" },
		--     ["<leader>u"] = { name = "+ui" },
		--     ["<leader>w"] = { name = "+windows" },
		--     ["<leader>x"] = { name = "+diagnostics/quickfix" },
		--   },
		-- },
		-- config = function(_, opts)
		--   local wk = require("which-key")
		--   wk.setup(opts)
		--   wk.register(opts.defaults)
		-- end,
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = true })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
}
