-- Load Plugins
require('plugins')

-- Load Options & Keymaps
require('mappings')
require('options')

-- load theme
-- vim.cmd[[colorscheme tokyonight]]
-- Use Scheme util, stolen from https://github.com/Theory-of-Everything/nii-nvim/blob/master/lua/lib/scheme.lua
local scheme = require('lib.scheme')
scheme.load_shared_scheme('tokyonight')

-- Load plugin configs
require('config.plug')
require('config.modules')
