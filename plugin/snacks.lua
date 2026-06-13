-- Install snacks.nvim
vim.pack.add({
	{ src = "https://github.com/folke/snacks.nvim.git" },
})

require("snacks").setup({
	picker = {
		enabled = true,
		ui_select = true, -- Replaces vim.ui.select with snacks.picker
		sources = {
			files = {
				layout = {
					layout = {
						box = "horizontal",
						width = 0.9,
						height = 0.8,
						{
							box = "vertical",
							border = "rounded",
							title = "{title} {live} {flags}",
							{ win = "input", height = 1, border = "bottom" },
							{ win = "list", border = "none" },
						},
						{ win = "preview", title = "{preview}", border = "rounded", width = 0.7 },
					},
				},
			},
		},
	},
	terminal = {
		enabled = true,
	},
	indent = {
		enabled = true,
	},
	-- You can enable other snacks modules here in the future if needed, e.g.:
	-- notifier = { enabled = true },
	-- dashboard = { enabled = true },
})

-- Keymaps for Snacks Picker
local map = vim.keymap.set

map("n", "<leader>ff", function()
	Snacks.picker.files()
end, { desc = "Fuzzy Find: Files" })
map("n", "<leader>fg", function()
	Snacks.picker.grep()
end, { desc = "Fuzzy Find: Live Grep" })
map("n", "<leader>fb", function()
	Snacks.picker.buffers()
end, { desc = "Fuzzy Find: Active Buffers" })
map("n", "<leader>fr", function()
	Snacks.picker.recent()
end, { desc = "Fuzzy Find: Recent Files" })
map("n", "<leader>fh", function()
	Snacks.picker.help()
end, { desc = "Fuzzy Find: Help Tags" })
map("n", "<leader>f/", function()
	Snacks.picker.lines()
end, { desc = "Fuzzy Find: Lines in Buffer" })
map("n", "<leader>fq", function()
	Snacks.picker.qflist()
end, { desc = "Fuzzy Find: Quickfix List" })
map("n", "<leader>fk", function()
	Snacks.picker.keymaps()
end, { desc = "Fuzzy Find: Keymaps" })
map("n", "<leader>fd", function()
	Snacks.picker.diagnostics()
end, { desc = "Fuzzy Find: Diagnostics" })

-- Unified Dev Terminal runner
local function run_dev()
	local cwd = vim.fn.getcwd()
	local has_backend = vim.fn.isdirectory(cwd .. "/backend") == 1
	local has_frontend = vim.fn.isdirectory(cwd .. "/frontend") == 1

	local backend_dir, frontend_dir
	if has_backend and has_frontend then
		backend_dir = cwd .. "/backend"
		frontend_dir = cwd .. "/frontend"
	elseif vim.fn.filereadable(cwd .. "/package.json") == 1 and vim.fn.isdirectory(cwd .. "/../backend") == 1 then
		backend_dir = vim.fn.fnamemodify(cwd .. "/../backend", ":p")
		frontend_dir = cwd
	else
		vim.notify("Could not detect backend/frontend folders relative to CWD. Running in current directory.", vim.log.levels.WARN)
		backend_dir = cwd
		frontend_dir = cwd
	end

	-- Open split for backend
	vim.cmd("split")
	Snacks.terminal.open("mvn quarkus:dev", { cwd = backend_dir })
	-- Open vertical split for frontend
	vim.cmd("vsplit")
	Snacks.terminal.open("npm run dev", { cwd = frontend_dir })
end

map("n", "<leader>td", run_dev, { desc = "Terminal: Run dev servers side-by-side" })

