local cmd = vim.cmd
local opt = vim.opt
local g = vim.g
local o = vim.o

cmd('syntax enable')
o.nu = true
o.mouse = 'a'
o.modeline = true
o.modelines = 5

-- Tab settings
o.tabstop = 2
o.shiftwidth = 2
o.expandtab = true

opt.undofile = true
opt.ruler = false
opt.hidden = true
opt.ignorecase = true
opt.splitbelow = true
opt.splitright = true
o.completeopt = 'menuone,noselect'
opt.wrap = false

vim.opt.termguicolors = true
