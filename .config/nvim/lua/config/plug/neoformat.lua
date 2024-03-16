vim.cmd("let g:neoformat_run_all_formatters = 1")
vim.cmd("let g:neoformat_enabled_javascript = ['prettier', 'eslint_d']")
vim.cmd("let g:neoformat_enabled_typescript = ['prettier', 'eslint_d']")
vim.cmd("au BufWritePre *.js,*.ts,*.scss,*.rb Neoformat")
