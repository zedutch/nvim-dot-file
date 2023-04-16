local null_ls = require("null-ls")

---- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
---- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
---- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/code_actions
local code_actions = null_ls.builtins.code_actions
null_ls.setup {
    debug = false,
    sources = {
        -- All
        diagnostics.editorconfig_checker,

        -- Python
        diagnostics.pylint.with {
            extra_args = {
                "--load-plugins=pylint_django,pylint_quotes",
            },
        },
        formatting.isort,
        -- formatting.autopep8,
        formatting.black.with {
            extra_args = {
                "--fast",
            },
        },

        -- Javascript
        -- diagnostics.eslint_d,
        -- code_actions.eslint_d,
        diagnostics.tsc,

        -- CSS
        diagnostics.stylelint,

        -- HTML
        formatting.prettier.with {
            filetypes = { "html", "json", "yaml", "markdown", "toml" },
            extra_args = { "--single-quote", "--jsx-single-quote" },
        },

        -- Git
        code_actions.gitsigns,
    },
    on_attach = function()
        vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])
    end,
}
