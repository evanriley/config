require("ultest").setup({})

vim.api.nvim_set_keymap('n', '<leader>ut', '<cmd>Ultest<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>us', '<cmd>UltestSummary<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>ud', '<cmd>UltestDebugNearest<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>uo', '<cmd>UltestOutput<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>un', '<cmd>UltestNearest<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>ul', '<cmd>UltestLast<cr>', {noremap = true})
