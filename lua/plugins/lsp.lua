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

            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            checkThirdParty = false,
                            library = vim.api.nvim_get_runtime_file("", true),
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
        end,
    },
    {
        "mfussenegger/nvim-lint",
        dependencies = {},
        config = function()
            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                callback = function()
                    -- try_lint without arguments runs the linters defined in `linters_by_ft`
                    -- for the current filetype
                    --require("lint").try_lint()

                    -- You can call `try_lint` with a linter name or a list of names to always
                    -- run specific linters, independent of the `linters_by_ft` configuration
                    --require("lint").try_lint("ruff")
                end,
            })
        end,
    },
    {
        "saghen/blink.cmp",
        dependencies = { "rafamadriz/friendly-snippets" },
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
                default = { "lsp", "path", "snippets" },
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

            fuzzy = { implementation = "prefer_rust_with_warning" },
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
