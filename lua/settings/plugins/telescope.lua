local ok, telescope = pcall(require, 'telescope')
if not ok then
    print 'Skipping telescope as it is not installed.'
    return
end

local actions = require 'telescope.actions'
local fb_actions = telescope.extensions.file_browser.actions

telescope.setup {
    defaults = {
        mappings = {
            i = {
                ['<C-k>'] = actions.move_selection_previous,
                ['<C-j>'] = actions.move_selection_next,
                ['<C-e>'] = actions.close,
                ['<D-k>'] = actions.move_selection_previous,
                ['<D-j>'] = actions.move_selection_next,
                ['<D-e>'] = actions.close,
            },
            n = {
                ['q'] = actions.close,
                ['<C-e>'] = actions.close,
                ['<D-e>'] = actions.close,
            },
        },
        file_ignore_patterns = {
            'node_modules',
            '.git/',
            '.git\\',
        }
    },
    pickers = {
        find_files = {
            hidden = true,
            prompt_prefix = '🔍 ',
        },
        projects = {
            theme = "dropdown",
        },
        buffers = {
            mappings = {
                i = {
                    ['<C-d>'] = actions.delete_buffer,
                }
            }
        },
    },
    extensions = {
        file_browser = {
            theme = 'ivy',
            hijack_netrw = true,
        },
        ['ui-select'] = {
            require("telescope.themes").get_dropdown {},
            mappings = {
                i = {
                    ['<Esc>'] = actions.close,
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
