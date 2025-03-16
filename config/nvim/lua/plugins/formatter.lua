return {
    "stevearc/conform.nvim",
    opts = {
        -- Global configuration for all formatters
        formatters = {
            -- Ensure spaces are used instead of tabs and set tab width to 4 for all formatters
            -- Default for all formatters that support indentation options
            stylua = {
                prepend_args = { "--indent-type", "Spaces", "--indent-width", "4" },
            },
            prettierd = {
                prepend_args = { "--tab-width", "4", "--use-tabs", "false" },
            },
        },
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "black", "isort" },
            javascript = { { "prettierd", "prettier" } },
            -- Add more file types and their respective formatters as needed
        },
        format_on_save = {
            lsp_fallback = true,
            timeout_ms = 500,
        },
        ensure_installed = { "stylua", "black", "prettierd" },
    },
}
