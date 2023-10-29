vim.g.mapleader = " "

---- Buffers ----
vim.keymap.set("n", "L", "<cmd>bnext<CR>")
vim.keymap.set("n", "H", "<cmd>bprev<CR>")


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
-- Increment and decrement numbers
vim.keymap.set("n", "+", "<C-a>")
vim.keymap.set("n", "-", "<C-x>")
-- Change wd to current file
vim.keymap.set("n", "cd.", "<cmd>lcd %:p:h<CR>")
-- Always open external in browser
vim.keymap.set("", "gx", "<cmd>let url = expand(\"<cfile>\")<CR><cmd>call OpenBrowser(url)<CR>")
-- Search and replace word under cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- Delete words
vim.keymap.set("i", "<C-BS>", "<Esc>cvb")

---- Windows ----
-- Rotate through windows
vim.keymap.set("n", "<leader><Tab>", "<C-w>w")
-- Change height
vim.keymap.set("n", "<C-S-k>", "<cmd>resize +2<CR>")
vim.keymap.set("n", "<C-S-j>", "<cmd>resize -2<CR>")
-- Change width
vim.keymap.set("n", "<C-S-h>", "<cmd>vertical resize -2<CR>")
vim.keymap.set("n", "<C-S-l>", "<cmd>vertical resize +2<CR>")
-- Make all windows equally sized
vim.keymap.set("n", "<leader>=", "<C-w>=")


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
vim.keymap.set("n", "<leader>qj", "<cmd>cnext<CR>")
vim.keymap.set("n", "<leader>qk", "<cmd>cprev<CR>")
vim.keymap.set("n", "<leader>qh", "<cmd>cfirst<CR>")
vim.keymap.set("n", "<leader>ql", "<cmd>clast<CR>")

