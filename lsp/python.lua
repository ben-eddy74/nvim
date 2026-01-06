return {
	cmd = { "basedpyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml" },
	settings = {
		basedpyright = {
			analysis = {
				useLibraryCodeForTypes = true,
				diagnosticSeverityOverrides = {
					reportUnusedVariable = "warning",
				},
				typeCheckingMode = "off", -- Set type-checking mode to off
				diagnosticMode = "workspace",
			},
		},
	},
}
