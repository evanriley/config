return {
	"phaazon/hop.nvim",
	event = "BufReadPost",
	name = "hop",
	config = function()
		require("hop").setup({
			teasing = false,
		})
	end,
}
