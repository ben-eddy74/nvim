-- nvim-tree
vim.keymap.set("n", "<leader>e", vim.cmd.NvimTreeToggle, { desc = "Toggle nvim-tree" })

-- Python
vim.keymap.set("n", "<leader>pyb", "<cmd>!uv build<CR>", { desc = "Python: Build python module (uv)" })

-- Powershell
vim.keymap.set(
	"n",
	"<leader>psb",
	'<cmd>!powershell.exe -NoLogo -NoProfile -Command "& { .\\build.ps1 -tasks build }"<CR>',
	{ desc = "PowerShell: Sampler - Build module" }
)
