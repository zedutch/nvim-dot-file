-- :help options

local opt = vim.opt
local fn = vim.fn

-- Indentation
opt.autoindent = true
opt.expandtab = true
opt.smartcase = true
opt.smartindent = true
opt.smarttab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.breakindent = true
opt.showtabline = 2

-- Editor
opt.numberwidth = 1
opt.ruler = true
opt.signcolumn = 'yes'
opt.cursorline = true
opt.colorcolumn = '120'
opt.wrap = false
opt.scrolloff = 8     -- Number of vertical margin lines
opt.sidescrolloff = 8 -- Number of horizontal margin characters
opt.whichwrap:append '<,>,[,],h,l'
opt.iskeyword:append '-'
opt.fillchars.eob = ' '
opt.textwidth = 0
opt.laststatus = 3
opt.mouse = ''
opt.listchars = "space:·,tab:-> "

-- Files
opt.backup = false
opt.swapfile = false
opt.undofile = true -- Persistent undo
opt.undodir = fn.stdpath('data') .. "/undo"
opt.writebackup = false
opt.completeopt = { 'menu', 'menuone', 'noselect' }
opt.conceallevel = 0
opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'

-- Layout
opt.cmdheight = 0
opt.pumheight = 8
opt.showmode = true
opt.showcmd = true
opt.showmatch = true
opt.splitbelow = true
opt.splitright = true
opt.splitkeep = "screen"
opt.winborder = "rounded"

-- Search
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.path:append { '**' } -- Search down into folders
opt.wildignore:append { '*/node_modules/*' }

-- Commands
opt.timeoutlen = 1000 -- ms
opt.updatetime = 50   -- ms
opt.shortmess:append 'c'

-- Netrw
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 1
vim.g.netrw_liststyle = 1

-- Disable unused providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

vim.g.copilot_enabled = true

-- Disable all clients by default
vim.lsp.stop_client(vim.lsp.get_clients())
