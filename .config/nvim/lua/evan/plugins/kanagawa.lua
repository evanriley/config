return {
	"rebelot/kanagawa.nvim",
	lazy = false,
	priority = 1000,
	name = "kanagawa",
	config = function()
		require("kanagawa").setup({
			undercurl = false,
			theme = "wave",
			background = {
				dark = "wave",
				light = "lotus",
			},
		})
		vim.cmd("colorscheme kanagawa")
	end,
}
