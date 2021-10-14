return require('packer').startup(function()
	-- Let packer manage itself
	use 'wbthomason/packer.nvim'	

	-- LSP stuff
	use 'neovim/nvim-lspconfig'
	use 'kabouzeid/nvim-lspinstall'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/nvim-cmp'
  -- use 'hrsh7th/nvim-compe' -- Deprecated --

	-- Editor cstuff
	use 'windwp/nvim-autopairs'
  use 'L3MON4D3/luasnip'
	use {
  		'hoob3rt/lualine.nvim',
  		requires = { 'kyazdani42/nvim-web-devicons', opt = true } 
	}
	use {
		'akinsho/bufferline.nvim',
		requires = 'kyazdani42/nvim-web-devicons'
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
	use 'norcalli/nvim-colorizer.lua'
	use {
	  		'lewis6991/gitsigns.nvim',
	  		requires = { 'nvim-lua/plenary.nvim'} 
	}
  use {
      'TimUntersberger/neogit',
      requires = 'nvim-lua/plenary.nvim'
  }
	use 'phaazon/hop.nvim'
  use 'machakann/vim-sandwich'

	-- Themes
	use 'folke/tokyonight.nvim'

  -- Stuff?
  use 'tpope/vim-dispatch'
  use 'radenling/vim-dispatch-neovim'
  use 'clojure-vim/vim-jack-in'

  -- Terminals, amirite?
  use 'voldikss/vim-floaterm'

  -- General Language
  use 'p00f/nvim-ts-rainbow'

  -- Specific Lang Stuff --
  -- Clojure
  use {
      'eraserhd/parinfer-rust',
      run = 'cargo build --release'
  }
  use  {
      'Olical/conjure',
      tag = 'v4.24.1'
  }

  --  Go
  use {
    'fatih/vim-go',
    run = ':GoUpdateBinaries'
  } 
end)
