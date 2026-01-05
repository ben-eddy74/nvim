-- Get path to home directory
Home_directory = os.getenv("HOME")
if Home_directory == nil then
	-- Windows
	Home_directory = os.getenv("USERPROFILE")
end

-- Set Powershell Editor Services path variable
PSes_path = Home_directory .. "/AppData/local/nvim-data/mason/packages/powershell-editor-services"

vim.keymap.set("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.options")
require("config.keymaps")
require("config.diagnostics")
require("config.autocmds")
require("config.lazy")

require("config.treesitter")
require("config.lsp")
require("config.linting")
require("config.snacks")
require("config.whichkey")
require("config.conform")
--require('config.trouble')
require("config.utils")
require("config.lualine")

vim.cmd.colorscheme("catppuccin")
vim.cmd("highlight Normal guibg=NONE")

-- Set powershell as default shell when on Windows
--
if vim.fn.has("win32") == 1 then
	local powershell_options = {
		shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell",
		shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
		shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
		shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
		shellquote = "",
		shellxquote = "",
	}

	for option, value in pairs(powershell_options) do
		vim.opt[option] = value
	end
end

-- Custom file types
--
vim.filetype.add({
	pattern = {
		[".*ansible/.*.yml"] = "ansible",
	},
})
