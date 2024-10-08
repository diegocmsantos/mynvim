-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
	-- NOTE: Yes, you can install new plugins here!
	'mfussenegger/nvim-dap',

	-- NOTE: And you can specify dependencies as well
	dependencies = {
		-- Creates a beautiful debugger UI
		'rcarriga/nvim-dap-ui',
		'nvim-neotest/nvim-nio',

		-- Installs the debug adapters for you
		'williamboman/mason.nvim',
		'jay-babu/mason-nvim-dap.nvim',

		-- Add your own debuggers here
		'leoluz/nvim-dap-go',

		-- Shows the current line in the virtual text
		'theHamsta/nvim-dap-virtual-text',
	},

	config = function()
		local dap = require 'dap'
		local dapui = require 'dapui'

		require('mason-nvim-dap').setup {
			-- Makes a best effort to setup the various debuggers with
			-- reasonable debug configurations
			automatic_setup = true,

			-- You'll need to check that you have the required things installed
			-- online, please don't ask me how to install them :)
			ensure_installed = {
				-- Update this to ensure that you have the debuggers for the langs you want
				'delve',
			},
		}

		-- You can provide additional configuration to the handlers,
		-- see mason-nvim-dap README for more information
		-- require('mason-nvim-dap').setup_handlers()

		-- Basic debugging keymaps, feel free to change to your liking!
		vim.keymap.set('n', '<F5>', dap.continue, { silent = true, noremap = true, desc = 'Continue' })
		vim.keymap.set('n', '<F7>', dap.step_into, { silent = true, noremap = true, desc = 'Step into' })
		vim.keymap.set('n', '<F8>', dap.step_over, { silent = true, noremap = true, desc = 'Step over' })
		vim.keymap.set('n', '<S-<F7>>', dap.step_out, { silent = true, noremap = true, desc = 'Step out' })
		vim.keymap.set('n', '<F9>', dap.terminate, { silent = true, noremap = true, desc = 'Terminate' })
		vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint,
			{ silent = true, noremap = true, desc = 'Toggle breakpoint' })
		vim.keymap.set('n', '<leader>dB', function()
			dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
		end, { silent = true, noremap = true, desc = 'Set breakpoint condition' })
		vim.keymap.set('n', '<leader>dr', dap.repl.open, { silent = true, noremap = true, desc = 'Open REPL' })
		vim.keymap.set('n', '<leader>v', '<Cmd>lua require("dapui").eval()<CR>',
			{ silent = true, noremap = true, desc = 'Evaluate expression' })

		-- dap ui keymaps
		vim.keymap.set('n', '<leader>du', dapui.toggle, { silent = true, noremap = true, desc = 'Toggle UI' })

		-- Dap UI setup
		-- For more information, see |:help nvim-dap-ui|
		dapui.setup {
			-- Set icons to characters that are more likely to work in every terminal.
			--    Feel free to remove or use ones that you like more! :)
			--    Don't feel like these are good choices.
			icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
			controls = {
				icons = {
					pause = '⏸',
					play = '▶',
					step_into = '⏎',
					step_over = '⏭',
					step_out = '⏮',
					step_back = 'b',
					run_last = '▶▶',
					terminate = '⏹',
				},
			},
		}

		dap.listeners.after.event_initialized['dapui_config'] = dapui.open
		-- dap.listeners.before.event_terminated['dapui_config'] = dapui.close
		dap.listeners.before.event_exited['dapui_config'] = dapui.close

		-- allow use of the vscode launch.json file for debugging
		require('dap.ext.vscode').load_launchjs(nil, {})

		-- Install golang specific config
		local dapgo = require('dap-go')
		vim.keymap.set('n', '<leader>dt', dapgo.debug_test,
			{ silent = true, noremap = true, desc = 'Debug test' })
		vim.keymap.set('n', '<leader>dl', dapgo.debug_last_test,
			{ silent = true, noremap = true, desc = 'Debug last test' })
		dapgo.setup()

		-- Install virtual text
		require('nvim-dap-virtual-text').setup()
	end,
}
