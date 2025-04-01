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

            vim.keymap.set("n", "<leader>lsp", function()
                vim.cmd("MasonInstall lua-language-server")
                vim.cmd("MasonInstall pyright")
                vim.cmd("MasonInstall ruff")
            end
            , { desc = "Install LSP packages" })

            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            checkThirdParty = false,
                            library = { vim.env.VIMRUNTIME }
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
        keys = {
            { "<leader>cf", "<cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "Show code actions" } }
        }
    },
    {
        "saghen/blink.cmp",
        dependencies = { "rafamadriz/friendly-snippets", "neovim/nvim-lspconfig", },
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
