return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",

		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",

		"rafamadriz/friendly-snippets",
		"kitagry/vs-snippets",
	},
	config = function()
		local luasnip = require("luasnip")
		local cmp = require("cmp")
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")

		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

		local has_words_before = function()
			unpack = unpack or table.unpack
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
		end

		local feedkey = function(key, mode)
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
		end

		local kinds = {
			Text = "文",
			Method = "技",
			Function = "関",
			Constructor = "作",
			Field = "有",
			Variable = "変",
			Class = "ｸﾗｽ",
			Interface = "引",
			Module = "組",
			Property = "質",
			Unit = "単",
			Value = "値",
			Enum = "列挙",
			Keyword = "予",
			Snippet = "切",
			Color = "色",
			File = "ﾌｧｪﾙ",
			Reference = "指",
			Folder = "結",
			EnumMember = "列挙類",
			Constant = "定",
			Struct = "構造",
			Event = "行",
			Operator = "演算子",
			TypeParameter = "型",
		}

		cmp.setup({
			enabled = function()
				local in_prompt = vim.api.nvim_buf_get_option(0, "buftype") == "prompt"
				if in_prompt then
					return false
				end
				local context = require("cmp.config.context")
				return not (context.in_treesitter_capture("comment") == true or context.in_syntax_group("Comment"))
			end,
			experimental = {
				ghost_text = false,
			},
			confirmation = {
				get_commit_characters = function()
					return {}
				end,
			},
			view = {
				entries = "custom",
			},
			completion = {
				completeopt = "longest,menuone",
				keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]],
				keyword_length = 1,
			},
			window = {
				completion = {
					winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
					col_offset = -3,
					side_padding = 0,
				},
			},
			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = function(_, vim_item)
					vim_item.menu = vim_item.kind
					vim_item.kind = " " .. kinds[vim_item.kind] .. " "

					return vim_item
				end,
			},
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			mapping = {
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_locally_jump()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			},
			sources = {
				{ name = "nvim_lsp", keyword_length = 3 },
				{ name = "nvim_lua", keyword_length = 3 },
				{ name = "path" },
				{ name = "buffer", keyword_length = 3 },
				{ name = "luasnip" },
			},
			preselect = cmp.PreselectMode.None,
		})
	end,
}
