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
		frecency = {
      show_scores = false,
      workspaces = {
        ["conf"] = "/Users/evan/.config",
        ["data"] = "/Users/evan/.local/share",
        ["project"] = "/Users/evan/Code",
        ["notes"] = "/Users/evan/org"
      },
      ignore_patterns = {"*.git/*", "*/tmp/*", "*node_modules/*", "*.direnv/*" }
		},
	},
	pickers = {
	  git_files = {
	    theme = "dropdown"
	  },
    find_files = {
      theme = "dropdown"
    },
    file_browser = {
      theme = "dropdown"
    },
	}
})


-- Telescope Mappings
vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope git_files<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fd', ':Telescope find_files<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fb', "<cmd>lua require 'telescope'.extensions.file_browser.file_browser()<CR>", { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fg', "<cmd>lua require 'telescope'.extensions.file_browser.file_browser()<CR>", { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fG', ':Telescope git_branches<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fs', ':Telescope live_grep<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>bb', ':Telescope buffers<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader><leader>', ':Telescope frecency frecency default_text=:CWD:<CR>', { noremap = true })
