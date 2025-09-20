return {
	cmd = {
		"pwsh",
		"-NoLogo",
		"-NoProfile",
		"-Command",
		PSes_path .. "\\PowerShellEditorServices\\Start-EditorServices.ps1",
		"-BundledModulesPath " .. PSes_path,
		"-stdio",
		"-SessionDetailsPath $ENV:USERPROFILE/pwessession.json",
	},
	settings = {
		bundle_path = Home_directory .. "/AppData/local/nvim-data/mason/packages/powershell-editor-services",
		powershell = {
			codeFormatting = { Preset = "OTBS" },
			init_options = {
				enableProfileLoading = false,
			},
		},
	},
	filetypes = { "ps1", "psd1" },
	root_markers = { "requiredmodules.psd1" },
}
