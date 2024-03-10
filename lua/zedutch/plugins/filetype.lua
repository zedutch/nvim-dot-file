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
                ["tmux.conf"] = "tmux",
            },
            extensions = {
                ["jinja"] = "htmldjango",
                ["tera"] = "htmldjango",
                ["html"] = "html",
                ["gd"] = "gdscript",
                ["sh"] = "sh",
                ["h"] = "cpp",
                ["sql"] = "sql",
                ["vert"] = "glsl",
                ["frag"] = "glsl",
            },
        },
    },
}
