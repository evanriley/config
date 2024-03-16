-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install package manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      { 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },

      -- Additional lua configuration
      'folke/neodev.nvim',
    },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },

  -- Easily hop around
  {
    'phaazon/hop.nvim',
    event = 'BufReadPost',
    name = 'hop',
    config = function()
      local hop = require('hop')
      local directions = require('hop.hint').HintDirection
      vim.keymap.set('', 'f', function()
        hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
      end, { remap = true })
      vim.keymap.set('', 'F', function()
        hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
      end, { remap = true })
      vim.keymap.set('', 't', function()
        hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
      end, { remap = true })
      vim.keymap.set('', 'T', function()
        hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
      end, { remap = true })
      require('hop').setup {
        teasing = false,
      }
    end,
  },

  -- Autopairs
  {
    'echasnovski/mini.pairs',
    version = '*',
    config = function()
      require('mini.pairs').setup {}
    end,
  },

  -- Toggleterm
  {
    'akinsho/toggleterm.nvim',
    keys = { '<C-t>', { '<C-t>', mode = 'n' } },
    config = function()
      local Terminal = require('toggleterm.terminal').Terminal
      local lazygit = Terminal:new {
        cmd = 'lazygit',
        hidden = true,
        dir = 'git_dir',
        direction = 'float',
      }

      function _lazygit_toggle()
        lazygit:toggle()
      end

      require('toggleterm').setup {
        size = function(term)
          if term.direction == 'horizontal' then
            return 15
          elseif term.direction == 'vertical' then
            return vim.o.columns * 0.4
          end
        end,
        open_mapping = [[<c-t>]],
        hide_numbers = true, -- hide the number column in toggleterm buffers
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = '1',   -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
        start_in_insert = true,
        insert_mappings = true, -- whether or not the open mapping applies in insert mode
        persist_size = true,
        direction = 'float',
        close_on_exit = true, -- close the terminal window when the process exits
        shell = vim.o.shell,  -- change the default shell
        float_opts = {
          border = 'single',
          width = 250,
          height = 40,
          winblend = 3,
          highlights = {
            border = 'Normal',
            background = 'Normal',
          },
        },
      }

      -- Open lazygit with toggleterm
      vim.api.nvim_set_keymap('n', '<leader>gg', '<cmd>lua _lazygit_toggle()<CR>', { noremap = true, silent = true })
    end,
  },

  -- Make my sql life easier

  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      'tpope/vim-dadbod',
      'kristijanhusak/vim-dadbod-completion',
    },
    ft = 'sql',
  },

  -- clojure
  {
    'eraserhd/parinfer-rust',
    build = 'cargo build --release',
    ft = 'clojure',
  },

  {
    'Olical/conjure',
    ft = 'clojure',
  },

  -- Better buffer deletion
  {
    'moll/vim-bbye',
    event = 'BufReadPost',
  },

  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk, { buffer = bufnr })
        vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk, { buffer = bufnr })
        vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk, { buffer = bufnr })
      end,
    },
  },

  {
    -- Theme
    'rebelot/kanagawa.nvim',
    priority = 1000,
    config = function()
      require('kanagawa').setup {
        undercurl = false,
        theme = 'wave',
        background = {
          dark = 'wave',
          light = 'lotus',
        },
      }
      vim.cmd.colorscheme 'kanagawa'
    end,
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = false,
        theme = 'kanagawa',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  { import = 'evan.plugins' },
}, {})

