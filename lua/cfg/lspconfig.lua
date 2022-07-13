require("nvim-lsp-installer").setup {
    --log_level = vim.log.levels.DEBUG
}

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
    return
end

require('cfg.lsphandlers').setup()

local opts = {}

local servers = {
    'angularls',
    'eslint',
    'html',
    'jsonls',
    'pylsp',
    'rust_analyzer',
    'stylelint_lsp',
    'sumneko_lua',
    'taplo',
    'tsserver',
    'yamlls',
}
for _, lsp in ipairs(servers) do
    opts = {
        capabilities = require('cfg.lsphandlers').capabilities,
        on_attach = require('cfg.lsphandlers').on_attach,
    }

    if lsp == "sumneko_lua" then
        local lua_opts = {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        library = {
                            [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                        },
                    },
                    telemetry = {
                        enable = false,
                    },
                },
            },
        }
        opts = vim.tbl_deep_extend("force", lua_opts, opts)
    end

    if lsp == "pylsp" then
        local py_opts = {
            settings = {
                pylsp = {
                    plugins = {
                        pylint = {
                            enabled = true,
                            -- args = "--load-plugins=pylint_django,pylint_quotes",
                            args = {
                                "--load-plugins=pylint_django,pylint_quotes",
                            },
                        },
                        autopep8 = {
                            enabled = false,
                        },
                        flake8 = {
                            enabled = false,
                        },
                        pycodestyle = {
                            enabled = false,
                        },
                    },
                },
            },
        }
        opts = vim.tbl_deep_extend("force", py_opts, opts)
    end

    if lsp == "rust_analyzer" then
        require("rust-tools").setup {
            server = {
                capabilities = require('cfg.lsphandlers').capabilities,
                on_attach = require('cfg.lsphandlers').on_attach,
                settings = {
                    ["rust-analyzer"] = {
                        checkOnSave = {
                            command = "clippy",
                        },
                        inlayHints = {
                            closingBraceHints = {
                                enable = true,
                                minLines = 5,
                            },
                        },
                        joinLines = {
                            removeTrailingComma = false,
                        },
                        typing = {
                            autoClosingAngleBrackets = {
                                enable = true,
                            },
                        },
                    },
                },
            }
        }
        goto continue
    end

    require('lspconfig')[lsp].setup(opts)
    ::continue::
end
