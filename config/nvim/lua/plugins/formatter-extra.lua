return {
    "mhartington/formatter.nvim",
    config = function()
        require("formatter").setup({
            filetype = {
                prisma = {
                    function()
                        vim.lsp.buf.format()
                    end,
                },
                -- setup other languages here
            },
        })

        vim.cmd([[
        augroup FormatAutogroup
        autocmd!
        autocmd BufWritePost * FormatWrite
        augroup END
      ]])
    end,
}
