return {
	{
		"stevearc/conform.nvim",
		config = function()
			local conform = require("conform")

			conform.setup({
				default_format_opts = {
					timeout_ms = 5000,
					lsp_format = "fallback",
				},
				formatters_by_ft = {
					c = { "clang-format" },
					yaml = { "prettierd", "prettier", stop_after_first = true },
					php = { "pint", "php_cs_fixer" },
					lua = { "stylua" },
					go = { "goimports", "gofmt" },
					templ = { "templ" },
					-- Conform will run multiple formatters sequentially
					python = { "isort", "black" },
					-- Conform will run the first available formatter
					javascript = { "prettierd", "prettier", stop_after_first = true },
				},
			})
			vim.keymap.set("n", "<leader>f", function()
				require("conform").format({ bufnr = 0 })
			end)
		end,
	},
}
