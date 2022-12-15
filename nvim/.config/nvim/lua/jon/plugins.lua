-- This file can be loaded by calling `lua require('plugins')` from your init.vim
local fn = vim.fn
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
return require('packer').startup(function(use)
    use("wbthomason/packer.nvim")

    ------------------------------------------------------------------------------
    --Colorscheme & Syntax Highlighting
    ------------------------------------------------------------------------------
    use("tinted-theming/base16-vim")
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use('nvim-treesitter/playground')

    ------------------------------------------------------------------------------
    --Git
    ------------------------------------------------------------------------------
    use("tpope/vim-fugitive")
    use("lewis6991/gitsigns.nvim")
    use("ThePrimeagen/git-worktree.nvim")

    ------------------------------------------------------------------------------
    --LSP, Autocompletion & Snippets
    ------------------------------------------------------------------------------

  use {
	  'VonHeikemen/lsp-zero.nvim',
	  requires = {
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},
		  {'williamboman/mason.nvim'},
		  {'williamboman/mason-lspconfig.nvim'},

		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-buffer'},
		  {'hrsh7th/cmp-path'},
		  {'saadparwaiz1/cmp_luasnip'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'hrsh7th/cmp-nvim-lua'},

		  -- Snippets
		  {'L3MON4D3/LuaSnip'},
		  {'rafamadriz/friendly-snippets'},
	  }
  }



    --use("onsails/lspkind-nvim")
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
    use { "nvim-telescope/telescope.nvim", tag = '0.1.0' }
    use { 'nvim-telescope/telescope-fzf-native.nvim',
        run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

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

end)
