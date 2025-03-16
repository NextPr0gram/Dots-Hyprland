local palette = require("catppuccin.palettes.mocha")
return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        theme = "catppuccin",
        options = {
            component_separators = " | ",
            section_separators = { left = "", right = "" },
        },
        sections = {
            lualine_a = {
                {
                    "mode",
                    color = { bg = palette.mauve },
                    separator = { right = "" },
                },
            },
            lualine_b = {
                {
                    "branch",
                    color = { fg = palette.pink },
                },
            },
            lualine_c = {
                {
                    "filetype",
                    icon_only = true,
                    separator = "",
                    padding = {
                        left = 1,
                        right = 0,
                    },
                },
                { "filename", path = 1, symbols = { modified = " ●", readonly = "", unnamed = "" } },
            },
            lualine_x = { "encoding", "fileformat", "filetype" },
            lualine_y = {
                {
                    "progress",
                    color = { bg = palette.red, fg = palette.base },
                },
            },
            lualine_z = { { "location", color = { bg = palette.flamingo } } },
        },
    },
}
