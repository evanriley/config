require('kanagawa').setup({
    undercurl = true,           -- enable undercurls
    commentStyle = "NONE",
    functionStyle = "NONE",
    keywordStyle = "NONE",
    statementStyle = "bold",
    typeStyle = "NONE",
    variablebuiltinStyle = "NONE",
})

vim.cmd("colorscheme kanagawa")
