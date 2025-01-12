RunLinters = function(bufnr)
    local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
    local linters = nil

    if vim.tbl_contains({ "typescript", "typescriptreact", "javascript", "html" }, filetype) then
        if vim.fs.root(0, { ".eslintrc.cjs", ".eslintrc" }) then
            linters = { "eslint_d" }
        end
    end

    require("lint").try_lint(linters)
end

return {
    -- https://github.com/rshkarin/mason-nvim-lint
    "rshkarin/mason-nvim-lint",
    priority = 40, -- after all lsp plugins
    dependencies = {
        -- https://github.com/mfussenegger/nvim-lint
        "mfussenegger/nvim-lint",

        "williamboman/mason.nvim",
        "neovim/nvim-lspconfig", -- This will do mason setup
    },
    config = function()
        require("lint").linters_by_ft = {
            ["yaml.ansible"] = { "ansible-lint" },
            ["yaml.action"] = { "actionlint" },
            htmldjango = { "djlint" },
            dotenv = { "dotenv_linter" },
            -- typescript = { "eslint_d" },
            -- typescriptreact = { "eslint_d" },
            -- javascript = { "eslint_d" },
            -- html = { "eslint_d" },
            gd = { "gdlint" },
            go = { "golangcilint" },
        }

        require("mason-nvim-lint").setup({
            -- Automatically install the linters configured in nvim-lint
            automatic_installation = true,
        })

        -- This is no longer necessary, the next autocmd already does autolinting
        -- vim.api.nvim_create_autocmd({ "BufReadPre", "BufWritePost" }, {
        --     callback = function()
        --         require("lint").try_lint()
        --     end,
        -- })

        -- Only run eslint_d if an eslintrc is present
        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            callback = function(args)
                RunLinters(args.buf)
            end,
        })

        vim.keymap.set("n", "<leader>ll", function()
            RunLinters(vim.api.nvim_get_current_buf())
            local linters = require("lint").get_running()
            if #linters == 0 then
                vim.notify("No linters active", vim.log.levels.ERROR)
            else
                vim.notify("Running " .. table.concat(linters, ", "), vim.log.levels.INFO)
            end
        end, {
            silent = false,
            noremap = true,
        })
    end,
}
