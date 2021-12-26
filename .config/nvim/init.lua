require("impatient")
-- Load Plugins
require('plugins')

-- Set Colorscheme
vim.cmd("colorscheme kanagawa")

-- Load Options
require('options')
-- Load mappings
require('mappings')

-- Diagnostics
require "diagnostics"

-- Autocommands
vim.cmd "source ~/.config/nvim/viml/autocommands.vim"
