-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')

-- Install your plugins here
return require('packer').startup(function(use)
    use("wbthomason/packer.nvim")

    ------------------------------------------------------------------------------
    --Colorscheme & Syntax Highlighting
    ------------------------------------------------------------------------------
    use("tinted-theming/base16-vim")
    use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
    use('nvim-treesitter/playground')

    ------------------------------------------------------------------------------
    --Git
    ------------------------------------------------------------------------------
    use("tpope/vim-fugitive")
    use("lewis6991/gitsigns.nvim")

    ------------------------------------------------------------------------------
    --LSP, Autocompletion & Snippets
    ------------------------------------------------------------------------------
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }

    use('mfussenegger/nvim-dap')

    ------------------------------------------------------------------------------
    --Navigation/FuzzySearch
    ------------------------------------------------------------------------------
    use("justinmk/vim-dirvish")
    use("justinmk/vim-gtfo")
    use("nvim-lua/plenary.nvim")
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use { 'nvim-telescope/telescope-fzf-native.nvim',
        run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
    }

    ------------------------------------------------------------------------------
    --Utils
    ------------------------------------------------------------------------------
    use("tpope/vim-surround")
    use("tpope/vim-commentary")
    use("junegunn/vim-easy-align")
    use("ThePrimeagen/harpoon")
    use("tpope/vim-eunuch")
    use("tpope/vim-unimpaired")
    use("mbbill/undotree")
    use("mhinz/vim-startify")
    use("editorconfig/editorconfig-vim")
    use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", cmd = "MarkdownPreview" })
    use("ThePrimeagen/vim-be-good")
    use("github/copilot.vim")


end)
