require('nvim-tree').setup {
    -- syn_root_with_cwd = true,
    -- reload_on_bufenter = true,
    update_cwd = true,
    respect_buf_cwd = true,
    update_focused_file = {
        enable = true,
        update_cwd = true,
    },
    view = {
        adaptive_size = true,
        mappings = {
            list = {
                { key = "u", action = "dir_up" },
                { key = "n", action = "create" },
                { key = "<leader>?", action = "toggle_help" },
            },
        },
    },
    filters = {
        dotfiles = false,
        custom = {
            "^.git",
            "^node_modules",
        },
        exclude = {
            "^.gitlab-ci.yml$",
        },
    },
    renderer = {
        highlight_opened_files = "all",
    },
    actions = {
        open_file = {
            quit_on_open = true,
        },
    },
    diagnostics = {
        enable = true,
        show_on_dirs = false,
    },
}
