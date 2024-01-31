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
        local cmp = require('cmp')
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
                ['C-y'] = cmp.mapping.confirm({ select = true }),
                ['C-Space'] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'path' },
                { name = 'nvim_lsp' },
                { name = 'luasnip', keyword_length = 2 },
                { name = 'buffer',  keywordslength = 3 },
            }),
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
        })
    end
}

-- local cmp = require('cmp')
-- local cmp_select = { behavior = cmp.SelectBehavior.Select }
-- cmp.setup({
--     sources = {
--         { name = 'path' },
--         { name = 'nvim_lsp' },
--         { name = 'nvim_lua' },
--         { name = 'luasnip', keyword_length = 2 },
--         { name = 'buffer',  keyword_length = 3 },
--     },
--     formatting = lsp_zero.cmp_format(),
--     mapping = cmp.mapping.preset.insert({
--         ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
--         ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
--         ['<C-y>'] = cmp.mapping.confirm({ select = true }),
--         ['<C-e>'] = cmp.mapping.abort(),
--         ['<C-Space>'] = cmp.mapping.complete(),
--         ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
--     }),
--     snippet = {
--         expand = function(args)
--             require('luasnip').lsp_expand(args.body)
--         end,
--     },
-- })
--
-- local OrgImports = function(wait_ms)
--     local params = vim.lsp.util.make_range_params()
--     params.context = { only = { "source.organizeImports" } }
--     local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
--     for _, res in pairs(result or {}) do
--         for _, r in pairs(res.result or {}) do
--             if r.edit then
--                 vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
--             else
--                 vim.lsp.buf.execute_command(r.command)
--             end
--         end
--     end
-- end
--
-- -- add imports on save
-- vim.api.nvim_create_autocmd({ "BufWritePre" }, {
--     pattern = { "*.go", "lua", "rust" },
--     callback = function() OrgImports() end,
-- })
--
-- -- -- Format on save
-- -- vim.api.nvim_create_autocmd("BufWritePre", {
-- --     pattern = { "*" },
-- --     command = [[lua vim.lsp.buf.format]]
-- -- })
-- --
--
-- -- additional filetypes
-- vim.filetype.add({
--     extension = {
--         templ = "templ",
--     },
-- })
--
-- -- Show diagnostics
-- vim.diagnostic.config({
--     virtual_text = true,
-- })
