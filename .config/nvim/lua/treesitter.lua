require("nvim-treesitter.configs").setup({
	ensure_installed = {"c", "clojure", "commonlisp", "cpp", "fish", "go", "html", "javascript", "json", "json5", "julia", "lua", "make", "r", "ruby", "rust", "tsx", "typescript", "vim", "vue", "zig"}, --  "all", "maintained" or a list
	ignore_install = { "html" }, -- List of parsers to ignore installing
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "vim", "sh", "bash", "javascript", "javascriptreact", "typescript", "typescriptreact" }, -- list of language that will be disabled
		additional_vim_regex_highlighting = false,
	},
	autotag = {
	  enable = true,
	  filetypes = {"html", "javascript", "javascriptreact", "typescriptreact", "svelte", "vue", "eruby", "erb"}
	},
	rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn",
			node_incremental = "gnr",
			node_decremental = "gNr",
			scope_incremental = "gnc",
		},
	},
	indent = {
		enable = true,
		disable = { "javascript", "javascriptreact", "typescript", "typescriptreact" }, -- list of language that will be disabled
	},
	matchup = {
		enable = true,
	},
	textobjects = {
		select = {
			enable = true,

			-- Automatically jump forward to textobj, similar to targets.vim
			lookahead = true,

			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				["al"] = "@loop.outer",
				["il"] = "@loop.inner",
			},
		},
		swap = {
			enable = true,
			swap_next = {
				["<leader>ss"] = "@parameter.inner",
			},
			swap_previous = {
				["<leader>sS"] = "@parameter.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
		lsp_interop = {
			enable = true,
			border = "single",
			peek_definition_code = {
				["<leader>lg"] = "@block.outer",
				-- ["<leader>lG"] = "@class.outer",
			},
		},
	},
    textsubjects = {
        enable = true,
        keymaps = {
            ["<cr>"] = "textsubjects-smart", -- works in visual mode
        },
    },
    playground = {
        enable = true,
    }
})

--  @block.inner
--  @block.outer
--  @call.inner
--  @call.outer
--  @class.inner
--  @class.outer
--  @comment.outer
--  @conditional.inner
--  @conditional.outer
--  @frame.inner
--  @frame.outer
--  @function.inner
--  @function.outer
--  @loop.inner
--  @loop.outer
--  @parameter.inner
--  @parameter.outer
--  @scopename.inner
--  @statement.outer
