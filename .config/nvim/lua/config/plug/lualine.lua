-- load scheme wrapper library
local scheme = require('lib.scheme')

-- lualine setup config
require('lualine').setup({
	options = {
		section_separators = scheme.lualine_style,
		component_separators = scheme.lualine_seperator,
		theme = 'tokyonight',
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = { 'branch' },
		lualine_c = { 'filename' },
		lualine_x = { 'encoding', 'fileformat', 'filetype' },
		lualine_y = { 'progress' },
		lualine_z = { 'location' },
	},
})
