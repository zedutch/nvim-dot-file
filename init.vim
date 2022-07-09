""" Load Plugins
call plug#begin()
" Theme
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
Plug 'jose-elias-alvarez/null-ls.nvim'
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
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab autoindent smartindent
set incsearch ignorecase smartcase hlsearch
" set wildmode=longest,list,full wildmenu
set ruler laststatus=2 showcmd showmode
set wrap breakindent
set encoding=utf-8
set textwidth=0
set hidden
set number
set title
set cursorline
set signcolumn=auto:1-2
set showmatch
set clipboard+=unnamedplus

if has("termguicolors")
    set termguicolors
end


""" Key mappings
nnoremap <SPACE> <Nop>
let mapleader="\<Space>"
" Functionality
nnoremap <leader>rc :source $MYVIMRC<CR>
nnoremap <leader><leader> :noh<CR>
nnoremap <leader>il :IndentLinesToggle<CR>
" Buffers
nnoremap <leader>bb :Telescope buffers<CR>
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>q :bd<CR>
nnoremap <leader><Tab> :bnext<CR>
nnoremap <leader><S-Tab> :bprevious<CR>
" Clipboard
nnoremap <leader><C-c> "+y
nnoremap <leader><C-v> "+p
inoremap <C-v> <C-r>+
cnoremap <C-v> <C-r>+
" Files
nnoremap <leader>ff :Telescope find_files<CR>
nnoremap <leader>fp :Telescope projects<CR>
nnoremap <C-s> :w<CR>
" Gitsigns
nnoremap <leader>gb :Gitsigns blame_line<CR>
" Comments
nmap <leader>cc <Plug>NERDCommenterToggle
nmap <C-/> <Plug>NERDCommenterToggle
vmap <C-/> <Plug>NERDCommenterToggle<CR>gv
" Rust
nnoremap <leader>rr :RustRun<CR>
nnoremap <leader>rf :RustFmt<CR>

""" Plugin configuration
if has("gui_running")
    colorscheme nightfox
endif

set guifont=RobotoMono\ Nerd\ Font:h14

" Load config files
lua require('cfg.feline')
lua require('cfg.null-ls')
lua require('cfg.cmp')

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
    require('nvim-lsp-installer').setup {
        --log_level = vim.log.levels.DEBUG
    }
    require('trouble').setup {}
    require('gitsigns').setup {}
    require('feline').setup {}
EOF
