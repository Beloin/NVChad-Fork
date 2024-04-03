local M = {}

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
    print(table['configurations'][1]['env']['TEST_2'])
    return table['configurations'][1]['env']
end

function set_env()
    local tb = read_env()
    for key, value in pairs(tb) do
        vim.fn.setenv(key, value)
    end
end

M.read_launch = read_launch
M.read_args = read_args
M.read_program = read_program
M.read_env = read_env
M.set_env = set_env

return M
