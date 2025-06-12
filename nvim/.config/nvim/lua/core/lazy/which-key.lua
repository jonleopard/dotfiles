return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {},
	config = function()
		local wk = require("which-key")

		wk.register({
			["<leader>f"] = {
				name = "file/find",
				f = { "<cmd>Telescope find_files<cr>", "Find Files" },
				g = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
				w = { "<cmd>Telescope grep_string<cr>", "Find Word Under Cursor" },
				W = { "<cmd>Telescope grep_string search=expand('<cWORD>')<cr>", "Find WORD Under Cursor" },
				h = { "<cmd>Telescope help_tags<cr>", "Help Tags" },
			},

			["<C-p>"] = { "<cmd>Telescope git_files<cr>", "Git Files" },

			["<leader>g"] = {
				name = "git",
				s = { "<cmd>Gitsigns stage_hunk<cr>", "Stage Hunk" },
				u = { "<cmd>Gitsigns undo_stage_hunk<cr>", "Undo Stage Hunk" },
				p = { "<cmd>Gitsigns preview_hunk<cr>", "Preview Hunk" },
				r = { "<cmd>Gitsigns reset_hunk<cr>", "Reset Hunk" },
				S = { "<cmd>Gitsigns stage_buffer<cr>", "Stage Buffer" },
			},

			["<leader>x"] = {
				name = "diagnostics",
				x = { "<cmd>Trouble diagnostics toggle<cr>", "Diagnostics (All)" },
				X = { "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", "Diagnostics (Buffer)" },
				L = { "<cmd>Trouble loclist toggle<cr>", "Location List" },
				Q = { "<cmd>Trouble qflist toggle<cr>", "Quickfix List" },
			},

			["<leader>c"] = {
				name = "code",
				s = { "<cmd>Trouble symbols toggle focus=false<cr>", "Symbols Outline" },
				l = { "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", "LSP References/Defs" },
			},

			["<leader>s"] = {
				name = "session",
				s = { "<cmd>SessionSave<cr>", "Save Session" },
				l = { "<cmd>SessionLoad<cr>", "Load Session" },
			},

			["<leader>u"] = {
				name = "ui",
				n = { "<cmd>Noice dismiss<cr>", "Dismiss Noice" },
			},

			["<leader>w"] = {
				name = "windows",
				h = { "<C-w>h", "Window Left" },
				j = { "<C-w>j", "Window Down" },
				k = { "<C-w>k", "Window Up" },
				l = { "<C-w>l", "Window Right" },
			},

			["<leader>b"] = {
				name = "buffers",
				d = { "<cmd>bdelete<cr>", "Delete Buffer" },
				n = { "<cmd>bnext<cr>", "Next Buffer" },
				p = { "<cmd>bprevious<cr>", "Previous Buffer" },
			},

			["<leader>q"] = {
				name = "quit",
				q = { "<cmd>qa!<cr>", "Quit All" },
				s = { "<cmd>wqa<cr>", "Save and Quit" },
			},

			["<leader>/"] = { "gcc", "Toggle Comment" },
		})
	end,
}
