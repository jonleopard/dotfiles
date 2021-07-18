require('plugin-settings.telescope')
require('plugin-settings.lspconfig')
require('plugin-settings.compe')
require('plugin-settings.snippets')
require('plugin-settings.gitsigns')
require('plugin-settings.ts')


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
