-- [nfnl] Compiled from fnl/plugins/toggleterm.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local nvim = autoload("nvim")
local function _2_()
  local toggleterm = require("toggleterm")
  return toggleterm.setup({open_mapping = "<C-t>"})
end
return {{"akinsho/toggleterm.nvim", config = _2_, lazy = false}}
