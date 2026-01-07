return {
	cmd = { "basedpyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml" },
	settings = {
		basedpyright = {
			enabled = true,
			settings = {
				disableOrganizeImports = true,
				basedpyright = {
					analysis = {
						ignore = { "*" },
						typeCheckingMode = "recommended",
						diagnosticMode = "workspace",
						useLibraryCodeForTypes = true,
					},
				},
			},
		},
	},
}
