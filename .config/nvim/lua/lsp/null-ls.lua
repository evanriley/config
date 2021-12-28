local null_ls = require("null-ls")

local sources = {
  -- For js,ts,jsx,tsx,etc
  null_ls.builtins.diagnostics.eslint_d,
  null_ls.builtins.code_actions.eslint_d,
  null_ls.builtins.formatting.prettier,

  null_ls.builtins.diagnostics.write_good,

  null_ls.builtins.code_actions.gitsigns,

  null_ls.builtins.code_actions.refactoring,

}

null_ls.setup({
  sources = sources,
  on_attach = require("lsp.lsp-config").on_attach,
  debug = false,
})
