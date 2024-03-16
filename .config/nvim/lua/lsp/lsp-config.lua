local lspconfig = require("lspconfig")

local borders = { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" }


-- Handlers Overrides

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    silent = true,
    max_height = "10",
    border = borders,
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = borders,
})

vim.lsp.buf.rename = function(new_name, options)
    options = options or {}

    local filter = function(client)
        return not vim.tbl_contains({ "null-ls" }, client.name)
    end

    options.filter = options.filter or filter

    lsprename(new_name, options)
end

-- Capabilities

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.workDoneProgress = true

-- On Attach
local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

-- Mappings
    local opts = { noremap = true, silent = true, buffer = bufnr }
    -- vim.keymap.set("n", "gd", require("telescope.builtin").lsp_defintions, { unpack(opts), desc = "Go to LSP definition"})
    vim.keymap.set(
        "n",
        "gd",
        require("telescope.builtin").lsp_definitions,
        { unpack(opts), desc = "Go to LSP definition" }
    )
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { unpack(opts), desc = "Go to LSP declaration"})
    vim.keymap.set("n", "K",  vim.lsp.buf.hover, { unpack(opts), desc = "LSP Hover" })
    vim.keymap.set("n", "gi", require("telescope.builtin").lsp_implementations, {  unpack(opts), desc = "Go to LSP implementations" })
    vim.keymap.set({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, { unpack(opts), desc = "Show LSP signature help" })
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { unpack(opts), desc = "Add LSP workspace folder" })
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { unpack(opts), desc = "Remove LSP workspace folder" })
    vim.keymap.set("n", "<leader>wl", require("telescope.builtin").lsp_dynamic_workspace_symbols, { unpack(opts), desc = "List LSP workspace symbols" })
    vim.keymap.set("n", "<leader>D", require("telescope.builtin").lsp_type_definitions, { unpack(opts), desc = "Go to LSP type definitions" })
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { unpack(opts), desc = "LSP rename" })
    vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, { unpack(opts), desc = "Go to LSP references" })
    vim.keymap.set("n", "ca", vim.lsp.buf.code_action, { unpack(opts), desc = "List LSP Code Actions" })

    if client.server_capabilities.documentFormattingProvider then
        -- set eventignore=all
        vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { unpack(opts), desc = "LSP format" })
        vim.api.nvim_buf_create_user_command(
            bufnr,
            "LspFormat",
            vim.lsp.buf.format,
            { range = false, desc = "LSP format" }
        )
    end

    if client.server_capabilities.documentRangeFormattingProvider then
        vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr(#{timeout_ms:250})")
        vim.keymap.set("x", "<leader>lf", vim.lsp.buf.range_formatting, { unpack(opts), desc = "LSP range format" })
        vim.api.nvim_buf_create_user_command(bufnr, "LspRangeFormat", vim.lsp.buf.range_formatting, { range = true, desc = "LSP range format" })
    end

    if client.server_capabilities.documentHighlightProvider then
        local lsp_references_au_id = vim.api.nvim_create_augroup("LSP_references", { clear = true })
        vim.api.nvim_create_autocmd("CursorHold", { callback = vim.lsp.buf.document_highlight, buffer = bufnr, group = lsp_references_au_id, desc = "LSP document highlight", })
        vim.api.nvim_create_autocmd("CursorMoved", { callback = vim.lsp.buf.clear_references, buffer = bufnr, group = lsp_references_au_id, desc = "Clear LSP document highlight", })
    end

end

local function make_config(server_name)
    local ok, config = pcall(require, "lsp.servers" .. server_name)
    if not ok then
        config = {}
    end
    local client_on_attach = config.on_attach
    if client_on_attach then
        config.on_attach = function(client, bufnr)
            on_attach(client, bufnr)
            client_on_attach(client, bufnr)
        end
    else
        config.on_attach = on_attach
    end
    config.capabilites = capabilities
    return config
end

local servers = {
    "ccls",
    "marksman",
    "tsserver",
    "gopls",
    "rust_analyzer",
}

for _, server in ipairs(servers) do
    -- call make_config() before trying to access lspconfig[server] to ensure
    -- registering custom servers
    local config = make_config(server)
    lspconfig[server].setup(config)
end

M = {}
M.on_attach = on_attach
M.capabilities = capabilities
M.borders = borders
return M
