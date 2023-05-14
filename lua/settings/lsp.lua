local settings = require("settings/lsp-settings")

-- SERVERS
local servers = {
    'clangd',
    'cssls',
    'eslint',
    'html',
    'jsonls',
    'lua_ls',
    'marksman',
    'prismals',
    'pylsp',
    'rust_analyzer',
    'tailwindcss',
    'tsserver',
    'vimls',
    'yamlls',
    'wgsl_analyzer',
}

-- KEYMAPS

-- Wrapper around vim keymap to add description and extend options
local function keymap(bufnr, mode, lhs, rhs, description)
    local options = { silent = true, noremap = false, desc = description, buffer = bufnr }
    vim.keymap.set(mode, lhs, rhs, options)
end


local function keymaps(_, bufnr)
    keymap(bufnr, "n", "gD", function() vim.lsp.buf.declaration() end, "Go to declaration")
    keymap(bufnr, "n", "gd", function() vim.lsp.buf.definition() end, "Go to definition")
    keymap(bufnr, "n", "gi", function() vim.lsp.buf.implementation() end, "List implementations")
    keymap(bufnr, "n", "go", function() vim.lsp.buf.type_definition() end, "Type definition")
    keymap(bufnr, "n", "gr", function() vim.lsp.buf.references() end, "List references")
    keymap(bufnr, "n", "gs", function() vim.lsp.buf.signature_help() end, "Signature help")
    keymap(bufnr, "i", "<C-h>", function() vim.lsp.buf.signature_help() end, "Signature help")

    keymap(bufnr, "n", "K", function() vim.lsp.buf.hover() end, "Hover action")

    keymap(bufnr, "n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, "Format")
    keymap(bufnr, "n", "<leader>la", function() vim.lsp.buf.code_action() end, "Code actions")
    keymap(bufnr, "n", "<leader>lr", function() vim.lsp.buf.rename() end, "Rename")
    keymap(bufnr, "n", "<leader>lj", function() vim.diagnostic.goto_next() end, "Next diagnostic problem")
    keymap(bufnr, "n", "<leader>lk", function() vim.diagnostic.goto_prev() end, "Previous diagnostic problem")
    keymap(bufnr, "n", "gl", function() vim.diagnostic.open_float() end, "Show diagnostics")
    keymap(bufnr, "n", "<leader>ldd", function() vim.diagnostic.enable() end, "Enable diagnostics")
    keymap(bufnr, "n", "<leader>ldl", function() vim.diagnostic.disable() end, "Disable diagnostics")
end


-- CAPABILITIES
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local function on_attach(client, bufnr)
    -- local disableFormatting = {
    --     lua='lua_ls',
    -- }
    -- for file, clnt in pairs(disableFormatting) do
    --     if vim.bo.filetype == file and client.name == clnt then
    --         client.server_capabilities.documentFormattingProvider = false
    --     end
    -- end

    if settings.disable_formatting_files[vim.bo.filetype] then
        client.server_capabilities.documentFormattingProvider = false
    end

    keymaps(client, bufnr)

    pcall(settings.custom_keymaps[client.name], client, bufnr)

    require('illuminate').on_attach(client)
end

-- SETUP

require('mason').setup {
    ui = {
        border = 'rounded',
    },
    max_concurrent_installers = 4,
}

local lsp = require('mason-lspconfig')

lsp.setup {
    ensure_installed = servers,
    automatic_installation = false,
}

-- VIM LSP CONFIG
local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn",  text = "" },
    { name = "DiagnosticSignHint",  text = "" },
    { name = "DiagnosticSignInfo",  text = "" },
}

for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

vim.diagnostic.config {
    virtual_text = true,
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    signs = {
        active = signs,
    },
    float = {
        focusable = true,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
})

-- HANDLERS

local lspconfig = require('lspconfig')
for _, server_name in ipairs(lsp.get_installed_servers()) do
    local opts = {
        on_attach = on_attach,
        capabilities = capabilities,
    }
    local server_opts = settings.server_settings[server_name]
    if server_opts then
        opts = vim.tbl_deep_extend('force', opts, server_opts)
    end
    if settings.custom_setup[server_name] then
        pcall(settings.custom_setup[server_name], opts)
    else
        lspconfig[server_name].setup(opts)
    end
end
