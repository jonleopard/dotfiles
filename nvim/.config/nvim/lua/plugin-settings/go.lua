-- -- setup go.nvim
-- require('go').setup({
--   goimport = 'gopls', -- if set to 'gopls' will use golsp format
--   gofmt = 'gopls', -- if set to gopls will use golsp format
--   max_line_line = 120,
--   tag_transform = false,
--   test_dir = '',
--   comment_placeholder = '   ',
--   lsp_cfg = true, -- false: use your own lspconfig
--   lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
--   lsp_on_attach = true, -- use on_attach from go.nvim
--   dap_debug = true,
-- })




-- -- Lua doesn't have autocmd support yet
-- -- Format on save
-- vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').gofmt() ]], false)

-- -- Import on save
-- vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)

-- -- vim.cmd([[command! Gofmt lua require("go.format").goimport()]])
-- -- vim.cmd([[command! Goimport lua require("go.format").goimport()]])

-- local protocol = require'vim.lsp.protocol'
--

-- local lspconfig = require "lspconfig"
-- lspconfig.gopls.setup {
--   cmd = {"gopls", "serve"},
--   capabilities = capabilities,
--   settings = {
--     gopls = {
--       analyses = {
--         unusedparams = true,
--         shadow = true,
--       },
--       staticcheck = true,
--     },
--   },
--   on_attach = on_attach,
-- }


-- function goimports(timeout_ms)
--   local context = { only = { "source.organizeImports" } }
--   vim.validate { context = { context, "t", true } }

--   local params = vim.lsp.util.make_range_params()
--   params.context = context

--   -- See the implementation of the textDocument/codeAction callback
--   -- (lua/vim/lsp/handler.lua) for how to do this properly.
--   local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
--   if not result or next(result) == nil then return end
--   local actions = result[1].result
--   if not actions then return end
--   local action = actions[1]

--   -- textDocument/codeAction can return either Command[] or CodeAction[]. If it
--   -- is a CodeAction, it can have either an edit, a command or both. Edits
--   -- should be executed first.
--   if action.edit or type(action.command) == "table" then
--     if action.edit then
--       vim.lsp.util.apply_workspace_edit(action.edit)
--     end
--     if type(action.command) == "table" then
--       vim.lsp.buf.execute_command(action.command)
--     end
--   else
--     vim.lsp.buf.execute_command(action)
--   end
-- end


-- vim.api.nvim_exec([[ autocmd BufWritePre *.go lua goimports(1000) ]], false)
-- vim.api.nvim_exec([[ autocmd BufWritePre *.go lua vim.lsp.buf.formatting() ]], false)

