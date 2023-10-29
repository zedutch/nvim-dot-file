local util = require 'lspconfig/util'

local M = {}

-- Formatting will be disabled completely for these filetypes (for LSP-config servers at least)
M.disable_formatting_files = {
    typescriptreact = true, -- Use nullls prettier
    typescript = true,      -- Use nullls prettier
    html = true,            -- Use nullls prettier
    json = true,            -- Use nullls prettier
    python = true,          -- Use nullls black
    svelte = true,          -- Use nullls prettier
    --kotlin_language_server = true, -- Use nullls ktlint
}

-- Add settings per LSP server
M.server_settings = {
    rust_analyzer = {
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy",
                },
            },
        },
    },
    lua_ls = {
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" }
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file('', true),
                    checkThirdParty = false,
                },
                telemetry = {
                    enable = false,
                },
            }
        }
    },
    tailwindcss = {
        root_dir = util.root_pattern('tailwind.config.js', 'tailwind.config.cjs', 'tailwind.config.ts',
            'postcss.config.js', 'postcss.config.ts',
            'package.json', 'node_modules', '.git'),
        filetypes = { "aspnetcorerazor", "astro", "astro-markdown", "blade", "django-html", "edge", "eelixir", "ejs",
            "erb", "eruby", "gohtml", "haml", "handlebars", "hbs", "html", "html-eex", "jade", "leaf", "liquid",
            "markdown", "mdx", "mustache", "njk", "nunjucks", "php", "razor", "slim", "twig", "css", "less", "postcss",
            "sass", "scss", "stylus", "sugarss", "javascript", "javascriptreact", "reason", "rescript", "typescript",
            "typescriptreact", "vue", "svelte",
            -- Added by me:
            "rust"
        }
    },
    pylsp = {
        settings = {
            pylsp = {
                plugins = {
                    -- Disable all plugins, these are used through null-ls as that works better
                    pylint = {
                        enabled = false,
                    },
                    black = {
                        enabled = false,
                    },
                    pycodestyle = {
                        enabled = false,
                    },
                    mccabe = {
                        enabled = false,
                    },
                    yapf = {
                        enabled = false,
                    },
                    autopep8 = {
                        enabled = false,
                    },
                    pyflakes = {
                        enabled = false,
                    },
                },
            },
        },
    },
    eslint = {
        filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact",
            "typescript.tsx", "vue", "svelte", "astro",
            -- Added by me:
            "html" }
    },
    html = {
        root_dir = util.root_pattern('~angular.json', 'package.json', '.git'),
        filetypes = { "html",
            -- Added by me:
            "htmldjango" }
    },
    yamlls = {
        settings = {
            yaml = {
                keyOrdering = false,
            },
        },
    },
    kotlin_language_server = {
        settings = {
            kotlin = {
                compiler = {
                    jvm = {
                        target = "17",
                    },
                },
            },
        },
    },
    gopls = {
        settings = {
            gopls = {
                completeUnimported = true,
                usePlaceholders = true,
                analyses = {
                    nilness = true,
                    -- unusedparams = true,
                    unusedvariable = true,
                },
            },
        },
    },
}

