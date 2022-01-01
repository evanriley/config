local null_ls = require("null-ls")

local sources = {
  -- For js,ts,jsx,tsx,etc
  null_ls.builtins.code_actions.eslint,
  null_ls.builtins.formatting.prettierd,
  -- For go
  null_ls.builtins.formatting.goimports,
  null_ls.builtins.formatting.gofmt,

  -- English is hard.
  null_ls.builtins.diagnostics.write_good.with({
    filetypes = { "markdown", "gitmessage" }
  }),

  null_ls.builtins.code_actions.gitsigns,

  null_ls.builtins.code_actions.refactoring,

}

null_ls.setup({
  sources = sources,
  on_attach = require("lsp.lsp-config").on_attach,
  debug = false,
})
