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

-- Plugins --

-- Packer
keymap('n', '<localleader>pu', ':PackerUpdate<CR>', opts)
keymap('n', '<localleader>pc', ':PackerClean<CR>', opts)
keymap('n', '<localleader>pi', ':PackerInstall<CR>', opts)

-- Telescope
keymap("n", "<leader>ff", ":Telescope git_files<CR>", opts)
keymap("n", "<leader>fd", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fs", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fp", ":Telescope projects<CR>", opts)
keymap("n", "<leader>bb", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>fG", ":Telescope git_branches<CR>", opts)
keymap("n", "<leader>fb", "<cmd>lua require 'telescope'.extensions.file_browser.file_browser()<CR>", opts)
keymap('n', '<leader><leader>', ':Telescope frecency frecency default_text=:CWD:<CR>', opts)

-- Git
-- keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)
keymap("n", "<leader>gg", ":Neogit<CR>", opts)

-- Comment
keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", opts)
keymap("x", "<leader>/", '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>')

-- DAP
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)

-- Hop
keymap('n', 's', "<cmd>lua require'hop'.hint_char1()<cr>", opts)
keymap('x', 's', "<cmd>lua require'hop'.hint_char1()<cr>", opts)
keymap('o', 'x', "<cmd>lua require'hop'.hint_char1()<cr>", opts)
keymap('n', 'S', "<cmd>lua require'hop'.hint_lines()<cr>", opts)
keymap('o', 'X', "<cmd>lua require'hop'.hint_lines()<cr>", opts)
keymap('x', 'SS', "<cmd>lua require'hop'.hint_lines()<cr>", opts)
keymap('n', '<C-s>', "<cmd>lua require'hop'.hint_char2()<cr>", opts)
keymap('x', '<C-s>', "<cmd>lua require'hop'.hint_char2()<cr>", opts)
keymap('o', '<C-x>', "<cmd>lua require'hop'.hint_char2()<cr>", opts)
