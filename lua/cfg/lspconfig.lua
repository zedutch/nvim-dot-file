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

    if lsp == "rust_analyzer" then
        local keymap = vim.keymap.set
        local kopts = { silent = true }
        keymap("n", "<leader>rh", ":RustToggleInlayHints<CR>", kopts)
        keymap("n", "<leader>rr", ":RustRun<CR>", kopts)
        keymap("n", "<leader>rf", ":RustFmt<CR>", kopts)
        keymap("n", "<leader>rd", ":RustDebuggables<CR>", kopts)
        keymap("n", "<leader>rem", ":RustExpandMacro<CR>", kopts)
        keymap("n", "<leader>red", ":RustExternalDocs<CR>", kopts)
        keymap("n", "<leader>rpm", ":RustParentModule<CR>", kopts)
        keymap("n", "<leader>roc", ":RustOpenCargo<CR>", kopts)
        keymap("n", "<leader>rw", ":RustReloadWorkspace<CR>", kopts)
        keymap("n", "<leader>rg", ":RustViewCrateGraph<CR>", kopts)
        keymap("n", "<leader>rs", ":RustSSR<CR>", kopts)
        keymap("n", "<S-j>", ":RustJoinLines<CR>", kopts)
        keymap("n", "<C-j>", ":RustMoveItemDown<CR>", kopts)
        keymap("n", "<C-k>", ":RustMoveItemUp<CR>", kopts)

        require("rust-tools").setup {
            server = {
                capabilities = require('cfg.lsphandlers').capabilities,
                on_attach = require('cfg.lsphandlers').on_attach,
                settings = {
                    ["rust-analyzer"] = {
                        completion = {
                            postfix = {
                                enable = false,
                            },
                        },
                        checkOnSave = {
                            command = "clippy",
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
