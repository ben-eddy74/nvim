return {
    {
        "stevearc/conform.nvim",
        dependencies = {
            "williamboman/mason.nvim",
        },
        event = { "BufWritePre" },
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "ruff_format" },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_fallback = true,
            },
        },
        --config = function(_, opts)
        --	require("conform").setup(opts)
        --end,
        keys = {
            { "<leader>f", "<cmd>lua vim.lsp.buf.format()<CR>", "Format current buffer" },
        },
    },
    --	{
    --		"mhartington/formatter.nvim",
    --		config = function()
    --			local util = require("formatter.util")
    --			require("formatter").setup({
    --				filetype = {
    --					-- Formatter configurations for filetype "lua" go here
    --					-- and will be executed in order
    --					lua = {
    --						-- "formatter.filetypes.lua" defines default configurations for the
    --						-- "lua" filetype
    --						require("formatter.filetypes.lua").stylua,
    --						require("formatter.filetypes.python").ruff,
    --					},
    --				},
    --			})
    --			local augroup = vim.api.nvim_create_augroup
    --			local autocmd = vim.api.nvim_create_autocmd
    --			augroup("__formatter__", { clear = true })
    --			autocmd("BufWrite", {
    --				group = "__formatter__",
    --				command = ":FormatWrite",
    --			})
    --		end,
    --		keys = {
    --			{ "<leader>f", "<cmd>Format<CR>", { desc = "Format current buffer" } },
    --		},
    --	},
}
