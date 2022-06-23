--      :::::::::::::     :::    :::    ::::    :::
--     :+:       :+:     :+:  :+: :+:  :+:+:   :+:
--    +:+       +:+     +:+ +:+   +:+ :+:+:+  +:+
--   +#++:++#  +#+     +:++#++:++#++:+#+ +:+ +#+
--  +#+        +#+   +#+ +#+     +#++#+  +#+#+#
-- #+#         #+#+#+#  #+#     #+##+#   #+#+#
--##########    ###    ###     ######    ####

-- Load Plugins
require('plugins')
-- Set Colorscheme
require('colorschemes.kanagawa')
-- Load Options
require('options')
-- Load mappings
require('mappings')
-- Diagnostics
require("diagnostics")
-- Autocommands
vim.cmd "source ~/.config/nvim/viml/autocommands.vim"
-- Don't use the default filetype.vim, speed up neovim a bit by using filetype.nvim
vim.g.did_load_filetypes = 1

