return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		adapters = {
			http = {
				mylama = function()
					return require("codecompanion.adapters").extend("ollama", {
						name = "mylama",
						schema = {
							model = {
								--default = "mistral:7b-instruct",
								--default = "codellama:34b",
								default = "deepseek-coder:33b",
							},
							num_ctx = {
								default = 4096,
							},
							num_predict = {
								default = -1,
							},
						},
					})
				end,
				gemini = function()
					return require("codecompanion.adapters").extend("gemini", {
						schema = {
							model = {
								default = "gemini-2.5-flash-lite",
							},
						},
					})
				end,
			},
		},
		strategies = {
			chat = {
				adapter = "gemini",
			},
			inline = {
				adapter = "mylama",
			},
		},
		prompt_library = {
			["Code reviewer"] = {
				strategy = "chat",
				description = "A code review",
				opts = {
					modes = { "n" },
					short_name = "expert",
					auto_submit = false,
					stop_context_insertion = true,
					user_prompt = true,
				},
				prompts = {
					{
						role = "system",
						content = function(context)
							return "I want you to act as a senior " .. context.filetype .. " developer."
						end,
					},
					{
						role = "user",
						content = [[Describe and analyze the following code.
                            Consider:
                            1. Code quality and adherence to best practices
                            2. Potential bugs or edge cases
                            3. Performance optimizations
                            4. Readability and maintainability
                            5. Any security concerns
                            Suggest improvements and explain your reasoning for each suggestion.]],
					},
				},
			},
		},
	},
	keys = {
		{
			"<leader>cca",
			"<cmd>CodeCompanionActions<cr>",
			desc = "CodeCompanionActions",
		},
		{
			"<leader>ccc",
			"<cmd>CodeCompanionChat Toggle<cr>",
			desc = "CodeCompanionChat",
		},
	},
}
