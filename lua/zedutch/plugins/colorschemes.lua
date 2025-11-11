return {
    -- https://github.com/folke/tokyonight.nvim
    {
        "folke/tokyonight.nvim",
        lazy = true,
        priority = 1000,
        opts = {
            style = "storm",
            dim_inactive = true,
            sidebars = { "qf" },
            styles = {
                keywords = {},
            }
        },
    },
    -- https://github.com/rose-pine/neovim
    {
        "rose-pine/neovim",
        lazy = true,
        name = 'rose-pine',
        priority = 1000,
        opts = {},
    },
    -- https://github.com/rebelot/kanagawa.nvim
    {
        "rebelot/kanagawa.nvim",
        lazy = true,
        priority = 1000,
        opts = {},
    },
    -- https://github.com/ellisonleao/gruvbox.nvim
    { "ellisonleao/gruvbox.nvim",
        lazy = false,
        priority = 1000,
        config = true,
    },
}
