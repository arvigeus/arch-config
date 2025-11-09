-- Set leader key
vim.g.mapleader = " "

-- Helper function
local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  opts.noremap = opts.noremap ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Basic operations
map("n", "<leader>w", "<cmd>w<cr>")
map("n", "<leader>q", "<cmd>q<cr>")

-- Split navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Feature-specific keymaps are defined in their respective feature files:
-- <leader>e - file explorer toggle (see lua/config/ui/file-explorer.lua)
-- <leader>x - close buffer (see lua/config/ui/tabs.lua)
