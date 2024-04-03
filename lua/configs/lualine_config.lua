local M = {}

M.config = function()
    local lualine = require('lualine')
    lualine.setup({
        sections = {
            lualine_z = {{function()
                for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                    if vim.api.nvim_buf_get_option(buf, 'modified') then
                        if not vim.bo[buf].readonly then
                            return 'Unsaved buffers' -- any message or icon
                        end
                    end
                end
                return ''
            end}}
        }
    })
end

return M
