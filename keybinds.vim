""" Key mappings
nnoremap <SPACE> <Nop>
let mapleader="\<Space>"
" Functionality
nnoremap <leader>rc       <cmd>source $MYVIMRC<CR>
nnoremap <leader><leader> <cmd>noh<CR>
nnoremap <leader>il       <cmd>IndentLinesToggle<CR>
vnoremap <                <gv
vnoremap >                >gv
" Resize windows
nnoremap <C-Up>     <cmd>resize -2<CR>
nnoremap <C-Down>   <cmd>resize +2<CR>
nnoremap <C-Left>   <cmd>vertical resize -2<CR>
nnoremap <C-Right>  <cmd>vertical resize +2<CR>
" Buffers
nnoremap <leader>bb <cmd>Telescope buffers<CR>
nnoremap <leader>br <cmd>bufdo e<CR>
nnoremap <leader>bq <cmd>bd<CR>
nnoremap <leader>q  <cmd>bd<CR>
nmap <S-l>          <cmd>bnext<CR>
nmap <S-h>          <cmd>bnext<CR>
" WhichKey descriptions
lua << EOF
require("which-key").register({
    b = {
        name = "buffer",
        r = { "Reload all buffers" },
        q = { "Close current buffer" },
    },
}, { prefix = "<leader>" })
EOF
" Clipboard
nnoremap <leader><C-c> "+y
nnoremap <leader><C-v> "+p
inoremap <C-v>         <C-r>+
cnoremap <C-v>         <C-r>+
" Files
nnoremap <leader>ff <cmd>Telescope find_files<CR>
nnoremap <leader>fp <cmd>Telescope projects<CR>
nnoremap <leader>ft <cmd>Telescope live_grep<CR>
nnoremap <C-s>      <cmd>w<CR>
nnoremap <leader>e  <cmd>NvimTreeToggle<CR>
" Gitsigns
nnoremap <leader>gb <cmd>Gitsigns blame_line<CR>
" Comments
nmap <leader>cc     <Plug>NERDCommenterToggle
nmap <C-/>          <Plug>NERDCommenterToggle
vmap <C-/>          <Plug>NERDCommenterToggle<CR>gv
" Debugging
nnoremap <leader>db <cmd>lua require('dap').toggle_breakpoint()<CR>
nnoremap <leader>dc <cmd>lua require('dap').continue()<CR>
nnoremap <leader>di <cmd>lua require('dap').step_into()<CR>
nnoremap <leader>do <cmd>lua require('dap').step_over()<CR>
nnoremap <leader>dO <cmd>lua require('dap').step_out()<CR>
nnoremap <leader>dr <cmd>lua require('dap').repl_toggle()<CR>
nnoremap <leader>du <cmd>lua require('dapui').toggle()<CR>
nnoremap <leader>dt <cmd>lua require('dap').terminate()<CR>
" Illuminate
nnoremap <leader>j  <cmd>lua require('illuminate').next_reference{wrap=true}<CR>
nnoremap <leader>k  <cmd>lua require('illuminate').next_reference{reverse=true, wrap=true}<CR>
