return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {},
	config = function()
		local wk = require("which-key")
		wk.setup({})

		wk.add({
			-- File/Find group (from telescope and custom)
			{ "<leader>f", group = "file/find/format" },
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
			{ "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Find Word Under Cursor" },
			{ "<leader>fW", "<cmd>Telescope grep_string search=expand('<cWORD>')<cr>", desc = "Find WORD Under Cursor" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
			{ "<leader>f", vim.lsp.buf.format, desc = "Format Buffer", mode = { "n", "v" } },

			-- Git group (from fugitive and gitsigns)
			{ "<leader>g", group = "git" },
			{ "<leader>gs", vim.cmd.Git, desc = "Git Status (Fugitive)" },
			{ "<leader>gd", vim.cmd.Gdiffsplit, desc = "Git Diff Split" },
			{ "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview Hunk" },
			{ "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", desc = "Reset Hunk" },
			{ "<leader>gS", "<cmd>Gitsigns stage_buffer<cr>", desc = "Stage Buffer" },
			{ "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<cr>", desc = "Undo Stage Hunk" },

			-- Harpoon
			{ "<leader>a", desc = "Add to Harpoon" },
			{ "<C-e>", desc = "Toggle Harpoon Menu" },
			{ "<C-h>", desc = "Harpoon File 1" },
			{ "<C-j>", desc = "Harpoon File 2" },
			{ "<C-k>", desc = "Harpoon File 3" },
			{ "<C-l>", desc = "Harpoon File 4" },
			{ "<C-S-P>", desc = "Previous Harpoon" },
			{ "<C-S-N>", desc = "Next Harpoon" },

			-- Diagnostics/Trouble
			{ "<leader>x", group = "diagnostics" },
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (All)" },
			{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Diagnostics (Buffer)" },
			{ "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List" },
			{ "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List" },

			-- Code/LSP
			{ "<leader>c", group = "code" },
			{ "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols Outline" },
			{ "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP References/Defs" },

			-- Session
			{ "<leader>s", group = "session" },
			{ "<leader>ss", "<cmd>SessionSave<cr>", desc = "Save Session" },
			{ "<leader>sl", "<cmd>SessionLoad<cr>", desc = "Load Session" },

			-- UI/Undo
			{ "<leader>u", vim.cmd.UndotreeToggle, desc = "Toggle Undotree" },

			-- Windows
			{ "<leader>w", group = "windows" },
			{ "<leader>wh", "<C-w>h", desc = "Window Left" },
			{ "<leader>wj", "<C-w>j", desc = "Window Down" },
			{ "<leader>wk", "<C-w>k", desc = "Window Up" },
			{ "<leader>wl", "<C-w>l", desc = "Window Right" },

			-- Buffers
			{ "<leader>b", group = "buffers" },
			{ "<leader>bd", "<cmd>bdelete<cr>", desc = "Delete Buffer" },
			{ "<leader>bn", "<cmd>bnext<cr>", desc = "Next Buffer" },
			{ "<leader>bp", "<cmd>bprevious<cr>", desc = "Previous Buffer" },

			-- Quit
			{ "<leader>q", group = "quit" },
			{ "<leader>qq", "<cmd>qa!<cr>", desc = "Quit All" },
			{ "<leader>qs", "<cmd>wqa<cr>", desc = "Save and Quit" },

			-- Yank to system clipboard
			{ "<leader>y", [["+y]], desc = "Yank to System Clipboard", mode = { "n", "v" } },
			{ "<leader>Y", [["+Y]], desc = "Yank Line to System Clipboard" },

			-- Paste without losing register
			{ "<leader>p", [["_dP]], desc = "Paste Without Register", mode = "x" },

			-- Search with grep
			{ "<leader>ps", desc = "Project Search" },

			-- Diagnostic navigation
			{ "<leader>e", vim.diagnostic.open_float, desc = "Show Diagnostic Float" },
			{ "[d", vim.diagnostic.goto_prev, desc = "Previous Diagnostic" },
			{ "]d", vim.diagnostic.goto_next, desc = "Next Diagnostic" },

			-- Quickfix/Location list navigation (using bracket notation like ThePrimeagen)
			{ "[q", "<cmd>cprev<CR>zz", desc = "Previous Quickfix" },
			{ "]q", "<cmd>cnext<CR>zz", desc = "Next Quickfix" },
			{ "[l", "<cmd>lprev<CR>zz", desc = "Previous Location List" },
			{ "]l", "<cmd>lnext<CR>zz", desc = "Next Location List" },
			{ "[t", desc = "Previous Trouble Item" },
			{ "]t", desc = "Next Trouble Item" },
			{ "<leader>tt", desc = "Toggle Trouble" },

			-- Other useful mappings
			{ "<C-p>", "<cmd>Telescope git_files<cr>", desc = "Git Files" },
			{ "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", desc = "Tmux Sessionizer" },
			{ "-", vim.cmd.Ex, desc = "File Explorer" },

			-- LSP mappings (non-leader)
			{ "K", vim.lsp.buf.hover, desc = "Hover Documentation" },
			{ "gd", vim.lsp.buf.definition, desc = "Go to Definition" },
			{ "gD", vim.lsp.buf.declaration, desc = "Go to Declaration" },
			{ "gi", vim.lsp.buf.implementation, desc = "Go to Implementation" },
			{ "go", vim.lsp.buf.type_definition, desc = "Go to Type Definition" },
			{ "gr", vim.lsp.buf.references, desc = "Go to References" },
			{ "gs", vim.lsp.buf.signature_help, desc = "Signature Help" },
			{ "<F2>", vim.lsp.buf.rename, desc = "Rename Symbol" },
			{ "<F3>", vim.lsp.buf.format, desc = "Format", mode = { "n", "x" } },
			{ "<F4>", vim.lsp.buf.code_action, desc = "Code Action" },

			-- Git merge conflict resolution
			{ "dv", vim.cmd.Gvdiffsplit, desc = "Git Vertical Diff Split" },
			{ "gh", "<cmd>diffget //3<CR>", desc = "Get Right (Theirs)" },
			{ "gl", "<cmd>diffget //2<CR>", desc = "Get Left (Ours)" },

			-- Git push mappings (from fugitive config)
			{ "<leader>p", desc = "Git Push" },
			{ "<leader>P", desc = "Git Push Force" },
			{ "<leader>t", desc = "Git Push Upstream" },
		})
	end,
}
