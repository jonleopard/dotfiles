return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/playground",
			"nvim-treesitter/nvim-treesitter-context",
		},
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("nvim-treesitter.configs").setup({
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
				auto_install = true,
				highlight = {
					enable = true,
					-- Only enable if you **really** need Markdown regex
					-- additional_vim_regex_highlighting = { "markdown" },
				},
				indent = { enable = true },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "gnn",
						node_incremental = "grn",
						scope_incremental = "grc",
						node_decremental = "grm",
					},
				},
			})

			-- Custom parsers outside of setup
			local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
			parser_config.templ = {
				install_info = {
					url = "https://github.com/vrischmann/tree-sitter-templ.git",
					files = { "src/parser.c", "src/scanner.c" },
					branch = "master",
				},
			}
			vim.treesitter.language.register("templ", "templ")

			-- Performance: disable for big files (>100kb)
			vim.api.nvim_create_autocmd({ "BufReadPost" }, {
				callback = function(args)
					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.loop.fs_stat, args.file)
					if ok and stats and stats.size > max_filesize then
						vim.treesitter.stop()
					end
				end,
			})
		end,
	},
}
