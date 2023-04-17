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
    },
    {
        "tyru/open-browser.vim",
        lazy = true,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = "InsertEnter",
    },
    {
        "theprimeagen/harpoon",
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
        lazy = true,
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
            { "nvim-cmp" },
        },
        config = function ()
            require('settings.lsp')
        end,
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        keys = {
            { '<leader>ln', '<cmd>NullLsInfo<CR>' },
        },
    },

    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter", "CmdlineEnter" },
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
        opts = {
            null_ls = {
                enabled = true,
                name = "Crates",
            },
        },
    },
    {
        "marklcrns/vim-smartq",
    },
    {
        "RRethy/vim-illuminate",
        lazy = true,
    },
    {
        "numToStr/Comment.nvim",
        config = true,
        lazy = true,
    },
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        lazy = true,
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
        event = "InsertEnter",
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
})
