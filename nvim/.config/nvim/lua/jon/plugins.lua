local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer, close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})


-- Install your plugins here
return packer.startup(function(use)
	use("wbthomason/packer.nvim")

	------------------------------------------------------------------------------
	--Colorscheme & Syntax Highlighting
	------------------------------------------------------------------------------
	use("base16-project/base16-vim")
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

	------------------------------------------------------------------------------
	--Git
	------------------------------------------------------------------------------
	use("TimUntersberger/neogit")
	use("lewis6991/gitsigns.nvim")
	use("ThePrimeagen/git-worktree.nvim")

	------------------------------------------------------------------------------
	--LSP, Autocompletion & Snippets
	------------------------------------------------------------------------------

	use("williamboman/nvim-lsp-installer")
	use("neovim/nvim-lspconfig")

	use("L3MON4D3/LuaSnip")
	use("saadparwaiz1/cmp_luasnip")
	use("rafamadriz/friendly-snippets")

	use("onsails/lspkind-nvim")
	use("hrsh7th/nvim-cmp")
    use("tzachar/cmp-tabnine", { run = "./install.sh" })
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-nvim-lsp")
	use("tamago324/nlsp-settings.nvim")
	use("glepnir/lspsaga.nvim")
	use("sbdchd/neoformat")

	--" Plug 'mfussenegger/nvim-dap'
	--" Plug 'rcarriga/nvim-dap-ui'
	--" Plug 'nvim-telescope/telescope-dap.nvim'

	------------------------------------------------------------------------------
	--Editing
	------------------------------------------------------------------------------
	use("tpope/vim-surround")
	use("tpope/vim-commentary")
	use("junegunn/vim-easy-align")

	------------------------------------------------------------------------------
	--Navigation/FuzzySearch
	------------------------------------------------------------------------------
	use("justinmk/vim-dirvish")
	use("justinmk/vim-gtfo")
	use("nvim-lua/plenary.nvim")
	use("nvim-telescope/telescope.nvim")
	use("nvim-telescope/telescope-fzy-native.nvim")

	------------------------------------------------------------------------------
	--Utils
	------------------------------------------------------------------------------
	use("ThePrimeagen/harpoon")
    use('simrat39/symbols-outline.nvim')
    use("romgrk/nvim-treesitter-context")
	use("tpope/vim-eunuch")
	use("tpope/vim-unimpaired")
	use("mbbill/undotree")
	use("mhinz/vim-startify")
	use("aserowy/tmux.nvim")
	use("editorconfig/editorconfig-vim")
	use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", cmd = "MarkdownPreview" })

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
