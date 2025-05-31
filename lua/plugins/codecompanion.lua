return {
    {
        "olimorris/codecompanion.nvim",
        config = true,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            adapters = {
                mylama = function()
                    return require("codecompanion.adapters").extend("ollama", {
                        name = "mylama",
                        schema = {
                            model = {
                                default = "qwen3:8b",
                            },
                            num_ctx = {
                                default = 16384,
                            },
                            num_predict = {
                                default = -1,
                            },
                        },
                    })
                end,
            },
            strategies = {
                chat = {
                    adapter = "mylama",
                },
                inline = {
                    adapter = "mylama",
                },
            },
        },
    },
}
