local ok, mason = pcall(require, 'mason')
if not ok then
    print('Skipping lsp configuration as mason is missing')
    return
end

local mason_ok, masonLspConfig = pcall(require, 'mason-lspconfig')
if not mason_ok then
    print('Skipping lsp configuration as mason-lspconfig is missing')
    return
end

local lsp_ok, _ = pcall(require, 'lspconfig')
if not lsp_ok then
    print('Skipping lsp configuration as lspconfig is missing')
    return
end

local servers = {
    'angularls',
    'cssls',
    'eslint',
    'html',
    'jsonls',
    'marksman',
    'prismals',
    'pyright',
    'rust_analyzer',
    -- 'stylelint_lsp',
    'lua_ls',
    'tailwindcss',
    'tsserver',
    'yamlls',
}

mason.setup {
    ui = {
        border = 'rounded',
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
}

masonLspConfig.setup {
    ensure_installed = servers,
    automatic_installation = true,
}

local handlers = require('settings.lsp.handlers')
handlers.setup()

masonLspConfig.setup_handlers {
    -- Default handler
    function(server_name)
        local opts = {
            on_attach = handlers.on_attach,
            capabilities = handlers.capabilities,
        }
        local has_opts, server_opts = pcall(require, 'settings.lsp.' .. server_name)
        if has_opts then
            opts = vim.tbl_deep_extend('force', opts, server_opts)
        end
        require('lspconfig')[server_name].setup(opts)
    end,
    -- Server-specific ones
    ['rust_analyzer'] = function()
        require('rust-tools').setup {
            server = {
                capabilities = handlers.capabilities,
                on_attach = handlers.on_attach,
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
    end,
}

-- GDScript has to be set up manually:
function configGdscript()
    local opts = {
        on_attach = handlers.on_attach,
        capabilities = handlers.capabilities,
    }
    local has_opts, server_opts = pcall(require, 'settings.lsp.gdscript')
    if has_opts then
        opts = vim.tbl_deep_extend('force', opts, server_opts)
    end
    require('lspconfig').gdscript.setup(opts)
end
configGdscript()
