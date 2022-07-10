local null_ls = require("null-ls")
null_ls.setup {
    sources = {
        -- All
        null_ls.builtins.diagnostics.editorconfig_checker,
        
        -- Python
        null_ls.builtins.diagnostics.pylint.with({
            extra_args = {
                "--load-plugins=pylint_django,pylint_quotes",
            },
        }),
        null_ls.builtins.formatting.isort,
        -- null_ls.builtins.formatting.autopep8,

        -- Javascript
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.diagnostics.tsc,

        -- CSS
        null_ls.builtins.diagnostics.stylelint,

        -- HTML
        null_ls.builtins.formatting.prettier.with({
            filetypes = { "html", "json", "yaml", "markdown" },
        }),

        -- Git
        null_ls.builtins.code_actions.gitsigns,

        -- Rust
        null_ls.builtins.formatting.rustfmt,
    },
    on_attach = function()
        vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])
    end,
}
