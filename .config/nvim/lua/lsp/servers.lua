local buf_map = function(bufnr, mode, lhs, rhs, opts)
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
        silent = true,
    })
end

local pyright = {}

local solargraph = {}

local tsserver = {
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false

    local ts_utils = require("nvim-lsp-ts-utils")
    ts_utils.setup({})
    ts_utils.setup_client(client)

    buf_map(bufnr, "n", "ts", ":TSLspOrganize<CR>")
    buf_map(bufnr, "n", "ti", ":TSLspRenameFile<CR>")
    buf_map(bufnr, "n", "to", ":TSLspImportAll<CR>")

    on_attach(client, bufnr)
  end,
}

local clojure_lsp = {}

local gopls = {}

local jsonls = {}

local sumneko_lua = {}

local fsautocomplete = {}

local configs = {}

configs.pyright = pyright
configs.solargraph = solargraph
configs.tsserver = tsserver
configs.gopls = gopls
configs.clojure_lsp = clojure_lsp
configs.jsonls = jsonls
configs.sumneko_lua = sumneko_lua
configs.fsautocomplete = fsautocomplete

return configs
