return require('packer').startup(function()
	use 'wbthomason/packer.nvim'	

	use {
      'neovim/nvim-lspconfig',
      'williamboman/nvim-lsp-installer'
  }
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/nvim-cmp'
  use 'onsails/lspkind-nvim'
	use 'windwp/nvim-autopairs'
  use "rafamadriz/friendly-snippets"
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip-integ'
  use 'mattn/emmet-vim'
  use {
    'tzachar/cmp-tabnine',
    run='./install.sh',
    requires = 'hrsh7th/nvim-cmp'
  }
  
	use {
  		'nvim-lualine/lualine.nvim',
  		requires = { 'kyazdani42/nvim-web-devicons', opt = true } 
	}
	use {
  		'nvim-telescope/telescope.nvim',
  		requires = {'nvim-lua/plenary.nvim'}
	}
  use {
      'nvim-telescope/telescope-fzf-native.nvim',
      run = 'make'
  }
	use 'terrortylor/nvim-comment'
	use 'sbdchd/neoformat'
	use {
        	'nvim-treesitter/nvim-treesitter',
        	run = ':TSUpdate'
  }
  use 'windwp/nvim-ts-autotag'
	use 'norcalli/nvim-colorizer.lua'
	use {
	  		'lewis6991/gitsigns.nvim',
	  		requires = { 'nvim-lua/plenary.nvim'} 
	}
	use 'phaazon/hop.nvim'
  use 'machakann/vim-sandwich'

	use 'folke/tokyonight.nvim'
  use 'ayu-theme/ayu-vim'
  use 'tiagovla/tokyodark.nvim'

  use 'tpope/vim-dispatch'
  use 'radenling/vim-dispatch-neovim'
  use 'clojure-vim/vim-jack-in'

  use 'akinsho/toggleterm.nvim'

  use 'p00f/nvim-ts-rainbow'

  use {
      'eraserhd/parinfer-rust',
      run = 'cargo build --release'
  }
  use  {
      'Olical/conjure',
      tag = 'v4.24.1'
  }
  use {
      'kovisoft/slimv'
  }

  use {
    'fatih/vim-go',
    run = ':GoUpdateBinaries'
  } 
  -- use {
  --   'kristijanhusak/orgmode.nvim',
  --   config = function()
  --       require('orgmode').setup{}
  --   end
  -- }
  -- use {
  --   'akinsho/org-bullets.nvim',
  --   config = function()
  --     require('org-bullets').setup {
  --       sumbols = { "◉", "○", "✸", "✿" }
  --     }
  --   end
  -- }
end)
