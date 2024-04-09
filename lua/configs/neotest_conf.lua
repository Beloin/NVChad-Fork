local M = {}

M.opts = {
    adapters = {
        ["neotest-go"] = {
            -- Here we can set options for neotest-go, e.g.
            -- args = { "-tags=integration" }
            recursive_run = true
        },
        ["neotest-python"] = {
            -- Here you can specify the settings for the adapter, i.e.
            -- runner = "pytest",
            python = "venv/bin/python",
        }
    }
}

return M
