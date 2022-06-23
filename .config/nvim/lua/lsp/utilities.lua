local lspconfig = require("lspconfig")

local M = {}

function M.update_settings(client, settings)
    settings = { settings = vim.tbl_deep_extend('force', client.config.settings, settings) }
    client.notify("workspace/didChangeConfiguration", settings)
end


return M
