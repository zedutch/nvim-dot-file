local opt = vim.opt

local function keymap(mode, lhs, rhs, description, opts)
    local options = { silent = true, noremap = true, desc = description }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end


opt.clipboard:append { 'unnamedplus' }

keymap("i", "<D-v>", "<C-r>+", "Paste from system clipboard")
keymap("c", "<D-v>", "<C-r>+", "Paste from system clipboard")
keymap("v", "<D-c>", '"+y', "Copy to system clipboard")

keymap('', '<D-t>', "<cmd>ToggleTerm<CR>", 'Terminal')
keymap('t', '<D-e>', "<cmd>ToggleTerm<CR>", 'Terminal')
keymap('t', '<esc>', [[<C-\><C-n>]], 'Normal mode')
keymap('t', '<D-h>', [[<Cmd>wincmd h<CR>]], 'Window left')
keymap('t', '<D-l>', [[<Cmd>wincmd l<CR>]], 'Window right')
keymap('t', '<D-j>', [[<Cmd>wincmd j<CR>]], 'Window down')
keymap('t', '<D-k>', [[<Cmd>wincmd k<CR>]], 'Window up')

keymap("n", "<leader>rr", '<cmd>!./build.sh<CR>', "Compile debug")
keymap("n", "<leader>rw", '<cmd>!./build_web.sh<CR>', "Compile web")
keymap("n", "<leader>rg", '<cmd>!./run.sh<CR>', "Run application")
