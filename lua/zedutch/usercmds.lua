-- Copy the json path to the node currently under the cursor to the clipboard and display its path with notify
-- I used to have a plugin for it but it broke in neovim 0.12 so I reimplemented it as a user command
vim.api.nvim_create_user_command('JsonPath', function()
    vim.treesitter.get_parser():parse()
    local node = vim.treesitter.get_node()
    local result = {}

    while node do
        if tostring(node) == '<node pair>' then
            local key_node = node:named_child(0):named_child(0)
            if key_node ~= nil then
                table.insert(result, 1, vim.treesitter.get_node_text(key_node, 0))
            end
        end
        node = node:parent()
    end
    local path = vim.fn.join(result, '.')
    vim.notify("PATH: " .. path)
    vim.fn.setreg("+", path)
end, {})
