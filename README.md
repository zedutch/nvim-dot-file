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

## Next rewrite

Libraries to consider for the next config rewrite:

- [cloak.nvim](https://github.com/laytan/cloak.nvim) - prevent accidental secret sharing
- nvim-treesitter/nvim-treesitter-textobjects - textobject (w, p) for treesitter objects (assignments, conditionals, parameters, function call, loop, etc)

Consider:
- Did I ever miss vim-illuminate?
- Did I ever miss undo-tree?
