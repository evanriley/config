local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

return packer.startup(function(use)
	use({ "wbthomason/packer.nvim" }) -- Have packer manage itself
	use({ "nvim-lua/plenary.nvim" }) -- Useful lua functions used by lots of plugins
	use({ "lewis6991/impatient.nvim" })

	-- LSP
	use({ "williamboman/mason.nvim" })
	use({ "williamboman/mason-lspconfig.nvim" })
	use({
		"neovim/nvim-lspconfig",
		config = function()
			require("lsp.lsp")
		end,
	})

	use({
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("lsp.null-ls")
		end,
	})

	-- Coq
	use({
		"ms-jpq/coq_nvim",
		branch = "coq",
		config = function()
			require("plugins.coq")
		end,
	})
	use({ "ms-jpq/coq.artifacts", branch = "artifacts" })
	use({ "ms-jpq/coq.thirdparty", branch = "3p" })

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		config = function()
			require("plugins.telescope")
		end,
	})
	use({ "nvim-telescope/telescope-ui-select.nvim" })
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "make",
	})
	use({ "nvim-telescope/telescope-file-browser.nvim" })
	use({
		"nvim-telescope/telescope-frecency.nvim",
		requires = { "tami5/sqlite.lua" },
	})

	-- Colors
	use({ "ellisonleao/gruvbox.nvim" })

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("plugins.treesitter")
		end,
	})
	use({ "JoosepAlviste/nvim-ts-context-commentstring" })
	use({ "p00f/nvim-ts-rainbow" })
	use({
		"akinsho/toggleterm.nvim",
		config = function()
			require("plugins.toggleterm")
		end,
	})
	use({
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	})
	use({ "nvim-treesitter/nvim-treesitter-context" })

	-- Helpers
	use({ "tpope/vim-surround" })
	use({ "wellle/targets.vim" })
	use({ "folke/todo-comments.nvim" })
	use({ "monaqa/dial.nvim" })
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("plugins.autopairs")
		end,
	})

	use({
		"numToStr/Comment.nvim",
		config = function()
			require("plugins.comment")
		end,
	})
	use({
		"nvim-lualine/lualine.nvim",
		config = function()
			require("plugins.lualine")
		end,
	})
	use({
		"phaazon/hop.nvim",
		as = "hop",
		config = function()
			require("plugins.hop")
		end,
	})
	use({
		"eraserhd/parinfer-rust",
		run = "cargo build --release",
	})
	use({ "moll/vim-bbye" })

	-- Git
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("plugins.gitsigns")
		end,
	})
	use({ "rhysd/git-messenger.vim" })
	use({ "sindrets/diffview.nvim" })

	-- SQL
	use({ "tpope/vim-dadbod" })
	use({ "kristijanhusak/vim-dadbod-ui" })

	-- JS/TS/JSX/TSX
	use({ "yuezk/vim-js" })
	use({ "maxmellon/vim-jsx-pretty" })
	use({ "HerringtonDarkholme/yats.vim" })

	-- Clojure
	use({ "Olical/conjure" })

	-- Automatically set up your configuration after cloning packer.nvim
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
