return {
	"echasnovski/mini.nvim",
	version = false, -- always latest
	event = "VeryLazy", -- lazyload it
	config = function()
		require("mini.pairs").setup()
		require("mini.surround").setup()
		require("mini.comment").setup()
		require("mini.bufremove").setup()
		-- optional, if you want movement too
		-- require("mini.move").setup()
	end,
}