-- Add custom keymaps to certain LSP servers
M.custom_keymaps = {
    rust_analyzer = function(_, bufnr)
        local rt = require('rust-tools')
        vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
        -- vim.keymap.set("n", "<leader>la", rt.code_action_group.code_action_group, { buffer = bufnr })
        vim.keymap.set("n", "<leader>rr", [[<cmd>!cargo run<CR>]])
        vim.keymap.set("n", "<leader>lf", rt.format, { buffer = bufnr, desc = "Rust format" })
        vim.keymap.set("n", "<leader>ihe", rt.inlay_hints.enable(), { buffer = bufnr })
        vim.keymap.set("n", "<leader>ihd", rt.inlay_hints.disable(), { buffer = bufnr })
        vim.keymap.set("n", "<leader>co", rt.open_cargo_toml.open_cargo_toml(), { buffer = bufnr })
        vim.keymap.set("n", "<leader>cr", rt.workspace_refresh.reload_workspace(), { buffer = bufnr })
        vim.keymap.set("n", "<leader>dd", rt.debuggables.debuggables(), { buffer = bufnr })
        --  keymap(bufnr, "n", "<leader>lh", ":RustToggleInlayHints<CR>", "Toggle inlay hints", { buffer = bufnr })
        --  keymap(bufnr, "n", "<leader>lf", ":RustFmt<CR>", "Rust format", { buffer = bufnr })
        --  keymap(bufnr, "n", "<leader>rr", ":Cargo run<CR>", "Cargo run", { buffer = bufnr })
        --  keymap(bufnr, "n", "<leader>rar", ":RustRunnables<CR>", "Rust runnables", { buffer = bufnr })
        --  keymap(bufnr, "n", "<leader>rd", ":RustDebuggables<CR>", "Rust debug", { buffer = bufnr })
        --  keymap(bufnr, "n", "<leader>rem", ":RustExpandMacro<CR>", "Rust expand macro", { buffer = bufnr })
        --  keymap(bufnr, "n", "<leader>red", ":RustExternalDocs<CR>", "Rust external docs", { buffer = bufnr })
        --  keymap(bufnr, "n", "<leader>rpm", ":RustParentModule<CR>", "Rust parent module", { buffer = bufnr })
        --  keymap(bufnr, "n", "<leader>roc", ":RustOpenCargo<CR>", "Rust open cargo", { buffer = bufnr })
        --  keymap(bufnr, "n", "<leader>rw", ":RustReloadWorkspace<CR>", "Rust reload workspace", { buffer = bufnr })
        --  keymap(bufnr, "n", "<leader>rg", ":RustViewCrateGraph<CR>", "Rust view crate graph", { buffer = bufnr })
        --  keymap(bufnr, "n", "<leader>rs", ":RustSSR<CR>", "Rust structural search replace", { buffer = bufnr })
        --  keymap(bufnr, "n", "<S-j>", ":RustJoinLines<CR>", "Rust join lines", { buffer = bufnr })
        --  keymap(bufnr, "n", "<C-j>", ":RustMoveItemDown<CR>", "Rust move item down", { buffer = bufnr })
        --  keymap(bufnr, "n", "<C-k>", ":RustMoveItemUp<CR>", "Rust move item up", { buffer = bufnr })
    end,

    clangd = function(_, bufnr)
        vim.keymap.set("n", "<leader>o", "<cmd>ClangdSwitchSourceHeader<CR>",
            { buffer = bufnr, desc = "Switch source <> header" })
    end,

    gopls = function(_, bufnr)
        -- local go = require('gopher.nvim')
        vim.keymap.set("n", "<leader>ke", [[<cmd>GoIfErr<CR>]], { buffer = bufnr, desc = "if err != nil" })
        vim.keymap.set("n", "<leader>kta", [[<cmd>GoTagAdd ]], { buffer = bufnr, desc = "Add struct tag" })
        vim.keymap.set("n", "<leader>ktr", [[<cmd>GoTagRemove ]], { buffer = bufnr, desc = "Remove struct tag" })
    end,

}

-- Add custom setup steps for certain LSP servers
M.custom_setup = {
    rust_analyzer = function(server)
        local mason_registry = require("mason-registry")
        local codelldb = mason_registry.get_package("codelldb")
        local ext_path = codelldb:get_install_path() .. "/extension/"
        local os = vim.loop.os_uname().sysname;
        local codelldb_path = ext_path .. "adapter/codelldb"
        local liblldb_path = ext_path .. "lldb/lib/liblldb"
        if os:find "Windows" then
            codelldb_path = ext_path .. "adapter/codelldb.exe"
            liblldb_path = ext_path .. "lldb/lib/liblldb.dll"
        else
            liblldb_path = ext_path .. "lldb/lib/liblldb" .. (os == "Linux" and ".so" or ".dylib")
        end
        require('rust-tools').setup {
            server = server,
            dap = {
                adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
            },
            tools = {
                reload_workspace_from_cargo_toml = true,
            },
        }
    end,
    clangd = function(server)
        server.capabilities.offsetEncoding = { "utf-16", "utf-8" }
        require('clangd_extensions').setup {
            server = server,
            extensions = {
                autoSetHints = true,
                inlay_hints = {
                    only_current_line = false,
                },
                memory_usage = {
                    border = "rounded"
                },
                symbol_info = {
                    border = "rounded"
                }
            }

        }
    end,
}

return M
