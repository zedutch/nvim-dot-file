-- local opt = vim.opt
-- opt.clipboard:prepend { 'unnamed', 'unnamedplus' }


-- vim.keymap.set("i", "<C-v>", "<C-r>+")
-- vim.keymap.set("c", "<C-v>", "<C-r>+")
-- vim.keymap.set("v", "<C-c>", '"+y')

vim.keymap.set("n", "<leader>rr", '<cmd>!build.bat<CR>')
vim.keymap.set("n", "<leader>rw", '<cmd>!build_web.bat<CR>')
vim.keymap.set("n", "<leader>rg", '<cmd>!run.bat<CR>')
