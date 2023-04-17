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

-- local rt = require('rust-tools')
-- 
-- rt.setup {
--     server = {
--         on_attach = function(_, bufnr)
--             vim.keymap.set("n", "<leader>la", rt.hover_actions.hover_actions, { buffer = bufnr })
--             vim.keymap.set("n", "<leader>rr", [[<cmd>!cargo run<CR>]])
--             vim.keymap.set("n", "<leader>lf", rt.format, { buffer = bufnr })
--             vim.keymap.set("n", "<leader>ihe", rt.inlay_hints.enable())
--             vim.keymap.set("n", "<leader>ihd", rt.inlay_hints.disable())
--             vim.keymap.set("n", "<leader>co", rt.open_cargo_toml.open_cargo_toml())
--             vim.keymap.set("n", "<leader>cr", rt.workspace_refresh.reload_workspace())
--         end,
--         -- standalone = false,
--         settings = {
--             ["rust-analyzer"] = {
--                 checkOnSave = {
--                     command = "clippy",
--                 },
--             },
--         },
--     },
--     dap = {
--         adapter = {
--             type = "executable",
--             command = "lldb-vscode",
--             name = "rt_lldb",
--         },
--     },
--     tools = {
--         reload_workspace_from_cargo_toml = true,
--     },
-- }
