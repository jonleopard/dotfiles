return {
	{
		"tinted-theming/tinted-nvim",
		priority = 1000,
		config = function()
			vim.opt.termguicolors = true

			-- Setup with tinty integration and live reload
			-- Pass nil as first arg to auto-detect theme from tinty
			require("tinted-colorscheme").setup(nil, {
				supports = {
					tinty = true,
					live_reload = true,
					telescope = true,
					cmp = true,
					lsp_semantic = true,
				},
			})
		end,
	},
}
