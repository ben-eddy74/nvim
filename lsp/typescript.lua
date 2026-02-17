-- return {
-- 	cmd = { "typescript-language-server", "--stdio" },
-- 	settings = {},
-- 	filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
-- 	init_options = {
-- 		hostInfo = "neovim",
-- 	},
-- }
return {
  cmd = { "vtsls", "--stdio" },
  settings = {},
  filetypes = { "javascript", "typescript" },
  init_options = {
    hostInfo = "neovim"
  }
}
