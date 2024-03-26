require("mason").setup()
require("mason-nvim-dap").setup({
	ensure_installed = { "python", "cpptools" },
	automatic_installation = true,
})

local dap = require("dap")
dap.adapters.lldb = {
	type = "executable",
	command = "/usr/bin/lldb-vscode", -- adjust as needed, must be absolute path
	name = "lldb",
}

dap.configurations.cpp = {
	{
		name = "Launch",
		type = "lldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},

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
	},
}

dap.configurations.c = dap.configurations.cpp

-- C# Dap configurations

dap.adapters.coreclr = {
	type = "executable",
	command = vim.fn.exepath("netcoredbg"), -- /home/beloin/.local/share/nvim/mason/bin/netcoredbg
	args = { "--interpreter=vscode" },
}

dap.configurations.cs = {
	{
		type = "coreclr",
		name = "launch - netcoredbg",
		request = "launch",
		program = function()
			return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
		end,
	},
}


if not dap.adapters["netcoredbg"] then
	require("dap").adapters["netcoredbg"] = {
	  type = "executable",
	  command = vim.fn.exepath("netcoredbg"),
	  args = { "--interpreter=vscode" },
	  env = {"ASPNETCORE_ENVIRONMENT=Development"}
	}
end

for _, lang in ipairs({ "cs", "fsharp", "vb" }) do
	if not dap.configurations[lang] then
	  dap.configurations[lang] = {
		{
		  type = "netcoredbg",
		  name = "Launch file",
		  request = "launch",
		  ---@diagnostic disable-next-line: redundant-parameter
		  program = function()
			return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/", "file")
		  end,
		  cwd = "${workspaceFolder}",
		},
	  }
	end
end


-- Configure DAP auto start
-- local dap, dapui = require("dap"), require("dapui")

-- dap.listeners.before.attach.dapui_config = function()
--   dapui.open()
-- end

-- dap.listeners.before.launch.dapui_config = function()
--   dapui.open()
-- end

-- dap.listeners.before.event_terminated.dapui_config = function()
--   dapui.close()
-- end

-- dap.listeners.before.event_exited.dapui_config = function()
--   dapui.close()
-- end