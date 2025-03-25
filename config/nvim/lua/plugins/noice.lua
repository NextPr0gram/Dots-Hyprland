return {
    "folke/noice.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
    config = function()
        require("noice").setup({
            lsp = {
                override = {
                    ["vim.lsp.util.show_line_diagnostics"] = true,
                    ["vim.lsp.util.open_floating_preview"] = true,
                },
            },
            presets = {
                command_palette = true, -- Fancy command menu
                lsp_doc_border = true, -- Border around hover docs
            },
        })
    end,
}
