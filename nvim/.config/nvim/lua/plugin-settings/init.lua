require('plugin-settings.telescope')
require('plugin-settings.lspconfig')
require('plugin-settings.compe')
require('plugin-settings.snippets')
require('plugin-settings.gitsigns')
require('plugin-settings.ts')
--require('plugin-settings.go')
require('plugin-settings.treesitter')
--require('plugin-settings.bufferline')
require('plugin-settings.which-key')
require('plugin-settings.indent-blankline')
require('plugin-settings.trouble')
require('plugin-settings.tmux')
--require('plugin-settings.harpoon')


P = function(v)
  print(vim.inspect(v))
  return v
end

if pcall(require, 'plenary') then
  RELOAD = require('plenary.reload').reload_module

  R = function(name)
    RELOAD(name)
    return require(name)
  end
end
