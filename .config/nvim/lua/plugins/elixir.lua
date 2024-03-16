-- [nfnl] Compiled from fnl/plugins/elixir.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local nvim = autoload("nvim")
local function _2_()
  local elixir = require("elixir")
  local elixirls = require("elixir.elixirls")
  return elixir.setup({nextls = {enable = true}, elixirls = {enable = false}})
end
return {{"elixir-tools/elixir-tools.nvim", lazy = true, event = {"BufReadPre", "BufNewFile"}, ft = {"elixir"}, config = _2_}}
