return {
	"mhartington/formatter.nvim",
	event = "BufReadPre",
	config = function()
		require("formatter").setup({
			filetype = {
				go = {
					require("formatter.filetypes.go").goimports,
				},
				elixir = {
					require("formatter.filetypes.elixir").mixformat,
				},
				html = {
					require("formatter.filetypes.html").prettierd,
				},
				lua = {
					require("formatter.filetypes.lua").stylua,
				},
			},
		})
	end,
}
