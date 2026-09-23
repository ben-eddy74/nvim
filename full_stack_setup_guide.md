# 📋 Full-Stack Development Environment Guide: Java/Quarkus + TypeScript/Lit

This guide outlines the setups and architecture rules for a modern, high-performance, split-editor development workflow:
- **Backend**: Apache NetBeans managing Java, Maven, and Quarkus.
- **Frontend**: Neovim 0.12 managing TypeScript, Lit, and CSS/HTML template literals.

---

## 🏗️ 1. Project Directory Structure

Use a clean monorepo folder layout. This allows the backend and frontend to live under a single git repository for easy coordination, while keeping editors isolated:

```text
my-project/
├── backend/                  # Open in Apache NetBeans
│   ├── pom.xml               # Maven configuration
│   └── src/                  # Quarkus Java code (Resources, DTOs, Entities)
├── frontend/                 # Open in Neovim
│   ├── package.json          # Node dependencies
│   ├── tsconfig.json         # TypeScript configuration
│   ├── vite.config.ts        # Vite build tool & dev server
│   └── src/                  # Lit web component files
└── README.md
```

---

## 🛠️ 2. Neovim 0.12 Frontend Setup

We utilize Neovim 0.12's native package manager (`vim.pack.add`), native LSP configurations (`vim.lsp.config`/`vim.lsp.enable`), and `conform.nvim` with Prettier.

### 🔌 File Layout
Three primary configuration files are added under `~/.config/nvim/plugin/` (or Windows equivalent `~/AppData/Local/nvim/plugin/`):

1. **[lsp.lua](file:///C:/Users/Eddy/AppData/Local/nvim/plugin/lsp.lua)**: Sets up `vtsls` (enhanced TypeScript language server), `html` LSP, and `cssls` LSP to auto-complete templates and TS code.
2. **[treesitter.lua](file:///C:/Users/Eddy/AppData/Local/nvim/plugin/treesitter.lua)**: Adds syntax highlighting inside Lit template literals (using Tree-sitter's `html` and `css` injection rules).
3. **[formatting.lua](file:///C:/Users/Eddy/AppData/Local/nvim/plugin/formatting.lua)**: Sets up `conform.nvim` for formatting TypeScript and embedded template literals.

---

### 🔍 LSP Setup (`plugin/lsp.lua`)
`vtsls` is configured to run the `ts-lit-plugin` TypeScript language service extension. Both `html` and `cssls` are enabled for `.ts` files to handle template autocomplete.

```lua
local on_attach = function(client, bufnr)
	-- Native Neovim 0.11/0.12 already sets up LSP keymaps like:
	-- grn (rename), gra (code action), grr (references), gri (implementation), gO (outline)
end

vim.pack.add({
	{ src = "https://github.com/mason-org/mason.nvim.git" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim.git" },
	{ src = "https://github.com/neovim/nvim-lspconfig.git" },
})

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "basedpyright", "vtsls", "html", "cssls" },
	handlers = {
		function(server_name)
			vim.lsp.enable(server_name)
		end,
	}
})

-- Configure vtsls (TypeScript & Lit template literals)
vim.lsp.config("vtsls", {
	on_attach = on_attach,
	settings = {
		typescript = {
			tsserver = {
				pluginPaths = { "./node_modules" },
			},
		},
		vtsls = {
			tsserver = {
				globalPlugins = {
					{
						name = "ts-lit-plugin",
						enableForWorkspaceTypeScriptVersions = true,
					},
				},
			},
		},
	},
})

-- Configure html and cssls for Lit template literals autocomplete
vim.lsp.config("html", {
	on_attach = on_attach,
	filetypes = { "html", "typescript", "javascript", "typescriptreact", "javascriptreact" },
})

vim.lsp.config("cssls", {
	on_attach = on_attach,
	filetypes = { "css", "typescript", "javascript", "typescriptreact", "javascriptreact" },
})
```

---

### 🎨 Treesitter Highlighting (`plugin/treesitter.lua`)
We use `nvim-treesitter` to download and compile parsers. With the `html` and `css` parsers installed, treesitter injects highlighting rules into `html`\`...\` and `css`\`...\` tagged template literals inside TS code automatically.

```lua
vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter.git" },
})

require("nvim-treesitter").setup({
	ensure_installed = { "javascript", "typescript", "html", "css", "lua", "vim", "vimdoc", "query" },
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})
```

---

### ✍️ Formatting (`plugin/formatting.lua`)
Using `conform.nvim` with Prettier ensures both TS and HTML templates are formatted beautifully on save. Prettier natively handles HTML inside `html` tagged template literals.

```lua
vim.pack.add({
	{ src = "https://github.com/stevearc/conform.nvim.git" },
})

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
    python = { "ruff_fix", "ruff_format" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		html = { "prettier" },
		css = { "prettier" },
	},
	format_on_save = {
		timeout_ms = 1000,
		lsp_fallback = true,
	},
})
```

---

## ☕ 3. NetBeans Java/Quarkus Backend Setup

Apache NetBeans is lightweight, fast with Maven, and provides first-class debugging for Quarkus.

### 🏃 Running Quarkus Dev Mode in NetBeans
Quarkus features a powerful Dev Mode that handles hot-reloading (Live Coding) instantly when classes change.
1. Right-click the Quarkus project in NetBeans.
2. Select **Run** or **Debug**.
3. Under the run properties, specify the goal: `quarkus:dev` (e.g. `clean compile quarkus:dev`).
4. To debug, run using NetBeans' Debug action. Dev Mode listens on port `5005` by default, and NetBeans attaches to it seamlessly, allowing you to hit breakpoints instantly.

---

### 🔄 Generating TypeScript Interfaces from Java DTOs
To prevent maintaining duplicate schemas on both sides, compile Maven DTOs into TS definitions automatically using the `typescript-generator-maven-plugin`.

Add this plugin execution block to your `backend/pom.xml`:

```xml
<plugin>
    <groupId>cz.habarta.typescript-generator</groupId>
    <artifactId>typescript-generator-maven-plugin</artifactId>
    <version>3.2.1263</version>
    <executions>
        <execution>
            <id>generate-ts-interfaces</id>
            <goals>
                <goal>generate</goal>
            </goals>
            <phase>process-classes</phase>
        </execution>
    </executions>
    <configuration>
        <jsonLibrary>jackson2</jsonLibrary>
        <classPatterns>
            <!-- Auto-scan and convert all DTO classes in your DTO package -->
            <pattern>com.example.project.dto.**</pattern>
        </classPatterns>
        <outputKind>module</outputKind>
        <outputFileType>implementationFile</outputFileType>
        <outputFile>../frontend/src/types/generated.d.ts</outputFile>
        <mapEnum>asEnum</mapEnum>
        <nonConstEnums>true</nonConstEnums>
    </configuration>
</plugin>
```

When you build or when NetBeans compiles classes (`mvn compile`), the plugin creates `frontend/src/types/generated.d.ts` which is immediately read by Neovim's LSP.

---

## 🌐 4. Seamless Dev Integration

### 🔀 Local Dev Proxy Setup (Vite)
To run your frontend and backend on different ports without CORS blockages, configure a development proxy in Vite (`frontend/vite.config.ts`):

```typescript
import { defineConfig } from 'vite';

export default defineConfig({
  server: {
    port: 5173,
    proxy: {
      '/api': {
        target: 'http://localhost:8080',
        changeOrigin: true,
        secure: false,
      },
    },
  },
});
```

Now, the Lit frontend makes requests to `/api/users` and Vite proxy forwards them to `http://localhost:8080/api/users`.
