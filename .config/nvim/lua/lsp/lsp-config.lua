local lspconfig = require('lspconfig')
local lsp_installer = require("nvim-lsp-installer")
local configs = require('lsp.servers')
local utils = require('lsp.utilities')

-- Handlers override
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	silent = true,
	max_height = "10",
	border = "rounded",
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
})

vim.lsp.util.close_preview_autocmd = function(events, winnr)
	events = vim.tbl_filter(function(v)
		return v ~= "CursorMovedI" and v ~= "BufLeave"
	end, events)
	vim.api.nvim_command(
		"autocmd "
			.. table.concat(events, ",")
			.. " <buffer> ++once lua pcall(vim.api.nvim_win_close, "
			.. winnr
			.. ", true)"
	)
end

-- Capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
capabilities.textDocument.codeAction = {
	dynamicRegistration = true,
	codeActionLiteralSupport = {
		codeActionKind = {
			valueSet = (function()
				local res = vim.tbl_values(vim.lsp.protocol.CodeActionKind)
				table.sort(res)
				return res
			end)(),
		},
	},
}

-- LSP Status
require("lsp-status").register_progress()
capabilities.textDocument.completion.completionItem.workDoneProgress = true
capabilities.window.workDoneProgress = true


-- On Attach

local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	require("lsp-status").on_attach(client)
	-- mappings
	local opts = {
		noremap = true,
		silent = true,
	}
	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	local opts = { noremap = true, silent = true }
	buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	buf_set_keymap('n', 'gd', '<Cmd>Telescope lsp_definitions<CR>', { noremap = true })
	buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true })
	buf_set_keymap('n', 'gi', '<Cmd>Telescope lsp_implementations<CR>', { noremap = true })
	buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	buf_set_keymap('n', '<space>D', '<Cmd>Telescope lsp_type_definitions<CR>', { noremap = true })
	buf_set_keymap('n', '<space>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
	buf_set_keymap('n', 'gr', '<Cmd>Telescope lsp_references<CR>', { noremap = true })
	buf_set_keymap('n', 'ca', '<Cmd>Telescope lsp_code_actions<CR>', { noremap = true })
	buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
	buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
	buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
	buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

	if client.resolved_capabilities.document_formatting then
		buf_set_keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting_seq_sync()<CR>", opts)
		vim.cmd([[command! -buffer LspFormat lua vim.lsp.buf.formatting_seq_sync()]])
	elseif client.resolved_capabilities.document_range_formatting then
		buf_set_keymap("x", "<leader>lf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
		vim.cmd([[command! -buffer -range LspRangeFormat lua vim.lsp.buf.range_formatting()]])
	end

	vim.cmd([[
        augroup lsp_echo_diagnostics
            autocmd! * <buffer>
            autocmd CursorHold <buffer> lua require'lsp.utilities'.echo_cursor_diagnostic()
            "autocmd CursorHold <buffer> lua vim.diagnostic.open_float(nil, {scope = "cursor", border = "rounded", focusable = false})
            autocmd CursorMoved <buffer> echo ""
        augroup END
    ]])

	if client.resolved_capabilities.signature_help then
		vim.cmd([[
            augroup lsp_signature_help
                autocmd! * <buffer>
                "autocmd CursorHoldI <buffer> lua vim.lsp.buf.signature_help({focusable = false})
            augroup END
        ]])
	end

	if client.resolved_capabilities.document_highlight then
		vim.cmd([[
            augroup lsp_document_highlight
                autocmd! * <buffer>
                autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                "autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
        ]])
	end
end

for server, config in pairs(configs) do
  lsp_installer.on_server_ready(function(server)
    config.capabilities = capabilities
    config.on_attach = on_attach
    server:setup(config)
  end)
end

-- Commands
vim.cmd([[
command! -nargs=1 -complete=customlist,PythonInterpreterComplete PythonInterpreter lua require'lsp.utilities'.change_python_interpreter(<q-args>)
function! PythonInterpreterComplete(A,L,P) abort
  return v:lua.require('lsp.utilities').get_python_interpreters()
endfunction
]])

local M = {}
M.on_attach = on_attach
M.capabilites = capabilities
return M
