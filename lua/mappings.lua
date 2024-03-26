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

-- Lua function to toggle quickfix window
function toggle_quickfix()
    if #vim.fn.getwininfo() == 0 or vim.fn.empty(vim.fn.filter(vim.fn.getwininfo(), "v:val.quickfix")) then
        vim.cmd("copen")
    else
        vim.cmd("cclose")
    end
end

map("n", "<F2>", toggle_quickfix, { desc = "Toggle Quickfix", silent = true })

map("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", { desc = "Telescope Git Branchs" })
map("n", "<leader>gs", "<cmd>Telescope git_stash<CR>", { desc = "Telescope Git Stash" })
map("n", "<leader>gs", "<cmd>Telescope git_commits<CR>", { desc = "Telescope Git Commits" })


map("n", "gs", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", { desc = "Telescope find Symbol" })

map("n", "<leader>Fb", "vaB:fold<CR>", { desc = "Fold Block" })
