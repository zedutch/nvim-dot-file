local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
}

local formatting_disabled = {
    typescriptreact = true, -- Use prettier
    typescript = true,      -- Use prettier
    html = true,            -- Use prettier
    json = true,            -- Use prettier
    python = true,          -- Use black
    svelte = true,          -- Use prettier
}

for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

vim.diagnostic.config({
    update_in_insert = true,
    severity_sort = true,
    signs = {
        active = signs,
    },
    float = {
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
})

local kind_icons = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "ﴯ",
    Interface = "",
    Module = "",
    Property = "ﰠ",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = ""
}

return {
    -- https://github.com/neovim/nvim-lspconfig
    "neovim/nvim-lspconfig",
    dependencies = {
        {
            -- https://github.com/williamboman/mason.nvim
            "williamboman/mason.nvim",
            build = function()
                vim.cmd.MasonUpdate()
            end,
        },
        {
            -- https://github.com/williamboman/mason-lspconfig.nvim
            "williamboman/mason-lspconfig.nvim",
        },
        {
            -- https://github.com/hrsh7th/nvim-cmp
            "hrsh7th/nvim-cmp",
            dependencies = {
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-nvim-lua",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-emoji",
                "L3MON4D3/LuaSnip",
                "saadparwaiz1/cmp_luasnip",
                "David-Kunz/cmp-npm",
                "petertriho/cmp-git",
            },
        },
    },
    config = function()
        require("mason").setup({
            ui = {
                border = "rounded",
            },
        })

        local lspconfig = require("lspconfig")

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true
        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

        -- Rust LSP settings
        vim.g.rustaceanvim = {
            -- Plugin configuration
            tools = {
            },
            -- LSP configuration
            server = {
                on_attach = function(client, bufnr)
                    vim.keymap.set("n", "<leader>co", "<cmd>RustLsp openCargo<cr>", { buffer = bufnr })
                    vim.keymap.set("n", "<leader>cr", "<cmd>RustLsp reloadWorkspace<cr>", { buffer = bufnr })
                    vim.keymap.set("n", "<leader>cp", "<cmd>RustLsp parentModule<cr>", { buffer = bufnr })
                    vim.keymap.set("n", "<leader>ce", "<cmd>RustLsp explainError<cr>", { buffer = bufnr })
                end,
                settings = {
                    -- rust-analyzer language server configuration
                    ['rust-analyzer'] = {
                        capabilities = capabilities,
                        checkOnSave = {
                            command = "clippy",
                        },
                    },
                },
            },
            -- DAP configuration
            dap = {
            },
        }

        local util = require 'lspconfig/util'
        local on_attach = function(client, _)
            if formatting_disabled[vim.bo.filetype] then
                client.server_capabilities.documentFormattingProvider = false
                vim.notify("LSP Formatting disabled for " .. vim.bo.filetype, vim.log.levels.INFO)
            end
        end
        require("mason-lspconfig").setup({
            automatic_installation = true,
            ensure_installed = {
                "gopls",
                "lua_ls",
                "rust_analyzer",
                "tsserver",
                "vimls",
            },
            handlers = {

                function(server_name)
                    lspconfig[server_name].setup({
                        capabilities = capabilities,
                        on_attach = on_attach,
                    })
                end,

                ["rust_analyzer"] = function()
                    -- do nothing, let rustaceanvim handle it
                end,

                ["lua_ls"] = function()
                    lspconfig.lua_ls.setup({
                        settings = {
                            Lua = {
                                runtime = {
                                    version = 'LuaJIT'
                                },
                                diagnostics = {
                                    globals = { "vim" }
                                },
                                workspace = {
                                    library = vim.env.VIMRUNTIME,
                                    checkThirdParty = false,
                                },
                                telemetry = {
                                    enable = false,
                                },
                            },
                        },
                        capabilities = capabilities,
                        on_attach = on_attach,
                    })
                end,

                ["gopls"] = function()
                    lspconfig.gopls.setup({
                        settings = {
                            gopls = {
                                analyses = {
                                    nilness = true,
                                    unusedparams = true,
                                    unusedvariable = true,
                                },
                                usePlaceholders = true,
                                completeUnimported = true,
                                staticcheck = true,
                            },
                        },
                        capabilities = capabilities,
                        on_attach = function(client, bufnr)
                            on_attach(client, bufnr)
                            vim.keymap.set("n", "<leader>gie", "<cmd>GoIfErr<cr>",
                                { buffer = bufnr, desc = "if err != nil" })
                        end,
                    })
                end,

                ["pylsp"] = function()
                    lspconfig.pylsp.setup({
                        settings = {
                            pylsp = {
                                plugins = {
                                    pylint = {
                                        enabled = true,
                                        args = "--load-plugins=pylint_django,pylint_quotes",
                                    },
                                    yapf = {
                                        enabled = false,
                                    },
                                    pyflakes = {
                                        enabled = false,
                                    },
                                    mccabe = {
                                        enabled = false,
                                    },
                                    autopep8 = {
                                        enabled = false,
                                    },
                                    pycodestyle = {
                                        enabled = false,
                                    },
                                    pylsp_mypy = {
                                        enabled = true,
                                    },
                                    pyls_isort = {
                                        enabled = true,
                                    },
                                },
                            },
                        },
                        capabilities = capabilities,
                        on_attach = on_attach,
                    })
                end,

                ["tailwindcss"] = function()
                    lspconfig.tailwindcss.setup({
                        filetypes = "*",
                        capabilities = capabilities,
                        on_attach = on_attach,
                    })
                end,

                ["html"] = function()
                    lspconfig.html.setup({
                        root_dir = util.root_pattern('~angular.json', 'package.json', '.git'),
                        filetypes = { "html", "htmldjango" },
                        capabilities = capabilities,
                        on_attach = on_attach,
                    })
                end,

                ["yamlls"] = function()
                    lspconfig.yamlls.setup({
                        settings = {
                            yaml = {
                                keyOrdering = false,
                            },
                        },
                        capabilities = capabilities,
                        on_attach = on_attach,
                    })
                end,

                ["clangd"] = function()
                    capabilities.offsetEncoding = { "utf-16", "utf-8" }
                    require('clangd_extensions').setup({
                        server = {
                            capabilities = capabilities,
                            on_attach = on_attach,
                        },
                        extensions = {
                            autoSetHints = true,
                            inlay_hints = {
                                only_current_line = false,
                            },
                            memory_usage = {
                                border = "rounded"
                            },
                            symbol_info = {
                                border = "rounded"
                            }
                        }
                    })
                end,
            },
        })

        local cmp = require("cmp")
        local luasnip = require("luasnip")

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                ["<C-j>"] = cmp.mapping.select_next_item(),
                ["<C-k>"] = cmp.mapping.select_prev_item(),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "path" },
                { name = "nvim_lua" },
                { name = "npm" },
                { name = "crates" },
            }, {
                { name = "emoji" },
                { name = "buffer" },
            }),
            formatting = {
                fields = { 'kind', 'abbr', 'menu' },
                format = function(entry, item)
                    item.kind = string.format('%s %s', kind_icons[item.kind], item.kind)
                    item.menu = ({
                        npm = '[NPM]',
                        crates = '[Crates]',
                        nvim_lsp = '[LSP]',
                        nvim_lua = '[NVIM]',
                        luasnip = '[Snip]',
                        buffer = '[Buff]',
                        path = '[Path]',
                        emoji = '[Emoji]',
                    })[entry.source.name]
                    return item
                end,
            },
        })

        cmp.setup.filetype('gitcommit', {
            sources = cmp.config.sources({
                { name = 'git' },
            }, {
                { name = 'buffer' },
            })
        })
    end,
}
