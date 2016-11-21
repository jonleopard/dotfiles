call plug#begin('~/.vim/plugged')

" Colorscheme & Syntax Highlighting
Plug 'Yggdroot/indentLine'
Plug 'dracula/vim'
Plug 'Raimondi/delimitMate'

" Git
Plug 'junegunn/vim-github-dashboard'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Tmux
Plug 'christoomey/vim-tmux-navigator'

" Syntax
Plug 'tpope/vim-surround'
Plug 'sheerun/vim-polyglot'
Plug 'neomake/neomake'
Plug 'SirVer/ultisnips'
Plug 'tomtom/tcomment_vim'
Plug 'zchee/deoplete-jedi'
Plug 'fatih/vim-hclfmt'

" Javascript
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/jspc.vim', { 'for': ['javascript', 'javascript.jsx'] }

" Go
Plug 'fatih/vim-go'
Plug 'zchee/deoplete-go'

" Ruby/Rails

" Utils
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'rking/ag.vim'
Plug 'tpope/vim-vinegar'
Plug 'itchyny/lightline.vim'
Plug 'ervandew/supertab'

call plug#end()


