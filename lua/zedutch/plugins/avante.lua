return {
    -- https://github.com/yetone/avante.nvim
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false,
    lazy = false,
    build = "make",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-telescope/telescope.nvim",
        "hrsh7th/nvim-cmp",
        "stevearc/dressing.nvim",
        "zbirenbaum/copilot.lua",
        {
            'MeanderingProgrammer/render-markdown.nvim',
            opts = {
                file_types = { "markdown", "Avante" },
            },
            ft = { "markdown", "Avante" },
        },
        {
            -- support for image pasting
            "HakonHarnes/img-clip.nvim",
            event = "VeryLazy",
            opts = {
                -- recommended settings
                default = {
                    embed_image_as_base64 = false,
                    prompt_for_file_name = false,
                    drag_and_drop = {
                        insert_mode = true,
                    },
                    -- required for Windows users
                    use_absolute_path = true,
                },
            },
        },
    },
    opts = {
        provider = "openai",
        openai = {
            endpoint = "https://api.openai.com/v1",
            model = "gpt-4.1",             -- your desired model (or use gpt-4o, etc.)
            timeout = 30000,              -- Timeout in milliseconds, increase this for reasoning models
            temperature = 0,
            max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
            --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
        },
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
