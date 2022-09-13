local ok, treesitter = pcall(require, 'nvim-treesitter.configs')
if not ok then
    print 'Skipping treesitter as it is not installed.'
    return
end

treesitter.setup {
    ensure_installed = {
        'c',
        'css',
        'scss',
        'typescript',
        'javascript',
        'json',
        'json5',
        'python',
    },
    sync_install = false,
    ignore_install = { '' },
    highlight = {
        enable = true,
        disable = { '' },
        additional_vim_regex_highlighting = true,
    },
    autopairs = {
        enable = true,
    },
    autotag = {
        enable = true,
    },
    indent = {
        enable = true,
        disable = { "yaml" },
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
}

