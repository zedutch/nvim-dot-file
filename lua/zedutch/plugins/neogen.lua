return {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    keys = {
        { "<leader>dd", "<cmd>Neogen file<cr>" },
        { "<leader>df", "<cmd>Neogen func<cr>" },
        { "<leader>dt", "<cmd>Neogen type<cr>" },
        { "<leader>dc", "<cmd>Neogen class<cr>" },
    },
    opts = {
        snippet_engine = "luasnip",
    },
}
