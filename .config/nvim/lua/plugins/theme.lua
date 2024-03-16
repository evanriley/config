-- [nfnl] Compiled from fnl/plugins/theme.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local nvim = autoload("nvim")
local function _2_()
  local theme = require("kanagawa")
  theme.setup({theme = "wave", background = {dark = "wave", light = "lotus"}, undercurl = false})
  return vim.cmd("colorscheme kanagawa")
end
return {{"rebelot/kanagawa.nvim", priority = 1000, name = "kanagawa", config = _2_, lazy = false}}
