return {
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter", -- Make sure this plugin loads after nvim-treesitter
    config = function()
        require("nvim-treesitter.configs").setup({
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true, -- Enable lookahead when selecting textobjects
                    keymaps = {
                        -- Select text objects
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                        ["ap"] = "@parameter.outer",
                        ["ip"] = "@parameter.inner",
                        ["as"] = "@scope.outer",
                        ["is"] = "@scope.inner",
                    },
                },
            },
        })
    end,
}