-- [[ Setting options ]]
vim.o.backup = false            -- creates a backup file
vim.o.clipboard = 'unnamedplus' -- allows neovim to access the system clipboard
vim.o.cmdheight = 1             -- more space in the neovim command line for displaying messages
vim.o.completeopt = 'menuone,noselect'
vim.o.conceallevel = 0          -- so that `` is visible in markdown files
vim.o.fileencoding = 'utf-8'    -- the encoding written to a file
vim.o.hlsearch = true           -- highlight all matches on previous search pattern
vim.o.ignorecase = true         -- ignore case in search patterns
vim.o.mouse = 'a'               -- allow the mouse to be used in neovim
vim.o.pumheight = 10            -- pop up menu height
vim.o.showmode = false          -- we don't need to see things like -- INSERT -- anymore
vim.o.smartcase = true          -- smart case
vim.o.smartindent = true        -- make indenting smarter again
vim.o.splitbelow = true         -- force all horizontal splits to go below current window
vim.o.splitright = true         -- force all vertical splits to go to the right of current window
vim.o.swapfile = false          -- creates a swapfile
vim.o.termguicolors = true      -- set term gui colors (most terminals support this)
vim.o.timeoutlen = 1000         -- time to wait for a mapped sequence to complete (in milliseconds)
vim.o.undofile = true           -- enable persistent undo
vim.o.updatetime = 300          -- faster completion (4000ms default)
vim.o.writebackup = false       -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.o.expandtab = true          -- convert tabs to spaces
vim.o.shiftwidth = 2            -- the number of spaces inserted for each indentation
vim.o.tabstop = 2               -- insert 2 spaces for a tab
vim.o.cursorline = false        -- don't highlight the current line
vim.o.number = true             -- set numbered lines
vim.o.relativenumber = true
vim.o.laststatus = 3
vim.o.showcmd = false
vim.o.ruler = false
vim.o.numberwidth = 4    -- set number column width to 2 {default 4}
vim.o.signcolumn = 'yes' -- always show the sign column, otherwise it would shift the text each time
vim.o.wrap = false       -- display lines as one long line
vim.o.scrolloff = 12     -- start scrolling when the cursor is 12 lines from the bottom.
vim.o.sidescrolloff = 8
vim.o.wildignore = '*.swp,*.bak,*.pyc,*.class'

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Clear highlights with Esc (and enter becasue muscle memory is weird)
vim.keymap.set('n', '<Esc>', ":noh<CR>", { silent = true })
vim.keymap.set('n', '<CR>', ":noh<CR>", { silent = true })


-- Better window navigation

vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true })


-- Navigate buffers
vim.keymap.set("n", "<S-l>", ":bnext<CR>", { silent = true })
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", { silent = true })

-- Close buffers
vim.keymap.set("n", "<S-q>", "<cmd>Bdelete!<CR>", { silent = true })

-- Better paste
vim.keymap.set("v", "p", '"_dP', { silent = true })
vim.keymap.set("n", "<leader>ya", ":%y+<CR>", { silent = true })

-- [[ Highlight on yank ]]
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Configure Telescope ]]
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>fr', require('telescope.builtin').oldfiles)
vim.keymap.set('n', '<leader>bb', require('telescope.builtin').buffers)
vim.keymap.set('n', '<leader>/', function()
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end)

vim.keymap.set('n', '<leader>ff', require('telescope.builtin').git_files)
vim.keymap.set('n', '<leader>fd', require('telescope.builtin').find_files)
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags)
vim.keymap.set('n', '<leader>fs', require('telescope.builtin').live_grep)
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics)

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  ensure_installed = 'all',

  sync_install = true,

  ignore_install = {},

  auto_install = true,

  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- [[ Configure LSP ]]
local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    vim.keymap.set('n', keys, func, { buffer = bufnr })
  end

  nmap('<leader>rn', vim.lsp.buf.rename)
  nmap('<leader>ca', vim.lsp.buf.code_action)

  nmap('gd', vim.lsp.buf.definition)
  nmap('gr', require('telescope.builtin').lsp_references)
  nmap('gI', vim.lsp.buf.implementation)
  nmap('<leader>D', vim.lsp.buf.type_definition)
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols)
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols)

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover)
  nmap('<C-k>', vim.lsp.buf.signature_help)

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration)
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder)
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder)
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end)

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end)
end

-- Enable the following language servers
local servers = {
  gopls = {},
  rust_analyzer = {},
  html = {},
  cssls = {},
  tsserver = {},
  bashls = {},
  yamlls = {},
  clojure_lsp = {},
  clangd = {},
  elixirls = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end,
}

-- [[ Configure nvim-cmp ]]
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = "nvim_lsp", keyword_length = 3 },
    { name = "nvim_lua", keyword_length = 3 },
    { name = "path" },
    { name = "buffer",   keyword_length = 3 },
    { name = "luasnip" },
  },
}
