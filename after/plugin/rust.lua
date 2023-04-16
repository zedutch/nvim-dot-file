local rt = require('rust-tools')

rt.setup {
    server = {
        on_attach = function(_, bufnr)
            vim.keymap.set("n", "<leader>la", rt.hover_actions.hover_actions, { buffer = bufnr })
            vim.keymap.set("n", "<leader>rr", [[<cmd>!cargo run<CR>]])
            vim.keymap.set("n", "<leader>lf", rt.format, { buffer = bufnr })
            vim.keymap.set("n", "<leader>ihe", rt.inlay_hints.enable())
            vim.keymap.set("n", "<leader>ihd", rt.inlay_hints.disable())
            vim.keymap.set("n", "<leader>co", rt.open_cargo_toml.open_cargo_toml())
            vim.keymap.set("n", "<leader>cr", rt.workspace_refresh.reload_workspace())
        end,
        standalone = false,
    },
    dap = {
        adapter = {
            type = "executable",
            command = "lldb-vscode",
            name = "rt_lldb",
        },
    },
    tools = {
        reload_workspace_from_cargo_toml = true,
        inlay_hints = {
            -- automatically set inlay hints (type hints)
            -- default: true
            auto = true,
            -- Only show inlay hints for the current line
            only_current_line = false,
            -- whether to show parameter hints with the inlay hints or not
            -- default: true
            show_parameter_hints = true,
            -- prefix for parameter hints
            -- default: "<-"
            parameter_hints_prefix = "<- ",
            -- prefix for all the other hints (type, chaining)
            -- default: "=>"
            other_hints_prefix = "=> ",
            -- whether to align to the length of the longest line in the file
            max_len_align = false,
            -- padding from the left if max_len_align is true
            max_len_align_padding = 1,
            -- whether to align to the extreme right or not
            right_align = false,
            -- padding from the right if right_align is true
            right_align_padding = 7,
            -- The color of the hints
            highlight = "Comment",
        },
    },
}
