vim.env.ESLINT_D_PPID = vim.fn.getpid()

RunLinters = function(bufnr)
    local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
    local linters = nil
    local lintersRan = false

    if vim.tbl_contains({ "typescript", "typescriptreact", "javascript", "html", "svelte" }, filetype) then
        local eslintfiles = { ".eslintrc.cjs", ".eslintrc", "eslint.config.js", "eslint.config.mjs" }
        local rootmatch = vim.fs.root(0, eslintfiles)
        if rootmatch then
            vim.notify("Eslint file found in root: " .. vim.inspect(rootmatch));
            vim.env.ESLINT_D_ROOT = rootmatch
            linters = { "eslint_d" }

            local original_cwd = vim.fn.getcwd()
            vim.cmd("cd " .. rootmatch)
            require("lint").try_lint(linters)
            vim.cmd("cd " .. original_cwd)
            lintersRan = true
            --[[ else
            -- Search recursively downwards
            local matches = vim.fs.find(eslintfiles, { limit = 1, type = 'file' })
            if matches then
                vim.notify("Eslint dir found: " .. vim.inspect(matches));
                linters = { "eslint_d" }
            end ]]
        end
    end

    if not lintersRan then
        require("lint").try_lint(linters)
    end

    local numlinters = require("lint").get_running()
    if #numlinters == 0 then
        vim.notify("No linters active", vim.log.levels.ERROR)
    else
        vim.notify("Running " .. table.concat(numlinters, ", "), vim.log.levels.INFO)
    end
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

        require("lint").linters.eslint_d.args = {
            "--no-warn-ignored",
            "--format",
            "json",
            "--stdin",
            "--stdin-filename",
            function()
                return vim.api.nvim_buf_get_name(0)
            end,
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
        end, {
            silent = false,
            noremap = true,
        })
    end,
}
