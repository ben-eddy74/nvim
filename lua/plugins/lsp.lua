return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "saghen/blink.cmp",
        },
        opts = {},
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
                vim.cmd("MasonInstall eslint_d")
            end, { desc = "Install LSP packages" })

            vim.keymap.set("n", "<leader>cf", function()
                vim.lsp.buf.code_action()
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

            lspconfig.html.setup({
                capabilities = capabilities,
            })

            lspconfig.ts_ls.setup({
                capabilities = capabilities,
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

            completion = {
                accept = {
                    auto_brackets = {
                        enabled = false,
                    },
                },
                documentation = {
                    auto_show = true,
                },
                menu = {
                    border = "rounded",
                },
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
            signature = {
                enabled = true,
                window = {
                    show_documentation = false,
                },
            },
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
    {
        "mfussenegger/nvim-lint",
        config = function()
            vim.env.ESLINT_D_PPID = vim.fn.getpid()
            require("lint").linters_by_ft = {
                javascript = { "eslint_d" },
            }
        end,
    },
    {
        "stevearc/conform.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
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
