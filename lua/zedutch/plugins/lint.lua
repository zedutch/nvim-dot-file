return {
    -- https://github.com/rshkarin/mason-nvim-lint
    "rshkarin/mason-nvim-lint",
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
            typescript = { "eslint_d" },
            typescriptreact = { "eslint_d" },
            javascript = { "eslint_d" },
            html = { "eslint_d" },
        }

        require("mason-nvim-lint").setup({
            -- Automatically install the linters configured in nvim-lint
            automatic_installation = true,
        })

        vim.api.nvim_create_autocmd({ "BufReadPre", "BufWritePost" }, {
            callback = function()
                require("lint").try_lint()
            end,
        })

        vim.keymap.set("n", "<leader>ll", function()
            require("lint").try_lint()
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
