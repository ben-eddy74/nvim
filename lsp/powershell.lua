return {
	cmd = {
		"powershell",
		"-NoLogo",
		"-NoProfile",
		"-Command",
		PSes_path .. "\\PowerShellEditorServices\\Start-EditorServices.ps1",
		"-BundledModulesPath " .. PSes_path,
		"-stdio",
		"-SessionDetailsPath ./psessession.json",
		"-LogLevel 'Information'",
	},
	settings = {
		bundle_path = Home_directory .. "/AppData/local/nvim-data/mason/packages/powershell-editor-services",
		powershell = {
			codeFormatting = {
				-- Preset = "OTBS",
				useCorrectCasing = true,
				autoCorrectAliases = true,
				openBraceOnSameLine = false,
				pipelineIndentationStyle = "IncreaseIndentationForFirstPipeline",
			},
			init_options = {
				enableProfileLoading = false,
			},
		},
	},
	filetypes = { "ps1", "psd1", "psm1" },
	root_markers = { "requiredmodules.psd1" },
}
