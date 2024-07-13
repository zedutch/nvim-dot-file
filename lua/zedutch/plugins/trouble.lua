-- https://github.com/folke/trouble.nvim
return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        { "<leader>tt", "<cmd>Trouble diagnostics toggle<cr>" },
        { "<leader>td", "<cmd>Trouble todo toggle<cr>" },
        { "L",          function() require("trouble").next({ skip_groups = true, jump = true }) end },
        { "H",          function() require("trouble").previous({ skip_groups = true, jump = true }) end },
    },
    opts = {
        mode = "workspace_diagnostics",
        -- auto_open = true,
    },
}
