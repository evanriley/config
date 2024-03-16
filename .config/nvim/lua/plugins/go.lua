-- [nfnl] Compiled from fnl/plugins/go.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local nvim = autoload("nvim")
return {{"fatih/vim-go", lazy = true, build = ":GoInstallBinaries", ft = {"go"}}}
