vim.lsp.enable("html")
vim.lsp.enable("luals")
vim.lsp.enable("powershell")
vim.lsp.enable("python")
vim.lsp.enable("ruff")
vim.lsp.enable("typescript")

-- LSP
vim.diagnostic.config({
	virtual_lines = {
		current_line = true,
	},
})

vim.lsp.config("*", {
	capabilities = require("blink.cmp").get_lsp_capabilities(),
})

vim.keymap.set("n", "<leader>ca", function()
	vim.lsp.buf.code_action()
end, { desc = "Trigger code action menu" })
