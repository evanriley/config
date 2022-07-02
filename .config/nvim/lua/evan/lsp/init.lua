local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require("evan.lsp.lsp-installer")
require("evan.lsp.handlers").setup()
require("evan.lsp.null-ls")
