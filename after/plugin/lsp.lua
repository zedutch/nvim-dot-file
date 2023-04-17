local lsp = require('lsp-zero').preset({})

lsp.ensure_installed {
    'angularls',
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
}

local cmp = require('cmp')
local luasnip = require('luasnip')
require('luasnip/loaders/from_vscode').lazy_load()

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

cmp.setup {
    mapping = {
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<Tab>'] = cmp.mapping(
            function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expandable() then
                    luasnip.expand {}
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end
        ),
        ['<S-Tab>'] = cmp.mapping(
            function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end
        ),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-k>'] = cmp.mapping.select_prev_item(),
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    sources = cmp.config.sources {
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'path' },
        { name = 'npm' },
        { name = 'crates' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'emoji' },
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        format = function(entry, item)
            item.kind = string.format('%s %s', kind_icons[item.kind], item.kind)
            item.menu = ({
                npm = '[NPM]',
                crates = '[CRATES]',
                nvim_lsp = '[LSP]',
                nvim_lua = '[NVIM]',
                luasnip = '[Snippet]',
                buffer = '[Buffer]',
                path = '[Path]',
            })[entry.source.name]
            return item
        end,
    },
    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
    },
    experimental = {
        ghost_text = true,
        native_menu = false,
    },
}

-- https://github.com/windwp/nvim-autopairs#you-need-to-add-mapping-cr-on-nvim-cmp-setupcheck-readmemd-on-nvim-cmp-repo
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)


-- Wrapper around vim keymap to add description and extend options
local function keymap(bufnr, mode, lhs, rhs, description)
    local options = { silent = true, noremap = true, desc = description, buffer = bufnr }
    vim.keymap.set(mode, lhs, rhs, options)
end

lsp.on_attach(function(_, bufnr)
    keymap(bufnr, "n", "gD", function() vim.lsp.buf.declaration() end, "Go to declaration")
    keymap(bufnr, "n", "gd", function() vim.lsp.buf.definition() end, "Go to definition")
    keymap(bufnr, "n", "gi", function() vim.lsp.buf.implementation() end, "List implementations")
    keymap(bufnr, "n", "go", function() vim.lsp.buf.type_definition() end, "Type definition")
    keymap(bufnr, "n", "gr", function() vim.lsp.buf.references() end, "List references")
    keymap(bufnr, "n", "gs", function() vim.lsp.buf.signature_help() end, "Signature help")
    keymap(bufnr, "i", "<C-h>", function() vim.lsp.buf.signature_help() end, "Signature help")

    keymap(bufnr, "n", "K", function() vim.lsp.buf.hover() end)

    keymap(bufnr, "n", "<leader>ll", function() vim.diagnostic.open_float() end, "Show diagnostics")
    keymap(bufnr, "n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end)
    keymap(bufnr, "n", "<leader>la", function() vim.lsp.buf.code_action() end)
    keymap(bufnr, "n", "<leader>lr", function() vim.lsp.buf.rename() end, "Rename")
    keymap(bufnr, "n", "<leader>lj", function() vim.diagnostic.goto_next() end, "Next diagnostic problem")
    keymap(bufnr, "n", "<leader>lk", function() vim.diagnostic.goto_prev() end,
        "Previous diagnostic problem")
    keymap(bufnr, "n", "<leader>ldd", function() vim.diagnostic.enable() end, "Enable diagnostics")
    keymap(bufnr, "n", "<leader>ldl", function() vim.diagnostic.disable() end, "Disable diagnostics")
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.skip_server_setup({ 'rust_analyzer' })

lsp.setup()

vim.diagnostic.config {
    virtual_text = true,
}

