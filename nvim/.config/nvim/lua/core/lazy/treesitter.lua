return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/playground",
			"nvim-treesitter/nvim-treesitter-context",
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				-- Your config options here (these are correct)
				ensure_installed = {
					"javascript",
					"typescript",
					"c",
					"lua",
					"rust",
					"go",
					"jsdoc",
					"html",
					"templ",
				},
				indent = {
					enable = true,
				},
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = { "markdown" },
				},
				sync_install = false,
				auto_install = true,
				disable = function(lang, buf)
					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,
			})

			local treesitter_parser_config = require("nvim-treesitter.parsers").get_parser_configs()
			treesitter_parser_config.templ = {
				install_info = {
					url = "https://github.com/vrischmann/tree-sitter-templ.git",
					files = { "src/parser.c", "src/scanner.c" },
					branch = "master",
				},
			}
			vim.treesitter.language.register("templ", "templ")
		end,
	},
}
