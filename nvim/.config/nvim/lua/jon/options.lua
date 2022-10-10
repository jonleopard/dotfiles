-- :help options

vim.g.mapleader = " "
vim.opt.guicursor = ""

vim.opt.errorbells = false
vim.opt.smartindent = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.opt.scrolloff = 8
vim.opt.joinspaces = true
vim.opt.signcolumn = "yes"
vim.opt.backup = false
vim.opt.relativenumber = true
vim.opt.nu = true
--vim.opt.number         = true
vim.opt.textwidth = 80
vim.opt.termguicolors = true
vim.opt.wrap = false
vim.opt.isfname:append("@-@")

-- Don't pass messages to |ins-completion-menu|.
vim.opt.shortmess:append("c")

-- Give more space for displaying messages.
vim.opt.cmdheight = 1

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.opt.updatetime = 50

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Files
vim.opt.swapfile = false
vim.opt.undodir = os.getenv("HOME") .. "/.config/nvim/undodir"
vim.opt.undofile = true
vim.opt.colorcolumn = "80"

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

  " yank to clipboard
  if has("clipboard")
    set clipboard=unnamed " copy to the system clipboard
    if has("unnamedplus") " X11 support
      set clipboard+=unnamedplus
    endif
  endif

  " Disable ctrl-a on tmux & screen
  if $TERM =~ '*256color' || ',*256col*:Tc'
    nnoremap <C-a> <nop>
    nnoremap <Leader><C-a> <C-a>
  endif
]])
