vim.g.clipboard = {
    name = 'WslClipboard',
    copy = {
        ["+"] = 'clip.exe',
        ["*"] = 'clip.exe',
    },
    paste = {
        ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
        ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = false,
}

vim.keymap.set("n", "<leader>rr", "<cmd>!./build.sh<CR>")
vim.keymap.set("n", "<leader>rw", "<cmd>!./build_web.sh<CR>")
vim.keymap.set("n", "<leader>rg", "<cmd>!./run.sh<CR>")
vim.g.python3_host_prog = "/bin/python3"
