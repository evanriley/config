local plugins = {
	-- Plugins that I'm testing or feel just don't need their own file.
	{
		"moll/vim-bbye",
		event = "BufReadPost",
	},
	{
		"eraserhd/parinfer-rust",
		build = "cargo build --release",
		ft = "clojure",
	},
	{
		"Olical/conjure",
		ft = "clojure",
	},
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			"tpope/vim-dadbod",
			"kristijanhusak/vim-dadbod-completion",
		},
		ft = "sql",
	},
}

table.insert(plugins, require("evan.plugins.lsp"))
table.insert(plugins, require("evan.plugins.tokyonight"))
table.insert(plugins, require("evan.plugins.lualine"))
table.insert(plugins, require("evan.plugins.autopairs"))
table.insert(plugins, require("evan.plugins.cmp"))
table.insert(plugins, require("evan.plugins.comment"))
table.insert(plugins, require("evan.plugins.formatter"))
table.insert(plugins, require("evan.plugins.telescope"))
table.insert(plugins, require("evan.plugins.gitsigns"))
table.insert(plugins, require("evan.plugins.hop"))
table.insert(plugins, require("evan.plugins.treesitter"))
table.insert(plugins, require("evan.plugins.toggleterm"))
table.insert(plugins, require("evan.plugins.lualine"))
table.insert(plugins, require("evan.plugins.surround"))
table.insert(plugins, require("evan.plugins.targets"))
table.insert(plugins, require("evan.plugins.todocomments"))
table.insert(plugins, require("evan.plugins.oil"))
table.insert(plugins, require("evan.plugins.neorg"))
table.insert(plugins, require("evan.plugins.dressing"))

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

local home = os.getenv("HOME")
local cache = home .. "/.cache/nvim"
vim.opt.runtimepath:prepend(cache)

require("lazy").setup(plugins, {
	defaults = { lazy = true },
	install = {
		missing = true,
	},
	checker = { enabled = false, notify = false },
	change_detection = {
		enabled = false,
		notify = false,
	},
	performance = {
		cache = {
			enabled = true,
			path = cache .. "/lazy/cache",
			disable_events = { "VimEnter", "BufReadPre" },
		},
		rtp = {
			reset = true,
			disabled_plugins = {
				"gzip",
				"zip",
				"zipPlugin",
				"fzf",
				"tar",
				"tarPlugin",
				"getscript",
				"getscriptPlugin",
				"vimball",
				"vimballPlugin",
				"2html_plugin",
				"matchit",
				"matchparen",
				"logiPat",
				"rrhelper",
				"netrw",
				"netrwPlugin",
				"netrwSettings",
				"netrwFileHandlers",
			},
		},
	},
})
