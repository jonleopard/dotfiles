call plug#begin('~/.vim/plugged')


" Make sure you use single quotes
Plug 'tpope/vim-sensible'
Plug 'dracula/vim'

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }


" Add plugins to &runtimepath

call plug#end()


colorscheme dracula
