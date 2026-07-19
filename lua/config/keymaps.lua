-- nvim-tree
vim.keymap.set("n", "<leader>e", vim.cmd.NvimTreeToggle, { desc = "Toggle nvim-tree" })

-- Close all buffers
vim.keymap.set("n", "<leader>bda", ":bd|e#<CR>", { desc = "Delete all buffers except current" })
vim.keymap.set("n", "<leader>bw", ":bufdo bwipeout<CR>", { desc = "Wipe out all buffers" })

-- Noice shortcuts
vim.keymap.set("n", "<leader>nh", ":Noice history<CR>", { desc = "Open message history" })
vim.keymap.set("n", "<leader>ne", ":Noice errors<CR>", { desc = "Open message history, filtered to show only errors" })

-- Python
vim.keymap.set(
	"n",
	"<leader>pyb",
	"<cmd>split | terminal uv build<CR><cmd>startinsert<CR>",
	{ desc = "Python: Build python module (uv)" }
)

-- Powershell
vim.keymap.set(
	"n",
	"<leader>psb",
	'<cmd>split | terminal powershell.exe -NoLogo -NoProfile -Command "& { .\\build.ps1 -tasks build }"<CR><cmd>startinsert<CR>',
	{ desc = "PowerShell: Sampler - Build module" }
)
