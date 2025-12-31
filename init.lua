-- Get path to home directory
Home_directory = os.getenv("HOME")
if Home_directory == nil then
	Home_directory = os.getenv("USERPROFILE")
end

-- Set Powershell Editor Services path variable
PSes_path = Home_directory .. "/AppData/local/nvim-data/mason/packages/powershell-editor-services"

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })

	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- import your plugins
		{ import = "plugins" },
	},
	-- automatically check for plugin updates
	checker = { enabled = false, notify = true, frequency = 345600 },
	-- Disable hererocks
	opts = { rocks = { enabled = false } },
})

-- Various options
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.guicursor = "" -- Fat cursor
vim.opt.clipboard = "unnamedplus" -- use systems clipboard
vim.opt.ignorecase = true
vim.opt.smartcase = true -- Override the 'ignorecase' option if the search pattern contains upper case characters
vim.o.winborder = "rounded"
-- Scroll
vim.opt.scrolloff = 12
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"
-- Resize windows
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>")
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>")
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>")
-- Buffers
vim.keymap.set("n", "<PageUp>", ":bprevious<CR>")
vim.keymap.set("n", "<PageDown>", ":bnext<CR>")
vim.keymap.set("n", "<leader>d", ":bd<CR>")
vim.keymap.set("n", "<leader>ft", ":= vim.bo.filetype<CR>", { desc = "Get filetype of current buffer" })
-- Set highlight on search but clear on pressing Esc in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc><Esc>", "<cmd>nohlsearch<CR>")
-- Keep cursor in the middle when jumping forward or backward
vim.keymap.set("n", "<C-d>", "<C-d>zz")
--vim.keymap.set("n", "<C-b>", "<C-b>zz")
-- Keep cursor in the middle when going to next or previous search
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

-- Highlight yanking
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("custom-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- remove trailing spaces
vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		-- Save cursor position to restore later
		local curpos = vim.api.nvim_win_get_cursor(0)
		-- Search and replace trailing whitespaces
		vim.cmd([[keeppatterns %s/\s\+$//e]])
		vim.api.nvim_win_set_cursor(0, curpos)
	end,
})

-- Custom file types
vim.filetype.add({
	pattern = {
		[".*ansible/.*.yml"] = "ansible",
	},
})
-- Quickfix navigation
vim.keymap.set("n", "<leader>qn", "<cmd>cnext<CR>", { desc = "Go to next quickfix list entry" })
vim.keymap.set("n", "<leader>qp", "<cmd>cprevious<CR>", { desc = "Go to previous quickfix list entry" })

-- Terminal
vim.cmd.colorscheme("tokyonight")
--- remove line numbers
vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
	callback = function()
		vim.opt.number = false
		vim.opt.relativenumber = false
	end,
})
--- Open small terminal in split
vim.keymap.set("n", "<leader>st", function()
	vim.cmd.vnew()
	vim.cmd.term()
	vim.cmd.wincmd("J")
	vim.api.nvim_win_set_height(0, 14)
end, { desc = "Open small terminal window" })

-- Telescope
local tsbuiltin = require("telescope.builtin")
vim.keymap.set(
	"n",
	"<leader>ff",
	tsbuiltin.find_files,
	{ desc = "Lists files in your current working directory, respects .gitignore" }
)
vim.keymap.set(
	"n",
	"<leader>fr",
	tsbuiltin.grep_string,
	{ desc = "Searches for the string under your cursor or selection in your current working directory" }
)
vim.keymap.set("n", "<leader>fg", tsbuiltin.live_grep, {
	desc = "Search for a string in your current working directory and get results live as you type, respects .gitignore.",
})
vim.keymap.set("n", "<leader>fb", tsbuiltin.buffers, { desc = "Lists open buffers in current neovim instance" })
vim.keymap.set("n", "<leader>fh", tsbuiltin.help_tags, { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>fq", tsbuiltin.quickfix, { desc = "Lists items in the quickfix list" })
vim.keymap.set(
	"n",
	"<leader>fp",
	tsbuiltin.registers,
	{ desc = "Lists vim registers, pastes the contents of the register on <cr>" }
)
vim.keymap.set("n", "<leader>fk", tsbuiltin.keymaps, { desc = "Lists normal mode keymappings" })

-- Treesitter

require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"bash",
		"css",
		"html",
		"javascript",
		"json",
		"lua",
		"markdown",
		"markdown_inline",
		"powershell",
		"python",
		"regex",
		"sql",
		"vimdoc",
		"xml",
		"yaml",
	},
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
	},
})

-- Window
vim.keymap.set("n", "<leader>w", "<cmd>lua require('nvim-window').pick()<cr>", { desc = "nvim-window: Jump to window" })

-- Neotree
vim.keymap.set("n", "<leader>e", "<cmd>Neotree<CR>", { desc = "Open Neotree" })

-- LSP
vim.diagnostic.config({
	virtual_lines = {
		current_line = true,
	},
})

vim.lsp.config("*", {
	capabilities = require("blink.cmp").get_lsp_capabilities(),
})

vim.lsp.enable("luals")
vim.lsp.enable("powershell")
vim.lsp.enable("python")
vim.lsp.enable("ruff")
vim.lsp.enable("html")
vim.lsp.enable("typescript")
vim.lsp.enable("html")

vim.keymap.set("n", "<leader>lsp", function()
	vim.cmd("MasonInstall powershell-editor-services")
	vim.cmd("MasonInstall lua-language-server")
	vim.cmd("MasonInstall pyright")
	vim.cmd("MasonInstall ruff")
	vim.cmd("MasonInstall html-lsp")
	vim.cmd("MasonInstall typescript-language-server")
	vim.cmd("MasonInstall eslint_lsp") -- javascript linter
	vim.cmd("MasonInstall stylua")
end, { desc = "Install LSP packages" })

vim.keymap.set("n", "<leader>ca", function()
	vim.lsp.buf.code_action()
end, { desc = "Trigger code action menu" })

vim.keymap.set("n", "<leader>fo", "<cmd>lua vim.lsp.buf.format()<CR>", { desc = "Format current buffer" })

-- Python
vim.keymap.set("n", "<leader>pyb", "<cmd>!uv build<CR>", { desc = "UV: Build python module" })

-- Powershell
vim.keymap.set(
	"n",
	"<leader>psb",
	'<cmd>!powershell.exe -NoLogo -NoProfile -Command "& { .\\build.ps1 -tasks build }"<CR>',
	{ desc = "Sampler: Build module" }
)
