local rl = require('scripts.read_launch')

local M = {}

function read_launch_sttgs(path)
    path = path or "Properties/launchSettings.json"
    path = vim.fn.getcwd() .. '/./' .. path
    path = vim.fn.resolve(path)
    local profile = rl.read_profile()

    print("Profile: ")
    print(profile)
    print("Path: ")
    print(path)
    
    local table = nil

    local lsttgs = io.open(path)
    if lsttgs then
        local content = lsttgs:read("*all") 
        lsttgs:close()

        table = vim.json.decode(content) -- Problem with decode
    else 
        return false
    end

    local profileTable = table['profiles'][profile]

    print('Profile Table: ')
    print(profileTable)

    print('Urls: ')
    print(profileTable['applicationUrl'])
    -- ASPNETCORE_URLS
    vim.fn.setenv('ASPNETCORE_URLS', profileTable['applicationUrl'])

    local variables = profileTable['environmentVariables']
    for key, value in pairs(variables) do
        vim.fn.setenv(key, value)
    end
end

M.read_launch_sttgs = read_launch_sttgs

return M