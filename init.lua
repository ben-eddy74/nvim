-- Get path to home directory
Home_directory = os.getenv("HOME")
if Home_directory == nil then
	-- Windows
	Home_directory = os.getenv("USERPROFILE")
end

-- Set Powershell Editor Services path variable
PSes_path = Home_directory .. "/AppData/local/nvim-data/mason/packages/powershell-editor-services"

-- Set leader key
vim.keymap.set("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Load config
require("config.settings")
require("config.keymaps")
require("config.autocmds")

-- Set powershell as default shell when on Windows
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
vim.filetype.add({
	pattern = {
		[".*ansible/.*.yml"] = "ansible",
	},
})
