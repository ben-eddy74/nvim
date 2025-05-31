-- require('keymaps')
-- require('config.lazy')
-- require('options')
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })

    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Various options
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.guicursor = ""            -- Fat cursor
vim.opt.clipboard = "unnamedplus" -- use systems clipboard
vim.opt.ignorecase = true
vim.opt.smartcase = true          -- Override the 'ignorecase' option if the search pattern contains upper case characters
-- Scroll
vim.opt.scrolloff = 12
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"
-- Resize windows
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>")
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>")
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>")
-- Buffers
vim.keymap.set("n", "<PageUp>", ":bprevious<CR>")
vim.keymap.set("n", "<PageDown>", ":bnext<CR>")
vim.keymap.set("n", "<leader>d", ":bd<CR>")
vim.keymap.set("n", "<leader>ft", ":= vim.bo.filetype<CR>", { desc = "Get filetype of current buffer" })
-- Set highlight on search but clear on pressing Esc in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc><Esc>", "<cmd>nohlsearch<CR>")
-- Keep curser in the middle when jumping forward or backward
vim.keymap.set("n", "<C-f>", "<C-f>zzzv")
vim.keymap.set("n", "<C-b>", "<C-b>zzzv")
-- Keep curser in the middle when going to next or previous search
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Highlight yanking
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("custom-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- remove trailing spaces
vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
        -- Save cursor position to restore later
        local curpos = vim.api.nvim_win_get_cursor(0)
        -- Search and replace trailing whitespaces
        vim.cmd([[keeppatterns %s/\s\+$//e]])
        vim.api.nvim_win_set_cursor(0, curpos)
    end,
})

-- Custom file types
vim.filetype.add({
    pattern = {
        [".*ansible/.*.yml"] = "ansible",
    },
})
-- Quickfix navigation
vim.keymap.set("n", "<leader>qn", "<cmd>cnext<CR>", { desc = "Go to next quickfix list entry" })
vim.keymap.set("n", "<leader>qp", "<cmd>cprevious<CR>", { desc = "Go to previous quickfix list entry" })

-- Terminal
--- remove line numbers
vim.api.nvim_create_autocmd("TermOpen", {
    group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
    callback = function()
        vim.opt.number = false
        vim.opt.relativenumber = false
    end,
})
--- Open small terminal in split
vim.keymap.set("n", "<leader>st", function()
    vim.cmd.vnew()
    vim.cmd.term()
    vim.cmd.wincmd("J")
    vim.api.nvim_win_set_height(0, 14)
end, { desc = "Open small terminal window" })

-- LSP
--- Disable semanticTokensProvider
vim.api.nvim_create_autocmd("LspDetach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        client.server_capabilities.semanticTokensProvider = nil
    end,
})

--
-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- import your plugins
        { import = "plugins" },
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "habamax" } },
    -- automatically check for plugin updates
    checker = { enabled = true },
})
