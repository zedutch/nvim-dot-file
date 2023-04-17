local M = {}

-- Formatting will be disabled completely for these filetypes
M.disable_formatting_files = {
    typescriptreact = true,
    typescript = true,
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
}

-- Add custom keymaps to certain LSP servers
M.custom_keymaps = {
    rust_analyzer = function(_, bufnr)
        local rt = require('rust-tools')
        vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
        vim.keymap.set("n", "<leader>rr", [[<cmd>!cargo run<CR>]])
        vim.keymap.set("n", "<leader>lf", rt.format, { buffer = bufnr })
        vim.keymap.set("n", "<leader>ihe", rt.inlay_hints.enable())
        vim.keymap.set("n", "<leader>ihd", rt.inlay_hints.disable())
        vim.keymap.set("n", "<leader>co", rt.open_cargo_toml.open_cargo_toml())
        vim.keymap.set("n", "<leader>cr", rt.workspace_refresh.reload_workspace())
        --  keymap(bufnr, "n", "<leader>lh", ":RustToggleInlayHints<CR>", "Toggle inlay hints")
        --  keymap(bufnr, "n", "<leader>lf", ":RustFmt<CR>", "Rust format")
        --  keymap(bufnr, "n", "<leader>rr", ":Cargo run<CR>", "Cargo run")
        --  keymap(bufnr, "n", "<leader>rar", ":RustRunnables<CR>", "Rust runnables")
        --  keymap(bufnr, "n", "<leader>rd", ":RustDebuggables<CR>", "Rust debug")
        --  keymap(bufnr, "n", "<leader>rem", ":RustExpandMacro<CR>", "Rust expand macro")
        --  keymap(bufnr, "n", "<leader>red", ":RustExternalDocs<CR>", "Rust external docs")
        --  keymap(bufnr, "n", "<leader>rpm", ":RustParentModule<CR>", "Rust parent module")
        --  keymap(bufnr, "n", "<leader>roc", ":RustOpenCargo<CR>", "Rust open cargo")
        --  keymap(bufnr, "n", "<leader>rw", ":RustReloadWorkspace<CR>", "Rust reload workspace")
        --  keymap(bufnr, "n", "<leader>rg", ":RustViewCrateGraph<CR>", "Rust view crate graph")
        --  keymap(bufnr, "n", "<leader>rs", ":RustSSR<CR>", "Rust structural search replace")
        --  keymap(bufnr, "n", "<S-j>", ":RustJoinLines<CR>", "Rust join lines")
        --  keymap(bufnr, "n", "<C-j>", ":RustMoveItemDown<CR>", "Rust move item down")
        --  keymap(bufnr, "n", "<C-k>", ":RustMoveItemUp<CR>", "Rust move item up")
    end,
}

-- Add custom setup steps for certain LSP servers
M.custom_setup = {
    rust_analyzer = function(server)
        local rt = require('rust-tools')

        rt.setup {
            server = server,
            dap = {
                adapter = {
                    type = "executable",
                    command = "lldb-vscode",
                    name = "rt_lldb",
                },
            },
            tools = {
                reload_workspace_from_cargo_toml = true,
            },
        }
    end,
}

return M
