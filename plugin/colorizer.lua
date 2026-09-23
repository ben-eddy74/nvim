vim.pack.add({
	{ src = "https://github.com/Norcalli/nvim-colorizer.lua.git" },
})

require("colorizer").setup({
	"typescript",
	"javascript",
	"css",
	"html",
}, {
	RGB = true,
	RRGGBB = true,
	names = true,
	RRGGBBAA = true,
	rgb_cols = true,
})
