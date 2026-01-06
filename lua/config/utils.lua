-- Install packages via Mason
--
vim.keymap.set("n", "<leader>mi", function()
	vim.cmd("MasonInstall powershell-editor-services")
	vim.cmd("MasonInstall lua-language-server")
	vim.cmd("MasonInstall basedpyright")
	vim.cmd("MasonInstall ruff")
	vim.cmd("MasonInstall html-lsp")
	vim.cmd("MasonInstall typescript-language-server")
	vim.cmd("MasonInstall eslint_lsp") -- javascript linter
	vim.cmd("MasonInstall stylua")
	vim.cmd("MasonInstall prettier")
	vim.cmd("MasonInstall taplo")
	vim.cmd("MasonInstall markdownlint")
end, { desc = "Install lsp's, formatters etc using Mason" })

-- Code actions
--
vim.keymap.set("n", "<leader>ca", function()
	vim.lsp.buf.code_action()
end, { desc = "Trigger code action menu" })

-- Python
--
vim.keymap.set("n", "<leader>pyb", "<cmd>!uv build<CR>", { desc = "UV: Build python module" })

-- Powershell
--
vim.keymap.set(
	"n",
	"<leader>psb",
	'<cmd>!powershell.exe -NoLogo -NoProfile -Command "& { .\\build.ps1 -tasks build }"<CR>',
	{ desc = "Sampler: Build module" }
)
