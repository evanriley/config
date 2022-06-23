local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
        "git",
        "clone",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    execute("packadd packer.nvim")
end


-- Autocompile
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])


require("packer").init({
	max_jobs = 50,
})

return require('packer').startup(function()
    -- Make packer manage itself
    use 'wbthomason/packer.nvim'

    use 'nvim-lua/plenary.nvim'

    use 'nvim-lua/popup.nvim'

    use 'nathom/filetype.nvim'

    ----------------------------------------
    -- LSP, Completions and related items --
    ----------------------------------------

    use({
	    'neovim/nvim-lspconfig',
	    config = function()
		    require("lsp.lsp-config")
	    end,
    })

    use 'nvim-lua/lsp-status.nvim'

    use({
        "folke/trouble.nvim",
        config = function()
            require("plugins.trouble")
        end,
    })

    use({
      "jose-elias-alvarez/null-ls.nvim",
      after = "nvim-lspconfig",
      disable = false,
      config = function()
        require("lsp.null-ls")
      end,
    })
    use({
      "jose-elias-alvarez/nvim-lsp-ts-utils",
    })


    use({
      "hrsh7th/nvim-cmp",
      config = function()
        require("plugins.cmp")
      end,
      requires = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "petertriho/cmp-git"
      }
    })

    use({
      "hrsh7th/vim-vsnip",
      requires = {"hrsh7th/cmp-vsnip"}
    })

    use { "rafamadriz/friendly-snippets" }

    use {"tzachar/cmp-tabnine", run="./install.sh", requires = "hrsh7th/nvim-cmp"}

    --------------------------------
    -- Fuzzy Finders and what not --
    --------------------------------

    use({
	    "nvim-telescope/telescope.nvim",
	    config = function()
		    require("plugins.telescope")
	    end,
    })

    use({
      "nvim-telescope/telescope-fzf-native.nvim",
      after = "telescope.nvim",
      run = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    })

    use({
      "nvim-telescope/telescope-file-browser.nvim",
      after = "telescope.nvim",
      config = function()
        require("telescope").load_extension("file_browser")
      end,
    })

    use({
      "nvim-telescope/telescope-frecency.nvim",
      after = { "telescope.nvim", "sqlite.lua"},
      config = function()
        require("telescope").load_extension("frecency")
      end,
      requires = {"tami5/sqlite.lua"}
    })


    --------------------------
    -- Visuals and what not --
    --------------------------

    use 'rebelot/kanagawa.nvim'
    use 'folke/tokyonight.nvim'

    use({
      "ojroques/nvim-hardline",
      config = function()
        require("plugins.hardline")
      end,
    })

    use({
      "norcalli/nvim-colorizer.lua",
      config = function()
        require("colorizer").setup()
      end,
    })

    -------------------------
    -- Syntax and what not --
    -------------------------

    use({
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      config = function()
        require("treesitter")
      end,
    })

    use({
      "windwp/nvim-ts-autotag",
      config = function()
        require('nvim-ts-autotag').setup()
      end,
    })

    use({ "LnL7/vim-nix" })

    ------------------------
    -- Editing Text Stuff --
    ------------------------
    use({
	    "windwp/nvim-autopairs",
	    config = function()
	      require("plugins.autopairs")
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
      "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup({ mappings = { extended = true } })
      end,
    })

    use({ "tpope/vim-surround" })

    use({ "wellle/targets.vim" })

    -------------------------
    -- Utilities and stuff --
    -------------------------
   use({ "tpope/vim-fugitive" })

   use({
        "lewis6991/gitsigns.nvim",
        after = "trouble.nvim",
        config = function()
            require("plugins.gitsigns")
        end,
    })

    use({ "rhysd/git-messenger.vim" })
    use({ "p00f/nvim-ts-rainbow" })

    use({ "tpope/vim-dispatch" })
    use({ "radenling/vim-dispatch-neovim" })

    use({
      "akinsho/toggleterm.nvim",
      config = function()
        require("plugins.toggleterm")
      end,
    })

    use({
      "direnv/direnv.vim",
      config = function()
        vim.g.direnv_silent_load = 0
      end
    })

    -------------------------
    --  Language Specific  --
    -------------------------

    -- JS/JSX/TS/TSX
    -- TreeSitter...kind of sucks sometimes
    use({
      "yuezk/vim-js",
      ft = {"javascript"}
    })
    use({
      "maxmellon/vim-jsx-pretty",
      ft = {"javascriptreact", "typescriptreact"},
    })
    use({
      "HerringtonDarkholme/yats.vim",
      ft = {"typescript", "typescriptreact"},
    })
end)
