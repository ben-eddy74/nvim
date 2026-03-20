return {
  cmd = { "pylsp" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml" },
  settings = {
    pylsp = {
      plugins = {
        jedi = {
          environment = "./.venv",
          extra_paths = { "./src" }
        },
        pyflakes = { enabled = false },
        pycodestyle = {
          enabled = true,
          maxLineLength = 100,
          ignore = { "E203", "E722" },
        },
      }
    }
  },
}
