return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {},
	config = function()
		local wk = require("which-key")

		wk.register({
			-- GOTO / COMMENT
			g = {
				name = "goto/comment",
				c = {
					name = "comment line",
					c = { "Toggle Comment Line" },
					b = { "Toggle Block Comment" },
				},
			},

			-- SURROUND
			s = {
				name = "surround",
				a = { "Add Surrounding" },
				d = { "Delete Surrounding" },
				r = { "Replace Surrounding" },
				f = { "Find Right Surrounding" },
				F = { "Find Left Surrounding" },
				h = { "Highlight Surrounding" },
			},

			-- FILE / TELESCOPE
			["<leader>f"] = {
				name = "file/find",
				f = { "<cmd>Telescope find_files<cr>", desc = "Find Files" },
				g = { "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
				w = { "<cmd>Telescope grep_string<cr>", desc = "Find Word Under Cursor" },
				W = { "<cmd>Telescope grep_string search=expand('<cWORD>')<cr>", desc = "Find WORD Under Cursor" },
				h = { "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
			},

			["<C-p>"] = { "<cmd>Telescope git_files<cr>", desc = "Git Files" },

			-- GIT / GITSIGNS
			["<leader>g"] = {
				name = "git",
				s = { "<cmd>Gitsigns stage_hunk<cr>", desc = "Git Stage Hunk" },
				u = { "<cmd>Gitsigns undo_stage_hunk<cr>", desc = "Git Undo Stage Hunk" },
				p = { "<cmd>Gitsigns preview_hunk<cr>", desc = "Git Preview Hunk" },
				r = { "<cmd>Gitsigns reset_hunk<cr>", desc = "Git Reset Hunk" },
				S = { "<cmd>Gitsigns stage_buffer<cr>", desc = "Git Stage Buffer" },
			},

			-- DIAGNOSTICS / TROUBLE
			["<leader>x"] = {
				name = "diagnostics",
				x = { "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (All)" },
				X = { "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Diagnostics (Buffer)" },
				L = { "<cmd>Trouble loclist toggle<cr>", desc = "Location List" },
				Q = { "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List" },
			},

			-- CODE / TROUBLE SYMBOLS
			["<leader>c"] = {
				name = "code",
				s = { "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols Outline" },
				l = {
					"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
					desc = "LSP Definitions/References",
				},
			},

			-- SESSION MANAGEMENT
			["<leader>s"] = {
				name = "session",
				s = { "<cmd>SessionSave<cr>", desc = "Save Session" },
				l = { "<cmd>SessionLoad<cr>", desc = "Load Session" },
			},

			-- UI / NOICE
			["<leader>u"] = {
				name = "ui",
				n = { "<cmd>Noice dismiss<cr>", desc = "Dismiss Noice Messages" },
			},

			-- WINDOWS MOVEMENT
			["<leader>w"] = {
				name = "windows",
				h = { "<C-w>h", desc = "Window Left" },
				j = { "<C-w>j", desc = "Window Down" },
				k = { "<C-w>k", desc = "Window Up" },
				l = { "<C-w>l", desc = "Window Right" },
			},

			-- BUFFER MANAGEMENT
			["<leader>b"] = {
				name = "buffers",
				d = { "<cmd>bdelete<cr>", desc = "Delete Buffer" },
				n = { "<cmd>bnext<cr>", desc = "Next Buffer" },
				p = { "<cmd>bprevious<cr>", desc = "Previous Buffer" },
			},

			-- QUIT
			["<leader>q"] = {
				name = "quit/session",
				q = { "<cmd>qa!<cr>", desc = "Quit All" },
				s = { "<cmd>wqa<cr>", desc = "Save and Quit" },
			},
		})
	end,
}
