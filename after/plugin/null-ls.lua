local null_ls = require('null-ls')

---- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
---- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
---- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/code_actions
local code_actions = null_ls.builtins.code_actions

null_ls.setup {
    sources = {
        formatting.black.with {
            extra_args = {
                "--fast",
            },
        },

        formatting.prettier.with {
            filetypes = { "html", "json", "yaml", "markdown", "toml", "javascript", "typescript", "typescriptreact", "typescript.tsx" },
            extra_args = { "--editorconfig" },
        },

        code_actions.gitsigns,
    },
    on_attach = function()
        vim.cmd([[ command! Diagnostics execute 'lua vim.diagnostic.enable()' ]])
    end,
}

