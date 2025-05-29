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
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			-- Notifications
			"j-hui/fidget.nvim",
		},
		config = function()
			local cmp = require("cmp")
			local cmp_lsp = require("cmp_nvim_lsp")
			local lspconfig = require("lspconfig")

			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				cmp_lsp.default_capabilities()
			)

			local function with_defaults(config)
				return vim.tbl_deep_extend("force", {
					capabilities = capabilities,
					on_attach = on_attach,
				}, config or {})
			end

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
					-- Default handler
					function(server_name)
						lspconfig[server_name].setup(with_defaults())
					end,

					["lua_ls"] = function()
						lspconfig.lua_ls.setup(with_defaults({
							settings = {
								Lua = {
									diagnostics = {
										globals = { "vim" },
									},
								},
							},
						}))
					end,

					["golangci_lint_ls"] = function()
						lspconfig.golangci_lint_ls.setup(with_defaults({
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
						}))
					end,

					["intelephense"] = function()
						lspconfig.intelephense.setup(with_defaults())
					end,

					["htmx"] = function()
						lspconfig.htmx.setup(with_defaults({
							filetypes = { "html" },
						}))
					end,

					["html"] = function()
						lspconfig.html.setup(with_defaults({
							filetypes = { "html" },
						}))
					end,

					["tailwindcss"] = function()
						lspconfig.tailwindcss.setup(with_defaults({
							filetypes = { "templ", "astro", "javascript", "typescript", "react" },
							init_options = { userLanguages = { templ = "html" } },
						}))
					end,

					["bashls"] = function()
						lspconfig.bashls.setup(with_defaults({
							filetypes = { "sh" },
							cmd = { "bash-language-server", "start" },
						}))
					end,

					["zls"] = function()
						lspconfig.zls.setup(with_defaults())
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
					["C-p"] = cmp.mapping.select_prev_item(cmp_select),
					["C-n"] = cmp.mapping.select_next_item(cmp_select),
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
					focusable = false,
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
