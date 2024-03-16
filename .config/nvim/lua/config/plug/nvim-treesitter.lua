require('nvim-treesitter.configs').setup({
	ensure_installed = {
    "tsx",
    "toml",
    "fish",
    "json",
    "clojure",
    "swift",
    "html",
    "scss",
    "commonlisp",
    "go",
    "lua",
    "nix",
    "ruby",
    "rust",
    "org",
	},
	ignore_install = {},
	highlight = {
		enable = true, 
		disable = {}, 
		additional_vim_regex_highlighting = false,
	},
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil
  },
  indent = {
    enable = true,
    disbale = {},
  },
  autotag = {
    enable = true,
  },
})

