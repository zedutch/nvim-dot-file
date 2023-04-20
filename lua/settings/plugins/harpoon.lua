local mark = require('harpoon.mark')
local ui = require('harpoon.ui')

vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Harpoon add mark" })
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
vim.keymap.set("n", "<leader>hh", function() ui.nav_file(1) end, { desc = "Harpoon mark 1" })
vim.keymap.set("n", "<leader>hj", function() ui.nav_file(2) end, { desc = "Harpoon mark 2" })
vim.keymap.set("n", "<leader>hk", function() ui.nav_file(3) end, { desc = "Harpoon mark 3" })
vim.keymap.set("n", "<leader>hl", function() ui.nav_file(4) end, { desc = "Harpoon mark 4" })

require('telescope').load_extension('harpoon')
