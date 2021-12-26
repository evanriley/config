require('telescope').setup({
	defaults = {
		prompt_prefix = '=> ',
		selection_caret = '=> ',
		entry_prefix = '   ',
		borderchars = { '═', '│', '═', '│', '╒', '╕', '╛', '╘' },
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = false,
			override_file_sorter = true,
			case_mode = 'smart_case',
		},
	},
})


-- Telescope Mappings
vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope git_files<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fd', ':Telescope find_files<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fF', ':Telescope file_browser<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fg', ':Telescope git_commits<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fG', ':Telescope git_branches<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fs', ':Telescope live_grep<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>bb', ':Telescope buffers<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fb', ':Telescope buffers<CR>', { noremap = true })
