local MyGroup = vim.api.nvim_create_augroup("ZedutchAutocmds", {})

-- Trailing whitespace
vim.api.nvim_create_autocmd("BufWritePre", {
    group = MyGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

-- LSP keybindings
vim.api.nvim_create_autocmd("LspAttach", {
    group = MyGroup,
    callback = function(ev)
        local options = {
            silent = true,
            noremap = true,
            buffer = ev.buf,
        }

        -- local client = vim.lsp.get_client_by_id(ev.data.client_id);
        -- local buffer = vim.bo[ev.buf];

        vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, options)
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, options)
        vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, options)
        vim.keymap.set("n", "go", function() vim.lsp.buf.type_definition() end, options)
        vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, options)
        vim.keymap.set("n", "gs", function() vim.lsp.buf.signature_help() end, options)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, options)

        vim.keymap.set("n", "<leader>lh", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
            options)
        vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, options)
        vim.keymap.set("n", "<leader>la", function() vim.lsp.buf.code_action() end, options)
        vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.rename() end, options)
    end
})
