return {
	"rebelot/kanagawa.nvim",
	lazy = false,
	priority = 1000,
	name = "kanagawa",
	config = function()
		require("kanagawa").setup({
			undercurl = false,
			theme = "dragon",
			background = {
				dark = "dragon",
				light = "lotus",
			},
		})
		vim.cmd("colorscheme kanagawa")
	end,
}
