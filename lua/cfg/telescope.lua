require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                ["<esc>"] = require('telescope.actions').close,
            },
        },
        file_ignore_patterns = {
            "node_modules",
            ".git/",
        }
    },
    pickers = {
        find_files = {
            hidden = true,
        },
    },
}
