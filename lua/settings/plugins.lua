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
        tag = "0.1.1",
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
        tag = "v3.*",
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
        config = function ()
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
            { "<leader>tr", "<cmd>TroubleToggle quickfix<CR>", { silent = true, noremap = true } },
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
        config = true,
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
            require("which-key").setup()
        end,
        event = "VeryLazy",
    },
    {
        "mfussenegger/nvim-dap",
        lazy = true,
    },
    {
        "rcarriga/nvim-dap-ui",
        lazy = true,
    },
    {
        "uga-rosa/ugaterm.nvim",
        lazy = true,
        config = true,
        keys = {
            { "<leader>tt", "<cmd>UgatermToggle<CR>" },
            { "<C-t>", "<cmd>UgatermToggle<CR>", mode="n" },
            { "<C-t>", "<cmd>UgatermToggle<CR>", mode="t" },
            { "<Esc>", "<cmd>UgatermHide<CR>", mode="t" },
        },
    },
})
