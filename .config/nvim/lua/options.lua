local g = vim.g
local o = vim.o

o.termguicolors    = true -- enable gui colors for terminal
o.background       = "dark"
g.vimsyn_embed     = 'lPr'
g.tex_flavor       = 'latex'
o.encoding         = "utf-8"
o.modeline         = true
o.errorbells       = false
o.mouse            = 'a'
o.visualbell       = false
o.history          = 1000
o.undolevels       = 1000
o.title            = true
o.backup           = false
o.swapfile         = false
o.undofile         = true
o.wrap             = false
o.tabstop          = 2
o.shiftwidth       = o.tabstop
o.shiftround       = true
o.expandtab        = true
o.backspace        = 'indent,eol,start'
o.autoindent       = true
o.smartindent      = true
o.copyindent       = true
o.number           = true
o.showmatch        = true
o.ignorecase       = true
o.smartcase        = true
o.smarttab         = true
o.hlsearch         = true
o.incsearch        = true
o.hidden           = true
o.wildignore       = '*.swp,*.bak,*.pyc,*.class'
o.wildmode         = 'longest,full'
o.wildmenu         = true
o.wildcharm        = 26
o.wildignorecase   = true
o.clipboard        = 'unnamed,unnamedplus'
o.showcmd          = true
o.sidescroll       = 1
o.conceallevel     = 2
o.completeopt      = 'menu,menuone,noselect'
o.pumheight        = 15
o.inccommand       = 'split'
o.cmdheight        = 1
o.listchars        = "tab:|.,trail:_,extends:>,precedes:<,nbsp:~,eol:¬"
o.signcolumn       = 'yes'
o.splitbelow       = true
o.splitright       = true
vim.opt.shortmess:append({ c = true })
vim.opt.wildoptions:append({'pum'})
