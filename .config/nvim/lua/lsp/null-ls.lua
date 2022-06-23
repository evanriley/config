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

local on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set(
        "n",
        "ca",
        vim.lsp.buf.code_action,
        { unpack(opts), desc = "List LSP Code Actions" }
    )
    vim.keymap.set(
        "x",
        "ca",
        ":<C-u>lua vim.lsp.buf.range_code_action()<cr>", --https://github.com/neovim/neovim/issues/18340
        { unpack(opts), desc = "List LSP Code Actions for selected range" }
    )
    -- if client.server_capabilities.documentFormattingProvider then
    --     -- set eventignore=all
    --     vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { unpack(opts), desc = "LSP format" })
    --     vim.api.nvim_buf_create_user_command(
    --         bufnr,
    --         "LspFormat",
    --         vim.lsp.buf.format,
    --         { range = false, desc = "LSP format" }
    --     )
    -- end

    if client.server_capabilities.documentRangeFormattingProvider then
        vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr(#{timeout_ms:250})")
        vim.keymap.set("x", "<leader>lf", vim.lsp.buf.range_formatting, { unpack(opts), desc = "LSP range format" })
        vim.api.nvim_buf_create_user_command(
            bufnr,
            "LspRangeFormat",
            vim.lsp.buf.range_formatting,
            { range = true, desc = "LSP range format" }
        )
    end
end

null_ls.setup({
    sources = sources,
    on_attach = on_attach,
    debug = false,
})
