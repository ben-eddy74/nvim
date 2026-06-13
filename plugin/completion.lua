-- Auto-completion & Neovim Lua API helper plugins
vim.pack.add({
	{ src = "https://github.com/Saghen/blink.lib.git" },
	{ src = "https://github.com/Saghen/blink.cmp.git" },
	{ src = "https://github.com/folke/lazydev.nvim.git" },
})

-- Configure lazydev (replaces neodev.nvim)
require("lazydev").setup()

-- Configure blink.cmp
require("blink.cmp").setup({
	keymap = {
		preset = "default",
		["<Tab>"] = { "accept", "snippet_forward", "fallback" },
		["<S-Tab>"] = { "snippet_backward", "fallback" },
	},
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	fuzzy = {
		implementation = "lua",
	},
})
