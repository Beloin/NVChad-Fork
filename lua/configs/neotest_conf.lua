local M = {}

M.opts = {
    adapters = {
        ["neotest-go"] = {
            -- Here we can set options for neotest-go, e.g.
            -- args = { "-tags=integration" }
            recursive_run = true
        }
    }
}

return M
