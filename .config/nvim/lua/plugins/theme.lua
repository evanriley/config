-- [nfnl] Compiled from fnl/plugins/theme.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local nvim = autoload("nvim")
local function _2_()
  local theme = require("no-clown-fiesta")
  theme.setup({transparent = false})
  return vim.cmd("colorscheme no-clown-fiesta")
end
return {{"no-clown-fiesta/no-clown-fiesta.nvim", priority = 1000, config = _2_, lazy = false}}
