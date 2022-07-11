""" Key mappings
nnoremap <SPACE> <Nop>
let mapleader="\<Space>"
" Functionality
nnoremap <leader>rc :source $MYVIMRC<CR>
nnoremap <leader><leader> :noh<CR>
nnoremap <leader>il :IndentLinesToggle<CR>
vnoremap < <gv
vnoremap > >gv
" Resize windows
nnoremap <C-Up>    :resize -2<CR>
nnoremap <C-Down>  :resize +2<CR>
nnoremap <C-Left>  :vertical resize -2<CR>
nnoremap <C-Right> :vertical resize +2<CR>
" Buffers
nnoremap <leader>bb :Telescope buffers<CR>
nnoremap <leader>bq  :bd<CR>
nnoremap <leader>q   :bd<CR>
nmap <S-l> :bnext<CR>
nmap <S-h> :bnext<CR>
" Clipboard
nnoremap <leader><C-c> "+y
nnoremap <leader><C-v> "+p
inoremap <C-v> <C-r>+
cnoremap <C-v> <C-r>+
" Files
nnoremap <leader>ff :Telescope find_files<CR>
nnoremap <leader>fp :Telescope projects<CR>
nnoremap <leader>ft :Telescope live_grep<CR>
nnoremap <C-s> :w<CR>
nnoremap <leader>e  :NvimTreeToggle<CR>
" Gitsigns
nnoremap <leader>gb :Gitsigns blame_line<CR>
" Comments
nmap <leader>cc <Plug>NERDCommenterToggle
nmap <C-/> <Plug>NERDCommenterToggle
vmap <C-/> <Plug>NERDCommenterToggle<CR>gv
" Debugging
nnoremap <leader>db :lua require('dap').toggle_breakpoint()<CR>
nnoremap <leader>dc :lua require('dap').continue()<CR>
nnoremap <leader>di :lua require('dap').step_into()<CR>
nnoremap <leader>do :lua require('dap').step_over()<CR>
nnoremap <leader>dO :lua require('dap').step_out()<CR>
nnoremap <leader>dr :lua require('dap').repl_toggle()<CR>
nnoremap <leader>du :lua require('dapui').toggle()<CR>
nnoremap <leader>dt :lua require('dap').terminate()<CR>
" Illuminate
nnoremap <leader>j :lua require('illuminate').next_reference{wrap=true}<CR>
nnoremap <leader>k :lua require('illuminate').next_reference{reverse=true, wrap=true}<CR>
