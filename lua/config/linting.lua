local lint = require("lint")

local mdlint = lint.linters.markdownlint
mdlint.args = {
  "--stdin", "--disable", "MD013", "--"
}

lint.linters_by_ft = {
  markdown = { "markdownlint" },
  --python = { "ruff" },
  typescript = { "eslint_d" },
  javascript = { "eslint_d" },
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

-- Try linting
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = lint_augroup,
  callback = function()
    lint.try_lint()
  end,
})
