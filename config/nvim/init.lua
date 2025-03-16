require("config.lazy")

-- Tab configuration
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set relativenumber")
vim.opt.swapfile = false
vim.api.nvim_set_keymap("", "<C-v>", "+p<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("!", "<C-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<C-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-v>", "<C-R>+", { noremap = true, silent = true })

if vim.g.neovide then
    -- config only for neovide
    vim.o.guifont = "JetBrainsMono Nerd Font:h10.5"
    vim.g.neovide_scale_factor = 1
    vim.opt.linespace = 1
    vim.g.neovide_floating_shadow = false
    vim.g.neovide_cursor_trail_size = 0.82
    vim.keymap.set("v", "<C-c>", '"+y') -- Copy
    vim.keymap.set("n", "<C-v>", '"+P') -- Paste normal mode
    vim.keymap.set("v", "<C-v>", '"+P') -- Paste visual mode
    vim.keymap.set("c", "<C-v>", "<C-R>+") -- Paste command mode
    vim.keymap.set("i", "<C-v>", '<ESC>l"+Pli') -- Paste insert mode
end
