return {
	"nvim-lualine/lualine.nvim",
	event = "UIEnter",
	config = function()
		local hide_in_width = function()
			return vim.fn.winwidth(0) > 80
		end

		local diagnostics = {
			"diagnostics",
			sources = { "nvim_diagnostic" },
			sections = { "error", "warn" },
			symbols = { error = " ", warn = " " },
			colored = false,
			always_visible = true,
		}

		local diff = {
			"diff",
			colored = false,
			symbols = { added = "", modified = "", removed = "" }, -- changes diff symbols
			cond = hide_in_width,
		}

		local filetype = {
			"filetype",
			icons_enabled = false,
		}

		local location = {
			"location",
			padding = 0,
		}

		local filename = {
			"filename",
			file_status = true,
			path = 0,
			symbols = {
				modified = "[+]",
				readonly = "[-]",
				unnamed = "[No Name]",
			},
		}

		local spaces = function()
			return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
		end

		require("lualine").setup({
			options = {
				globalstatus = true,
				icons_enabled = true,
				theme = "kanagawa",
				component_separators = { left = " ", right = " " },
				section_separators = { left = " ", right = " " },
				always_divide_middle = true,
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch" },
				lualine_c = { diagnostics, "%=", filename },
				lualine_x = { diff, spaces, "encoding", filetype },
				lualine_y = { location },
				lualine_z = { "progress" },
			},
		})
	end,
}
