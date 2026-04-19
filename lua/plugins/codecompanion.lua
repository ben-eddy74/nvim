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
                --default = "qwen2.5-coder:7b-instruct-q6_K"
                default = "coder:latest"
              },
            },
          })
        end,
        gemini = function()
          return require("codecompanion.adapters").extend("gemini", {
            schema = {
              model = {
                --default = "gemini-3.1-pro-preview",
                default = "gemini-3-flash-preview",
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
          "~/.config/nvim/prompts/"
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
