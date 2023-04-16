local opt = vim.opt

local function keymap(mode, lhs, rhs, description, opts)
    local options = { silent = true, noremap = true, desc = description }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end


opt.clipboard:prepend { 'unnamed', 'unnamedplus' }

-- Python venv
vim.g.python3_host_prog = ".venv\\Scripts\\python.exe"


keymap("i", "<C-v>", "<C-r>+", "Paste from system clipboard")
keymap("c", "<C-v>", "<C-r>+", "Paste from system clipboard")
keymap("v", "<C-c>", '"+y', "Copy to system clipboard")

keymap("n", "<leader>rr", '<cmd>!build.bat<CR>', "Compile debug")
keymap("n", "<leader>rw", '<cmd>!build_web.bat<CR>', "Compile web")
keymap("n", "<leader>rg", '<cmd>!run.bat<CR>', "Run application")
