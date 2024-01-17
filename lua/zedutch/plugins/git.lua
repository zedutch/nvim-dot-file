return {
    {
        -- https://github.com/tpope/vim-fugitive
        "tpope/vim-fugitive",
        keys = {
            { "<leader>gs", vim.cmd.Git },
        },
    },

    {
        -- https://github.com/lewis6991/gitsigns.nvim
        "lewis6991/gitsigns.nvim",
        event = "BufRead",
        config = true,
        keys = {
            { "<leader>gb", function() require("gitsigns").blame_line() end },
        },
    },

    {
        -- https://github.com/akinsho/git-conflict.nvim
        "akinsho/git-conflict.nvim",
        version = "*",
        event = "BufRead",
        config = function()
            require("git-conflict").setup({})

            vim.api.nvim_create_autocmd('User', {
                pattern = 'GitConflictDetected',
                callback = function()
                    vim.notify('Conflict detected in ' .. vim.fn.expand('<afile>'))
                end
            })
        end,
    },
}
