require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>") -- TODO: Check if is really useless
map("n", "<leader>fm", function()
  require("conform").format()
end, { desc = "File Format with conform" })

map("i", "jk", "<ESC>", { desc = "Escape insert mode" })

-- tnoremap <Esc> <C-\><C-n>
map("t", "<ESC>", "<C-\\><C-n>", { desc = "Escape insert mode" })

-- Move selected lines using Alt
map("n", "<M-j>", ":m .+1<CR>==", { desc = "Move Down", silent= true })
map("n", "<M-k>", ":m .-2<CR>==", { desc = "Move Up", silent= true })

map("i", "<M-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move Down", silent= true })
map("i", "<M-k>", "<Esc>:m .-2<CR>==gi", { desc = "Move Up", silent= true })

map("v", "<M-j>", ":m '>+1<CR>gv=gv", { desc = "Move Down", silent= true })
map("v", "<M-k>", ":m '<-2<CR>gv=gv", { desc = "Move Up", silent= true })


map("n", "<leader>cf", function()
  vim.lsp.buf.format()
end, { desc = "[c]ode [f]ormat" })

map("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", { desc = "Telescope Git Branchs" })
map("n", "<leader>gd", "<cmd>Gitsigns diffthis<CR>", { desc = "Git diffthis" })
map("n", "<leader>gs", "<cmd>Telescope git_stash<CR>", { desc = "Telescope Git Stash" })
map("n", "<leader>gs", "<cmd>Telescope git_commits<CR>", { desc = "Telescope Git Commits" })


map("n", "gs", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", { desc = "Telescope find Symbol" })
map("n", "<leadler>fs", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", { desc = "Telescope find Symbol" })

map("n", "<leader>Fb", "vaB:fold<CR>", { desc = "Fold Block" })

map("n", "<leader>o", "i<CR><esc>", { desc = "Add one line" })


-- Telescope Setup
require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      n = {
    	  ['<c-d>'] = require('telescope.actions').delete_buffer
      }, -- n
      i = {
        ["<C-h>"] = "which_key",
        ['<c-d>'] = require('telescope.actions').delete_buffer
      } -- i
    } -- mappings
  }, -- defaults
...
} -- telescope setup