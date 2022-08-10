local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

-- TODO: Add this
-- nnoremap <leader>dot <cmd>lua require('user.telescope').search_dotfiles()<cr>

local actions = require("telescope.actions")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local previewers = require("telescope.previewers")
local action_state = require("telescope.actions.state")
local conf = require("telescope.config").values
require("telescope").load_extension("fzy_native")


telescope.setup({
	defaults = {

		prompt_prefix = "> ",
		path_display = { "smart" },
		file_sorter = require("telescope.sorters").get_fzy_sorter,
		color_devicons = true,


		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

		mappings = {
			i = {
				["<C-x>"] = false,
				["<C-q>"] = actions.send_to_qflist,
			},
		},
	},
	pickers = {
		-- Default configuration for builtin pickers goes here:
		-- picker_name = {
		--   picker_config_key = value,
		--   ...
		-- }
		-- Now the picker_config_key will be applied every time you call this
		-- builtin picker
	},
	extensions = {
		-- Your extension configuration goes here:
		-- extension_name = {
		--   extension_config_key = value,
		-- }
		-- please take a look at the readme of the extension you want to configure
		fzy_native = {
			override_generic_sorter = false,
			override_file_sorter = true,
		},
	},
})

local M = {}

function M.reload_modules()
	local lua_dirs = vim.fn.glob("./lua/*", 0, 1)
	for _, dir in ipairs(lua_dirs) do
		dir = string.gsub(dir, "./lua/", "")
		require("plenary.reload").reload_module(dir)
	end
end

M.search_dotfiles = function()
	require("telescope.builtin").find_files({
		prompt_title = "< VimRC >",
		cwd = "$HOME/dotfiles/nvim/.config/nvim/",
		hidden = true,
	})
end

M.git_branches = function()
	require("telescope.builtin").git_branches({
		attach_mappings = function(_, map)
			map("i", "<c-d>", actions.git_delete_branch)
			map("n", "<c-d>", actions.git_delete_branch)
			return true
		end,
	})
end


local function refactor(prompt_bufnr)
	local content = require("telescope.actions.state").get_selected_entry(prompt_bufnr)
	require("telescope.actions").close(prompt_bufnr)
	require("refactoring").refactor(content.value)
end

M.refactors = function()
	require("telescope.pickers").new({}, {
		prompt_title = "refactors",
		finder = require("telescope.finders").new_table({
			results = require("refactoring").get_refactors(),
		}),
		sorter = require("telescope.config").values.generic_sorter({}),
		attach_mappings = function(_, map)
			map("i", "<CR>", refactor)
			map("n", "<CR>", refactor)
			return true
		end,
	}):find()
end


M.dev = function(opts)
	opts = opts or {}

	opts.cwd = opts.cwd or vim.loop.fs_realpath(vim.loop.cwd())
	print("HEY BAE", opts.cwd)

	local possible_files = vim.api.nvim_get_runtime_file("/lua/**/dev.lua", true)
	local local_files = {}
	for _, raw_f in ipairs(possible_files) do
		local real_f = vim.loop.fs_realpath(raw_f)

		if string.find(real_f, opts.cwd, 1, true) then
			table.insert(local_files, real_f)
		end
	end

	local dev = local_files[1]
	local loaded = loadfile(dev)
	local ok, mod = pcall(loaded)
	if not ok then
		print("===================================================")
		print("HEY MAN. YOUR CODE DOESNT WORK. THIS IS NOT ON ME")
		print("===================================================")
		return
	end

	-- P(mod)
	local objs = {}
	for k, v in pairs(mod) do
		local debug_info = debug.getinfo(v)
		table.insert(objs, {
			filename = string.sub(debug_info.source, 2),
			text = k,
		})
	end

	local mod_name = vim.split(dev, "/lua/")
	if #mod_name ~= 2 then
		print("===================================================")
		print("HEY MAN. I DO NOT KNOW HOW TO FIND THIS FILE:")
		print(dev)
		print("===================================================")
	end
	mod_name = string.gsub(mod_name[2], ".lua$", "")
	mod_name = string.gsub(mod_name, "/", ".")

	pickers.new({
		finder = finders.new_table({
			results = objs,
			entry_maker = function(entry)
				return {
					value = entry,
					text = entry.text,
					display = entry.text,
					ordinal = entry.text,
					filename = entry.filename,
				}
			end,
		}),
		sorter = conf.generic_sorter(opts),
		previewer = previewers.builtin.new(opts),
		attach_mappings = function(_, map)
			actions.select_default:replace(function(...)
				-- print("SELECTED", vim.inspect(action_state.get_selected_entry()))
				local entry = action_state.get_selected_entry()
				actions.close(...)

				mod[entry.value.text]()
			end)

			map("i", "<tab>", function(...)
				local entry = action_state.get_selected_entry()
				actions.close(...)

				vim.schedule(function()
					-- vim.cmd(string.format([[normal!]], entry.value.text))
					vim.api.nvim_feedkeys(
						vim.api.nvim_replace_termcodes(
							string.format("<esc>:lua require('%s').%s()", mod_name, entry.value.text),
							true,
							false,
							true
						),
						"n",
						true
					)
				end)
			end)

			return true
		end,
	}):find()
end

return M
