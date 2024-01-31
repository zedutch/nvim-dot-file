return {
	'nvim-telescope/telescope.nvim',
	branch = '0.1.x',
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sharkdp/fd",
		"nvim-telescope/telescope-ui-select.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
		{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Find with grep" },
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find in NVim help" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
		{ "<leader>;", "<cmd>Telescope resume<cr>", desc = "Telescope resume" },
	},
	config = function()
		local actions = require("telescope.actions")
		require("telescope").setup {
			defaults = {
				file_ignore_patterns = {
					'node_modules',
					'.git/',
					'.git\\',
					'.godot',
					'vendor',
				},
				mappings = {
					i = {
						['<C-k>'] = actions.move_selection_previous,
						['<C-j>'] = actions.move_selection_next,
					},
				},
			},
			pickers = {
				find_files = {
					hidden = true,
					prompt_prefix = '🔍 ',
				},
			},
			extensions = {
				['ui-select'] = {
					require("telescope.themes").get_dropdown {},
					mappings = {
						i = {
							['<C-k>'] = actions.move_selection_previous,
							['<C-j>'] = actions.move_selection_next,
						},
					},
				}
			},
		}
		require("telescope").load_extension("ui-select")
	end,
}
