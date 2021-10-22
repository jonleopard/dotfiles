local cmp = require'cmp'
local luasnip = require("luasnip")

  cmp.setup({
    snippet = {
      expand = function(args)

        -- For `luasnip` user.
        require('luasnip').lsp_expand(args.body)

      end,
    },
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),

      -- Supertab like completion
      ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),

    },
    sources = {
      { name = 'nvim_lsp' },

      -- For luasnip user.
      { name = 'luasnip' },

      { name = 'buffer' },
    }
  })


-- cmp.setup({
--     snippet = {
--         expand = function(args)
--             -- For `vsnip` user.
--             -- vim.fn["vsnip#anonymous"](args.body)

--             -- For `luasnip` user.
--             require('luasnip').lsp_expand(args.body)

--             -- For `ultisnips` user.
--             -- vim.fn["UltiSnips#Anon"](args.body)
--         end,
--     },

--   mapping = {

--     -- ... Your other mappings ...

--     ["<Tab>"] = cmp.mapping(function(fallback)
--       if cmp.visible() then
--         cmp.select_next_item()
--       elseif luasnip.expand_or_jumpable() then
--         luasnip.expand_or_jump()
--       elseif has_words_before() then
--         cmp.complete()
--       else
--         fallback()
--       end
--     end, { "i", "s" }),

--     ["<S-Tab>"] = cmp.mapping(function(fallback)
--       if cmp.visible() then
--         cmp.select_prev_item()
--       elseif luasnip.jumpable(-1) then
--         luasnip.jump(-1)
--       else
--         fallback()
--       end
--     end, { "i", "s" }),

--     -- ... Your other mappings ...
--   },

--   -- ... Your other configuration ...
-- })
