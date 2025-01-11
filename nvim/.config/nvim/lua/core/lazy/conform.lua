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
					yaml = { "prettierd", "prettier", stop_after_first = true },
					php = { "pint", "php_cs_fixer" },
					lua = { "stylua" },
					go = { "goimports", "gofmt" },
					templ = { "templ" },
					-- Conform will run multiple formatters sequentially
					python = { "isort", "black" },
					-- You can customize some of the format options for the filetype (:help conform.format)
					rust = { "rustfmt" },
					-- Conform will run the first available formatter
					javascript = { "prettierd", "prettier", stop_after_first = true },
				},
			})
		end,
	},
}
