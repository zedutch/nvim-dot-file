------ Settings ------ 
require "settings/options"
require "settings/keymaps"


------ Platforms ------
if vim.fn.has('macunix') == 1 then
    require 'settings/macos'
elseif vim.fn.has('win32') == 1 then
    require 'settings/windows'
elseif vim.fn.has('wsl') == 1 then
    require 'settings/wsl'
elseif vim.fn.has('unix') == 1 then
    require 'settings/linux'
end


------- Plugins -------
require "settings/plugins"


------- Neovide -------
if vim.g.neovide ~= nil then
    require "settings/neovide"
end
