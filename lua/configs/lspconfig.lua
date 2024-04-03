-- EXAMPLE 
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "html", "cssls" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- typescript
lspconfig.tsserver.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}
local configs = require("nvchad.configs.lspconfig")

local on_attach = configs.on_attach
local on_init = configs.on_init
local capabilities = configs.capabilities

local lspconfig = require "lspconfig"
local servers = {"html", "cssls", "clangd", "omnisharp", "ast-grep", "lua-language-server", "sqlls",
                 "cmake-language-server", "gopls", "json-lsp", "jedi-language-server"}

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_init = on_init,
        on_attach = on_attach,
        capabilities = capabilities
    }
end

-- Language Specifics

lspconfig["cmake-language-server"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {"/home/beloin/.local/share/nvim/mason/bin/cmake-language-server"},
    filetype = {"cmake", "CMakeLists.txt"}
})

lspconfig['gopls'].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    on_init = on_init,
    keys = { -- Workaround for the lack of a DAP strategy in neotest-go: https://github.com/nvim-neotest/neotest-go/issues/12
    {
        "<leader>td",
        "<cmd>lua require('dap-go').debug_test()<CR>",
        desc = "Debug Nearest (Go)"
    }},
    settings = {
        gopls = {
            gofumpt = true,
            codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true
            },
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true
            },
            analyses = {
                fieldalignment = true,
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true
            },
            usePlaceholders = true,
            completeUnimported = true,
            staticcheck = true,
            directoryFilters = {"-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules"},
            semanticTokens = true
        }
    },
    gopls = function(_, opts)
        -- workaround for gopls not supporting semanticTokensProvider
        -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
        LazyVim.lsp.on_attach(function(client, _)
            if client.name == "gopls" then
                if not client.server_capabilities.semanticTokensProvider then
                    local semantic = client.config.capabilities.textDocument.semanticTokens
                    client.server_capabilities.semanticTokensProvider = {
                        full = true,
                        legend = {
                            tokenTypes = semantic.tokenTypes,
                            tokenModifiers = semantic.tokenModifiers
                        },
                        range = true
                    }
                end
            end
        end)
        -- end workaround
    end
}

lspconfig.omnisharp.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {"/home/beloin/.local/share/nvim/mason/packages/omnisharp/omnisharp"},
    -- Enables support for reading code style, naming convention and analyzer
    -- settings from .editorconfig.
    enable_editorconfig_support = true,
    -- If true, MSBuild project system will only load projects for files that
    -- were opened in the editor. This setting is useful for big C# codebases
    -- and allows for faster initialization of code navigation features only
    -- for projects that are relevant to code that is being edited. With this
    -- setting enabled OmniSharp may load fewer projects and may thus display
    -- incomplete reference lists for symbols.
    enable_ms_build_load_projects_on_demand = false,
    -- Enables support for roslyn analyzers, code fixes and rulesets.
    -- enable_roslyn_analyzers = false,
    -- Specifies whether 'using' directives should be grouped and sorted during
    -- document formatting.
    -- organize_imports_on_format = true,
    -- Enables support for showing unimported types and unimported extension
    -- methods in completion lists. When committed, the appropriate using
    -- directive will be added at the top of the current file. This option can
    -- have a negative impact on initial completion responsiveness,
    -- particularly for the first few completion sessions after opening a
    -- solution.
    -- enable_import_completion = true,
    -- Specifies whether to include preview versions of the .NET SDK when
    -- determining which version to use for project loading.
    sdk_include_prereleases = true,
    -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
    -- true
    analyze_open_documents_only = false,

    handlers = {
        ["textDocument/definition"] = function(...)
            return require("omnisharp_extended").handler(...)
        end
    },
    keys = {{
        "gd",
        function()
            require("omnisharp_extended").telescope_lsp_definitions()
        end,
        desc = "Goto Definition"
    }},

    enable_roslyn_analyzers = true,
    organize_imports_on_format = true,
    enable_import_completion = true
})

-- json

lspconfig['jsonls'].setup {
    on_new_config = function(new_config)
        new_config.settings.json.schemas = new_config.settings.json.schemas or {}
        vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
    end,
    settings = {
        json = {
            format = {
                enable = true
            },
            validate = {
                enable = true
            }
        }
    }
}

-- Mappings
function opts(desc)
    return {
        buffer = bufnr,
        desc = desc
    }
end

local map = vim.keymap.set
map('n', 'gI', vim.lsp.buf.implementation, {
    desc = "Go to Implementation"
})
map('n', 'ga', vim.lsp.buf.type_definition, {
    desc = "Go to Type Defitinion"
})

map('n', '<M-CR>', vim.lsp.buf.code_action, {
    desc = "Code Action"
})
map('i', '<M-CR>', vim.lsp.buf.code_action, {
    desc = "Code Action"
})

map("i", "<C-p>", vim.lsp.buf.signature_help, opts "Lsp Show signature help")
map("n", "<C-p>", vim.lsp.buf.signature_help, opts "Lsp Show signature help")

map("i", "<C-b>", vim.lsp.buf.definition, opts "Lsp Go to definition")
map("n", "<C-b>", vim.lsp.buf.definition, opts "Lsp Go to definition")
