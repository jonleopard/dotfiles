local fn = vim.fn
local cmd = vim.cmd
local set_theme_path = "$HOME/.config/base16-project/set_theme.lua"
local is_set_theme_file_readable = fn.filereadable(fn.expand(set_theme_path)) == 1 and true or false

if is_set_theme_file_readable then
    cmd("let base16colorspace=256")
    cmd("source " .. set_theme_path)
end

vim.cmd [[
    if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
      let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
      let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    endif
]]
