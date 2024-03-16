-- [nfnl] Compiled from fnl/plugins/treesitter.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  do
    local treesitter = require("nvim-treesitter.configs")
    treesitter.setup({highlight = {enable = true}, indent = {enable = true}, ensure_installed = "all", autotag = {enable = true}, endwise = {enable = true}, contet_commentstring = {enable = true}})
  end
  local treesitter_context = require("treesitter-context")
  return treesitter_context.setup({enable = true})
end
return {{"nvim-treesitter/nvim-treesitter", dependencies = {"windwp/nvim-ts-autotag", "nvim-treesitter/nvim-treesitter-textobjects", "JoosepAlviste/nvim-ts-context-commentstring", "nvim-treesitter/nvim-treesitter-context", "RRethy/nvim-treesitter-endwise", "hiphish/rainbow-delimiters.nvim"}, build = ":TSUpdate", config = _1_}}
