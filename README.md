## Dependencies

- [Hack Nerd Font Mono](https://github.com/ryanoasis/nerd-fonts/releases/latest)
- [ripgrep (rg)](https://github.com/BurntSushi/ripgrep)
- [sharkdp/fd](https://github.com/sharkdp/fd)
- [dotenv-linter](http://dotenv-linter.github.io/#/installation)
- clang (or any other c compiler)
- pnpm
- Run `checkhealth` and install missing executables

## Current issues

- I don't know how to add snippets myself, I should use [nvim-scissors](https://github.com/chrisgrieser/nvim-scissors)
- [git-conflict](https://github.com/akinsho/git-conflict.nvim) uses deprecated functions (vim.highlight, vim.validate) but seems to not be maintained anymore, might need to replace or remove it (I do use it a lot so would prefer a maintained alternative)
- LspInfo returns warnings about "GitHub Copilot" and "null-ls" not being active, but calling `vim.lsp.config('null-ls')` and `vim.lsp.config('GitHub Copilot')` breaks LSP entirely. Needs investigation.

## Next rewrite

Libraries to consider for the next config rewrite:

- [cloak.nvim](https://github.com/laytan/cloak.nvim) - prevent accidental secret sharing
- nvim-treesitter/nvim-treesitter-textobjects - textobject (w, p) for treesitter objects (assignments, conditionals, parameters, function call, loop, etc)
- [jj.nvim](https://github.com/NicolasGB/jj.nvim) - depending on if it's even more useful than `jjui` (which I love).
    - Would prefer a way to open jjui from within neovim and callback between both rather than a full 'new' plugin...
    - The only thing I really need from fugitive is a way to quickly see changes in the current changeset and to navigate to them. Commit / squash would be nice as well but less necessary.
