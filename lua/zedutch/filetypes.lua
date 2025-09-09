vim.filetype.add({
    extension = {
        jinja = "htmldjango",
        tera = "htmldjango",
        gd = "gdscript",
        vert = "glsl",
        frag = "glsl",
        tf = "terraform",
        tfvars = "terraform",
        mdx = "markdown-react",
    },
    filename = {
        ["justfile"] = "just",
        ["tmux.conf"] = "tmux",
    },
    pattern = {
        [".*ansible.*yml$"] = "yaml.ansible",
        [".github/workflows/.*y(a?)ml$"] = "yaml.action",
        [".env.*"] = "dotenv",
        [".*%.env%.%a+$"] = "dotenv",
    },
})
