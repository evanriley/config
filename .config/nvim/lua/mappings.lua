local function map(mode, bind, exec, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend('force', options, opts)
	end
	vim.api.nvim_set_keymap(mode, bind, exec, opts)
end

local opt = {} --empty opt for maps with no extra options


vim.g.mapleader = ' ' -- Map leader key to space
vim.g.maplocalleader = ',' -- Map localleader
map('n', '<leader>ln', ':set rnu!<CR>', opt) -- toggle relative line numbers
map('', '<C-c>', ':CommentToggle<CR>', opt) -- toggle comment on current line or selection
map('n', '<leader>nf', ':Neoformat<CR>', { noremap = true }) -- format current buffer with neoformat

map('n', '<esc>', ':nohlsearch<cr>', { silent = true})
vim.cmd [[
  command! W :w
  command! Q :q
  command! Qa :qa
]]  -- Make :Q, :Q, and :Qa work like :q, :w, and :qa because I'm dumb

map('n', '<leader>ya', ':%y+<CR>', opt) -- Copy content of entire buffer to system clipboard
map('n', '<leader>yl', '"+yy', opt) -- yank current line into system clipboard


map('n', '<localleader>pu', ':PackerUpdate<cr>', opt)
map('n', '<localleader>pc', ':PackerClean<cr>', opt)
map('n', '<localleader>pi', ':PackerInstall<cr>', opt)

map('n', '<leader>bh', ':bf<CR>', { noremap = true })
map('n', '<leader>bk', ':bn<CR>', { noremap = true })
map('n', '<leader>bj', ':bp<CR>', { noremap = true })
map('n', '<leader>bl', ':bl<CR>', { noremap = true })
map('n', '<leader>bd', ':bd<CR>', { noremap = true })

map('n', '<leader>ff', ':Telescope git_files<CR>', { noremap = true })
map('n', '<leader>fd', ':Telescope find_files<CR>', { noremap = true })
map('n', '<leader>fF', ':Telescope file_browser<CR>', { noremap = true })
map('n', '<leader>fg', ':Telescope git_commits<CR>', { noremap = true })
map('n', '<leader>fG', ':Telescope git_branches<CR>', { noremap = true })
map('n', '<leader>bb', ':Telescope buffers<CR>', { noremap = true })

map('n', '<leader>hH', ':HopWord<CR>', opt)
map('n', '<leader>hh', ':HopLine<CR>', opt)
