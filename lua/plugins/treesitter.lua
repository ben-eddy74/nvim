return {
  "nvim-treesitter/nvim-treesitter", 
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")
    configs.setup({
      ensure_installed = { 'vimdoc', 'lua', 'bash' },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
      }
    })
  end
}
