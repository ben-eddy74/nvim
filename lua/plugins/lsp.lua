return {
	{
		"neovim/nvim-lspconfig",
		opts = {},
		dependencies = {
			"saghen/blink.cmp",
		},
		config = function()
			local lspconfig = require("lspconfig")
			local default_capabilities = vim.lsp.protocol.make_client_capabilities()
			local capabilities = require("blink.cmp").get_lsp_capabilities(default_capabilities)

			local home_directory = os.getenv("HOME")
			if home_directory == nil then
				home_directory = os.getenv("USERPROFILE")
			end

			vim.keymap.set("n", "<leader>lsp", function()
				vim.cmd("MasonInstall powershell-editor-services")
				vim.cmd("MasonInstall lua-language-server")
				vim.cmd("MasonInstall pyright")
				vim.cmd("MasonInstall ruff")
				vim.cmd("MasonInstall html-lsp")
				vim.cmd("MasonInstall typescript-language-server")
			end, { desc = "Install LSP packages" })

			vim.keymap.set("n", "<leader>cf", function()
				if vim.bo.ft == "python" then
					vim.lsp.buf.code_action()
				end
			end)

			lspconfig.powershell_es.setup({
				capabilities = capabilities,
				bundle_path = home_directory
					.. "\\AppData\\local\\nvim-data\\mason\\packages\\powershell-editor-services",
				settings = { powershell = { codeFormatting = { Preset = "OTBS" } } },
			})

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							checkThirdParty = false,
							library = { vim.env.VIMRUNTIME },
						},
					},
				},
			})
			lspconfig.pyright.setup({
				capabilities = capabilities,
				settings = {
					pyright = {
						-- Using Ruff's import organizer
						disableOrganizeImports = true,
					},
					python = {
						analysis = {},
					},
				},
			})
			lspconfig.ruff.setup({
				capabilities = capabilities,
				init_options = {
					settings = {
						lint = {
							ignore = { "F821" },
						},
					},
				},
			})
			lspconfig.ts_ls.setup({})
			lspconfig.html.setup({})
		end,
	},
	{
		"saghen/blink.cmp",
		dependencies = { "rafamadriz/friendly-snippets", "neovim/nvim-lspconfig" },
		-- use a release tag to download pre-built binaries
		version = "*",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = { preset = "default" },

			appearance = {
				-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
			},

			sources = {
				default = { "lsp", "buffer", "snippets", "path" },
				providers = {
					buffer = {
						opts = {
							get_bufnrs = function()
								return vim.tbl_filter(function(bufnr)
									return vim.bo[bufnr].buftype == ""
								end, vim.api.nvim_list_bufs())
							end,
						},
					},
				},
			},

			fuzzy = {
				implementation = "prefer_rust_with_warning",
				prebuilt_binaries = {
					extra_curl_args = { "--insecure" },
				},
			},
			signature = { enabled = true },
		},
		opts_extend = { "sources.default" },
		keys = {
			{
				"<esc>",
				function()
					if vim.snippet then
						vim.snippet.stop()
					end
				end,
				{ desc = "Stop snippet placeholders" },
			},
		},
	},
}
