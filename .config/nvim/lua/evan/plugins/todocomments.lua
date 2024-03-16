return {
	-- FIX:
	-- TODO:
	-- HACK:
	-- PERF:
	-- NOTE:
	-- WARN:
	"folke/todo-comments.nvim",
	event = "BufReadPre",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("todo-comments").setup({})
	end,
}
