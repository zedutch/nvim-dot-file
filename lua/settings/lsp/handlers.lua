local M = {}

local ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not ok then
    print 'Skipping cmp_nvim_lsp as it is not installed.'
    cmp_nvim_lsp = false
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
if cmp_nvim_lsp then
    M.capabilities = cmp_nvim_lsp.update_capabilities(M.capabilities)
end

M.setup = function()
    local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    vim.diagnostic.config {
        virtual_text = false,
        signs = {
            active = signs,
        },
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

    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = 'rounded',
    })

    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = 'rounded',
    })
end

-- Wrapper around vim keymap to add description and extend options
local function keymap(bufnr, mode, lhs, rhs, description, opts)
    local options = { silent = true, noremap = true, desc = description }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, options)
end

local function lsp_keymaps(bufnr)
    local opts = { noremap = true, silent = true }
    keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", "Go to declaration")
    keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to definition")
    keymap(bufnr, "n", "gI", ":lua vim.lsp.buf.implementation()<CR>", "Go to implementation")
    keymap(bufnr, "n", "gr", ":lua vim.lsp.buf.references()<CR>")
    keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>")

    keymap(bufnr, "n", "K",  "<cmd>lua vim.lsp.buf.hover()<CR>")

    keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>")
    keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>")
    keymap(bufnr, "n", "<leader>lr", ":lua vim.lsp.buf.rename()<CR>", "Rename")
    keymap(bufnr, "n", "<leader>ls", ":lua vim.lsp.buf.signature_help()<CR>")
    keymap(bufnr, "n", "<leader>lj", ":lua vim.diagnostic.goto_next({buffer=0})<CR>", "Next diagnostic problem")
    keymap(bufnr, "n", "<leader>lk", ":lua vim.diagnostic.goto_prev({buffer=0})<CR>", "Previous diagnostic problem")
end

M.on_attach = function(client, bufnr)
    -- Do not auto-format HTML
    if client.name == 'html' then
        client.server_capabilities.documentFormattingProvider = false
    end

    -- Do not show tsserver as a formatting source
    -- if client.name == 'tsserver' then
    --     client.resolved_capabilities.document_formatting = false
    -- end

    -- Do not show sumneko_lua as a formatting source
    if client.name == 'sumneko_lua' then
        client.resolved_capabilities.document_formatting = false
    end

    if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_command [[augroup Format]]
        vim.api.nvim_command [[autocmd! * <buffer>]]
        vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
        vim.api.nvim_command [[augroup END]]
    end

    lsp_keymaps(bufnr)

    local ok, illuminate = pcall(require, 'illuminate')
    if not ok then
        print('Skipping illuminate as it is not installed.')
        return
    end
    illuminate.on_attach(client)
end

return M
