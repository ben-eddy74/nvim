-- Code actions
--
vim.keymap.set("n", "<leader>ca", function()
  vim.lsp.buf.code_action()
end, { desc = "Trigger code action menu" })

-- Python
--
vim.keymap.set("n", "<leader>pyb", "<cmd>!uv build<CR>", { desc = "UV: Build python module" })

-- Powershell
--
vim.keymap.set(
  "n",
  "<leader>psb",
  '<cmd>!powershell.exe -NoLogo -NoProfile -Command "& { .\\build.ps1 -tasks build }"<CR>',
  { desc = "Sampler: Build module" }
)

-- Install parsers
--
vim.keymap.set("n", "<leader>tsi", function()
  require('nvim-treesitter').install({
    "bash",
    "comment",
    "css",
    "diff",
    "gitignore",
    "html",
    "ini",
    "javascript",
    "jsdoc",
    "json",
    "lua",
    "luadoc",
    "luap",
    "make",
    "markdown",
    "markdown_inline",
    "powershell",
    "python",
    "query",
    "regex",
    "scss",
    "sql",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "xml",
    "yaml",
  })
end
)
