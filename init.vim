""" Load Plugins
call plug#begin()
" Theme
Plug 'EdenEast/nightfox.nvim'
" File management
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-ui-select.nvim'
Plug 'ahmedkhalf/project.nvim'
" Language server
Plug 'williamboman/nvim-lsp-installer'
Plug 'neovim/nvim-lspconfig'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'simrat39/rust-tools.nvim'
" Code completion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'ray-x/cmp-treesitter'
" Status bar
Plug 'feline-nvim/feline.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'lewis6991/gitsigns.nvim'
" Functionality
Plug 'scrooloose/nerdcommenter'
Plug 'alvan/vim-closetag'
Plug 'Yggdroot/indentLine'
Plug 'folke/trouble.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'folke/which-key.nvim'
Plug 'kyazdani42/nvim-tree.lua'

call plug#end()

""" Neovide configuration
if exists("g:neovide")
    " Put anything you want to happen only in Neovide here
    let g:neovide_refresh_rate=165
    let g:neovide_scroll_animation_length = 0.2
    let g:neovide_remember_window_size = v:true
    let g:neovide_profiler = v:false
    let g:neovide_cursor_animation_length=0.1
    let g:neovide_cursor_trail_length=0.2
    let g:neovide_cursor_antialiasing=v:false
endif

""" Main configuration
filetype plugin indent on
lua require('cfg.options')

runtime keybinds.vim

""" Plugin configuration
if exists("g:neovide")
    colorscheme nightfox
endif

set guifont=RobotoMono\ Nerd\ Font:h14

" Load config files
lua require('cfg.feline')
lua require('cfg.lspconfig')
lua require('cfg.null-ls')
lua require('cfg.cmp')
lua require('cfg.treesitter')
lua require('cfg.nvim-tree')

" disable perl
let g:loaded_perl_provider = 0

" nvim-cmp
set completeopt=menu,menuone,noselect

" indentLine
let g:indentLine_char = '|'
let g:indentLine_defaultGroup = 'NonText'
let g:vim_json_syntax_conceal = 0
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

" NERDcommenter
let g:NERDSpaceDelims = 1

lua << EOF
    require('project_nvim').setup {
        silent_chdir = true,
        show_hidden = false,
    }
    require('telescope').load_extension('projects')
    require('telescope').load_extension('ui-select')
    require('trouble').setup {}
    require('gitsigns').setup {}
    require('which-key').setup {
        window = {
            border = 'single'
        }
    }
EOF
