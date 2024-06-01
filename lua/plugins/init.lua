
function configureImagePreview()
  local openFl = require("scripts.open_files")
  vim.keymap.set('n', '<leader>pp', openFl.call_gweenview, {desc = '[p]review images'})  
end

configureImagePreview()

return {
  {
    -- Code formatter
    "stevearc/conform.nvim",
    -- opts = require("configs.conform").opts,
    config = function()
      require("conform").setup(require("configs.conform").setup)
    end,
    event = "VeryLazy",
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      git = { enable = true },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "cpp",
        "c",
        "c_sharp",
        "json",
        "jsdoc",
        "jsonc",
        "json5",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",

        -- Golang
        "go",
        "gomod",
        "gowork",
        "gosum",

        -- C/C++ && CMake
        "cmake",

        -- Python
        "ninja", "python", "rst", "toml",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
    opts = require'configs.nvim_lspconfig'.opts
  },

  {
    "williamboman/mason.nvim",
    opts = {
       ensure_installed = {
         "lua-language-server",
         "html-lsp",
         "clangd",
         "cmakelang",
         "clang-format",
         "cpplint",
         "clangd",
         "cpptools",
         "jedi-language-server",
         "markdownlint",
         "pylint",
         "cmake-language-server",
         "autopep8",
         "clang-format",
         "clangd",
         
         -- C/C++ CMake
         "cmake-language-server",
         "cmakelint",
         "cmakelang",
         "neocmakelsp",

         "codelldb",
         "cpplint",
         "cpptools",
         "debugpy",
         "doctoc",
         "hadolint",
         "jedi-language-server",
         "jsonlint",
         "json-lsp",
         "markdownlint",
         "pylint",
         "vale",
         "csharpier",
         "netcoredbg",

         -- Golang
         "gopls",
         "goimports", 
         "gofumpt",
         "gomodifytags",
         "impl",
         "delve"
       },
       automatic_installation = true
     },
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {"williamboman/mason.nvim"},
    config = function()
      require("mason-lspconfig").setup()
    end
  },

  -- Lint setup
  {
    "mfussenegger/nvim-lint",
    config = function()
      require("configs.nvimlint")
    end,
    lazy = false
  },

  {
    "rshkarin/mason-nvim-lint",
    config = function()
      require("configs.masonnvimlint")
    end,
    lazy = false
  },

  -- DAP Setup
  {
    "jay-babu/mason-nvim-dap.nvim",
    config = function()
      require("configs.masondap")
    end,
    lazy = false,
  }, 
  
  {
    "mfussenegger/nvim-dap",
    vim.keymap.set('n', '<F9>', ':lua require"dap".continue()<CR>', {desc = '[d]ebug [c]ontinue'}),
    vim.keymap.set('n', '<leader>Dc', ':lua require"dap".continue()<CR>', {desc = '[d]ebug [c]ontinue'}),

    vim.keymap.set('n', '<leader>Db', ':lua require"dap".toggle_breakpoint()<CR>', {desc = '[d]ebug [b]breakpoint'}),
    vim.keymap.set('n', '<leader>DB', ':lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', {desc = '[d]ebug [B]breakpoint with Condition'}),

    vim.keymap.set('n', '<leader>Do', ':lua require"dap".step_over()<CR>', {desc = '[d]ebug Step [o]ver'}),
    vim.keymap.set('n', '<F8>', ':lua require"dap".step_over()<CR>', {desc = '[d]ebug Step [o]ver'}),

    vim.keymap.set('n', '<leader>Di', ':lua require"dap".step_into()<CR>', {desc = '[d]ebug Step [i]nto'}),
    vim.keymap.set('n', '<leader>Dt', ':lua require"dap".step_out()<CR>', {desc = '[d]ebug Step ou[t]'}),

    lazy = false,
    config = function()
      vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#993939', bg = '#31353f' })
      vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef', bg = '#31353f' })
      vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379', bg = '#31353f' })
    end
  },

  { "nvim-neotest/nvim-nio", },
  { "folke/neodev.nvim", opts = {} },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
    lazy = false,

    vim.keymap.set('n', '<leader>Dut', ':lua require"dapui".toggle()<CR>', {desc = '[d]ap [u]i [t]oggle'}),

    config = function()
      require("dapui").setup()
    end
  },

  {
    "voldikss/vim-floaterm",
    lazy = false
  },

  -- This configures CMake for build, lsp and debug!
  {
    "Shatur/neovim-tasks",
    lazy=false,
    config = function()
      vim.keymap.set('n', '<leader>tcc', ":Task start cmake configure<CR>", {desc = '[c]Make [c]onfigure'})
      vim.keymap.set('n', '<leader>tcd', ":Task start cmake debug<CR>", {desc = '[c]Make [d]ebug'})
      vim.keymap.set('n', '<leader>tcr', ":Task start cmake run<CR>", {desc = '[c]Make [r]un'})
      vim.keymap.set('n', '<leader>tct', ":Task set_module_param cmake target<CR>", {desc = '[c]Make [t]arget'})
      vim.keymap.set('n', '<leader>tx', ":Task cancel<CR>", {desc = '[t]ask cancel [x]'})
      vim.keymap.set('n', '<leader>tar', ":Task set_task_param cmake run args<CR>", {desc = '[t]ask set [a]rguments for [r]un'})
      vim.keymap.set('n', '<leader>tad', ":Task set_task_param cmake run args<CR>", {desc = '[t]ask set [a]rguments for [d]ebug'})
    end
  },

  -- { 'Civitasv/cmake-tools.nvim', lazy = false },

  { 
    'Shatur/neovim-session-manager',
    -- lazy = false,
    event = "VimEnter",
    vim.keymap.set('n', '<leader>sc', ':SessionManager load_current_dir_session<CR>:NvimTreeToggle<CR>', {desc = '[s]ession load [c]urrent', silent= true }),
    vim.keymap.set('n', '<leader>sl', ':SessionManager load_session<CR>', {desc = '[s]ession [l]oad', silent= true }),
  },

  -- Plantuml support
  { 
    'javiorfo/nvim-soil',
    lazy = true,
    ft = "plantuml",
  },

  { 'javiorfo/nvim-nyctophilia', lazy = false },

  -- Only works on WezTerm
  -- {
  --   'https://github.com/adelarsq/image_preview.nvim',
  --   vim.keymap.set('n', '<leader>pp', ':lua require("image_preview").PreviewImage()', {desc = '[p]review images'}),
  --   event = 'VeryLazy',
  --   config = function()
  --       require("image_preview").setup()
  --   end
  -- },
  -- For now, use: ./scripts.open_files

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    event = 'VeryLazy',
  },

  {
    "lewis6991/gitsigns.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
        require("gitsigns").setup()
    end
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = require'configs.lualine_config'.config,
    event = 'VeryLazy',
  },

  {
    'eriks47/generate.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = 'VeryLazy',
    vim.keymap.set("n", "<leader>cgi", "<cmd>Generate implementations<CR>")
  },

  {
    "Badhi/nvim-treesitter-cpp-tools",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    -- Optional: Configuration
    opts = require'configs.cpp_tools'.opt,
    -- End configuration
    config = true,
    event = 'VeryLazy'
  },

  {
    "rbong/vim-flog",
    lazy = true,
    cmd = { "Flog", "Flogsplit", "Floggit" },
    dependencies = {
      "tpope/vim-fugitive",
    },
  },

  {
    "sontungexpt/stcursorword",
    event = "VeryLazy",
    config = true,
  },
  
  { 
    'anuvyklack/fold-preview.nvim',
    dependencies = {'anuvyklack/keymap-amend.nvim'},
    config = function()
      require('fold-preview').setup()
    end
  },

  {
    'petertriho/nvim-scrollbar',
    config = function()
      require("scrollbar").setup()
    end,
    event = "VeryLazy",
  },

  {
    "ghillb/cybu.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "nvim-lua/plenary.nvim"},
    config = function()
      local ok, cybu = pcall(require, "cybu")
      if not ok then
        return
      end
      cybu.setup()
      -- vim.keymap.set("n", "", "<Plug>(CybuPrev)")
      -- vim.keymap.set("n", "", "<Plug>(CybuNext)")
      vim.keymap.set({"n", "v"}, "<M-S-Tab>", "<cmd>CybuLastusedPrev<CR>")
      vim.keymap.set("n", "<M-Tab>", "<cmd>CybuLastusedNext<CR>")
    end,
    event = "VeryLazy",
  },

  -- Language Specific
  -- C#
  { 
    'OmniSharp/omnisharp-vim',
    lazy = false
  },

  { 
    'Hoffs/omnisharp-extended-lsp.nvim'
  },

  -- Requries vim compiled with python 3.10, uses DAP isntead
  -- {
  --   'puremourning/vimspector',
  --   lazy=false
  -- }
  
  {
    "p00f/clangd_extensions.nvim",
    lazy = true,
    config = function() end,
    opts = {
      inlay_hints = {
        inline = false,
      },
      ast = {
        --These require codicons (https://github.com/microsoft/vscode-codicons)
        role_icons = {
          type = "",
          declaration = "",
          expression = "",
          specifier = "",
          statement = "",
          ["template argument"] = "",
        },
        kind_icons = {
          Compound = "",
          Recovery = "",
          TranslationUnit = "",
          PackExpansion = "",
          TemplateTypeParm = "",
          TemplateTemplateParm = "",
          TemplateParamObject = "",
        },
      },
    },
  },


  {
    -- Todo setup in other file
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require'treesitter-context'.setup{
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 20, -- Maximum number of lines to show for a single context
        trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20, -- The Z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
      }
    end,
    lazy = false
  },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
  },

  {
    "smoka7/multicursors.nvim",
    event = "VeryLazy",
    dependencies = {
        'smoka7/hydra.nvim',
    },
    opts = {},
    cmd = { 'MCstart', 'MCvisual', 'MCclear', 'MCpattern', 'MCvisualPattern', 'MCunderCursor' },
    keys = {
            {
                mode = { 'v', 'n' },
                '<Leader>m',
                '<cmd>MCstart<cr>',
                desc = 'Create a selection for selected text or word under the cursor',
            },
        },
  },

  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("refactoring").setup()
      vim.keymap.set("x", "<leader>ce", ":Refactor extract ", {desc = "Code extract"})
      vim.keymap.set("x", "<leader>cf", ":Refactor extract_to_file ", {desc = "Code extract to file"})

      vim.keymap.set("x", "<leader>cv", ":Refactor extract_var ", {desc = "Code extract to file"})

      vim.keymap.set({ "n", "x" }, "<leader>ci", ":Refactor inline_var", {desc = "Code inline var"})

      vim.keymap.set( "n", "<leader>cI", ":Refactor inline_func", {desc = "Code inline function"})

      vim.keymap.set("n", "<leader>cb", ":Refactor extract_block", {desc = "Code extract block"})
      vim.keymap.set("n", "<leader>cbf", ":Refactor extract_block_to_file", {desc = "Code extract block to file"})
    end,
    event = "VeryLazy"
  },


  -- Golang
  {
    "leoluz/nvim-dap-go",
    config = true,
  },

  {
    "nvim-neotest/neotest-go",
  },

  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "nvim-neotest/neotest-go",
    },
    opts = require'configs.neotest_conf'.opts
  },

  {
    "nvimtools/none-ls.nvim",
    optional = true,
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { "gomodifytags", "impl" })
        end,
      },
    },
    opts = require'configs.nonels_config'.opts
  },

  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    version = false, -- last release is way too old
  },

  {
    'stevearc/qf_helper.nvim',
    config = function()
      require("qf_helper").setup({
        prefer_loclist = true,       -- Used for QNext/QPrev (see Commands below)
        sort_lsp_diagnostics = true, -- Sort LSP diagnostic results
        quickfix = {
          autoclose = true,          -- Autoclose qf if it's the only open window
          default_bindings = true,   -- Set up recommended bindings in qf window
          default_options = true,    -- Set recommended buffer and window options
          max_height = 10,           -- Max qf height when using open() or toggle()
          min_height = 1,            -- Min qf height when using open() or toggle()
          track_location = true,     -- Keep qf updated with your current location
        },
        loclist = {                  -- The same options, but for the loclist
          autoclose = true,
          default_bindings = true,
          default_options = true,
          max_height = 10,
          min_height = 1,
          track_location = true,
        },
      })
    end,
    event = "VeryLazy"
  },

  {
    'kevinhwang91/nvim-bqf',
    event = "VeryLazy",
    vim.keymap.set("n", "<F2>", "<cmd>QFToggle<CR>", { desc = "Toggle Quickfix", silent = true })
  },

  -- Python

  {
    "nvim-neotest/neotest-python",
  },

  {
    "mfussenegger/nvim-dap-python",
    -- stylua: ignore
    keys = {
      { "<leader>DPt", function() require('dap-python').test_method() end, desc = "Debug Method", ft = "python" },
      { "<leader>DPc", function() require('dap-python').test_class() end, desc = "Debug Class", ft = "python" },
    },
    config = function()
      local path = require("mason-registry").get_package("debugpy"):get_install_path()
      -- require("dap-python").setup(path .. "/venv/bin/python")
    end,
  },

  {
    -- Needs fd command
    "linux-cultist/venv-selector.nvim",
    cmd = "VenvSelect",
    opts = function(_, opts)
      opts.dap_enabled = true
      return vim.tbl_deep_extend("force", opts, {
        name = {
          "venv",
          ".venv",
          "env",
          ".env",
        },
      })
    end,
    keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv" } },
    ft = {"py", "ipynb", "python"}
  },

  { 
    'luk400/vim-jukit',
    vim.api.nvim_create_user_command('JukitStart',function() end,{}),
    cmd = 'JukitStart'
  },
  
  {
    'Wansmer/symbol-usage.nvim',
    event = 'BufReadPre', -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
    config = function()
      require('symbol-usage').setup()
    end
  },

  {
    "karb94/neoscroll.nvim",
    config = function ()
      require('neoscroll').setup {}
    end,
    event = "VeryLazy"
  },
  {
    'chrisbra/csv.vim',
    ft = { 'csv' }
  },
  {
    'wfxr/minimap.vim',
    event = 'VeryLazy'
  }
}
