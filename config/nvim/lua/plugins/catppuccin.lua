return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            custom_highlights = function(c)
                return {
                    NvimTreeFolderName = { fg = c.mauve },
                    NvimTreeFolderIcon = { fg = c.mauve },
                    NvimTreeOpenedFolderName = { fg = c.mauve },
                    NvimTreeEmptyFolderName = { fg = c.mauve },
                    NvimTreeGitNew = { fg = c.mauve },
                    TelescopeMatching = { fg = c.mauve },
                    TelescopeBorder = { fg = c.mauve },
                    CmpBorder = { fg = c.mauve },
                    CmpDocumentationBorder = { fg = c.mauve },
                    CmpPmenu = { bg = c.base }, -- Background color of cmp menu
                    CmpSel = { bg = c.surface1, fg = c.text }, -- Selected item styling
                    FloatBorder = { fg = c.mauve },
                }
            end,
            integrations = {
                cmp = true,
                gitsigns = true,
                nvimtree = true,
                treesitter = true,
                notify = false,
                mini = {
                    enabled = true,
                    indentscope_color = "",
                },
                telescope = {
                    enabled = true,
                },
                noice = true,
            },
        })
        vim.cmd.colorscheme("catppuccin")
    end,
}
