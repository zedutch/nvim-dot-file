------ Settings ------ 
require "settings/options"
require "settings/keymaps"


------ Platforms ------
if vim.fn.has('macunix') == 1 then
    require 'settings/macos'
elseif vim.fn.has('win32') == 1 then
    require 'settings/windows'
end


------- Plugins -------
require "settings/plugins"


------ LspConfig ------
require "settings/lsp"


------- Neovide -------
if vim.g.neovide ~= nil then
    require "settings/neovide"
end


-- nvim sometimes likes to highlight random strings after reloading
vim.cmd("nohl")
