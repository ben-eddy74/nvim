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
                llama3 = function()
                    return require("codecompanion.adapters").extend("ollama", {
                        name = "mylama",
                        schema = {
                            model = {
                                default = "codestral:latest",
                            },
                            num_ctx = {
                                default = 16384,
                            },
                            num_predict = {
                                default = -1,
                            },
                        },
                    })
                end
            },
            strategies = {
                chat = {
                    adapter = "ollama",
                },
                inline = {
                    adapter = "ollama",
                },
            },
        },
    },
}
