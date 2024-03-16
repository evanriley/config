local null_ls = require("null-ls")

local sources = {
  null_ls.builtins.formatting.stylua.with({
    args = { "--indent-width", "2", "--indent-type", "Spaces", "-" },
  }),
  null_ls.builtins.formatting.prettierd,
  null_ls.builtins.formatting.eslint_d,
  -- null_ls.builtins.formatting.goimports,
  null_ls.builtins.formatting.rubocop,
  null_ls.builtins.formatting.rustfmt,

  null_ls.builtins.diagnostics.write_good,

  null_ls.builtins.code_actions.gitsigns,
}

null_ls.setup({
  sources = sources,
  on_attach = require("lsp.lsp-config").on_attach,
  debug = false,
})
