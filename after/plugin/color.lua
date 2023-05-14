require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = {  -- :h background
        light = "latte",
        dark = "mocha",
    },
    transparent_background = false,
    show_end_of_buffer = false, -- show the '~' characters after the end of buffers
    term_colors = true,
    dim_inactive = {
        enabled = true,
        shade = "dark",
        percentage = 0.20,
    },
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    styles = {
        comments = { "italic" },
        conditionals = {},
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    color_overrides = {},
    custom_highlights = {},
    integrations = {
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        cmp = true,
        gitsigns = true,
        telescope = true,
        mason = true,
        dap = true,
        treesitter = true,
        lsp_trouble = true,
        illuminate = true,
        which_key = true,
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = { "italic" },
                hints = { "italic" },
                warnings = { "italic" },
                information = { "italic" },
            },
            underlines = {
                errors = { "underline" },
                hints = { "underline" },
                warnings = { "underline" },
                information = { "underline" },
            },
        },
    },
})

function ReloadColors(color)
    color = color or "catppuccin"
    vim.cmd.colorscheme(color)
end

ReloadColors()
