""" Load Plugins
call plug#begin()
Plug 'EdenEast/nightfox.nvim'
" File management
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'ahmedkhalf/project.nvim'
" Language server
Plug 'williamboman/nvim-lsp-installer'
Plug 'neovim/nvim-lspconfig'
" Code completion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'ray-x/cmp-treesitter'

call plug#end()

""" Neovide configuration
if exists("g:neovide")
    " Put anything you want to happen only in Neovide here
    let g:neovide_refresh_rate=165
    let g:neovide_scroll_animation_length = 0.2
    let g:neovide_remember_window_size = v:true
    let g:neovide_profiler = v:false
    let g:neovide_cursor_animation_length=0.1
    let g:neovide_cursor_trail_length=0.4
    let g:neovide_cursor_antialiasing=v:false
endif

""" Main configuration
filetype plugin indent on
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab autoindent smartindent
set incsearch ignorecase smartcase hlsearch
set wildmode=longest,list,full wildmenu
set ruler laststatus=2 showcmd showmode
set wrap breakindent
set encoding=utf-8
set textwidth=0
set hidden
set number
set title
set termguicolors
set clipboard+=unnamedplus
set completeopt=menu,menuone,noselect

""" Key mappings
nnoremap <SPACE> <Nop>
let mapleader="\<Space>"
nnoremap <leader>rc :source $MYVIMRC<CR>
nnoremap <leader><leader> :noh<CR>
" Buffers
nnoremap <leader>bb :buffers<CR>
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bq :bd<CR>
nnoremap <leader><Tab> :bnext<CR>
nnoremap <leader><S-Tab> :bprevious<CR>
" Clipboard
nnoremap <leader><C-c> "+y
nnoremap <leader><C-v> "+p
inoremap <C-v> <C-r>+
cnoremap <C-v> <C-r>+
" Rust
nnoremap <leader>rr :RustRun<CR>
nnoremap <leader>rf :RustFmt<CR>
" Files
nnoremap <leader>ff :Telescope find_files<CR>
nnoremap <leader>fb :Telescope buffers<CR>
nnoremap <leader>fp :Telescope projects<CR>
nnoremap <C-s> :w<CR>

""" Plugin configuration
colorscheme nightfox
lua << EOF
    require('project_nvim').setup {
        -- configuration here
    }
    require('telescope').load_extension('projects')
    require('nvim-lsp-installer').setup {
        --log_level = vim.log.levels.DEBUG
    }
    local cmp = require('cmp')
    cmp.setup {
        snippet = {
            expand = function(args)
                vim.fn["vsnip#anonymous"](args.body)
            end,
        },
        window = {
            -- completion = cmp.config.window.bordered(),
            -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'vsnip' },
        }, {
            { name = 'buffer' },
        })
    }
    local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    require('lspconfig')[
        'rust_analyzer'
    ].setup {
        capabilities = capabilities
    }
EOF
