------ Settings ------
require "zedutch.options"
require "zedutch.keymaps"
require "zedutch.filetypes"

------ Platforms ------
if vim.fn.has("macunix") == 1 then
    require "zedutch.macos"
elseif vim.fn.has("win32") == 1 then
    require "zedutch.windows"
elseif vim.fn.has("wsl") == 1 then
    require "zedutch.wsl"
elseif vim.fn.has("unix") == 1 then
    require "zedutch.linux"
end

------- Plugins -------
require "zedutch.lazyloader"

-- This can possibly be removed later, but this speeds up startup time for now
-- See: https://github.com/JoosepAlviste/nvim-ts-context-commentstring
vim.g.skip_ts_context_commentstring_module = true

----- Colorscheme -----
vim.o.background = "dark"
vim.cmd[[colorscheme gruvbox]]

----- Autocommands -----
require "zedutch.autocmds"

