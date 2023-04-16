-- local opt = vim.opt
-- opt.clipboard:append { 'unnamedplus' }

vim.keymap.set("i", "<D-v>", "<C-r>+")
vim.keymap.set("c", "<D-v>", "<C-r>+")
vim.keymap.set("v", "<D-c>", '"+y')

vim.keymap.set("", "<D-t>", "<cmd>ToggleTerm<CR>")
vim.keymap.set("t", "<D-e>", "<cmd>ToggleTerm<CR>")
vim.keymap.set("t", "<esc>", [[<C-\><C-n>]])
vim.keymap.set("t", "<D-h>", [[<Cmd>wincmd h<CR>]])
vim.keymap.set("t", "<D-l>", [[<Cmd>wincmd l<CR>]])
vim.keymap.set("t", "<D-j>", [[<Cmd>wincmd j<CR>]])
vim.keymap.set("t", "<D-k>", [[<Cmd>wincmd k<CR>]])

vim.keymap.set("n", "<leader>rr", "<cmd>!./build.sh<CR>")
vim.keymap.set("n", "<leader>rw", "<cmd>!./build_web.sh<CR>")
vim.keymap.set("n", "<leader>rg", "<cmd>!./run.sh<CR>")
