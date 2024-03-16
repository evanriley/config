vim.o.background = "dark"
-- Gruvbox-Material colorScheme settings
vim.g.gruvbox_material_background = "medium" -- Set contrast: 'hard', 'medium', 'soft'
vim.g.gruvbox_material_foreground = "material" -- Foreground color palette: 'material', 'mix', 'original'
vim.g.gruvbox_material_better_performance = 1 -- For better performance
vim.g.gruvbox_material_enable_bold = 1 -- Bold in function name
local colorscheme = "gruvbox-material"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	return
end
