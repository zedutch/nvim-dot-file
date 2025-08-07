return {
    -- https://github.com/nvim-treesitter/nvim-treesitter
    "nvim-treesitter/nvim-treesitter",
    branch = "master", -- @TODO: Update to main but this requires more changes
    build = ":TSUpdate",
    lazy = false,
    config = function()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
            ensure_installed = {
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
            },
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
    end
}
