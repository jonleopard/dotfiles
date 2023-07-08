local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    ------------------------------------------------------------------------------
    --Colorscheme & Syntax Highlighting
    ------------------------------------------------------------------------------
    "tinted-theming/base16-vim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-treesitter/playground",

    ------------------------------------------------------------------------------
    --Git
    ------------------------------------------------------------------------------
    "tpope/vim-fugitive",
    "lewis6991/gitsigns.nvim",

    ------------------------------------------------------------------------------
    --LSP, Autocompletion & Snippets
    ------------------------------------------------------------------------------
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        dependencies = {
            -- LSP Support
            "neovim/nvim-lspconfig",
            { -- Optional
                "williamboman/mason.nvim",
                build = function()
                    pcall(vim.cmd, "MasonUpdate")
                end,
            },
            "williamboman/mason-lspconfig.nvim",

            -- Autocompletion
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",

            -- Snippets
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",
        }
    },
    "mfussenegger/nvim-dap",

    ------------------------------------------------------------------------------
    ------------------------------------------------------------------------------
    "justinmk/vim-gtfo",
    "nvim-lua/plenary.nvim",
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.0",
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build =
        "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
    },

    ------------------------------------------------------------------------------
    --Utils
    ------------------------------------------------------------------------------
    {
        "ahmedkhalf/project.nvim",
        config = function()
            require("project_nvim").setup {
                -- your configuration comes here
                -- or leave it empty to  the default settings
                -- refer to the configuration section below
            }
        end
    },
    {
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup {
                -- your configuration comes here
                -- or leave it empty to  the default settings
                -- refer to the configuration section below
            }
        end
    },
    "nvim-tree/nvim-web-devicons",
    "nvim-treesitter/nvim-treesitter-context",
    "jose-elias-alvarez/null-ls.nvim",
    "tpope/vim-surround",
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    },
    "junegunn/vim-easy-align",
    "ThePrimeagen/harpoon",
    "tpope/vim-eunuch",
    "tpope/vim-unimpaired",
    "mbbill/undotree",
    "mhinz/vim-startify",
    "editorconfig/editorconfig-vim",
    { "iamcco/markdown-preview.nvim", build = "cd app && npm install", cmd = "MarkdownPreview" },
    "ThePrimeagen/vim-be-good",
    "lewis6991/impatient.nvim",
    "ThePrimeagen/vim-be-good",
    "github/copilot.vim",
})
