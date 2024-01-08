local autocmd_group = vim.api.nvim_create_augroup(
    "Jinja Files",
    { clear = true })

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead", "FileReadPost" },
    {
        pattern = { "*.jinja" },
        desc = "Set the correct filetype for jinja files",
        callback = function()
            vim.bo.filetype = 'htmldjango'
            vim.opt_local.filetype = 'htmldjango'
        end,
        group = autocmd_group,
    })
