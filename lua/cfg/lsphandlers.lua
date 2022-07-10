local M = {}

local cmp_nvim_lsp = require('cmp_nvim_lsp')

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupprt = true
M.capabilities = cmp_nvim_lsp.update_capabilities(M.capabilities)

M.setup = function()
    local config = {
        virtual_text = false,
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
            focusable = true,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    }

    vim.diagnostics.config(config)

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
    })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
    })
end

local function lsp_keymaps(bufnr)
    local opts = { noremap = true, silent = true }
    local keymap = vim.api.nvim_buf_set_keymap
    keymap(bufnr, "n", "gD", ":lua vim.lsp.buf.declaration()<CR>", opts)
    keymap(bufnr, "n", "gd", ":lua vim.lsp.buf.definition()<CR>", opts)
    keymap(bufnr, "n", "K",  ":lua vim.lsp.buf.hover()<CR>", opts)
    keymap(bufnr, "n", "gI", ":lua vim.lsp.buf.implementation()<CR>", opts)
    keymap(bufnr, "n", "gr", ":lua vim.lsp.buf.references()<CR>", opts)
    keymap(bufnr, "n", "gl", ":lua vim.diagnostic.open_float()<CR>", opts)
    keymap(bufnr, "n", "<leader>lf", ":lua vim.lsp.buf.formatting()<CR>", opts)
    keymap(bufnr, "n", "<leader>la", ":lua vim.lsp.buf.code_action()<CR>", opts)
    keymap(bufnr, "n", "<leader>lr", ":lua vim.lsp.buf.rename()<CR>", opts)
    keymap(bufnr, "n", "<leader>ls", ":lua vim.lsp.buf.signature_help()<CR>", opts)
    keymap(bufnr, "n", "<leader>lj", ":lua vim.diagnostic.goto_next({buffer=0})<CR>", opts)
    keymap(bufnr, "n", "<leader>lk", ":lua vim.diagnostic.goto_prev({buffer=0})<CR>", opts)
    keymap(bufnr, "n", "<leader>li", ":LspInfo<CR>", opts)
    keymap(bufnr, "n", "<leader>lI", ":LspInstallInfo<CR>", opts)
end

M.on_attach = function(client, bufnr)
    if client.name == "tsserver" or client.name == "sumneko_lua" then
        client.resolved_capabilities.document_formatting = false
    end

    lsp_keymaps(bufnr)
    require('illuminate').on_attach(client)
end

return M
