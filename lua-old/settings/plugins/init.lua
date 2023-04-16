local fn = vim.fn

-- Automatically install Packer
local packer_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
-- print("Path:", packer_path)
if fn.empty(fn.glob(packer_path)) > 0 then
    PACKER_INSTALL = fn.system {
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        packer_path,
    }

    print 'Installing packer.'
    vim.cmd [[packadd packer.nvim]]
end

-- Reload plugins everytime this file is saved.
vim.cmd [[
    augroup packer_config
        autocmd!
        autocmd BufWritePost init.lua source <afile> | PackerSync
    augroup end
]]

local ok, packer = pcall(require, 'packer')
if not ok then
    print 'Please restart nvim.'
    return
end

packer.init {
    display = {
        open_fn = function()
            return require('packer.util').float {
                border = 'rounded',
            }
        end,
    },
}

return packer.startup(function(use)
    -- Packer (so it doesn't try to delete itself)
    ---- https://github.com/wbthomason/packer.nvim
    use { 'wbthomason/packer.nvim' }


    -- Widely used dependencies
    ---- https://github.com/nvim-lua/plenary.nvim
    use { 'nvim-lua/plenary.nvim' }
    ---- https://github.com/kyazdani42/nvim-web-devicons/
    use { 'kyazdani42/nvim-web-devicons' }


    -- Theming
    ---- https://github.com/EdenEast/nightfox.nvim
    use { 'EdenEast/nightfox.nvim',
        config = function()
            require('settings.plugins.nightfox')
        end,
    }
    ---- https://github.com/feline-nvim/feline.nvim
    use { 'feline-nvim/feline.nvim',
        config = function()
            require('settings.plugins.feline')
        end,
        requires = {
            ---- https://github.com/lewis6991/gitsigns.nvim/
            use { 'lewis6991/gitsigns.nvim',
                config = function ()
                    require("gitsigns").setup {}
                end,
            },
        },
    }

    -- Buffer management
    ---- https://github.com/marklcrns/vim-smartq
    use { 'marklcrns/vim-smartq',
        config = function()
            require('settings.plugins.smartq')
        end,
    }

    -- Key bindings
    ---- https://github.com/folke/which-key.nvim#%EF%B8%8F-configuration
    use { 'folke/which-key.nvim',
        config = function()
            require('settings.plugins.which-key')
        end,
    }

    -- Completion
    ---- https://github.com/hrsh7th/nvim-cmp
    use { 'hrsh7th/nvim-cmp',
        config = function()
            require('settings.plugins.cmp')
        end,
        requires = {
            ---- https://github.com/hrsh7th/cmp-buffer
            use { 'hrsh7th/cmp-buffer' },
            ---- https://github.com/hrsh7th/cmp-emoji
            use { 'hrsh7th/cmp-emoji' },
            ---- https://github.com/hrsh7th/cmp-path
            use { 'hrsh7th/cmp-path' },
            ---- https://github.com/hrsh7th/cmp-cmdline
            use { 'hrsh7th/cmp-cmdline' },
            ---- https://github.com/David-Kunz/cmp-npm 
            use { 'David-Kunz/cmp-npm' },
            ---- https://github.com/hrsh7th/cmp-nvim-lua
            use { 'hrsh7th/cmp-nvim-lua' },
            ---- https://github.com/hrsh7th/cmp-nvim-lsp
            use { 'hrsh7th/cmp-nvim-lsp' },
        },
    }


    -- Autopairs
    ---- https://github.com/windwp/nvim-autopairs
    use { 'windwp/nvim-autopairs',
        config = function()
            require('settings.plugins.autopairs')
        end,
    }
    ---- https://github.com/windwp/nvim-ts-autotag
    use { 'windwp/nvim-ts-autotag' }


    -- Code snippets
    ---- https://github.com/L3MON4D3/LuaSnip
    use { "L3MON4D3/LuaSnip",
        run = "make install_jsregexp",
        requires = {
            ---- https://github.com/rafamadriz/friendly-snippets
            use { 'rafamadriz/friendly-snippets' },
            ---- https://github.com/saadparwaiz1/cmp_luasnip
            use { 'saadparwaiz1/cmp_luasnip' },
        }
    }

    -- LSP
    ---- https://github.com/williamboman/mason.nvim#requirements
    use { 'williamboman/mason.nvim',
        requires = {
            ---- https://github.com/williamboman/mason-lspconfig.nvim
            use { 'williamboman/mason-lspconfig.nvim',
                requires = {
                    ---- https://github.com/neovim/nvim-lspconfig 
                    use { 'neovim/nvim-lspconfig' },
                },
            },
        },
    }


    -- Null-ls
    ---- https://github.com/jose-elias-alvarez/null-ls.nvim
    use { 'jose-elias-alvarez/null-ls.nvim',
        config = function ()
            require('settings.lsp.null-ls')
        end,
    }


    -- Telescope
    ---- https://github.com/nvim-telescope/telescope.nvim
    use { 'nvim-telescope/telescope.nvim',
        config = function ()
            require('settings.plugins.telescope')
        end,
        requires = {
            ---- https://github.com/nvim-telescope/telescope-fzf-native.nvim
            use { 'nvim-telescope/telescope-fzf-native.nvim',
                run = 'make',
            },
            ---- https://github.com/sharkdp/fd
            use { 'sharkdp/fd' },
        },
    }
    ---- https://github.com/nvim-telescope/telescope-ui-select.nvim
    use { 'nvim-telescope/telescope-ui-select.nvim' }
    ---- https://github.com/nvim-telescope/telescope-file-browser.nvim 
    use { 'nvim-telescope/telescope-file-browser.nvim' }


    -- Project
    ---- https://github.com/ahmedkhalf/project.nvim
    use { 'ahmedkhalf/project.nvim',
        config = function ()
            require('settings.plugins.project')
        end,
    }


    -- Bufferline
    ---- https://github.com/akinsho/bufferline.nvim
    use { 'akinsho/bufferline.nvim',
        tag = 'v2.*',
        config = function ()
            require('settings.plugins.bufferline')
        end,
    }


    -- TreeSitter
    ---- https://github.com/nvim-treesitter/nvim-treesitter
    use { 'nvim-treesitter/nvim-treesitter',
        run = ":TSUpdate",
        config = function ()
            require('settings.plugins.treesitter')
        end,
    }


    -- Illuminate
    ---- https://github.com/RRethy/vim-illuminate
    use { 'RRethy/vim-illuminate',
        config = function ()
            require('settings.plugins.illuminate')
        end,
    }


    -- Comments
    ---- https://github.com/numToStr/Comment.nvim
    use { 'numToStr/Comment.nvim',
        config = function ()
            require('settings.plugins.comments')
        end,
    }

    ---- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
    use { 'JoosepAlviste/nvim-ts-context-commentstring' }


    -- Surround
    ---- https://github.com/kylechui/nvim-surround
    use { 'kylechui/nvim-surround',
        config = function ()
            require('settings.plugins.surround')
        end,
    }


    -- Terminal
    ---- https://github.com/akinsho/toggleterm.nvim
    use { 'akinsho/toggleterm.nvim',
        tag = '*',
        config = function()
            require('settings.plugins.toggleterm')
        end,
    }

    -- Git conflict markers
    ---- https://github.com/rhysd/conflict-marker.vim
    use { 'rhysd/conflict-marker.vim' }

    -- Fix gx without Netrw
    ---- https://github.com/tyru/open-browser.vim
    use { 'tyru/open-browser.vim' }

    -- Rust
    use { 'rust-lang/rust.vim' }
    use { 'saecki/crates.nvim',
        config = function()
            require('crates').setup()
        end,
    }
    use { 'simrat39/rust-tools.nvim' }

    -- Editorconfig
    ---- https://github.com/gpanders/editorconfig.nvim
    use { 'gpanders/editorconfig.nvim' }

    if PACKER_INSTALL then
        require('packer').sync()
    end
end)

