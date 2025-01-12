-- @TODO: plugins
--  • https://github.com/rcarriga/cmp-dap
return {
    {
        -- https://github.com/numToStr/Comment.nvim
        "numToStr/Comment.nvim",
        event = "BufRead",
        dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
        config = function()
            require("Comment").setup({
                pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
            })
        end,
    },

    {
        -- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
        "JoosepAlviste/nvim-ts-context-commentstring",
        lazy = true,
        opts = {
            enable_autocmd = false,
        },
    },

    {
        "folke/todo-comments.nvim",
        event = "BufRead",
        opts = {
            highlight = {
                keyword = "wide_bg",
                after = "",
                pattern = [[.*<(KEYWORDS)\s*(\([^\)]*\))?:]],
            },
            search = {
                pattern = [[\b(KEYWORDS)\s*(\([^\)]*\))?:]],
            },
        },
    },

    {
        -- https://github.com/kylechui/nvim-surround
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = true,
    },

    {
        "p00f/clangd_extensions.nvim",
        ft = { "c", "cpp" },
    },

    {
        "olexsmir/gopher.nvim",
        ft = "go",
        config = true,
    },

    {
        "saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            popup = {
                border = "rounded",
                keys = {
                    open_url = { "gx", "<cr>" },
                    jump_forward = { "<leader>j" },
                    jump_back = { "<leader>k" },
                },
            },
            on_attach = function(bufnr)
                vim.keymap.set("n", "K", "<cmd>Crates show_popup<cr>", {
                    silent = true,
                    noremap = true,
                    buffer = bufnr,
                })
            end,
        },
    },

    {
        -- https://github.com/vuki656/package-info.nvim
        "vuki656/package-info.nvim",
        dependencies = { "MunifTanjim/nui.nvim" },
        event = { "BufRead package.json" },
        config = function()
            require("package-info").setup({
                package_manager = "pnpm",
            })
            vim.api.nvim_set_keymap(
                "n",
                "<leader>pd",
                "<cmd>lua require('package-info').delete()<cr>",
                { silent = true, noremap = true }
            )
            vim.api.nvim_set_keymap(
                "n",
                "<leader>pu",
                "<cmd>lua require('package-info').update()<cr>",
                { silent = true, noremap = true }
            )
        end,
    },

    {
        -- https://github.com/github/copilot.vim
        "github/copilot.vim",
        event = "InsertEnter",
        keys = {
            { "<leader>ce", "<cmd>Copilot enable<cr>" },
            { "<leader>cd", "<cmd>Copilot disable<cr>" },
        },
    },

    {
        -- https://github.com/nvim-lualine/lualine.nvim
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = {
                theme = "tokyonight",
            },
            sections = {
                lualine_b = {
                    "macro-recording",
                    fmt = show_macro_recording,
                },
            },
        },
    },

    {
        -- https://github.com/mrcjkb/rustaceanvim
        "mrcjkb/rustaceanvim",
        version = '^4', -- Recommended
        ft = { 'rust' },
    },

    {
        -- https://github.com/j-hui/fidget.nvim
        "j-hui/fidget.nvim",
        lazy = false,
        keys = {
            { "<leader>mm", "<cmd>lua require('fidget').notification.show_history()<cr>" },
        },
        opts = {
            notification = {
                override_vim_notify = true,
            },
        },
    },

    {
        -- https://github.com/iamcco/markdown-preview.nvim
        "iamcco/markdown-preview.nvim",
        ft = "markdown",
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
        cmd = {
            "MarkdownPreview",
            "MarkdownPreviewStop",
            "MarkdownPreviewToggle",
        },
    },

    {
        -- https://github.com/michaelrommel/nvim-silicon
        "michaelrommel/nvim-silicon",
        lazy = true,
        cmd = "Silicon",
        config = function()
            require("silicon").setup({
                -- Configuration here, or leave empty to use defaults
                disable_defaults = true,
                language = function()
                    return vim.bo.filetype
                end,
                output = function()
                    return "~/Downloads/" .. os.date("!%Y-%m-%dT%H-%M-%S") .. "_code.png"
                end,
            })
        end
    },

    {
        -- https://github.com/NoahTheDuke/vim-just
        "NoahTheDuke/vim-just",
        ft = { "just" },
    },

    {
        -- https://github.com/epwalsh/obsidian.nvim
        "epwalsh/obsidian.nvim",
        version = "*", -- recommended, use latest release instead of latest commit
        lazy = true,
        ft = "markdown",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",
            "nvim-telescope/telescope.nvim",
        },
        config = {
            workspaces = {
                {
                    name = "notes",
                    path = "~/Notes",
                },
            },
            completion = {
                nvim_cmp = true,
                min_chars = 2,
            },
        },
        keys = {
            { "<leader>ot", "<cmd>ObsidianToday<cr>" },
            { "<leader>od", "<cmd>ObsidianDailies<cr>" },
            { "<leader>oc", "<cmd>ObsidianToggleCheckbox<cr>" },
            { "<leader>oe", "<cmd>ObsidianExtractNote<cr>" },
            { "<leader>of", "<cmd>ObsidianSearch<cr>" },
        },
    },

    {
        -- https://github.com/mbbill/undotree
        "mbbill/undotree",
        keys = {
            { "<leader>u", "<cmd>UndotreeToggle<cr>" },
        },
    },

    {
        -- https://github.com/laytan/tailwind-sorter.nvim
        'laytan/tailwind-sorter.nvim',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-lua/plenary.nvim',
        },
        build = 'cd formatter && npm ci && npm run build',
        config = {
            on_save_enabled = true,
            trim_spaces = false,
        },
    },
}
