local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
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
        diagnostics.eslint,
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
