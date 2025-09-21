return {
	cmd = { "vscode-html-language-server", "--stdio" },
	settings = {},
	filetypes = { "html", "javascript" },
	init_options = {
		provideFormatter = true,
		embeddedLanguages = { css = true, javascript = true },
		configurationSection = { "html", "css", "javascript" },
	},
}
