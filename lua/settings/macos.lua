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
