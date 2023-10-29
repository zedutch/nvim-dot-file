local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "nvim-telescope/telescope.nvim",
        lazy = true,
        event = "VeryLazy",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
            { "sharkdp/fd" },
            { "ahmedkhalf/project.nvim" },
        },
        priority = 40,
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        lazy = true,
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        lazy = true,
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 100,
    },
    {
        "akinsho/bufferline.nvim",
        version = "v3.*",
        dependencies = "nvim-tree/nvim-web-devicons",
        priority = 110, -- After catppuccin per the documentation
        lazy = true,
        event = "VeryLazy",
    },
    {
        "tyru/open-browser.vim",
        event = "VeryLazy",
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = "InsertEnter",
        dependencies = {
            { 'windwp/nvim-ts-autotag' },
        }
    },
    {
        "theprimeagen/harpoon",
        event = "InsertEnter",
        config = function()
            require('settings.plugins.harpoon')
        end,
    },
    {
        "mbbill/undotree",
        keys = {
            { "<leader>u", ":UndotreeToggle<CR>" },
        },
    },
    {
        "tpope/vim-fugitive",
        keys = {
            { "<leader>gs", vim.cmd.Git },
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        config = true,
        event = "VeryLazy",
    },

    -- LSP Support
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "williamboman/mason-lspconfig.nvim",
                lazy = true,
            },
            {
                "williamboman/mason.nvim",
                build = function()
                    vim.cmd.MasonUpdate()
                end,
                cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
                keys = {
                    { '<leader>li', '<cmd>LspInfo<CR>' },
                },
            },
            { "simrat39/rust-tools.nvim", },
        },
        config = function()
            require('settings.lsp')
        end,
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        event = "InsertEnter",
        keys = {
            { '<leader>ln', '<cmd>NullLsInfo<CR>' },
        },
    },

    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            { "nvim-autopairs" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lua" },
            { "L3MON4D3/LuaSnip" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-emoji" },
            { "David-Kunz/cmp-npm" },
            { "rafamadriz/friendly-snippets" },
        },
        config = function()
            require('settings.plugins.cmp')
        end,
    },

    {
        "L3MON4D3/LuaSnip",
        version = "1.*",
        build = "make install_jsregexp",
        dependencies = {
            { "rafamadriz/friendly-snippets" },
        }
    },

    {
        "saecki/crates.nvim",
        tag = "v0.3.0",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = "InsertEnter",
        opts = {
            null_ls = {
                enabled = true,
                name = "Crates",
            },
        },
    },
    {
        "marklcrns/vim-smartq",
        event = "VeryLazy",
    },
    {
        "RRethy/vim-illuminate",
        event = "InsertEnter",
        config = function()
            require('settings.plugins.illuminate')
        end,
    },
    {
        "numToStr/Comment.nvim",
        config = true,
        event = "VeryLazy",
    },
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        event = "InsertEnter",
    },
    {
        "folke/trouble.nvim",
        config = true,
        keys = {
            { "<leader>tt", "<cmd>TroubleToggle quickfix<CR>", { silent = true, noremap = true } },
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        config = true,
        opts = {
            options = {
                theme = 'catppuccin',
            },
        },
    },
    {
        "folke/todo-comments.nvim",
        config = function()
            require("todo-comments").setup {
                keywords = {
                    HACK = {
                        alt = {
                            "TEMP",
                        },
                    },
                },
                highlight = {
                    keyword = 'wide_bg',
                    after = '',
                    pattern = [[.*<(KEYWORDS)\s*(\([^\)]*\))?:]],
                },
                search = {
                    pattern = [[\b(KEYWORDS)\s*(\([^\)]*\))?:]],
                    -- pattern = "\\b(KEYWORDS)\\s*(\\(.*\\))?:",
                }
            }
        end,
        keys = {
            { "<leader>tj", function() require('todo-comments').jump_next() end },
            { "<leader>tk", function() require('todo-comments').jump_prev() end },
            { "<leader>tq", "<cmd>TodoQuickFix<CR>" },
        },
    },
    {
        "windwp/nvim-autopairs",
        config = true,
        event = "InsertEnter",
    },
    {
        "tpope/vim-surround",
        event = "InsertEnter",
    },
    {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup {
                window = {
                    border = "single",
                }
            }
        end,
        event = "VeryLazy",
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap" },
        event = "VeryLazy",
        keys = {
            { "<leader>dt", "<cmd>DapToggleBreakpoint<CR>", mode = "n" },
            { "<leader>dx", "<cmd>DapTerminate<CR>",        mode = "n" },
            { "<leader>dc", "<cmd>DapContinue<CR>",         mode = "n" },
            { "<leader>dj", "<cmd>DapStepInto<CR>",         mode = "n" },
            { "<leader>dl", "<cmd>DapStepOver<CR>",         mode = "n" },
            { "<leader>dk", "<cmd>DapStepOut<CR>",          mode = "n" },
        },
        config = function()
            require('settings.dap')
        end,
    },
    {
        'akinsho/git-conflict.nvim',
        version = "*",
        config = function()
            require('git-conflict').setup { default_mappings = false }
        end,
        keys = {
            { "<leader>go", "<Plug>(git-conflict-ours)",          desc = "Git conflict resolve ours" },
            { "<leader>gt", "<Plug>(git-conflict-theirs)",        desc = "Git conflict resolve theirs" },
            { "<leader>gb", "<Plug>(git-conflict-both)",          desc = "Git conflict resolve both" },
            { "<leader>g0", "<Plug>(git-conflict-none)",          desc = "Git conflict resolve none" },
            { "<leader>gh", "<Plug>(git-conflict-prev-conflict)", desc = "Git conflict previous" },
            { "<leader>gl", "<Plug>(git-conflict-next-conflict)", desc = "Git conflict next" },
        }
    },
    {
        'p00f/clangd_extensions.nvim',
        ft = 'C'
    },
    {
        'olexsmir/gopher.nvim',
        ft = 'go',
        config = true,
    },
    {
        'github/copilot.vim',
        keys = {
            { "<leader>ce", "<cmd>Copilot enable<CR>" },
            { "<leader>cd", "<cmd>Copilot disable<CR>" },
        },
    }

})
