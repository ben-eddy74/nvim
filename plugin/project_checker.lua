-- Project setup checker for Java/Quarkus + TypeScript/Lit monorepos
-- Runs silently on startup, verifying configuration files based on full_stack_setup_guide.md

local function check_project()
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
		-- Not inside a fullstack monorepo, exit quietly
		return
	end

	local pom_path = backend_dir .. "/pom.xml"
	local vite_path = frontend_dir .. "/vite.config.ts"
	local props_path = backend_dir .. "/src/main/resources/application.properties"

	local warnings = {}

	-- 1. Check pom.xml for typescript-generator-maven-plugin
	if vim.fn.filereadable(pom_path) == 1 then
		local f = io.open(pom_path, "r")
		if f then
			local content = f:read("*all")
			f:close()
			if not content:find("typescript%-generator%-maven%-plugin") then
				table.insert(warnings, "• Missing 'typescript-generator-maven-plugin' in pom.xml for DTO generation.")
			end
		end
	else
		table.insert(warnings, "• pom.xml was not found in backend directory.")
	end

	-- 2. Check vite.config.ts for dev proxy OR application.properties for Quarkus CORS
	local has_proxy = false
	if vim.fn.filereadable(vite_path) == 1 then
		local f = io.open(vite_path, "r")
		if f then
			local content = f:read("*all")
			f:close()
			if content:find("proxy") then
				has_proxy = true
			end
		end
	end

	local has_cors = false
	if vim.fn.filereadable(props_path) == 1 then
		local f = io.open(props_path, "r")
		if f then
			local content = f:read("*all")
			f:close()
			if content:find("quarkus%.http%.cors%s*=%s*true") then
				has_cors = true
			end
		end
	end

	if not has_proxy and not has_cors then
		table.insert(warnings, "• Neither Vite dev proxy nor Quarkus CORS configurations were found. You may experience CORS blocks.")
	end

	-- 3. Check for Prettier configuration in the frontend directory
	local has_prettier_config = false
	local prettier_files = {
		".prettierrc",
		".prettierrc.json",
		".prettierrc.yml",
		".prettierrc.yaml",
		".prettierrc.js",
		".prettierrc.cjs",
		".prettierrc.mjs",
		"prettier.config.js",
		"prettier.config.cjs",
		"prettier.config.mjs",
	}
	for _, filename in ipairs(prettier_files) do
		if vim.fn.filereadable(frontend_dir .. "/" .. filename) == 1 then
			has_prettier_config = true
			break
		end
	end

	-- Check package.json for embedded "prettier" key
	if not has_prettier_config then
		local pkg_path = frontend_dir .. "/package.json"
		if vim.fn.filereadable(pkg_path) == 1 then
			local f = io.open(pkg_path, "r")
			if f then
				local content = f:read("*all")
				f:close()
				if content:find('"%s*prettier%s*"%s*:') then
					has_prettier_config = true
				end
			end
		end
	end

	if not has_prettier_config then
		table.insert(warnings, "• Prettier configuration file (.prettierrc) was not found in the frontend directory.")
	end

	-- Trigger warning notify if issues were found
	if #warnings > 0 then
		vim.defer_fn(function()
			local msg = "Missing project configurations:\n" .. table.concat(warnings, "\n")
			vim.notify(msg, vim.log.levels.WARN, {
				title = "Project Setup Warning",
				timeout = 10000, -- Keep visible for 10 seconds
			})
		end, 800) -- Defer slightly to ensure notifier is fully loaded and visible
	end
end

-- Run checks on startup
vim.api.nvim_create_autocmd("VimEnter", {
	callback = check_project,
})
