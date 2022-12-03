-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

--Remap space as leader key keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<A-h>", "<C-w>h", opts)
keymap("n", "<A-j>", "<C-w>j", opts)
keymap("n", "<A-k>", "<C-w>k", opts)
keymap("n", "<A-l>", "<C-w>l", opts)
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)

-- Clear highlights
keymap("n", "<esc><esc>", "<cmd>nohlsearch<CR>", opts)

-- Close buffers
--keymap("n", "<S-q>", "<cmd>Bdelete!<CR>", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- NvimTree
keymap("n", "<S-Tab>", ":NvimTreeToggle<CR>", opts)

-- FzfLua
keymap("n", "<C-p>", ":FzfLua files<CR>", opts)
keymap("n", "<C-f>", ":FzfLua oldfiles<CR>", opts)
keymap("n", "<S-m>", ":TroubleToggle<CR>", opts)
keymap("n", "dG", ":DogeGenerate<CR>", opts)
keymap("n", "t", "<C-w>s :te<CR>", opts)
keymap("n", "<leader>lg", ":FzfLua live_grep <CR>", opts)
keymap("n", "<leader>fix", ":lua vim.lsp.buf.code_action() <CR>", opts)
keymap("n", "<leader>ref", ":lua vim.lsp.buf.references() <CR>", opts)
