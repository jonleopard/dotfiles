local fn = vim.fn
local cmd = vim.cmd
local set_theme_path = "$HOME/.config/base16-project/set_theme.lua"

if fn.filereadable(fn.expand(set_theme_path)) then
  cmd("let base16colorspace=256")
  cmd("source " .. set_theme_path)
end
