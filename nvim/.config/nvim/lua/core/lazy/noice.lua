return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	opts = {
		lsp = {
			progress = { enabled = true },
			hover = { enabled = false },
			signature = { enabled = false },
		},
		presets = {
			bottom_search = true,
			command_palette = true,
			long_message_to_split = true,
			inc_rename = false,
		},
		cmdline = {
			enabled = true,
			format = {
				cmdline = { pattern = "^:", icon = "", lang = "vim" },
				search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
				search_up = { kind = "search", pattern = "^?", icon = " ", lang = "regex" },
				filter = { pattern = "^:%s*!%s*", icon = "$", lang = "bash" },
			},
		},
		messages = {
			enabled = true,
			view = "mini",
			view_warn = "mini",
		},
		views = {
			popup = {
				enter = true,
				leave = true,
				border = { style = "rounded" },
				win_options = {
					winblend = 10,
				},
			},
			mini = {
				win_options = {
					winblend = 15,
				},
			},
		},
		routes = {
			{
				filter = { event = "msg_show", kind = "error" },
				opts = { skip = false },
			},
			{
				filter = { event = "msg_show", kind = "warn" },
				opts = { skip = false },
			},
			{
				filter = {
					event = "msg_show",
					any = {
						{ find = "%d+L, %d+B" },
						{ find = "; after #%d+" },
						{ find = "; before #%d+" },
						{ find = '"%S+" written' },
					},
				},
				opts = { skip = true },
			},
		},
	},
}
