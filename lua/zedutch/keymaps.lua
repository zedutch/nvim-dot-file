vim.g.mapleader = " "

---- Better default commands ----
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<c-u>", "<c-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("v", "y", "ygc<esc>")

---- Utilities ----
vim.keymap.set("n", "<Esc>", ":nohl<CR>")
-- Keep buffer when pasting over something
vim.keymap.set("x", "p", "\"_dP")
-- Copy/paste to system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")
vim.keymap.set("n", "<leader>p", "\"+p")
vim.keymap.set("v", "<leader>p", "\"+p")
vim.keymap.set("n", "<leader>P", "\"+P")
-- Change wd to current file
vim.keymap.set("n", "cd.", "<cmd>lcd %:p:h<CR>")
-- Search and replace word under cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- Delete words
vim.keymap.set("i", "<C-BS>", "<Esc>cvb")

---- Windows ----
-- Change height
vim.keymap.set("n", "<leader><C-k>", "<cmd>resize +2<CR>")
vim.keymap.set("n", "<leader><C-j>", "<cmd>resize -2<CR>")
-- Change width
vim.keymap.set("n", "<leader><C-h>", "<cmd>vertical resize -2<CR>")
vim.keymap.set("n", "<leader><C-l>", "<cmd>vertical resize +2<CR>")
-- Make all windows equally sized
vim.keymap.set("n", "<leader>=", "<C-w>=")
-- Delete buffer without closing splits
vim.keymap.set("n", "<leader>bd", "<cmd>bp|bd #<CR>")

---- Text manipulation ----
-- Remain in visual mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
-- Move selection up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv")
-- Insert ellipsis
vim.keymap.set('n', "<leader>ie", "a…<Esc>")
-- Insert comments (todo: use comment plugin to define comment shape)
vim.keymap.set('n', "<leader>in", "0a// NOTE(robin): ")
vim.keymap.set('n', "<leader>it", "0a// TODO(robin): ")

---- Quickfix list ----
vim.keymap.set("n", "<leader>qo", "<cmd>copen<CR>")
vim.keymap.set("n", "<leader>qc", "<cmd>cclose<CR>")
vim.keymap.set("n", "<leader>L", "<cmd>cnext<CR>")
vim.keymap.set("n", "<leader>H", "<cmd>cprev<CR>")
vim.keymap.set("i", "<C-j>", "<cmd>cnext<CR>")
vim.keymap.set("i", "<C-k>", "<cmd>cprev<CR>")
vim.keymap.set("n", "<leader>qh", "<cmd>cfirst<CR>")
vim.keymap.set("n", "<leader>ql", "<cmd>clast<CR>")

---- LSP ----
vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<CR>")

---- Diagnostics ----
vim.keymap.set("n", "<leader>lj", function() vim.diagnostic.goto_next() end)
vim.keymap.set("n", "<leader>lk", function() vim.diagnostic.goto_prev() end)
vim.keymap.set("n", "gl", function() vim.diagnostic.open_float() end)
vim.keymap.set("n", "<leader>ldd", function() vim.diagnostic.enable() end)
vim.keymap.set("n", "<leader>ldl", function() vim.diagnostic.disable() end)

---- Make ----
vim.keymap.set("n", "<leader>mr", "<cmd>make run<cr>",
    { desc = "Make run" })
vim.keymap.set("n", "<leader>mb", "<cmd>make build<cr>",
    { desc = "Make build" })
vim.keymap.set("n", "<leader>mt", "<cmd>make test<cr>",
    { desc = "Make tests" })
vim.keymap.set("n", "<leader>m<space>", "<cmd>make<cr>",
    { desc = "Make" })
