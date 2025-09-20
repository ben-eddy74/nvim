return {
	cmd = { "vscode-html-language-server", "--stdio" },
	settings = {},
	filetypes = { "html" },
	init_options = {
		provideFormatter = true,
		embeddedLanguages = { css = true, javascript = true },
		configurationSection = { "html", "css", "javascript" },
	},
}
