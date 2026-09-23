-- Configure Neovim 0.12 native diagnostics
vim.diagnostic.config({
	virtual_text = {
		spacing = 4,
		source = "if_many",
		prefix = "●",
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.INFO] = " ",
			[vim.diagnostic.severity.HINT] = "󰠠 ",
		},
	},
	update_in_insert = false,
	underline = true,
	severity_sort = true,
	float = {
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})

-- Install and configure Trouble.nvim for rich diagnostics panel views
vim.pack.add({
	{ src = "https://github.com/folke/trouble.nvim.git" },
})

require("trouble").setup({
	auto_close = true,
})

-- Keybindings for Trouble diagnostics panel
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics: Toggle project panel" })
vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Diagnostics: Toggle current buffer panel" })
vim.keymap.set("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "LSP: Document Symbols panel" })
vim.keymap.set("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { desc = "LSP: Definitions/References panel" })
