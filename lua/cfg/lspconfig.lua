require("nvim-lsp-installer").setup {
    --log_level = vim.log.levels.DEBUG
}

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
    return
end

local opts = {}

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
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
        capabilities = capabilities
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
        require("rust-tools").setup {
            server = {
                capabilities = capabilities
            }
        }
        goto continue
    end

    require('lspconfig')[lsp].setup(opts)
    ::continue::
end
