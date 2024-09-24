return {
    -- https://github.com/yetone/avante.nvim
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    build = "make",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        {
            'MeanderingProgrammer/render-markdown.nvim',
            opts = {
                file_types = { "markdown", "Avante" },
            },
            ft = { "markdown", "Avante" },
        },
    },
    opts = {
        mappings = {
            ask = "<leader>aa",
            edit = "<leader>ae",
            refresh = "<leader>ar",
            diff = {
                ours = "co",
                theirs = "ct",
                none = "c0",
                both = "cb",
                next = "]x",
                prev = "[x",
            },
            jump = {
                next = "]]",
                prev = "[[",
            },
            submit = {
                normal = "<CR>",
                insert = "<C-s>",
            },
            toggle = {
                debug = "<leader>ad",
                hint = "<leader>ah",
            },
        },
    },
}
