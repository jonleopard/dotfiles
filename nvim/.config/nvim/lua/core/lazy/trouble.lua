return {
	{
		"folke/trouble.nvim",
		opts = {},
		cmd = "Trouble",
		config = function()
			require("trouble").setup({
				keys = {
					{
						"<leader>xx",
						"<cmd>Trouble diagnostics toggle<cr>",
						desc = "Diagnostics (Trouble)",
					},
					{
						"<leader>xX",
						"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
						desc = "Buffer Diagnostics (Trouble)",
					},
					{
						"<leader>cs",
						"<cmd>Trouble symbols toggle focus=false<cr>",
						desc = "Symbols (Trouble)",
					},
					{
						"<leader>cl",
						"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
						desc = "LSP Definitions / references / ... (Trouble)",
					},
					{
						"<leader>xL",
						"<cmd>Trouble loclist toggle<cr>",
						desc = "Location List (Trouble)",
					},
					{
						"<leader>xQ",
						"<cmd>Trouble qflist toggle<cr>",
						desc = "Quickfix List (Trouble)",
					},
				},
			})
		end,
		-- config = function()
		--     vim.keymap.set("n", "<leader>tt", function()
		--         require("trouble").toggle()
		--     end
		--     )
		--
		--     vim.keymap.set("n", "[d", function()
		--         require("trouble").next({ skip_groups = true, jump = true })
		--     end
		--     )
		--     vim.keymap.set("n", "]d", function()
		--         require("trouble").previous({ skip_groups = true, jump = true })
		--     end
		--     )
		--     vim.keymap.set("n", "<leader>tw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
		--         { silent = true, noremap = true }
		--     )
		--     vim.keymap.set("n", "<leader>td", "<cmd>TroubleToggle document_diagnostics<cr>",
		--         { silent = true, noremap = true }
		--     )
		--     vim.keymap.set("n", "<leader>tl", "<cmd>TroubleToggle loclist<cr>",
		--         { silent = true, noremap = true }
		--     )
		--     vim.keymap.set("n", "<leader>tq", "<cmd>TroubleToggle quickfix<cr>",
		--         { silent = true, noremap = true }
		--     )
		--     vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>",
		--         { silent = true, noremap = true }
		--     )
		-- end
	},
}
