-- Groups for which-key
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local ok, wk = pcall(require, "which-key")
		if ok then
			wk.add({
				{ "<leader>b", group = "Buffer handling" },
				{ "<leader>c", group = "Coding" },
				{ "<leader>f", group = "Fuzzy find" },
				{ "<leader>n", group = "Noice shortcuts" },
				{ "<leader>w", group = "Workflow / Workspace" },
				{ "<leader>t", group = "Terminal Tools" },
				{ "<leader>x", group = "Diagnostics" },
			})
		end
	end,
})

-- nvim-tree
vim.keymap.set("n", "<leader>e", vim.cmd.NvimTreeToggle, { desc = "Toggle nvim-tree" })

-- Close all buffers
vim.keymap.set("n", "<leader>bda", ":bd|e#<CR>", { desc = "Delete all buffers except current" })
vim.keymap.set("n", "<leader>bw", ":bufdo bwipeout<CR>", { desc = "Wipe out all buffers" })

-- Resize buffer windows
vim.keymap.set("n", "<A-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<A-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<A-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<A-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- Track whether the window is currently maximized
local is_maximized = false
local restore_cmd = ""

-- Maximize/minimize current window
vim.keymap.set("n", "<leader>m", function()
	if is_maximized then
		if restore_cmd ~= "" then
			vim.cmd(restore_cmd)
		else
			vim.cmd("wincmd =")
		end
		is_maximized = false
	else
		restore_cmd = vim.fn.winrestcmd()
		vim.cmd("wincmd _")
		vim.cmd("wincmd |")
		is_maximized = true
	end
end, { desc = "Toggle maximize current window" })

-- Noice shortcuts
vim.keymap.set("n", "<leader>nh", ":Noice history<CR>", { desc = "Open message history" })
vim.keymap.set("n", "<leader>ne", ":Noice errors<CR>", { desc = "Open message history, filtered to show only errors" })

-- Python
vim.keymap.set(
	"n",
	"<leader>pyb",
	"<cmd>split | terminal uv build<CR><cmd>startinsert<CR>",
	{ desc = "Python: Build python module (uv)" }
)

-- Powershell
vim.keymap.set(
	"n",
	"<leader>psb",
	'<cmd>split | terminal powershell.exe -NoLogo -NoProfile -Command "& { .\\build.ps1 -tasks build }"<CR><cmd>startinsert<CR>',
	{ desc = "PowerShell: Sampler - Build module" }
)

-- =============================================================================
-- WORKFLOW / WORKSPACE MANAGEMENT (<leader>w)
-- =============================================================================

-- Create a fresh, empty workspace layout
vim.keymap.set("n", "<leader>wn", "<cmd>tabnew<CR>", { desc = "Workflow: New workspace" })

-- Close the entire current workspace layout and its splits
vim.keymap.set("n", "<leader>wc", "<cmd>tabclose<CR>", { desc = "Workflow: Close workspace" })

-- Quick cycle through your open workspaces (Alt + . and Alt + ,)
vim.keymap.set("n", "<A-.>", "<cmd>tabnext<CR>", { desc = "Workflow: Next workspace" })
vim.keymap.set("n", "<A-,>", "<cmd>tabprevious<CR>", { desc = "Workflow: Previous workspace" })

vim.keymap.set("n", "<leader>w,", "<cmd>-tabmove<CR>", { desc = "Workflow: Move layout left" })
vim.keymap.set("n", "<leader>w.", "<cmd>+tabmove<CR>", { desc = "Workflow: Move layout right" })
