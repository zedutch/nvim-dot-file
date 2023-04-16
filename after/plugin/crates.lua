local crates = require('crates')
crates.setup {
    popup = {
        -- autofocus = true,
        style = "minimal",
        border = "rounded",
        show_version_date = true,
        show_dependency_version = true,
        max_height = 30,
        min_width = 20,
    },
    null_ls = {
        enabled = true,
        name = "Crates",
    },
}
crates.show()
