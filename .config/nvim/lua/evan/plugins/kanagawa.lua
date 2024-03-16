return {
	"rebelot/kanagawa.nvim",
	lazy = false,
	priority = 1000,
	name = "kanagawa",
	config = function()
		require("kanagawa").setup({
			undercurl = false,
		})
		vim.cmd("colorscheme kanagawa")
	end,
}
