return {
	cmd = { "ruff", "server" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
	on_attach = function(client, _)
		-- lsp use ruff to formatter
		client.server_capabilities.documentFormattingProvider = false -- enable vim.lsp.buf.format()
		client.server_capabilities.documentRangeFormattingProvider = false -- formatting will be used by confirm.nvim
	end,
	settings = {
		init_options = {
			settings = {
				args = {
					"--ignore",
					"F821",
					"--ignore",
					"E712",
				},
			},
		},
	},
}
