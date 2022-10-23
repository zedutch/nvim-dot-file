local ok, autopairs = pcall(require, 'nvim-autopairs')
if not ok then
    print 'Skipping nvim-autopairs as it is not installed.'
    return
end

autopairs.setup {
    check_ts = true,
    ts_config = {
        lua = { 'string', 'source' },
        javascript = { 'string', 'template_string' },
        java = false,
    },
    disable_filetype = { 'TelescopePrompt', 'spectre_panel' },
    fast_wrap = {
        map = '<A-e>',
        chars = { '{', '[', '(', '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        offset = 0,
        end_key = '$',
        keys = "qwertyuiopasdfghjklzxcvbnm",
        check_comma = true,
        highlight = 'PmenuSel',
        highlight_grey = 'LineNr',
    },
}

local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
local cmp_ok, cmp = pcall(require, 'cmp')
if not cmp_ok then
    print 'Skipping autopairs - cmp integration since cmp is not installed.'
    return
end
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done { map_char = { tex = '' } })
