require('kanagawa').setup({
    undercurl = false,           -- enable undercurls
    commentStyle = { italic = false},
    functionStyle = { italic = false, bold = false },
    keywordStyle = { italic = false },
    statementStyle = { bold = true },
    typeStyle = { italic = false, bold = false},
    variablebuiltinStyle = { italic = false },
})

vim.cmd("colorscheme kanagawa")
