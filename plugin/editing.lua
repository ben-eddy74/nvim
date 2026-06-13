-- Editing assistance plugins
vim.pack.add({
	{ src = "https://github.com/echasnovski/mini.pairs" },
	{ src = "https://github.com/echasnovski/mini.surround" },
})

-- Configure mini.pairs (autopairing brackets and quotes)
require("mini.pairs").setup()

-- Configure mini.surround (wrap/unwrap selections with tags, brackets, quotes, etc.)
require("mini.surround").setup()
