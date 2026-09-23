-- Git integration plugins
vim.pack.add({
	{ src = "https://github.com/lewis6991/gitsigns.nvim.git" },
})

-- Configure gitsigns
require("gitsigns").setup({
	signs = {
		add          = { text = "┃" },
		change       = { text = "┃" },
		delete       = { text = "_" },
		topdelete    = { text = "‾" },
		changedelete = { text = "~" },
		untracked    = { text = "┆" },
	},
})
