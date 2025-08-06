local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
}

local file_formatting_disabled = {
    -- typescriptreact = true, -- Use prettier
    -- typescript = true,      -- Use prettier
    html = true,   -- Use prettier
    --json = true,            -- Use prettier
    python = true, -- Use black
    svelte = true, -- Use prettier
    cpp = true,    -- Use clang-format
}
local client_formatting_disabled = {
    html = true,   -- Never use html lsp for formatting, it sucks
    ts_ls = true,  -- Never use ts_ls for formatting, use prettier instead
    denols = true, -- Never use deno lsp for formatting, use prettier instead
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
    virtual_text = true,
    float = {
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
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

--- Specialized root pattern that allows for an exclusion
--- @param opt { root: string[], exclude: string[] }
--- @return fun(file_name: string): string | nil
--- Source: https://www.npbee.me/posts/deno-and-typescript-in-a-monorepo-neovim-lsp
local function root_pattern_exclude(opt)
    local util = require('lspconfig.util')

    return function(fname)
        local excluded_root = util.root_pattern(opt.exclude)(fname)
        local included_root = util.root_pattern(opt.root)(fname)

        if excluded_root then
            return nil
        else
            return included_root
        end
    end
end

return {
    -- https://github.com/mason-org/mason-lspconfig.nvim
    "mason-org/mason-lspconfig.nvim",
    priority = 100,
    dependencies = {
        {
            -- https://github.com/mason-org/mason.nvim
            "mason-org/mason.nvim",
            opts = {},
            build = function()
                vim.cmd.MasonUpdate()
            end,
        },
        {
            -- https://github.com/neovim/nvim-lspconfig
            "neovim/nvim-lspconfig",
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
        {
            -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
            "WhoIsSethDaniel/mason-tool-installer.nvim",
        },
    },
    config = function()
        --- Utility functions
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true
        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

        --- Utility functions
        local on_attach = function(client, _)
            if file_formatting_disabled[vim.bo.filetype] or client_formatting_disabled[client.name] then
                client.server_capabilities.documentFormattingProvider = false
                vim.notify("LSP Formatting disabled for " .. client.name .. " in " .. vim.bo.filetype,
                    vim.log.levels.INFO)
            end
        end

        require('mason').setup({
            ui = {
                border = "rounded",
            },
        })
        require('mason-lspconfig').setup()
        require('mason-tool-installer').setup({
            ensure_installed = {
                "cssls",
                "denols",
                "gopls",
                "html",
                "lua_ls",
                "pylsp",
                "tailwindcss",
                "ts_ls",
                "yamlls",
            },
        })

        -- LSP Server Configuration

        vim.lsp.config('ts_ls', {
            settings = {
                ts_ls = {
                    experimental = {
                        allowDefaultProject = true
                    },
                },
            },
            filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "mdx" },
            root_dir = root_pattern_exclude({
                root = { "package.json" },
                exclude = { "deno.json", "deno.jsonc" },
            }),
            single_file_support = false,
            capabilities = capabilities,
            on_attach = on_attach,
        })
        vim.lsp.enable('ts_ls')

        vim.lsp.config('lua_ls', {
            settings = {
                Lua = {
                    runtime = {
                        version = 'LuaJIT'
                    },
                    diagnostics = {
                        globals = { "vim", "require" }
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
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
        vim.lsp.enable('lua_ls')

        vim.lsp.config('denols', {
            root_markers = { "deno.json", "deno.jsonc" },
            capabilities = capabilities,
            on_attach = on_attach,
        })
        vim.lsp.enable('denols')

        vim.lsp.config('tailwindcss', {
            filetypes = { "*" },
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                tailwindCSS = {
                    includeLanguages = {
                        rust = "html",
                        ["*.rs"] = "html",
                        markdown = "html",
                        ["*.md"] = "html",
                        templ = "html",
                        ["*.templ"] = "html",
                        heex = "html",
                        ["*.heex"] = "html",
                    }
                }
            },
        })
        vim.lsp.enable('tailwindcss')

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
                { name = "emoji" },
            }, {
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
    end
    -- config = function()
    --     require("mason").setup({
    --         ui = {
    --             border = "rounded",
    --         },
    --     })
    --
    --     local lspconfig = require("lspconfig")
    --
    --     local capabilities = vim.lsp.protocol.make_client_capabilities()
    --     capabilities.textDocument.completion.completionItem.snippetSupport = true
    --     capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
    --
    --     local on_attach = function(client, _)
    --         if file_formatting_disabled[vim.bo.filetype] or client_formatting_disabled[client.name] then
    --             client.server_capabilities.documentFormattingProvider = false
    --             vim.notify("LSP Formatting disabled for " .. client.name .. " in " .. vim.bo.filetype,
    --                 vim.log.levels.INFO)
    --         end
    --     end
    --
    --     -- Rust LSP settings
    --     vim.g.rustaceanvim = {
    --         -- Plugin configuration
    --         tools = {
    --         },
    --         -- LSP configuration
    --         server = {
    --             capabilities = capabilities,
    --             on_attach = function(client, bufnr)
    --                 on_attach(client, bufnr)
    --                 local opts = { silent = true, buffer = bufnr, noremap = false }
    --                 vim.keymap.set("n", "<leader>co", function() vim.cmd.RustLsp("openCargo") end, opts)
    --                 vim.keymap.set("n", "<leader>cb", function() vim.cmd("!cargo build") end, opts)
    --                 vim.keymap.set("n", "<leader>cc", function() vim.cmd("!cargo run") end, opts)
    --                 vim.keymap.set("n", "<leader>cr", function() vim.cmd.RustLsp("reloadWorkspace") end, opts)
    --                 vim.keymap.set("n", "<leader>rp", function() vim.cmd.RustLsp("parentModule") end, opts)
    --                 vim.keymap.set("n", "<leader>re", function() vim.cmd.RustLsp("explainError") end, opts)
    --                 vim.keymap.set("n", "<leader>rr", function() vim.cmd.RustLsp("runnables") end, opts)
    --                 vim.keymap.set("n", "<leader>rd", function() vim.cmd.RustLsp("debuggables") end, opts)
    --                 vim.keymap.set("n", "<leader>rj", function() vim.cmd.RustLsp({ "moveItem", "down" }) end, opts)
    --                 vim.keymap.set("n", "<leader>rk", function() vim.cmd.RustLsp({ "moveItem", "up" }) end, opts)
    --                 vim.keymap.set("n", "<leader>le", function() vim.cmd.RustLsp("renderDiagnostic") end, opts)
    --                 vim.keymap.set("n", "<leader>ll", function() vim.cmd.RustLsp("flyCheck") end, opts)
    --             end,
    --             default_settings = {
    --                 -- rust-analyzer language server configuration
    --                 ['rust-analyzer'] = {
    --                     capabilities = capabilities,
    --                     checkOnSave = {
    --                         command = "clippy",
    --                     },
    --                     rustfmt = {
    --                         overrideCommand = { "leptosfmt", "--stdin", "--rustfmt" },
    --                     },
    --                 },
    --             },
    --         },
    --         -- DAP configuration
    --         dap = {
    --             --autoload_configurations = true,
    --         },
    --     }
    --
    --     local util = require 'lspconfig/util'
    --     require("mason-lspconfig").setup({
    --         automatic_installation = true,
    --         ensure_installed = {
    --             "cssls",
    --             "denols",
    --             "gopls",
    --             "html",
    --             "lua_ls",
    --             "pylsp",
    --             "tailwindcss",
    --             "ts_ls",
    --             "vimls",
    --             "yamlls",
    --         },
    --         handlers = {
    --
    --             function(server_name)
    --                 lspconfig[server_name].setup({
    --                     capabilities = capabilities,
    --                     on_attach = on_attach,
    --                 })
    --             end,
    --
    --             ["rust_analyzer"] = function()
    --                 -- do nothing, let rustaceanvim handle it
    --             end,
    --
    --             ["gopls"] = function()
    --                 lspconfig.gopls.setup({
    --                     settings = {
    --                         gopls = {
    --                             analyses = {
    --                                 unusedvariable = true,
    --                                 useany = true,
    --                                 -- https://staticcheck.io/docs/checks/
    --                                 SA1002 = true, -- Invalid format in time.Parse
    --                                 SA1012 = true, -- A nil context.Context is being passed to a function, consider using context.TODO instead
    --                                 SA1014 = true, -- Non-pointer value passed to Unmarshal or Decode
    --                                 SA1017 = true, -- Channels used with os/signal.Notify should be buffered
    --                                 SA1023 = true, -- Modifying the buffer in an io.Writer implementation
    --                                 SA1026 = true, -- Cannot marshal channels or functions
    --                                 SA1028 = true, -- sort.Slice can only be used on slices
    --                                 SA1029 = true, -- Inappropriate key in call to context.WithValue
    --                                 SA2000 = true, -- sync.WaitGroup.Add called inside the goroutine, leading to a race condition
    --                                 SA2001 = true, -- Empty critical section, did you mean to defer the unlock?
    --                                 SA2002 = true, -- Called testing.T.FailNow or SkipNow in a goroutine, which isn’t allowed
    --                                 SA3000 = true, -- TestMain doesn’t call os.Exit, hiding test failures
    --                                 SA3001 = true, -- Assigning to b.N in benchmarks distorts the results
    --                                 SA5000 = true, -- Assignment to nil map
    --                                 SA5001 = true, -- Deferring Close before checking for a possible error
    --                                 SA5007 = true, -- Infinite recursive call
    --                                 SA5010 = true, -- Impossible type assertion
    --                                 SA5011 = true, -- Possible nil pointer dereference
    --                                 SA6000 = true, -- Using regexp.Match or related in a loop, should use regexp.Compile
    --                                 SA6002 = true, -- Storing non-pointer values in sync.Pool allocates memory
    --                                 SA6005 = true, -- Inefficient string comparison with strings.ToLower or strings.ToUpper
    --                                 S1001 = true,  -- Replace for loop with call to copy
    --                                 S1005 = true,  -- Drop unnecessary use of the blank identifier
    --                                 S1007 = true,  -- Simplify regular expression by using raw string literal
    --                                 S1008 = true,  -- Simplify returning boolean expression
    --                                 S1009 = true,  -- Omit redundant nil check on slices
    --                                 S1011 = true,  -- Use a single append to concatenate two slices
    --                                 S1012 = true,  -- Replace time.Now().Sub(x) with time.Since(x)
    --                                 S1016 = true,  -- Use a type conversion instead of manually copying struct fields
    --                                 S1019 = true,  -- Simplify make call by omitting redundant arguments
    --                                 S1020 = true,  -- Omit redundant nil check in type assertion
    --                                 S1023 = true,  -- Omit redundant control flow
    --                                 S1024 = true,  -- Replace x.Sub(time.Now()) with time.Until(x)
    --                                 S1025 = true,  -- Don’t use fmt.Sprintf("%s", x) unnecessarily
    --                                 S1028 = true,  -- Simplify error construction with fmt.Errorf
    --                                 S1038 = true,  -- Unnecessarily complex way of printing formatted string
    --                                 S1039 = true,  -- Unnecessary use of fmt.Sprint
    --                                 S1040 = true,  -- Type assertion to current type
    --                                 ST1000 = true, -- Incorrect or missing package comment
    --                                 QF1001 = true, -- Apply De Morgan’s law
    --                                 QF1002 = true, -- Convert untagged switch to tagged switch
    --                                 QF1003 = true, -- Convert if/else-if chain to tagged switch
    --                                 QF1006 = true, -- Lift if+break into loop condition
    --                                 QF1009 = true, -- Use time.Time.Equal instead of == operator
    --                                 QF1011 = true, -- Omit redundant type from variable declaration
    --                             },
    --                             codelenses = {
    --                                 test = true,
    --                                 run_govulncheck = true,
    --                                 tidy = true,
    --                                 upgrade_dependency = true,
    --                                 vendor = true,
    --                             },
    --                             usePlaceholders = true,
    --                             completeUnimported = true,
    --                             staticcheck = true,
    --                             vulncheck = "Imports",
    --                             gofumpt = true,
    --                             hints = {
    --                                 assignVariableTypes = true,
    --                                 compositeLiteralFields = true,
    --                                 constantValues = true,
    --                                 parameterNames = true,
    --                                 rangeVariableTypes = true,
    --                             },
    --                         },
    --                     },
    --                     capabilities = capabilities,
    --                     on_attach = function(client, bufnr)
    --                         on_attach(client, bufnr)
    --                         vim.keymap.set("n", "<leader>gie", "<cmd>GoIfErr<cr>",
    --                             { buffer = bufnr, desc = "if err != nil" })
    --                         vim.keymap.set("n", "<leader>gmt", "<cmd>GoMod tidy<cr>",
    --                             { buffer = bufnr, desc = "go mod tidy" })
    --                     end,
    --                 })
    --             end,
    --
    --             ["pylsp"] = function()
    --                 lspconfig.pylsp.setup({
    --                     settings = {
    --                         pylsp = {
    --                             plugins = {
    --                                 pylint = {
    --                                     enabled = true,
    --                                     args = "--load-plugins=pylint_django,pylint_quotes",
    --                                 },
    --                                 yapf = {
    --                                     enabled = false,
    --                                 },
    --                                 pyflakes = {
    --                                     enabled = false,
    --                                 },
    --                                 mccabe = {
    --                                     enabled = false,
    --                                 },
    --                                 autopep8 = {
    --                                     enabled = false,
    --                                 },
    --                                 pycodestyle = {
    --                                     enabled = false,
    --                                 },
    --                                 pylsp_mypy = {
    --                                     enabled = true,
    --                                 },
    --                                 pyls_isort = {
    --                                     enabled = true,
    --                                 },
    --                             },
    --                         },
    --                     },
    --                     capabilities = capabilities,
    --                     on_attach = on_attach,
    --                 })
    --             end,
    --
    --             ["hyprls"] = function()
    --                 lspconfig.hyprls.setup({
    --                     filetypes = { "hypr*.conf" },
    --                     capabilities = capabilities,
    --                     on_attach = on_attach,
    --                 })
    --             end,
    --
    --             -- This does not work very well currently, maybe try again later? (- 05/2024)
    --             -- ["sqlls"] = function()
    --             --     lspconfig.sqlls.setup({
    --             --         root_dir = util.root_pattern('.git'),
    --             --         filetypes = { "sql" },
    --             --         capabilities = capabilities,
    --             --         on_attach = on_attach,
    --             --     })
    --             -- end,
    --
    --             ["html"] = function()
    --                 lspconfig.html.setup({
    --                     root_dir = util.root_pattern('~angular.json', 'package.json', '.git'),
    --                     filetypes = { "html", "htmldjango", "rust", "templ" },
    --                     capabilities = capabilities,
    --                     on_attach = on_attach,
    --                 })
    --             end,
    --
    --             ["cssls"] = function()
    --                 lspconfig.cssls.setup({
    --                     capabilities = capabilities,
    --                     on_attach = on_attach,
    --                     settings = {
    --                         css = {
    --                             lint = {
    --                                 unknownAtRules = "ignore",
    --                             },
    --                         },
    --                     },
    --                 })
    --             end,
    --
    --             ["htmx"] = function()
    --                 lspconfig.htmx.setup({
    --                     filetypes = { "html", "htmldjango", "javascriptreact", "typescriptreact", "rust", "templ" },
    --                     capabilities = capabilities,
    --                     on_attach = on_attach,
    --                 })
    --             end,
    --
    --             ["yamlls"] = function()
    --                 lspconfig.yamlls.setup({
    --                     settings = {
    --                         yaml = {
    --                             keyOrdering = false,
    --                         },
    --                     },
    --                     capabilities = capabilities,
    --                     on_attach = on_attach,
    --                 })
    --             end,
    --
    --             ["clangd"] = function()
    --                 capabilities.offsetEncoding = { "utf-16", "utf-8" }
    --                 lspconfig.clangd.setup({
    --                     capabilities = capabilities,
    --                     on_attach = function(client, bufnr)
    --                         on_attach(client, bufnr)
    --                         vim.keymap.set("n", "<leader>cc", "<cmd>!./build.sh<cr>")
    --                         vim.keymap.set("n", "<leader>rr", "<cmd>!./run.sh<cr>")
    --                         vim.keymap.set("n", "<leader><leader>", "<cmd>ClangdSwitchSourceHeader<cr>")
    --                     end,
    --                 })
    --
    --                 require('clangd_extensions').setup({
    --                     server = {
    --                         capabilities = capabilities,
    --                         on_attach = on_attach,
    --                     },
    --                     extensions = {
    --                         autoSetHints = true,
    --                         inlay_hints = {
    --                             only_current_line = false,
    --                         },
    --                         memory_usage = {
    --                             border = "rounded"
    --                         },
    --                         symbol_info = {
    --                             border = "rounded"
    --                         }
    --                     }
    --                 })
    --             end,
    --
    --         },
    --     })
    --
    --     -- GDScript is currently not supported by mason-lspconfig
    --     lspconfig.gdscript.setup({
    --         capabilities = capabilities,
    --         on_attach = on_attach,
    --         cmd = { 'nc', '127.0.0.1', '6005' } -- This should match Godot settings
    --     })
    -- end,
}
