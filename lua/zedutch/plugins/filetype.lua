return {
    -- https://github.com/nathom/filetype.nvim
    "nathom/filetype.nvim",
    opts = {
        overrides = {
            complex = {
                [".*ansible.*yml$"] = "yaml.ansible",
                [".github/workflows/.*y(a?)ml$"] = "yaml.action",
                ["/?%.env%.%a+$"] = "dotenv",
            },
            literal = {
                [".env"] = "dotenv",
            },
            extensions = {
                ["jinja"] = "htmldjango",
                ["tera"] = "htmldjango",
                ["html"] = "html",
            },
        },
    },
}
