local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files)
vim.keymap.set('n', '<leader>fg', builtin.live_grep)
vim.keymap.set('n', '<leader>fp', "<cmd>Telescope projects<CR>")
vim.keymap.set('n', '<leader>fb', "<cmd>Telescope file_browser<CR>")
vim.keymap.set('n', '<C-p>', builtin.git_files)
-- vim.keymap.set('n', '<leader>bb', builtin.buffers)
vim.keymap.set('n', '<leader>fh', builtin.help_tags)
vim.keymap.set('n', '<leader>fs', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
vim.keymap.set("n", ";", builtin.resume)

local actions = require 'telescope.actions'
local telescope = require('telescope')

telescope.setup {
    defaults = {
        file_ignore_patterns = {
            'node_modules',
            '.git/',
            '.git\\',
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
        projects = {
            theme = "dropdown",
        },
    },
    extensions = {
        file_browser = {
            theme = 'ivy',
            hijack_netrw = true,
            initial_mode = 'normal',
        },
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

telescope.load_extension('file_browser')
telescope.load_extension('ui-select')
telescope.load_extension('projects')
