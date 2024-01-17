return {}
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
