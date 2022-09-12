local fn = vim.fn

-- Automatically install Packer
local packer_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
print("Path:", packer_path)
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
    use { 'wbthomason/packer.nvim', commit = '6afb67460283f0e990d35d229fd38fdc04063e0a' }


    -- Widely used dependencies
    ---- https://github.com/nvim-lua/plenary.nvim
    use { 'nvim-lua/plenary.nvim', commit = '4b66054e75356ac0b909bbfee9c682e703f535c2' }
    ---- https://github.com/kyazdani42/nvim-web-devicons/
    use { 'kyazdani42/nvim-web-devicons', commit = '2d02a56189e2bde11edd4712fea16f08a6656944' }


    -- Theming
    ---- https://github.com/EdenEast/nightfox.nvim
    use { 'EdenEast/nightfox.nvim',
        commit = '83f6ee9e646c803aa14c7293ad7775900f24ea1a',
        config = function()
            require('settings.plugins.nightfox')
        end,
    }
    ---- https://github.com/feline-nvim/feline.nvim
    use { 'feline-nvim/feline.nvim',
        commit = '331a79449d86668618a4e00fced153bce3ce2780',
        config = function()
            require('settings.plugins.feline')
        end,
        requires = {
            ---- https://github.com/lewis6991/gitsigns.nvim/
            use { 'lewis6991/gitsigns.nvim',
                commit = 'd7e0bcbe45bd9d5d106a7b2e11dc15917d272c7a',
                config = function ()
                    require("gitsigns").setup {}
                end,
            },
        },
    }

    -- Buffer management
    ---- https://github.com/marklcrns/vim-smartq
    use { 'marklcrns/vim-smartq',
        commit = '5d863e4c6b1467d5831e14e078a614fab6836a08',
        config = function()
            require('settings.plugins.smartq')
        end,
    }

    -- Key bindings
    ---- https://github.com/folke/which-key.nvim#%EF%B8%8F-configuration
    use { 'folke/which-key.nvim',
        commit = 'd5f0c63c91eeeb6c0a8cbbbe24a4d6aa3c2d8b45',
        config = function()
            require('settings.plugins.which-key')
        end,
    }

    -- Completion
    ---- https://github.com/hrsh7th/nvim-cmp
    use { 'hrsh7th/nvim-cmp',
        commit = '913eb8599816b0b71fe959693080917d8063b26a',
        config = function()
            require('settings.plugins.cmp')
        end,
        requires = {
            ---- https://github.com/hrsh7th/cmp-buffer
            use { 'hrsh7th/cmp-buffer', commit = '3022dbc9166796b644a841a02de8dd1cc1d311fa' },
            ---- https://github.com/hrsh7th/cmp-emoji
            use { 'hrsh7th/cmp-emoji', commit = '19075c36d5820253d32e2478b6aaf3734aeaafa0' },
            ---- https://github.com/hrsh7th/cmp-path
            use { 'hrsh7th/cmp-path', commit = '447c87cdd6e6d6a1d2488b1d43108bfa217f56e1' },
            ---- https://github.com/hrsh7th/cmp-cmdline
            use { 'hrsh7th/cmp-cmdline', commit = '9c0e331fe78cab7ede1c051c065ee2fc3cf9432e' },
            ---- https://github.com/David-Kunz/cmp-npm 
            use { 'David-Kunz/cmp-npm', commit = '4b6166c3feeaf8dae162e33ee319dc5880e44a29' },
            ---- https://github.com/hrsh7th/cmp-nvim-lua
            use { 'hrsh7th/cmp-nvim-lua', commit = 'd276254e7198ab7d00f117e88e223b4bd8c02d21' },
            ---- https://github.com/hrsh7th/cmp-nvim-lsp
            use { 'hrsh7th/cmp-nvim-lsp', commit = 'affe808a5c56b71630f17aa7c38e15c59fd648a8' },
        },
    }


    -- Autopairs
    ---- https://github.com/windwp/nvim-autopairs
    use { 'windwp/nvim-autopairs',
        commit = '5fe24419e7a7ec536d78d60be1515b018ab41b15',
        config = function()
            require('settings.plugins.autopairs')
        end,
    }
    ---- https://github.com/windwp/nvim-ts-autotag
    use { 'windwp/nvim-ts-autotag', commit = 'fdefe46c6807441460f11f11a167a2baf8e4534b' }


    -- Code snippets
    ---- https://github.com/L3MON4D3/LuaSnip
    use { "L3MON4D3/LuaSnip",
        commit = '6e506ce63b7bebd1d4cb2243e0ab67abe82d9594',
        run = "make install_jsregexp",
        requires = {
            ---- https://github.com/rafamadriz/friendly-snippets
            use { 'rafamadriz/friendly-snippets',
                commit = '22a99756492a340c161ab122b0ded90ab115a1b3',
            },
            ---- https://github.com/saadparwaiz1/cmp_luasnip
            use { 'saadparwaiz1/cmp_luasnip',
                commit = 'a9de941bcbda508d0a45d28ae366bb3f08db2e36',
            },
        }
    }

    -- LSP
    ---- https://github.com/williamboman/mason.nvim#requirements
    use { 'williamboman/mason.nvim',
        commit = 'b56ea0bd8b6b1c265752226666f1069d0a479438',
        requires = {
            ---- https://github.com/williamboman/mason-lspconfig.nvim
            use { 'williamboman/mason-lspconfig.nvim',
                commit = '1534b610c5e8afaa2cc4231f0715354dc2d9688b',
                requires = {
                    ---- https://github.com/neovim/nvim-lspconfig 
                    use { 'neovim/nvim-lspconfig',
                        commit = 'f8b3c240edad68bf549cae6b133cf2cac85554e8',
                    },
                },
            },
        },
    }


    -- Null-ls
    ---- https://github.com/jose-elias-alvarez/null-ls.nvim
    use { 'jose-elias-alvarez/null-ls.nvim',
        commit = 'bf027826eeb83606ef7153f312ef66750ef14961',
        config = function ()
            require('settings.lsp.null-ls')
        end,
    }


    -- Telescope
    ---- https://github.com/nvim-telescope/telescope.nvim
    use { 'nvim-telescope/telescope.nvim',
        commit = '2584ff391b528d01bf5e8c04206d5902a79ebdde',
        config = function ()
            require('settings.plugins.telescope')
        end,
        requires = {
            ---- https://github.com/nvim-telescope/telescope-fzf-native.nvim
            use { 'nvim-telescope/telescope-fzf-native.nvim',
                run = 'make',
                commit = '65c0ee3d4bb9cb696e262bca1ea5e9af3938fc90',
            },
            ---- https://github.com/sharkdp/fd
            use { 'sharkdp/fd',
                commit = '9ea882d7cca53e15900cdba7f3a91126a6aa5475',
            },
        },
    }
    ---- https://github.com/nvim-telescope/telescope-ui-select.nvim
    use { 'nvim-telescope/telescope-ui-select.nvim',
        commit = '62ea5e58c7bbe191297b983a9e7e89420f581369',
    }
    ---- https://github.com/nvim-telescope/telescope-file-browser.nvim 
    use { 'nvim-telescope/telescope-file-browser.nvim',
        commit = '00a814a891de086ed446151bacc559c63682b6ee',
    }


    -- Project
    ---- https://github.com/ahmedkhalf/project.nvim
    use { 'ahmedkhalf/project.nvim',
        commit = '090bb11ee7eb76ebb9d0be1c6060eac4f69a240f',
        config = function ()
            require('settings.plugins.project')
        end,
    }


    -- TreeSitter
    ---- https://github.com/nvim-treesitter/nvim-treesitter
    use { 'nvim-treesitter/nvim-treesitter',
        commit = '2eaf18826988f921ddb39e4a2e7d23d95bb0e52a',
        run = ":TSUpdate",
        config = function ()
            require('settings.plugins.treesitter')
        end,
    }


    -- Illuminate
    ---- https://github.com/RRethy/vim-illuminate
    use { 'RRethy/vim-illuminate',
        commit = '1c8132dc81078fc1ec7a4a1492352b8f541ee84b',
        config = function ()
            require('settings.plugins.illuminate')
        end,
    }


    -- Comments
    ---- https://github.com/numToStr/Comment.nvim
    use { 'numToStr/Comment.nvim',
        commit = '30d23aa2e1ba204a74d5dfb99777e9acbe9dd2d6',
        config = function ()
            require('settings.plugins.comments')
        end,
    }


    -- Surround
    ---- https://github.com/kylechui/nvim-surround
    use { 'kylechui/nvim-surround',
        commit = 'd91787d5a716623be7cec3be23c06c0856dc21b8',
        config = function ()
            require('settings.plugins.surround')
        end,
    }


    -- Terminal
    ---- https://github.com/akinsho/toggleterm.nvim
    use { 'akinsho/toggleterm.nvim',
        commit = '5e393e558f7c41d132542c8e9626aa824a1caa59',
        tag = '*',
        config = function()
            require('toggleterm').setup()
        end,
    }

    -- Git conflict markers
    ---- https://github.com/rhysd/conflict-marker.vim
    use { 'rhysd/conflict-marker.vim',
        commit = '22b6133116795ea8fb6705ddca981aa8faecedda',
    }


    -- Rust
    -- use { 'saecki/crates.nvim',
    --     config = function()
    --         require('crates').setup()
    --     end,
    -- }


    if PACKER_INSTALL then
        require('packer').sync()
    end
end)

