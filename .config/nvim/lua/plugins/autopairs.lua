-- [nfnl] Compiled from fnl/plugins/autopairs.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local nvim = autoload("nvim")
local function _2_()
  local ultimate_autopair = require("ultimate-autopair")
  return ultimate_autopair.setup({})
end
return {{"altermo/ultimate-autopair.nvim", event = {"InsertEnter", "CmdLineEnter"}, config = _2_}}
