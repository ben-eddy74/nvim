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
        keys = {
            { "<leader>f", "<cmd>lua vim.lsp.buf.format()<CR>", "Format current buffer" },
        },
    },
}
