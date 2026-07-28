vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter.git" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-context.git" },
})

-- Initialize treesitter
require("nvim-treesitter").setup({
	ensure_installed = { "javascript", "typescript", "html", "css", "lua", "vim", "vimdoc", "query", "robot" },
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})

-- Initialize treesitter context (sticky scroll headers)
require("treesitter-context").setup({
	enable = true, -- Enable this plugin (can be toggled by `:TSContextToggle`)
	max_lines = 3, -- How many lines the window should span. Values <= 0 mean no limit.
	min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
	line_numbers = true,
	multiline_threshold = 20, -- Maximum number of lines to show for a single context
	trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded
	mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
	separator = nil, -- Separator between context and content. Should be a single character string, like '-'.
	zindex = 20, -- The Z-index of the context window
	on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
})

-- Enable Native Treesitter Highlighting
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "javascript", "typescript", "html", "css", "lua", "vim", "vimdoc", "query", "robot" },
	callback = function()
		vim.treesitter.start()
	end,
})
