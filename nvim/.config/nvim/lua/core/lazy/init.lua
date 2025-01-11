return {
	------------------------------------------------------------------------------
	--Plugins that don't require their own file/setup
	------------------------------------------------------------------------------
	{
		"nvim-lua/plenary.nvim",
		name = "plenary",
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	},
	"mhinz/vim-startify",
	"editorconfig/editorconfig-vim",
	"nvim-tree/nvim-web-devicons",
	"junegunn/vim-easy-align",
	"tpope/vim-sleuth",
	"tpope/vim-surround",
	"tpope/vim-eunuch",
	"tpope/vim-unimpaired",
	"justinmk/vim-gtfo",
	"ThePrimeagen/vim-be-good",
}
