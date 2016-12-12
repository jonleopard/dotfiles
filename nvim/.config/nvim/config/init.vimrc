call plug#begin('~/.vim/plugged')

" Colorscheme & Syntax Highlighting
Plug 'Yggdroot/indentLine'
Plug 'Raimondi/delimitMate'
Plug 'dracula/vim'

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
Plug 'fatih/vim-hclfmt'
Plug 'plasticboy/vim-markdown'
Plug 'godlygeek/tabular'
Plug 'junegunn/vim-easy-align'

" Javascript

" Puppet
Plug 'voxpupuli/vim-puppet'


" Go
Plug 'fatih/vim-go'
Plug 'zchee/deoplete-go'

" Ruby/Rails

" Utils
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'rking/ag.vim'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-eunuch'
Plug 'ervandew/supertab'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhinz/vim-startify'


call plug#end()

