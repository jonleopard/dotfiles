" Basics {{{
set nocompatible                          " Use Vim's improvements
filetype plugin indent on                 " Enable fitetype detection, filetype scripts & indent scripts

let mapleader = ","                       " Map  <leader> key to ,
let maplocalleader="\\"                   " Map local leader to \\
set autoread                              " Auto-reload modified files
set encoding=utf-8                        " Encode characters as utf-8
set fileencoding=utf-8                    " Encode files as utf-8
set termencoding=utf-8                    " Set encoding used for the terminal
set foldmethod=marker                     " Fold based on specified markers
set gdefault                              " Default to substituting globally
set hlsearch                              " Highlight results
set ignorecase                            " Ignore the case in regexes
set incsearch                             " Enable incremental search
set smartcase                             " Override ignorecase if an uppercase is typed
set iskeyword-=_                          " Underscores delimit words
set lazyredraw                            " For better performance when replaying macros
set matchpairs+=<:>                       " Show matching <>'s, mostly for HTML
set noswapfile                            " Turn off file backups
set nowritebackup                         " Turn off swap file generation
set showbreak=                            " Show that a line has been wrapped
set nojoinspaces
set smartindent
set backspace=indent,eol,start
"set colorcolumn=80                       " Highlight 80 character limit
set hidden                                " Hide buffers instead of closing them
set history=1000                          " Rememebr command mode history
set laststatus=2                          " Always show the status bar. Airline requires this.
set list                                  " Show invisible characters
set listchars=tab:›\ ,eol:¬,trail:⋅       " Set the characters for the invisibles
set number relativenumber                 " Line number is relative to your position
set scrolloff=5                           " Keep the cursor centered in the screen
set showmatch                             " Highlight matching braces
set showmode                              " Show the current mode on the open buffer
set splitbelow                            " Better split opening
set splitright                            " Better split opening
set title                                 " Set the title for gvim
set visualbell                            " Use a visual bell to notify us
set expandtab smarttab                    " Expand tabs to the proper type and size
set tabstop=2                             " Tabs width in spaces
set shiftwidth=2                          " Amount of spaces when shifting

let g:netrw_localrmdir='rm -r'            " Allow deletion of a dir that isn't empty
let g:netrw_banner=0                      " Dont show the banner


" }}}

" Plugins {{{
call plug#begin('~/.config/nvim/plugged')

" Colorscheme & Syntax Highlighting
Plug 'Yggdroot/indentLine'
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
Plug 'Raimondi/delimitMate'

" Editing
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'sheerun/vim-polyglot'
Plug 'neomake/neomake'
"Plug 'tomtom/tcomment_vim
Plug 'tpope/vim-commentary',        { 'on': '<Plug>Commentary' }
Plug 'fatih/vim-hclfmt'
Plug 'plasticboy/vim-markdown'
Plug 'godlygeek/tabular'
Plug 'junegunn/vim-easy-align'
Plug 'reasonml/vim-reason-loader'
Plug 'tpope/vim-repeat'

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
Plug 'easymotion/vim-easymotion'

call plug#end()
" }}}

" Statusline (Airline) {{{
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='dracula'

" }}}

" Color settings (256, italics, etc) {{{

" vim color scheme (dracula)
let draculacolorspace=256  " Access colors present in 256 colorspace
syntax on
color dracula

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later,
"you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 
  "< https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.40 (`guicolors` option) 
  "< https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  "< https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
        set termguicolors
  endif
endif


" Enable Italics
let g:dracula_italic = 1
hi htmlArg gui=italic
hi Comment gui=italic
hi Type    gui=italic
hi htmlArg cterm=italic
hi Comment cterm=italic
hi Type    cterm=italic

" Highlight Italics
highlight Comment cterm=italic

" }}}
" Windows
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Supertab
autocmd FileType javascript let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:UltiSnipsExpandTrigger="<C-j>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Use ; for commands.
nnoremap ; :

" Use Q to execute default register.
nnoremap Q @q

" ack_or_silver_searcher
let g:ackprg = 'ag --vimgrep'

" Fuzzy Search
nnoremap <C-p> :FZF<CR>

" Set // to search the current visual selection
vnoremap // y/<C-R>"<CR>"

" neomake
nmap <Leader><Space>o :lopen<CR>      " open location window
nmap <Leader><Space>c :lclose<CR>     " close location window
nmap <Leader><Space>, :ll<CR>         " go to current error/warning
nmap <Leader><Space>n :lnext<CR>      " next error/warning
nmap <Leader><Space>p :lprev<CR>      " previous error/warning


" Shortcut to yanking to the system clipboard
map <leader>y "*y
map <leader>p "*p

" Navigating tabs easier
map <D-S-{> :tabprevious
map <D-S-}> :tabprevious

" To force myself to use hjkl. Pleb mode.
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" yank to clipboard
if has("clipboard")
  set clipboard=unnamed " copy to the system clipboard
  if has("unnamedplus") " X11 support
    set clipboard+=unnamedplus
  endif
endif

" Keybind crosshairs on and off
hi CursorLine   cterm=NONE ctermbg=235
hi CursorColumn cterm=NONE ctermbg=235
nnoremap x :set cursorline! cursorcolumn!

" toggle paste in cmd only
nnoremap <Leader>p :set invpaste<CR>

" netrw goodness
"let g:netrw_banner = 0
""let g:netrw_liststyle = 3
"let g:netrw_browse_split = 4
"let g:netrw_altv = 1
"let g:netrw_winsize = 25
"augroup ProjectDrawer
""  autocmd!
""  autocmd VimEnter * :Vexplore
"augroup END

