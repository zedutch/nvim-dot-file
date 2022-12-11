-- :luafile $MYVIMRC

---- Functions ----
-- Wrapper around vim keymap to add description and extend options
local function keymap(mode, lhs, rhs, description, opts)
    local options = { silent = true, noremap = true, desc = description }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

-- Delete all cached packages and reload them all
function _G.ReloadConfig()
    for name, _ in pairs(package.loaded) do
        if name:match('^settings') then
            package.loaded[name] = nil
        end
    end
    dofile(vim.env.MYVIMRC)
end


---- Leader key ----
-- keymap("", "<Space>", "<nop>")
vim.g.mapleader = " "


---- Buffers ----
keymap("n", "<S-l>", "<cmd>bnext<CR>", "Next buffer")
keymap("n", "<S-h>", "<cmd>bprev<CR>", "Previous buffer")



---- Source files ----
keymap("n", "<leader>s.", "<cmd>source %<CR>", "Source current file", { silent = false })
keymap("n", "<leader>ss", "<cmd>lua ReloadConfig()<CR>", "Reload configuration")


---- Windows ----
keymap("n", "<C-k>", "<cmd>resize +2<CR>", "Decrease current window height")
keymap("n", "<C-j>", "<cmd>resize -2<CR>", "Increase current window height")
keymap("n", "<C-h>", "<cmd>vertical resize -2<CR>", "Decrease current window width")
keymap("n", "<C-l>", "<cmd>vertical resize +2<CR>", "Increase current window width")
keymap("n", "<leader>=", "<C-w>=", "Make all windows equally sized")
keymap("n", "<Tab>", "<C-w>w", "Rotate through windows")


---- Utilities ----
keymap("n", "<esc>", "<cmd>nohlsearch<CR>", "Clear highlights")
keymap("v", "p", '"_dP', "Paste (keep register)")
keymap("n", "+", "<C-a>", "Increment number")
keymap("n", "-", "<C-x>", "Decrement number")
keymap('n', '<C-a>', 'gg<S-v>G', 'Select all')
keymap('n', 'cd.', 'lcd %:p:h', 'Change working directory to current file')


---- Text manipulation ----
keymap('v', '<', '<gv', 'Indent left (stay in visual mode)')
keymap('v', '>', '>gv', 'Indent right (stay in visual mode)')
keymap('', '<A-k>', '<cmd>m .-2<CR>==', 'Move line up')
keymap('', '<A-j>', '<cmd>m .+1<CR>==', 'Move line down')
keymap('n', "<leader>c'", "<cmd>s/\"/'/g<CR><cmd>nohl<CR>", "Change all quotes on the current line to '")
keymap('v', "<leader>c'", "<cmd>'<,'>s/\"/'/g<CR><cmd>nohl<CR>", "Change all quotes in the selection to '")
keymap('n', "<leader>ch", "<cmd>s/</\\&lt;/g<CR><cmd>s/>/\\&gt;/g<CR><cmd>nohl<CR>", "Encode all HTML on the current line")
keymap('n', "<leader>c{", "<cmd>s/{/\\&#10100;/g<CR><cmd>s/}/\\&#10101;/g<CR><cmd>nohl<CR>", "Encode all curly brackets on the current line")
keymap('v', "<leader>ch", "<cmd>'<,'>s/</\\&lt;/g<CR><cmd>'<,'>s/>/\\&gt;/g<CR><cmd>nohl<CR>", "Encode all HTML in the selection")
keymap('v', "<leader>c{", "<cmd>'<,'>s/{/\\&#10100;/g<CR><cmd>'<,'>s/}/\\&#10101;/g<CR><cmd>nohl<CR>", "Encode all curly brackets in the selection")


---- Editor Toggles ----
keymap('n', '<leader>tr', '<cmd>set relativenumber!<CR>', 'Toggle relative numbers')
keymap('n', '<leader>tw', '<cmd>set wrap!<CR>', 'Toggle wrap')


---- Packages ----
keymap('n', '<leader>pc', '<cmd>PackerClean<CR>', 'Clean packages')
keymap('n', '<leader>pi', '<cmd>PackerInstall<CR>', 'Install packages')
keymap('n', '<leader>pl', '<cmd>PackerStatus<CR>', 'List packages')
keymap('n', '<leader>ps', '<cmd>PackerSync<CR>', 'Sync packages')
keymap('n', '<leader>pu', '<cmd>PackerUpdate<CR>', 'Update packages')


---- LSP ----
keymap('n', '<leader>li', '<cmd>LspInfo<CR>', 'LSP Info')
keymap('n', '<leader>ll', '<cmd>Mason<CR>', 'Mason UI')
keymap('n', '<leader>lr', '<cmd>LspRestart<CR>', 'Restart LSP Servers')
keymap('n', '<leader>ln', '<cmd>NullLsInfo<CR>', 'Null-ls Info')


--- Telescope ----
keymap('n', '<leader>ff', '<cmd>Telescope find_files<CR>', 'Find files')
keymap('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', 'Live grep')
keymap('n', '<leader>fp', '<cmd>Telescope projects<CR>', 'Projects')
keymap('n', '<leader>fo', '<cmd>Telescope treesitter<CR>', 'Outline')
keymap('n', '<leader>fb', '<cmd>Telescope file_browser<CR>', 'File browser')
keymap('n', '<leader>fs', '<cmd>Telescope lsp_document_symbols<CR>', 'File symbols')
keymap('n', '<leader>fh', '<cmd>Telescope git_files<CR>', 'Git files')
keymap('n', '<leader>bb', '<cmd>Telescope buffers<CR>', 'Buffers')


---- Illuminate ----
keymap('n', '<leader>j', "<cmd>lua require('illuminate').next_reference{wrap=true}<CR>", 'Next reference')
keymap('n', '<leader>k', "<cmd>lua require('illuminate').next_reference{reverse=true, wrap=true}<CR>", 'Previous reference')


---- Terminal ----
keymap('', '<C-t>', "<cmd>ToggleTerm<CR>", 'Terminal')
keymap('t', '<C-e>', "<cmd>ToggleTerm<CR>", 'Terminal')
keymap('t', '<esc>', "<C-\\><C-n>", 'Normal mode')
keymap('t', '<C-h>', "<cmd>wincmd h<CR>", 'Window left')
keymap('t', '<C-l>', "<cmd>wincmd l<CR>", 'Window right')
keymap('t', '<C-j>', "<cmd>wincmd j<CR>", 'Window down')
keymap('t', '<C-k>', "<cmd>wincmd k<CR>", 'Window up')
keymap('n', '<leader>tp', '<cmd>lua _PYTHON_TOGGLE()<CR>', 'Open Python console')


---- Comments ----
keymap('n', '<leader>cc', 'gcc', 'Comment linewise')
keymap('n', '<leader>cb', 'gcb', 'Comment blockwise')
keymap('v', '<leader>cc', 'gc', 'Comment linewise')
keymap('v', '<leader>cb', 'gb', 'Comment blockwise')
--keymap("x", "<leader>/", '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>')


---- OpenBrowser ----
keymap('', 'gx', '<cmd>let url = expand("<cfile>")<CR><cmd>call OpenBrowser(url)<CR>', 'Open in browser')

