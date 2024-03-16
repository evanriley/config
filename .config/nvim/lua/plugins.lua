return require('packer').startup(function()
	-- Let packer manage itself
	use 'wbthomason/packer.nvim'	

	-- LSP stuff
	use 'neovim/nvim-lspconfig'
	use 'kabouzeid/nvim-lspinstall'
	use 'hrsh7th/nvim-compe'

	-- Editor cstuff
	use 'windwp/nvim-autopairs'
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
	use 'phaazon/hop.nvim'
  use 'machakann/vim-sandwich'
	-- Themes
	use 'folke/tokyonight.nvim'

end)
