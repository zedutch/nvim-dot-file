return {
    {
        -- https://github.com/Spiegie/jj-conflict-highlight.nvim
        'Spiegie/jj-conflict-highlight.nvim',
        version = "*",
        config = function()
            require("jj_conflict_highlight").setup({})
        end,
    },
}
