-- Completion options
vim.opt.completeopt = { "menu", "menuone", "noselect" }
-- Fat cursor
vim.opt.guicursor = ""
-- Line numbers
vim.opt.nu = true
vim.opt.relativenumber = true
-- Colors
vim.cmd.colorscheme("catppuccin")
vim.o.termguicolors = true
-- Scroll
vim.o.scrolloff = 12
vim.o.signcolumn = "yes"
vim.o.colorcolumn = "80"
-- Tabs
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 2
vim.o.expandtab = true
-- Clipboard
vim.opt.clipboard = "unnamedplus" -- use systems clipboard
-- Shell
vim.o.shell = "powershell.exe"
vim.o.shellcmdflag =
"-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
vim.o.shellredir = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
vim.o.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
vim.o.shellquote = ""
vim.o.shellxquote = "" -- Autocmd
-- Highlight
vim.opt.hlsearch = false
vim.opt.incsearch = true
-- Misc
vim.opt.updatetime = 50
-- Highlight when yanking
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
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
