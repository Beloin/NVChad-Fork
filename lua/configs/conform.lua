local M = {}

M.setup = {
	-- Hate this:
	-- format_on_save = {
	-- 	timeout_ms = 500,
	-- 	lsp_fallback = true,
	-- },
	formatters = {
		xmlformat = {
			command = { "xmlformat" },
			args = { "--selfclose", "-" },
		},

		csharpier = {
			command = "/home/beloin/.local/share/nvim/mason/bin/dotnet-csharpier",
			args = { "--write-stdout" },
		},
	},

	formatters_by_ft = {
		cs = { "csharpier" },
		html = { "prettier" },
		json = { "prettier" },
		lua = { "stylua" },
		markdown = { "prettier", "injected" },
		xml = { "xmlformat" },
		cpp = { "clang-format" },
		c = { "clang-format" },
		cmake = { "cmake-format" },
		sql = { "sql-formatter" },
		yaml = { "yamlfix" },
		go = { "goimports", "gofumpt" },
		python = { "autopep8" },
		py = { "autopep8" },
		sh = { "shfmt" }
	},
	lsp_fallback = true,
}

return M