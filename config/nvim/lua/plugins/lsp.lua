return {
    -- Mason: Portable package manager for Neovim
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    -- Mason LSPconfig: Bridges Mason with nvim-lspconfig
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                -- List of servers to automatically install if not already installed
                ensure_installed = { "lua_ls", "pyright", "ts_ls" },
            })
        end,
    },
    -- LSPconfig: Quickstart configurations for the Nvim LSP client
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            vim.diagnostic.config({
                virtual_text = true, -- You can enable virtual text for inline diagnostics
                signs = true, -- Enable diagnostic signs in the gutter
                update_in_insert = true, -- Update diagnostics while typing in insert mode
                float = {
                    border = "rounded", -- Choose your border style (single, double, rounded, solid, shadow, etc.)
                    source = "always", -- Always show the source of the diagnostic (e.g., LSP)
                    header = "", -- Customize the header text (empty for no header)
                    prefix = " ", -- Prefix to the diagnostic message (e.g., add a space or symbol)
                },
            })

            -- Lua Language Server Configuration
            lspconfig.lua_ls.setup({
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" }, -- Prevent undefined 'vim' warning
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true), -- Recognize Neovim runtime files
                            checkThirdParty = false, -- Avoid annoying popup
                        },
                        telemetry = { enable = false }, -- Disable telemetry for privacy
                    },
                },
            })

            lspconfig.pyright.setup({})
            lspconfig.ts_ls.setup({})
        end,
    },
}
