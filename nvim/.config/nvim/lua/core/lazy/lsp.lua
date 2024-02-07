return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        -- cmp
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        -- Snippets
        -- TODO: Should I only include these in the snippets.lua file?
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        -- Notifications
        "j-hui/fidget.nvim",
    },
    config = function()
        local cmp = require('cmp')
        local cmp_lsp = require('cmp_nvim_lsp')
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        require("fidget").setup({})
        require("mason").setup({})
        require("mason-lspconfig").setup({
            ensure_installed = {
                'tsserver',
                'tailwindcss',
                'rust_analyzer',
                'cssls',
                'emmet_ls',
                'gopls',
                'lua_ls',
                'pyright',
                'dockerls',
                'templ',
                --'htmx-lsp',
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require('lspconfig')[server_name].setup {
                        capabilities = capabilities,
                    }
                end,
                ["lua_ls"] = function()
                    local lspconfig = require('lspconfig')
                    lspconfig.lua_ls.setup {
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim" }
                                }
                            }
                        }
                    }
                end,
            }
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                -- ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                -- ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                -- ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                -- ['<C-e>'] = cmp.mapping.abort(),
                -- ['<C-Space>'] = cmp.mapping.complete(),
                -- ['<CR>'] = cmp.mapping.confirm({ select = true }),
                ['C-p'] = cmp.mapping.select_prev_item(cmp_select),
                ['C-n'] = cmp.mapping.select_next_item(cmp_select),
                --['C-y'] = cmp.mapping.confirm({ select = true }),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                ['C-Space'] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'path' },
                { name = 'luasnip'},
                { name = 'buffer'},
            })
        })
        vim.diagnostic.config({
            update_in_insert = true,
            float = {
                focasable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}
