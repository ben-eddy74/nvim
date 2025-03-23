-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- Show Explorer
vim.keymap.set("n", "<leader>ex", vim.cmd.Ex, { desc = "Open explorer" })
-- Move a line up or down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- Move around windows
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
-- Resize windows
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>")
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>")
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>")
-- Buffers
vim.keymap.set("n", "<PageUp>", ":bprevious<CR>")
vim.keymap.set("n", "<PageDown>", ":bnext<CR>")
vim.keymap.set("n", "<leader>d", ":bd<CR>")
-- Set highlight on search but clear on pressing Esc in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
-- Keep curser in the middle when jumping forward or backward
vim.keymap.set("n", "<C-f>", "<C-f>zzzv")
vim.keymap.set("n", "<C-b>", "<C-b>zzzv")
-- Keep curser in the middle when going to next or previous search
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
-- Paste over selection and keep yank buffer
vim.keymap.set("x", "<leader>p", "\"_dP")
-- Toggle line wrap
vim.keymap.set("n", "<C-l>l", ":set wrap!<CR>", { desc = "Toggle line wrap" })
-- LSP: Format buffer
vim.keymap.set("n", "<leader>f", function()
  vim.lsp.buf.format()
end)
-- Telescope: Show keymaps
vim.keymap.set("n", "<leader>?", ":Telescope keymaps<CR>")
-- Comment
vim.keymap.set("n", "<leader>/", ":CommentToggle<CR>")
