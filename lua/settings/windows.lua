local opt = vim.opt

local function keymap(mode, lhs, rhs, description, opts)
    local options = { silent = true, noremap = true, desc = description }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end


opt.clipboard:prepend { 'unnamed', 'unnamedplus' }

keymap("i", "<C-v>", "<C-r>+", "Paste from system clipboard")
keymap("c", "<C-v>", "<C-r>+", "Paste from system clipboard")
keymap("v", "<C-c>", '"+y', "Copy to system clipboard")