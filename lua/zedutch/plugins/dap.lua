return {
    {
        -- https://github.com/mfussenegger/nvim-dap
        "mfussenegger/nvim-dap",
        keys = {
            { "<F1>",       function() require("dap").continue({}) end,                                           desc = "DAP Continue" },
            { "<F2>",       function() require('dap').step_over() end,                                            desc = "DAP Step over" },
            { "<F3>",       function() require('dap').step_into() end,                                            desc = "DAP Step into" },
            { "<F4>",       function() require('dap').step_out() end,                                             desc = "DAP Step out" },
            { "<F12>",      function() require('dap').close() end,                                                desc = "DAP Close" },
            { "<leader>dq", function() require('dap').close() end,                                                desc = "DAP Close" },
            { "<leader>b",  function() require('dap').toggle_breakpoint() end,                                    desc = "DAP Toggle breakpoint" },
            { "<leader>B",  function() require('dap').set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "DAP Conditional breakpoint" },
            { "<leader>dr", function() require('dap').repl.open() end,                                            desc = "DAP REPL" },
            { "<leader>dl", function() require('dap').run_last() end,                                             desc = "DAP Run last" },
            { "<leader>dK", function() require('dap.ui.widgets').hover() end,                                     desc = "DAP Hover" },
        },
        dependencies = {
            -- https://github.com/rcarriga/nvim-dap-ui
            {
                "rcarriga/nvim-dap-ui",
                keys = {
                    { "<leader>du", function() require("dapui").toggle({}) end, desc = "DAP UI" },
                    { "<leader>dU", function() require("dapui").setup() end,    desc = "DAP Re-setup" },
                    { "<leader>de", function() require("dapui").eval() end,     desc = "DAP Eval",    mode = { "n", "v" } },
                },
                dependencies = {
                    -- https://github.com/nvim-neotest/nvim-nio
                    "nvim-neotest/nvim-nio"
                },
                config = function()
                    local dap = require("dap")
                    local dui = require("dapui")
                    dui.setup()

                    dap.listeners.before.attach.dapui_config = function()
                        dui.open()
                    end
                    dap.listeners.before.launch.dapui_config = function()
                        dui.open()
                    end
                    dap.listeners.before.event_terminated.dapui_config = function()
                        dui.close()
                    end
                    dap.listeners.before.event_exited.dapui_config = function()
                        dui.close()
                    end

                    -- dap.listeners.after.event_initialized["dapui_config"] = function()
                    --     dui.open({})
                    -- end
                end,
            },

            -- https://github.com/theHamsta/nvim-dap-virtual-text
            {
                "theHamsta/nvim-dap-virtual-text",
                lazy = true,
            },

            -- https://github.com/nvim-telescope/telescope-dap.nvim
            {
                "nvim-telescope/telescope-dap.nvim",
                dependencies = "telescope.nvim",
                config = function()
                    require("telescope").load_extension("dap")
                end,
            },

            -- https://github.com/jay-babu/mason-nvim-dap.nvim
            {
                "jay-babu/mason-nvim-dap.nvim",
                dependencies = "mason.nvim",
                cmd = { "DapInstall", "DapUninstall" },
                opts = {
                    -- Makes a best effort to setup the various debuggers with
                    -- reasonable debug configurations
                    automatic_installation = true,

                    -- You can provide additional configuration to the handlers,
                    -- see mason-nvim-dap README for more information
                    handlers = {},

                    -- You'll need to check that you have the required things installed online
                    ensure_installed = {
                        "codelldb",
                        "delve",
                    },
                },
            },
        },
        config = function()
            local dap = require("dap")
            local lldb_launch = {
                name = "Launch",
                type = "codelldb",
                request = "launch",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
                args = {},
                runInTerminal = false,
            }
            local lldb_attach = {
                name = "Attach to process",
                type = 'codelldb', -- Adjust this to match your adapter name (`dap.adapters.<name>`)
                request = 'attach',
                processId = require('dap.utils').pick_process,
                args = {},
            }
            dap.configurations.cpp = {
                lldb_launch, lldb_attach,
            }
            dap.configurations.c = {
                lldb_launch, lldb_attach,
            }
            dap.configurations.rust = {
                lldb_launch, lldb_attach,
            }

            dap.adapters.delve = {
                type = "server",
                host = "127.0.0.1",
                port = "8086",
                executable = {
                    command = "dlv",
                    args = { "dap", "-l", "127.0.0.1:8086", "--log" },
                },
            }
            dap.adapters.rawdlv = {
                type = "executable",
                command = "dlv",
            }
            dap.configurations.go = {
                {
                    name = "Debug file",
                    request = "launch",
                    type = "delve",
                    program = "${file}",
                    cwd = "${workspaceFolder}",
                },
                {
                    name = "Debug program",
                    request = "launch",
                    type = "delve",
                    program = function()
                        return vim.fn.input("Executable: ")
                    end,
                    cwd = "${workspaceFolder}",
                },
                {
                    name = "Attach to process",
                    request = "attach",
                    type = "delve",
                    processId = require('dap.utils').pick_process,
                },
                {
                    name = "Attach to remote dlv (port 8086)", -- Started with `dlv debug --headless -l 127.0.0.1:8086 <file>`
                    request = "attach",
                    mode = "remote",
                    type = "delve",
                    cwd = "${workspaceFolder}",
                },
            }

            dap.adapters.godot = {
                type = "server",
                host = "127.0.0.1",
                port = 6006,
            }
            dap.configurations.gdscript = {
                {
                    launch_game_instance = false,
                    launch_scene = false,
                    name = "Launch scene",
                    project = "${workspaceFolder}",
                    request = "launch",
                    type = "godot",
                },
            }
            require("nvim-dap-virtual-text").setup()
        end,
    },
}
