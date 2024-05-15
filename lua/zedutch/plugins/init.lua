-- @TODO: plugins
--  • https://github.com/epwalsh/obsidian.nvim ??
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

    -- Disabled for now as I no longer have free access to copilot and I want to test writing without it again for a couple of weeks
    -- {
    --     "github/copilot.vim",
    --     event = "InsertEnter",
    -- },

    {
        -- https://github.com/nvim-lualine/lualine.nvim
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = {
                theme = "tokyonight",
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
}
