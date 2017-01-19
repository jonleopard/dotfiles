call plug#begin('~/.config/nvim/plugged')

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


" Auto completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/jspc.vim', { 'for': ['javascript', 'javascript.jsx'] }

" Syntax
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'sheerun/vim-polyglot'
Plug 'neomake/neomake'
Plug 'tomtom/tcomment_vim'
Plug 'fatih/vim-hclfmt'
Plug 'plasticboy/vim-markdown'
Plug 'godlygeek/tabular'
Plug 'junegunn/vim-easy-align'
Plug 'reasonml/vim-reason-loader'

" Javascript

" Puppet
Plug 'voxpupuli/vim-puppet'

" Go
Plug 'fatih/vim-go'
Plug 'zchee/deoplete-go'

" Ruby/Rails
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'

" Searching/Navigation
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'rking/ag.vim'
Plug 'tpope/vim-vinegar'
Plug 'justinmk/vim-dirvish'

" Utils
Plug 'tpope/vim-eunuch'
Plug 'ervandew/supertab'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhinz/vim-startify'
Plug 'metakirby5/codi.vim'
Plug 'mhinz/vim-grepper'

call plug#end()

