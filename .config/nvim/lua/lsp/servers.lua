local pyright = {}

local solargraph = {}

local tsserver = {
  on_attach = function(client)
    local ts_utils = require("nvim-lsp-ts-utils")
    ts_utils.setup({})
    ts_utils.setup_client(client)

    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentFormattingProvider = false
    on_attach(client)
  end,
}

local clojure_lsp = {}
local gopls = {}
local jsonls = {}
local sumneko_lua = {}
local fsautocomplete = {}
local zls = {}
local hls = {}
local rust_analyzer = {}
local clangd = {}

local tailwindcss = {}
local html = {}
local cssls = {}
local emmet_ls = {}

local configs = {}

configs.pyright = pyright
configs.solargraph = solargraph
configs.tsserver = tsserver
configs.gopls = gopls
configs.clojure_lsp = clojure_lsp
configs.jsonls = jsonls
configs.sumneko_lua = sumneko_lua
configs.fsautocomplete = fsautocomplete
configs.zls = zls
configs.tailwindcss = tailwindcss
configs.html = html
configs.cssls = cssls
configs.emmet_ls = emmet_ls
configs.hls = hls
configs.rust_analyzer = rust_analyzer

return configs
