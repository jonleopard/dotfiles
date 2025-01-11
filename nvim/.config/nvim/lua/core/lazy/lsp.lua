return {
	{
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
			local cmp = require("cmp")
			local cmp_lsp = require("cmp_nvim_lsp")
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				cmp_lsp.default_capabilities()
			)

			require("fidget").setup({})
			require("mason").setup({})
			require("mason-lspconfig").setup({
				ensure_installed = {
					"ts_ls",
					"tailwindcss",
					"rust_analyzer",
					"cssls",
					"emmet_ls",
					"gopls",
					"lua_ls",
					"pyright",
					"dockerls",
					"templ",
					"astro",
				},
				handlers = {
					function(server_name) -- default handler (optional)
						require("lspconfig")[server_name].setup({
							capabilities = capabilities,
							on_attach = on_attach,
						})
					end,
					["lua_ls"] = function()
						local lspconfig = require("lspconfig")
						lspconfig.lua_ls.setup({
							capabilities = capabilities,
							settings = {
								Lua = {
									diagnostics = {
										globals = { "vim" },
									},
								},
							},
						})
					end,
					["golangci_lint_ls"] = function()
						local lspconfig = require("lspconfig")
						lspconfig.golangci_lint_ls.setup({
							capabilities = capabilities,
							cmd = { "golangci-lint-langserver" },
							root_dir = lspconfig.util.root_pattern(".git", "go.mod"),
							init_options = {
								cmd = {
									"golangci-lint",
									"run",
									"--enable-all",
									"--disable",
									"lll",
									"--out-format",
									"json",
									"--issues-exit-code=1",
								},
							},
							filetypes = { "go", "gomod" },
						})
					end,
					["intelephense"] = function()
						local lspconfig = require("lspconfig")
						lspconfig.intelephense.setup({
							capabilities = capabilities,
						})
					end,
					["htmx"] = function()
						local lspconfig = require("lspconfig")
						lspconfig.htmx.setup({
							capabilities = capabilities,
							filetypes = { "html" },
						})
					end,
					["html"] = function()
						local lspconfig = require("lspconfig")
						lspconfig.html.setup({
							capabilities = capabilities,
							filetypes = { "html" },
						})
					end,
					["tailwindcss"] = function()
						local lspconfig = require("lspconfig")
						lspconfig.tailwindcss.setup({
							capabilities = capabilities,
							filetypes = { "templ", "astro", "javascript", "typescript", "react" },
							init_options = { userLanguages = { templ = "html" } },
						})
					end,
					["bashls"] = function()
						local lspconfig = require("lspconfig")
						lspconfig.bashls.setup({
							capabilities = capabilities,
							filetypes = { "sh" },
							cmd = { "bash-language-server", "start" },
						})
					end,
					["zls"] = function()
						local lspconfig = require("lspconfig")
						lspconfig.zls.setup({
							capabilities = capabilities,
						})
					end,
				},
			})

			local cmp_select = { behavior = cmp.SelectBehavior.Select }
			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					-- ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
					-- ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
					-- ['<C-y>'] = cmp.mapping.confirm({ select = true }),
					-- ['<C-e>'] = cmp.mapping.abort(),
					-- ['<C-Space>'] = cmp.mapping.complete(),
					-- ['<CR>'] = cmp.mapping.confirm({ select = true }),
					["C-p"] = cmp.mapping.select_prev_item(cmp_select),
					["C-n"] = cmp.mapping.select_next_item(cmp_select),
					--['C-y'] = cmp.mapping.confirm({ select = true }),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["C-Space"] = cmp.mapping.complete(),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "path" },
					{ name = "luasnip" },
					{ name = "buffer" },
				}),
			})
			vim.diagnostic.config({
				update_in_insert = true,
				float = {
					focasable = false,
					style = "minimal",
					border = "rounded",
					source = true,
					header = "",
					prefix = "",
				},
			})
		end,
	},
}
