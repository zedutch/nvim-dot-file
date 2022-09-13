local api = vim.api

api.nvim_create_augroup('my-ESLint', { clear = true })

api.nvim_create_autocmd('BufWritePre', {
    group = 'my-ESLint',
    pattern = { "*.tsx", "*.ts", "*.jsx", "*.js" },
    command = 'EslintFixAll',
})
