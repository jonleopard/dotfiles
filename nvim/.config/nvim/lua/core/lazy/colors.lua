return {
	{
		"tinted-theming/tinted-nvim",
		priority = 1000,
		config = function()
			vim.opt.termguicolors = true

			local tinty_available = vim.fn.executable("tinty") == 1

			-- Auto-detect theme from tinty if available, otherwise falls back to base16-ayu-dark.
			-- live_reload requires tinty binary; guard to avoid crash on systems without it.
			require("tinted-colorscheme").setup(nil, {
				supports = {
					tinty = true,
					live_reload = tinty_available,
					telescope = true,
					cmp = true,
					lsp_semantic = true,
				},
			})
		end,
	},
}
