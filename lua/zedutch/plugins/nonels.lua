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
        ---- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
        -- local diagnostics = nonels.builtins.diagnostics

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
                        "json",
                        "htmldjango",
                        "templ",
                        "svelte",
                    },
                }),

                -- Go
                formatting.goimports_reviser,
                -- formatting.golines, -- I don't want a max line length anymore
                code_actions.gomodifytags,
                code_actions.impl,

                -- GDScript
                formatting.gdformat,

                -- OCaml
                -- formatting.ocamlformat,

                -- Kotlin
                -- formatting.ktlint,

                -- C / C++
                formatting.clang_format.with({
                    filetypes = {
                        "c",
                        "cpp",
                        "objc",
                        "objcpp",
                    },
                }),

                -- SQL
                formatting.pg_format,

                -- General
                code_actions.gitsigns,
            },
            on_init = function(client, _)
                client.offset_encoding = "utf-16"
            end,
        })
    end,
}
