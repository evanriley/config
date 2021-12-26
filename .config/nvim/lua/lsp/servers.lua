local lspconfig = require("lspconfig")

local pyright = {}

local solargraph = {}

local rust_analyzer = {}

local tsserver = {}

local clojure_lsp = {}

local gopls = {}

local jsonls = {}
local sumneko_lua = {}

local configs = {}

configs.pyright = pyright
configs.solargraph = solargraph
configs.rust_analyzer = rust_analyzer
configs.tsserver = tsserver
configs.gopls = gopls
configs.clojure_lsp = clojure_lsp
configs.jsonls = jsonls
configs.sumneko_lua = sumneko_lua

return configs
