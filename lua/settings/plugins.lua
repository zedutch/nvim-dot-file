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
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
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
    },
    {
        "tyru/open-browser.vim",
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
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
    },
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        dependencies = {
            -- LSP Support
            { "neovim/nvim-lspconfig" },
            {
                "williamboman/mason.nvim",
                build = function()
                    vim.cmd.MasonUpdate()
                end,
            },
            { "williamboman/mason-lspconfig.nvim" },

            -- Autocompletion
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lua" },
            { "L3MON4D3/LuaSnip" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-emoji" },
            { "David-Kunz/cmp-npm" },
            { "rafamadriz/friendly-snippets" },
        },
        keys = {
            { '<leader>li', '<cmd>LspInfo<CR>' },
        },
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        keys = {
            { '<leader>ln', '<cmd>NullLsInfo<CR>' },
        },
    },
    {
        "simrat39/rust-tools.nvim",
        priority = 40, -- after lsp-zero
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
    },
    {
        "numToStr/Comment.nvim",
        config = true,
    },
    {
        "folke/trouble.nvim",
        config = true,
        keys = {
            { "<leader>tr", "<cmd>TroubleToggle quickfix<CR>", { silent = true, noremap = true }},
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
    },
    {
        "tpope/vim-surround",
    },
    {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup()
        end,
    },
})
