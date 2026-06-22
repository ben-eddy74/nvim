local on_attach = function(client, bufnr)
	-- Native Neovim 0.11/0.12 already sets up LSP keymaps like:
	-- grn (rename), gra (code action), grr (references), gri (implementation), gO (outline)
end

vim.pack.add({
	{ src = "https://github.com/mason-org/mason.nvim.git" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim.git" },
	{ src = "https://github.com/neovim/nvim-lspconfig.git" },
})

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "basedpyright", "vtsls", "html", "cssls", "powershell_es", "lemminx" },
	handlers = {
		function(server_name)
			vim.lsp.enable(server_name)
		end,
	},
})

-- keybindings
vim.keymap.set("n", "<leader>ca", function()
	vim.lsp.buf.code_action()
end, { desc = "LSP: Trigger code action menu" })
vim.keymap.set("n", "<leader>li", "<cmd>checkhealth vim.lsp<CR>", { desc = "LSP: Check heath" })

-- Configure basedpyright
vim.lsp.config("basedpyright", {
	filetypes = { "python" },
	on_attach = on_attach,
	root_markers = { "pyproject.toml", "requirements.txt" },
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				typeCheckingMode = "basic",
			},
		},
	},
})

-- Configure vtsls (TypeScript & Lit template literals)
vim.lsp.config("vtsls", {
	on_attach = on_attach,
	settings = {
		typescript = {
			tsserver = {
				pluginPaths = { "./node_modules" },
			},
		},
		vtsls = {
			tsserver = {
				globalPlugins = {
					{
						name = "ts-lit-plugin",
						enableForWorkspaceTypeScriptVersions = true,
					},
				},
			},
		},
	},
})

-- Configure html and cssls for Lit template literals autocomplete
vim.lsp.config("html", {
	on_attach = on_attach,
	filetypes = { "html", "typescript", "javascript", "typescriptreact", "javascriptreact" },
})

vim.lsp.config("cssls", {
	on_attach = on_attach,
	filetypes = { "css", "typescript", "javascript", "typescriptreact", "javascriptreact" },
})

-- Configure lua_ls to recognize Neovim's globals and runtime
vim.lsp.config("lua_ls", {
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					vim.env.VIMRUNTIME,
				},
				useGitIgnore = true,
				checkThirdParty = false,
			},
			telemetry = {
				enable = false,
			},
		},
	},
})
