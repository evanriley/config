-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
-- Remap ',' as localleader key
keymap("", ",", "<Nop>", opts)
vim.g.maplocalleader = ","

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Tab navigation
keymap("n", "<C-h>", ":tabprevious<CR>", opts)
keymap("n", "<C-l>", ":tabnext<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Clear highlights
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", opts)

-- Close buffers
keymap("n", "<S-q>", "<cmd>Bdelete!<CR>", opts)

-- Better paste
keymap("v", "p", '"_dP', opts)
keymap("n", "<leader>ya", ":%y+<CR>", opts)

-- Packer
keymap("n", "<localleader>pu", ":PackerUpdate<CR>", opts)
keymap("n", "<localleader>pc", ":PackerClean<CR>", opts)
keymap("n", "<localleader>pi", ":PackerInstall<CR>", opts)

-- Telescope
keymap("n", "<leader>ff", ":Telescope git_files<CR>", opts)
keymap("n", "<leader>fd", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fs", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fp", ":Telescope projects<CR>", opts)
keymap("n", "<leader>bb", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>fG", ":Telescope git_branches<CR>", opts)
keymap("n", "<leader>fb", "<cmd>lua require 'telescope'.extensions.file_browser.file_browser()<CR>", opts)
keymap("n", "<leader><leader>", ":Telescope frecency frecency default_text=:CWD:<CR>", opts)

-- Comment
keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", opts)
keymap("x", "<leader>/", '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>')

-- Hop
keymap("n", "s", "<cmd>lua require'hop'.hint_char1()<cr>", opts)
keymap("x", "s", "<cmd>lua require'hop'.hint_char1()<cr>", opts)
keymap("o", "x", "<cmd>lua require'hop'.hint_char1()<cr>", opts)
keymap("n", "S", "<cmd>lua require'hop'.hint_lines()<cr>", opts)
keymap("o", "X", "<cmd>lua require'hop'.hint_lines()<cr>", opts)
keymap("x", "SS", "<cmd>lua require'hop'.hint_lines()<cr>", opts)
keymap("n", "<C-s>", "<cmd>lua require'hop'.hint_char2()<cr>", opts)
keymap("x", "<C-s>", "<cmd>lua require'hop'.hint_char2()<cr>", opts)
keymap("o", "<C-x>", "<cmd>lua require'hop'.hint_char2()<cr>", opts)

-- Dial
keymap("n", "<C-a>", require("dial.map").inc_normal(), opts)
keymap("n", "<C-x>", require("dial.map").dec_normal(), opts)
keymap("v", "<C-a>", require("dial.map").inc_visual(), opts)
keymap("v", "<C-x>", require("dial.map").dec_visual(), opts)
keymap("v", "g<C-a>", require("dial.map").inc_gvisual(), opts)
keymap("v", "g<C-x>", require("dial.map").dec_gvisual(), opts)

-- Toggleterm
-- LazyGit toggle
keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)
