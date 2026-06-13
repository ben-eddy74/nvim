vim.pack.add({
	{ src = "https://github.com/rmagatti/auto-session.git" },
})

require("auto-session").setup({
	log_level = "error",
	auto_session_enable_last_session = false,
	auto_session_use_git_branch = true,
	auto_save_enabled = true,
	auto_restore_enabled = true,
})
