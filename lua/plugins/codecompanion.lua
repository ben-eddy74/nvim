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
                default = "mistral:7b-instruct",
                --default = "codellama:34b",
                --default = "deepseek-coder:33b",
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
                default = "gemini-2.5-pro",
              },
            },
          })
        end,
        gemini_strict = function()
          return require("codecompanion.adapters").extend("gemini", {
            schema = {
              model = {
                default = "gemini-2.5-pro",
                temperature = 0.5,
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
        adapter = "gemini",
      },
    },
    prompt_library = {
      markdown = {
        dirs = {
          vim.fn.stdpath("config") .. "./prompts",
        },
      },
    },
  },
  keys = {
    {
      "<leader>cca",
      "<cmd>CodeCompanionActions<cr>",
      desc = "CodeCompanion Actions",
    },
    {
      "<leader>ccc",
      "<cmd>CodeCompanionChat Toggle<cr>",
      desc = "Toggle CodeCompanion Chat",
    },
    {
      "<leader>cci",
      ":CodeCompanion #{buffer} ",
      desc = "CodeCompanion Inline Assistant",
    },
  },
}
