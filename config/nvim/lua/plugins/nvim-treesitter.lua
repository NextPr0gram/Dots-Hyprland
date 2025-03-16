return {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate", -- Update treesitter parsers after installation
    opts = {
        ensure_installed = {
            "bash",
            "c",
            "diff",
            "html",
            "javascript",
            "jsdoc",
            "json",
            "jsonc",
            "lua",
            "luadoc",
            "luap",
            "markdown",
            "markdown_inline",
            "printf",
            "python",
            "query",
            "regex",
            "toml",
            "tsx",
            "typescript",
            "vim",
            "vimdoc",
            "xml",
            "yaml",
        },
        highlight = {
            enable = true, -- Enable Treesitter-based highlighting
            additional_vim_regex_highlighting = false,
            disable = {}, -- List of languages to disable highlighting
        },
        indent = {
            enable = true, -- Enable Treesitter-based indentation
        },
    },
}
