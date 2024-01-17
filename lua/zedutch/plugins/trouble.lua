-- https://github.com/folke/trouble.nvim
return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        { "<leader>tt", "<cmd>TroubleToggle<cr>" },
        { "<leader>tr", "<cmd>TroubleRefresh<cr>" },
        -- { "<leader>tj", function() require("trouble").next({ skip_groups = true, jump = true }) end },
        -- { "<leader>tk", function() require("trouble").previous({ skip_groups = true, jump = true }) end },
        { "L",  function() require("trouble").next({ skip_groups = true, jump = true }) end },
        { "H",  function() require("trouble").previous({ skip_groups = true, jump = true }) end },
    },
    opts = {
        mode = "workspace_diagnostics",
        -- auto_open = true,
    },
}
