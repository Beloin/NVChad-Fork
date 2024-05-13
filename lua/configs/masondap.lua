require("mason").setup()
require("mason-nvim-dap").setup({
    ensure_installed = {"python", "cpptools", "netcoredbg"},
    automatic_installation = true
})

local dap = require("dap")
dap.adapters.lldb = {
    type = "executable",
    command = "/usr/bin/lldb-vscode", -- adjust as needed, must be absolute path
    name = "lldb"
}
-- If don't want to use lldb-vscode
if not dap.adapters.codelldb then
    dap.adapters.codelldb = {
        type = "server",
        host = "localhost",
        port = "7878",
        -- command = "/home/beloin/.local/share/nvim/mason/packages/codelldb/codelldb", -- adjust as needed, must be absolute path
        -- name = "codelldb",
        executable = {
            command = "codelldb",
            args = {"--port", "7878"}
        }
    }
end

local csLaunch = require("scripts.cs_launch")
local rl = require("scripts.read_launch")
dap.configurations.cpp = {{
    request = "launch",
    type = "lldb",
    name = "Launch file",

    program = function()
        local prep = rl.should_preprocess()

        if prep then
            local r = vim.cmd("!cmake -DCMAKE_BUILD_TYPE=Debug ./build")
            r = vim.cmd("make -C ./build")    
        end

        local program = rl.read_program()
        if program then
            return program
        end

        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = function()
        local rl = require("scripts.read_launch")
        local args = rl.read_args()
        rl.set_env()
        if args then
            return args
        end

        local args_string = vim.fn.input("Arguments: ")
        return vim.split(args_string, " ")
    end

    -- 💀
    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    -- runInTerminal = false,
}}

dap.configurations.c = dap.configurations.cpp

-- C# Dap configurations

dap.adapters.coreclr = {
    type = "executable",
    command = vim.fn.exepath("netcoredbg"), -- /home/beloin/.local/share/nvim/mason/bin/netcoredbg
    args = {"--interpreter=vscode"}
}

dap.configurations.cs = {{
    type = "netcoredbg",
    name = "launch - netcoredbg",
    request = "launch",
    program = function()
        vim.cmd("!dotnet build")
        local program = rl.read_program()
        if program then
            return program
        end

        return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
    end,
    args = function()
        rl.set_env()
        csLaunch.read_launch_sttgs()
        return rl.read_args()
    end
}}

-- TODO: Configure cs to use netcoredbg? instead of coreclr
if not dap.adapters["netcoredbg"] then
    require("dap").adapters["netcoredbg"] = {
        type = "executable",
        command = vim.fn.exepath("netcoredbg"),
        args = {"--interpreter=vscode"},
        env = {"ASPNETCORE_ENVIRONMENT=Development"}
    }
end

for _, lang in ipairs({"cs", "fsharp", "vb"}) do
    if not dap.configurations[lang] then
        dap.configurations[lang] = {{
            type = "netcoredbg",
            name = "Launch file",
            request = "launch",
            ---@diagnostic disable-next-line: redundant-parameter
            program = function()
                return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd = "${workspaceFolder}"
        }}
    end
end

-- Python DAP
-- dap.adapters.python = {
--     type = 'executable',
--     command = vim.fn.getcwd() .. "/venv/bin/python",
--     args = {'-m', 'debugpy.adapter'}
-- }

-- dap.configurations.python = {{
--     type = 'python',
--     request = 'launch',
--     name = "Launch file",
--     program = "${file}",
--     pythonPath = 'python' -- /venv/bin/python
-- }}
require("dap-python").setup("python")

-- Configure DAP auto start
local dap, dapui = require("dap"), require("dapui")

dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end

dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end

-- dap.listeners.before.event_terminated.dapui_config = function()
--     dapui.close()
-- end
-- dap.listeners.before.event_exited.dapui_config = function()
--     dapui.close()
-- end

vim.keymap.set({'i', 'n'}, "<F5>", function()
    -- (Re-)reads launch.json if present -- Use rl.reload();
    require("dap").continue()
end, {
    desc = "DAP Continue"
})

vim.keymap.set({'i', 'n'}, "<F6>", function()
    local rl = require("scripts.read_launch")
    local table = rl.read_launch()
    print(table)
    print(table['configurations'])
    print(table['configurations'][1])
    print(table['configurations'][1]['env'])
end, {
    desc = "DAP Continue"
})
