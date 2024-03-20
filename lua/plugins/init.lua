return {
  {
    "stevearc/conform.nvim",
    -- config = function()
    --   require "configs.conform"
    -- end,
    -- lazy = false
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        -- Customize or remove this keymap to your liking
        "<leader>fm",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    -- Everything in opts will be passed to setup()
    opts = {
      -- Define your formatters
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        javascript = { { "prettierd", "prettier" } },
        c = { "clang-format" },
        cpp = { "clang-format" },
      },
      -- Set up format-on-save
      format_on_save = { timeout_ms = 500, lsp_fallback = true },
      -- Customize formatters
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2" },
        },
      },
    },
    init = function()
      -- If you want the formatexpr, here is the place to set it
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      git = { enable = true },
    },
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
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
         "cmake-language-server"
       },
     },
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

  { "nvim-neotest/nvim-nio" },
  { "folke/neodev.nvim", opts = {} },

  {
    -- TODO: Add tab to dapui and add shortcut
    "rcarriga/nvim-dap-ui",
    dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
    lazy = false,
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
    lazy=false
  },

  -- { 'Civitasv/cmake-tools.nvim', lazy = false },

  { 'Shatur/neovim-session-manager', lazy = false },
  -- TODO: Test with this later to see if saves Tabs. 
 
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
  -- For now, use:
  {
    -- TODO: This does not work
    vim.keymap.set('n', '<leader>pp', ':lua require("scripts.open_files").call_gweenview()<CR>', {desc = '[p]review images'})
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    event = 'VeryLazy',
  }
}
