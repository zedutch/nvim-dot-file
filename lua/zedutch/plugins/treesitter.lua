return {
    -- https://github.com/nvim-treesitter/nvim-treesitter
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    config = function()
        local ts = require('nvim-treesitter')
        ts.setup({
            install_dir = vim.fn.stdpath('data') .. '/site',
            sync_install = false,
            auto_install = true,
            ignore_install = {},
            modules = {},
            highlight = {
                enable = true,
            },
            additional_vim_regex_highlighting = false,
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<Enter>",
                    node_incremental = "<Enter>",
                    node_decremental = "<BS>",
                },
            },
        })
        ts.install({
            "c",
            "go",
            "javascript",
            "jsdoc",
            "lua",
            "markdown",
            "markdown_inline",
            "odin",
            "python",
            "rust",
            "typescript",
            "vim",
            "vimdoc",
        })
    end
}
