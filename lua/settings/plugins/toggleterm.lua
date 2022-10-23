local ok, terminal = pcall(require, 'toggleterm')
if not ok then
    print 'Skipping toggleterm as it is not installed.'
    return
end

terminal.setup {
    size = 20,
    open_mapping = '<C-t>',
    hide_numbers = true,
    shade_terminals = true,
    insert_mappings = true,
    persist_size = true,
    direction = 'float', -- 'float' | 'horizontal' | 'vertical'
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
        border = 'curved',
    },
}
local Terminal = require('toggleterm.terminal').Terminal
local python = Terminal:new({ cmd = 'python3', hidden = true })

function _PYTHON_TOGGLE()
	python:toggle()
end
