local M = {}

-- Example:
-- {
--
-- }

M.current_table = nil -- TODO: Add cache to table
function read_launch()
    local cwd = vim.fn.getcwd()
    local lJson = io.open(cwd .. '/launch.json')

    local table = nil
    if lJson then
        local content = lJson:read("*all")
        lJson:close()

        table = vim.json.decode(content)
    else
        local lJson2 = io.open(cwd .. '/.vscode/launch.json')
        if lJson2 then
            local content = lJson2:read("*all")
            lJson2:close()

            table = vim.json.decode(content)
        end
    end

    return table
end

function read_args()
    local table = read_launch()
    if not table then
        return nil
    end

    local args = table['configurations'][1]['args']
    return args
end

function should_preprocess()
    local table = read_launch()
    if not table then
        return true
    end

    local prep = table['configurations'][1]['preProcess']
    if prep == nil then
        return true
    end

    return prep
end

function read_program()
    local table = read_launch()
    if not table then
        return nil
    end
    local program = table['configurations'][1]['program']
    fullPath = vim.fn.getcwd() .. '/./' .. program

    return vim.fn.resolve(fullPath)
end

function read_env()
    local table = read_launch()
    if not table then
        return nil
    end
    return table['configurations'][1]['env']
end

function set_env()
    local tb = read_env()
    if not tb then
        return
    end
    for key, value in pairs(tb) do
        vim.fn.setenv(key, value)
    end
end

function read_profile()
    local table = read_launch()
    if not table then
        return nil
    end
    return table['configurations'][1]['profile']
end

M.read_launch = read_launch
M.read_args = read_args
M.read_program = read_program
M.read_env = read_env
M.set_env = set_env
M.read_profile = read_profile
M.should_preprocess = should_preprocess

return M
