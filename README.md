## Dependencies

- [Hack Nerd Font Mono](https://github.com/ryanoasis/nerd-fonts/releases/latest)
- [ripgrep (rg)](https://github.com/BurntSushi/ripgrep)
- [sharkdp/fd](https://github.com/sharkdp/fd)
- clang (or any other c compiler)
- npm
- Run `checkhealth` and install missing executables

## Next rewrite

Libraries to consider for the next config rewrite:

- [nvim-lint](https://github.com/mfussenegger/nvim-lint) - null-ls like but only for linting
- [formatter.nvim](https://github.com/mhartington/formatter.nvim) - null-ls like but only for formatting

- nvimtools/none-ls: community port of null-ls

Still need a null-ls like for code actions (do I actually use those? Other than git I guess?)

I also want to keep the following things in mind in a rewrite:

- Better support for snippets. I want to make it relatively easy to define custom snippets that
  can be associated with a filetype
- I really like my current lsp-settings flow, don't change too much with that
