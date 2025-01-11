-- return {
-- 	{
-- 		"NeogitOrg/neogit",
-- 		dependencies = {
-- 			"nvim-lua/plenary.nvim", -- required
-- 			"sindrets/diffview.nvim", -- optional - Diff integration
--
-- 			-- Only one of these is needed, not both.
-- 			"nvim-telescope/telescope.nvim", -- optional
-- 			"ibhagwan/fzf-lua", -- optional
-- 		},
-- 		config = function()
-- 			local neogit = require("neogit")
-- 			neogit.setup()
--
-- 			vim.keymap.set("n", "<leader>gs", vim.cmd.Neogit)
-- 		end,
-- 	},
-- }

return {
	{
		"tpope/vim-fugitive",
		dependencies = { "tpope/vim-rhubarb" },
		config = function()
			vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
			vim.keymap.set("n", "<leader>gd", vim.cmd.Gdiffsplit)
			vim.keymap.set("n", "dv", vim.cmd.Gvdiffsplit)
			vim.keymap.set("n", "gl", "<cmd>diffget //2<CR>")
			vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>")

			local Jon_Fugitive = vim.api.nvim_create_augroup("Jon_Fugitive", {})

			local autocmd = vim.api.nvim_create_autocmd
			autocmd("BufWinEnter", {
				group = Jon_Fugitive,
				pattern = "*",
				callback = function()
					if vim.bo.ft ~= "fugitive" then
						return
					end

					local bufnr = vim.api.nvim_get_current_buf()
					local opts = { buffer = bufnr, remap = false }
					vim.keymap.set("n", "<leader>p", function()
						vim.cmd.Git("push")
					end, opts)

					-- rebase always
					vim.keymap.set("n", "<leader>P", function()
						vim.cmd.Git({ "pull --rebase" })
					end, opts)

					-- NOTE: It allows me to easily set the branch i am pushing and any tracking
					-- needed if i did not set the branch up correctly
					vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts)
				end,
			})
		end,
	},
}
