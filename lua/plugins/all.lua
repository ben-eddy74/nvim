return {
	{ "yorickpeterse/nvim-window", opts = {} },
	{ "folke/which-key.nvim", opts = {} },
	{ "mason-org/mason.nvim", opts = {} },
	{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			close_if_last_window = true,
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},
	{
		"stevearc/conform.nvim",
		opts = {
			event = { "BufWritePre" },
			-- Define your formatters
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_format" },
			},
			format_after_save = {
				lsp_format = "fallback",
			},
		},
	},
	{ "folke/tokyonight.nvim", priority = 1000, opts = {} },
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		lazy = false,
		build = ":TSUpdate",
		config = function() end,
	},
	{
		"nvim-telescope/telescope.nvim",
		branch = "master",
		opts = {},
	},
	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		dependencies = { "rafamadriz/friendly-snippets" },

		-- use a release tag to download pre-built binaries
		version = "1.*",

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- See :h blink-cmp-config-keymap for defining your own keymap
			keymap = { preset = "default" },

			appearance = {
				nerd_font_variant = "mono",
			},

			completion = {
				accept = {
					auto_brackets = {
						enabled = false,
					},
				},
				documentation = { auto_show = true },
				ghost_text = { enabled = true },
				menu = {
					border = "rounded",
					draw = {
						columns = {
							{ "label", "label_description", gap = 1 },
							{ "kind_icon", "kind", gap = 1 },
							{ "source_name" },
						},
					},
				},
			},

			sources = {
				default = { "lsp", "buffer", "snippets", "path" },
				providers = {
					lsp = { fallbacks = {} },
				},
			},

			-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
		fuzzy = { implementation = "prefer_rust_with_warning" },
		signature = {
			enabled = true,
			window = { show_documentation = false },
		},
	},
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
	{
		"piersolenski/import.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		opts = {
			picker = "telescope",
		},
		keys = {
			{
				"<leader>ci",
				function()
					require("import").pick()
				end,
				desc = "Import",
			},
		},
	},
}
