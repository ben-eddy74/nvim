return {
	cmd = { "pyright-langserver", "--stdio" },
	settings = {
		pyright = {
			-- Using Ruff's import organizer
			disableOrganizeImports = true,
			disableTaggedHints = true,
		},
		python = {
			analysis = {},
		},
	},
	filetypes = { "python" },
	root_markers = { "pyproject.toml" },
}
