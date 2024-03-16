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
	},
	ignore_install = {}, -- List of parsers to ignore installing
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = {}, -- list of language that will be disabled
		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil
  },
  indent = {
    enable = false,
    disbale = {},
  },
  autotag = {
    enable = true,
  },
})

