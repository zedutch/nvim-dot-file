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
                    { "<leader>de", function() require("dapui").eval() end,     desc = "DAP Eval", mode = { "n", "v" } },
                },
                dependencies = {
                    -- https://github.com/nvim-neotest/nvim-nio
                    "nvim-neotest/nvim-nio"
                },
                config = function()
                    local dap = require("dap")
                    local dui = require("dapui")
                    dui.setup()
                    dap.listeners.after.event_initialized["dapui_config"] = function()
                        dui.open({})
                    end
                    dap.listeners.before.event_terminated["dapui_config"] = function()
                        dui.close({})
                    end
                    dap.listeners.before.event_exited["dapui_config"] = function()
                        dui.close({})
                    end
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
                    },
                },
            },
        },
        config = function()
            local dap = require("dap")
            local launch = {
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
            local attach = {
                name = "Attach to process",
                type = 'codelldb', -- Adjust this to match your adapter name (`dap.adapters.<name>`)
                request = 'attach',
                pid = require('dap.utils').pick_process,
                args = {},
            }
            dap.configurations.cpp = {
                launch, attach,
            }
            dap.configurations.c = {
                launch, attach,
            }
            dap.configurations.rust = {
                launch, attach,
            }
            require("nvim-dap-virtual-text").setup()
        end,
    },
}

-- OLD DAP CONFIG (saved for reference if i ever set DAP up again - which I probably will):
-- local dap, dapui = require("dap"), require("dapui")
--
-- dapui.setup {}
--
-- dap.listeners.after.event_initialized["dapui_config"] = function()
--     dapui.open()
-- end
--
-- dap.listeners.before.event_terminated["dapui_config"] = function()
--     dapui.close()
-- end
--
-- dap.listeners.before.event_exited["dapui_config"] = function()
--     dapui.close()
-- end
--
-- if false then
--     local mason_registry = require("mason-registry")
--     local cpptools = mason_registry.get_package("cpptools")
--     local adapter_path = cpptools:get_install_path() .. "/extension/debugAdapters/bin"
--     local od7_path = adapter_path .. "/OpenDebugAD7"
--     local options = {}
--
--     local os = vim.loop.os_uname().sysname;
--     if os:find "Windows" then
--         od7_path = adapter_path .. "/OpenDebugAD7.exe"
--         options = {
--             detached = false
--         }
--     end
--
--     print("Debugger path:", od7_path)
--
--     dap.adapters.cppdbg = {
--         id = 'cppdbg',
--         type = 'executable',
--         command = od7_path,
--         options = options,
--     }
--
--     dap.configurations.c = {
--         {
--             name = "Launch file",
--             type = "cppdbg",
--             request = "launch",
--             program = function()
--                 return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
--             end,
--             cwd = '${workspaceFolder}',
--             stopAtEntry = true,
--         },
--     }
-- end
--
-- local mason_registry = require("mason-registry")
-- local codelldb = mason_registry.get_package("codelldb")
-- local ext_path = codelldb:get_install_path() .. "/extension/"
-- local os = vim.loop.os_uname().sysname;
-- local codelldb_path = ext_path .. "adapter/codelldb"
-- local liblldb_path = ext_path .. "lldb/lib/liblldb"
-- if os:find "Windows" then
--     codelldb_path = ext_path .. "adapter/codelldb.exe"
--     liblldb_path = ext_path .. "lldb/lib/liblldb.dll"
-- else
--     liblldb_path = ext_path .. "lldb/lib/liblldb" .. (os == "Linux" and ".so" or ".dylib")
-- end
--
-- dap.adapters.codelldb = {
--     type = 'server',
--     port = "${port}",
--     executable = {
--         command = codelldb_path,
--         args = { "--port", "${port}" },
--
--         -- On windows you may have to uncomment this:
--         -- detached = false,
--     }
-- }
--
-- dap.configurations.c = {
--     {
--         name = "Launch file",
--         type = "codelldb",
--         request = "launch",
--         program = function()
--             return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
--         end,
--         cwd = '${workspaceFolder}/build',
--         stopOnEntry = false,
--     },
-- }
--
-- -- Third option:
-- -- /opt/homebrew/opt/llvm/bin/lldb-vscode
--
-- dap.configurations.cpp = dap.configurations.c
