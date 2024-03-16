-- [nfnl] Compiled from fnl/plugins/gitsigns.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local nvim = autoload("nvim")
local function _2_()
  local gitsigns = require("gitsigns")
  return gitsigns.setup({current_line_blame = false})
end
return {{"lewis6991/gitsigns.nvim", event = "BufReadPre", config = _2_}}
