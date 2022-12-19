-- :help options

vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.config/nvim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- TODO: Finish converting to lua
-- if vim.fn.has("persistent_undo") == 1 then
--     local target_path = vim.api.expand("~/.config/nvim/undodir")

--     if not vim.api.isdirectory(target_path)
--     then vim.api.mkdir(target_path, "p", 0700)
--     end

--     local undodir = target_path
--     vim.opt.undodir = undodir
-- end


vim.cmd([[
    if has("persistent_undo")
       let target_path = expand('~/.config/nvim/undodir')

        " create the directory and any parent directories
        " if the location does not exist.
        if !isdirectory(target_path)
            call mkdir(target_path, "p", 0700)
        endif

        let &undodir=target_path
        set undofile
    endif

  " Disable ctrl-a on tmux & screen
  if $TERM =~ '*256color' || ',*256col*:Tc'
    nnoremap <C-a> <nop>
    nnoremap <Leader><C-a> <C-a>
  endif
]])
