local execute = vim.api.nvim_command
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


require("plugins.coq") -- I need these settings to load before anything else.
require("packer").init({
	max_jobs = 50,
})

return require('packer').startup(function()
    -- Make packer manage itself
    use 'wbthomason/packer.nvim'

    use 'nvim-lua/plenary.nvim'

    use 'nvim-lua/popup.nvim'

    ----------------------------------------
    -- LSP, Copmletions and related items --
    ----------------------------------------
    use ({
	    'ms-jpq/coq_nvim',
	    branch = 'coq',
    })
    use({
	    'ms-jpq/coq.artifacts',
	    branch = 'artifacts',
    })
    use({
	    'ms-jpq/coq.thirdparty',
	    branch = '3p',
    })

    use({
	    'neovim/nvim-lspconfig',
	    config = function()
		    require("lsp.lsp-config")
	    end,
    })

    use 'williamboman/nvim-lsp-installer'

    use 'nvim-lua/lsp-status.nvim'
    use ({
      "onsails/lspkind-nvim",
      config = function ()
        require("lspkind").init({
          with_text = true,
          preset = "codicons",
        })
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
        "folke/trouble.nvim",
        config = function()
            require("plugins.trouble")
        end,
    })



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

    use({
      "kyazdani42/nvim-web-devicons",
      config = function()
        require("nvim-web-devicons").setup()
      end,
    })

  use({
    "nvim-lualine/lualine.nvim",
    requires = {"kyazdani42/nvim-web-devicons", opt = true},
    config = function()
      require("plugins.lualine")
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

    ------------------------
    -- Editing Text Stuff --
    ------------------------
    use({
	    "windwp/nvim-autopairs",
	    after = {"hop", "coq_nvim"},
	    config = function()
	      require("plugins.autopairs")
      end,
    })

    use({
	    "phaazon/hop.nvim",
	    as = "hop",
	    disable = false,
	    config = function()
	      require("plugins.hop")
      end,
    })

    use({
      "godlygeek/tabular",
      cmd = { "Tabularize" }
    })

    use({
      "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup({ mappings = { extended = true } })
      end,
    })

    use({ "tpope/vim-surround" })

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

    use({ "moll/vim-bbye" })

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

    -- Clojure
    use ({ "clojure-vim/vim-jack-in"})
    use({
      "eraserhd/parinfer-rust",
      run = "cargo build --release"
    })
    use({
      "Olical/conjure",
      tag = 'v4.28.0'
    })
    use({ "p00f/nvim-ts-rainbow" })

    -- Ruby/Rails
    use({ "tpope/vim-bundler" })
    use({ "tpope/vim-rails" })

    -- F#
    use({ "adelarsq/neofsharp.vim" })

end)
