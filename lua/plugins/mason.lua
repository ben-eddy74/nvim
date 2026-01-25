return {
  "mason-org/mason.nvim",
  opts = {
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗"
      }
    }
  },
  ensure_installed = {
    "powershell-editor-services",
    "lua-language-server",
    "basedpyright",
    "ruff",
    "html-lsp",
    "typescript-language-server",
    "eslint_d",
    "prettier",
    "taplo",
    "markdownlint",
  },
}
