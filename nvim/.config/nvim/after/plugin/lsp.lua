local Remap = require("jon.keymap")
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap

require("luasnip/loaders/from_vscode").lazy_load()
require("nvim-lsp-installer").setup({})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local luasnip = require('luasnip')

-- Setup nvim-cmp
local cmp = require("cmp")
local source_mapping = {
    buffer = "[Buffer]",
    nvim_lsp = "[LSP]",
    nvim_lua = "[Lua]",
    cmp_tabnine = "[TN]",
    path = "[Path]",
}
local lspkind = require("lspkind")

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
    }),

    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = lspkind.presets.default[vim_item.kind]
            local menu = source_mapping[entry.source.name]
            if entry.source.name == "cmp_tabnine" then
                if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
                    menu = entry.completion_item.data.detail .. " " .. menu
                end
                vim_item.kind = ""
            end
            vim_item.menu = menu
            return vim_item
        end,
    },
    sources = {
        { name = "cmp_tabnine" },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
    },
})

local tabnine = require("cmp_tabnine.config")
tabnine:setup({
    max_lines = 1000,
    max_num_results = 20,
    sort = true,
    run_on_every_keystroke = true,
    snippet_placeholder = "..",
})

local function config(_config)
    return vim.tbl_deep_extend("force", {
        capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
        on_attach = function()
            nnoremap("gd", function()
                vim.lsp.buf.definition()
            end)
            nnoremap("K", function()
                vim.lsp.buf.hover()
            end)
            nnoremap("<leader>vws", function()
                vim.lsp.buf.workspace_symbol()
            end)
            nnoremap("<leader>vd", function()
                vim.diagnostic.open_float()
            end)
            nnoremap("[d", function()
                vim.diagnostic.goto_next()
            end)
            nnoremap("]d", function()
                vim.diagnostic.goto_prev()
            end)
            nnoremap("<leader>vca", function()
                vim.lsp.buf.code_action()
            end)
            nnoremap("<leader>vrr", function()
                vim.lsp.buf.references()
            end)
            nnoremap("<leader>vrn", function()
                vim.lsp.buf.rename()
            end)
            inoremap("<C-h>", function()
                vim.lsp.buf.signature_help()
            end)
        end,
    }, _config or {})
end

require("lspconfig").tailwindcss.setup(config())

require("lspconfig").cssls.setup(config())

require("lspconfig").denols.setup(config())

require("lspconfig").dockerls.setup(config())

require("lspconfig").emmet_ls.setup(config())

require("lspconfig").jsonls.setup(config())

require("lspconfig").html.setup(config())

require("lspconfig").tsserver.setup(config())

require("lspconfig").gopls.setup(config({
    cmd = { "gopls" },
    on_attach = on_attach, -- do I need this?
    settings = {
        gopls = {
            experimentalPostfixCompletions = true,
            analyses = {
                unusedparams = true,
                shadow = true,
            },

            staticcheck = true,
        },
    },
    init_options = {
        gofumpt = true,
        usePlaceholders = true,
    }
}))



local OrgImports = function(wait_ms)
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" } }
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
    for _, res in pairs(result or {}) do
        for _, r in pairs(res.result or {}) do
            if r.edit then
                vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
            else
                vim.lsp.buf.execute_command(r.command)
            end
        end
    end
end


vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*.go", "lua" },
    callback = function() OrgImports() end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = {
        "*"
    },
    command = [[lua vim.lsp.buf.formatting_sync()]]
})

require("lspconfig").sumneko_lua.setup(config({
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}))

local opts = {
    -- whether to highlight the currently hovered symbol
    -- disable if your cpu usage is higher than you want it
    -- or you just hate the highlight
    -- default: true
    highlight_hovered_item = true,

    -- whether to show outline guides
    -- default: true
    show_guides = true,
}

require("symbols-outline").setup(opts)

local snippets_paths = function()
    local plugins = { "friendly-snippets" }
    local paths = {}
    local path
    local root_path = vim.env.HOME .. "/.vim/plugged/"
    for _, plug in ipairs(plugins) do
        path = root_path .. plug
        if vim.fn.isdirectory(path) ~= 0 then
            table.insert(paths, path)
        end
    end
    return paths
end

require("luasnip.loaders.from_vscode").lazy_load({
    paths = snippets_paths(),
    include = nil, -- Load all languages
    exclude = {},
})
