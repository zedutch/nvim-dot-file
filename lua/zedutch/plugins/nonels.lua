return {
    -- https://github.com/nvimtools/none-ls.nvim
    "nvimtools/none-ls.nvim",
    lazy = false,
    keys = {
        { '<leader>ln', '<cmd>NullLsInfo<CR>' },
    },
    config = function()
        local nonels = require("null-ls")
        ---- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
        local formatting = nonels.builtins.formatting
        ---- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/code_actions
        local code_actions = nonels.builtins.code_actions

        nonels.setup({
            sources = {
                -- Python
                formatting.black.with({
                    extra_args = {
                        "--fast",
                    },
                }),

                -- Web stuff
                formatting.prettier.with({
                    filetypes = {
                        "html",
                        "javascript",
                        "javascriptreact",
                        "typescript",
                        "typescriptreact",
                        "htmldjango",
                    },
                }),
                code_actions.eslint_d,

                -- Go
                formatting.gofumpt,
                formatting.goimports_reviser,
                formatting.golines,
                code_actions.gomodifytags,

                -- OCaml
                -- formatting.ocamlformat,

                -- Kotlin
                -- formatting.ktlint,

                -- C / C++
                formatting.clang_format,

                -- General
                code_actions.gitsigns,
            },
            on_init = function(client, _)
                client.offset_encoding = "utf-16"
            end,
        })
    end,
}
