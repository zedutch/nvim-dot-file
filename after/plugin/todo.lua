local tc = require("todo-comments")

tc.setup {}

vim.keymap.set("n", "<leader>tj", function() tc.jump_next() end)
vim.keymap.set("n", "<leader>tk", function() tc.jump_prev() end)
vim.keymap.set("n", "<leader>tq", "<cmd>TodoQuickFix<CR>")


