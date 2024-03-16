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


require("plugins.coq")
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
    -- use({
    --   "hrsh7th/nvim-cmp",
    --   config = function()
    --     require("plugins.cmp")
    --   end,
    --   requires = {
    --     "hrsh7th/cmp-buffer",
    --     "hrsh7th/cmp-path",
    --     "hrsh7th/cmp-nvim-lua",
    --     "hrsh7th/cmp-cmdline",
    --     "hrsh7th/cmp-nvim-lsp",
    --     "kdheepak/cmp-latex-symbols",
    --     "dmitmel/cmp-cmdline-history",
    --     "andersevenrud/cmp-tmux",
    --     "quangnguyen30192/cmp-nvim-ultisnips",
    --   },
    -- })
    --
    -- use({
    --   "tzachar/cmp-tabnine",
    --   run = './install.sh',
    --   requires = "hrsh7th/nvim-cmp",
    -- })

    -- use({
    --   "SirVer/ultisnips",
    --   event = 'InsertEnter',
    --   requires = "honza/vim-snippets",
    --   config = function() 
    --     vim.opt.rtp:append({ vim.fn.stdpath("data") .. "/site/pack/packer/start/vim-snippets" })
    --     vim.g.UltiSnipsExpandTrigger = "<Plug>(ultisnips_expand)"
    --     vim.g.UltiSnipsJumpForwardTrigger = "<Plug>(ultisnips_jump_forward)"
    --     vim.g.UltiSnipsJumpBackwardTrigger = "<Plug>(ultisnips_jump_backward)"
    --     vim.g.UltiSnipsListSnippets = "<c-x><c-s>"
    --     vim.g.UltiSnipsRemoveSelectModeMappings = 0
    --   end,
    -- })

    use({
      "ms-jpq/coq_nvim",
      branch = "coq",
    })

    use({
      "ms-jpq/coq.artifacts",
      branch = "artifacts",
    })

    use({
      "ms-jpq/coq.thirdparty",
      branch = "3p",
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
      config = function()
        require("lspkind").init({
          with_text = true,
        })
      end
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

    use({
      "nvim-telescope/telescope-dap.nvim",
      after = { "telescope.nvim", "nvim-dap" },
      config = function()
        require("telescope").load_extension("dap")
      end
    })

    use({
      "ms-jpq/chadtree",
      branch = "chad",
      run = "python3 -m chadtree deps"
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

    use({ "wellle/targets.vim" })

    use({ "chrisbra/NrrwRgn" })

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

    use({
      "Pocco81/DAPInstall.nvim",
    })

    use({
      "mfussenegger/nvim-dap",
      config = function()
        require("plugins.dap")
      end
    })

    use({
      "theHamsta/nvim-dap-virtual-text",
      after = "nvim-dap",
      config = function()
        require("nvim-dap-virtual-text").setup({
         enabled = true, -- enable this plugin (the default)
         enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
         highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
         highlight_new_as_changed = true, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
         show_stop_reason = true, -- show stop reason when stopped for exceptions
         commented = false, -- prefix virtual text with comment string
         -- experimental features:
         virt_text_pos = "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
         all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
         virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
         virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
        })
      end,
    })

    use({
      "rcarriga/nvim-dap-ui",
      after = "nvim-dap",
      module = "dapui",
      config = function()
        require("dapui").setup()
      end
    })

    use({ "jbyuki/one-small-step-for-vimkind" })

    use({
      "rcarriga/vim-ultest",
      requires = { "vim-test/vim-test" },
      run = ":UpdateRemotePlugins",
      config = function()
        require("plugins.ultest")
      end
    })

    use({
      "ThePrimeagen/refactoring.nvim",
      after = "nvim-treesitter",
      config = function()
        require("refactoring").setup({})
      end
    })
    use({
      "folke/todo-comments.nvim",
      config = function()
        require("todo-comments").setup{}
      end,
    })

    use({ "tweekmonster/startuptime.vim" })

    -------------------------
    --  Language Specific  --
    -------------------------

    -- Clojure
    use ({
      "clojure-vim/vim-jack-in",
      ft = {"clojure", "clojurescript"}
    })
    use({
      "eraserhd/parinfer-rust",
      run = "cargo build --release",
      ft = {"clojure", "clojurescript"}
    })
    use({
      "Olical/conjure",
      tag = 'v4.28.0',
      ft = {"clojure", "clojurescript"}
    })
    use({ "p00f/nvim-ts-rainbow" })

    -- Ruby/Rails
    use({
      "tpope/vim-bundler",
      ft = { "ruby" }

    })
    use({
      "tpope/vim-rails",
      ft = { "ruby" }
    })
end)
